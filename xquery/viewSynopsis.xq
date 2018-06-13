xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
declare variable $displayMode
{
	let $view := request:request-parameter("view", "null")
	return
	if ($view = 'null')
	then
		"word"
	else
		//view[@id=$view]/@displayMode cast as xs:string
};



declare function f:process($c) 
{
	let $nd := $c/local-name()
	return
	
		if ($nd='range')
		then
			if ($displayMode='clause')
			then
			(
				f:getClauses($c)
			)
			else
				if ($displayMode='wordgroup')
				then
					f:getWordGroups($c)
				else
					f:range($c)
		else
			if ($nd='view' and $c/@displayMode='clause')
			then
				<view>
					{ $c/@* ,
					
					if ($c/*)
					then
						for $ch in $c/*
						return
							f:process($ch)
					else
						$c cast as xs:string
					}
				 
				</view>
			else
	 
	
	
			 if ($nd='title')
			 then
			 (
					 $c,
					 <filters>
						 {
							for $f in request:parameter-names()
							let $val := request:request-parameter($f,'null')
							where contains($f,'filter-') and $val = 'on'
							
							return
								 <filter id="{substring-after($f,'-')}"/>
						
						
						 }
					 </filters>
			
			)
			
			else
				element { name($c) }
				{
					for $att in $c/@*
					return
						$att,
						
					if ($c/*)
					then
						for $ch in $c/*
						return
							f:process($ch)
					else
						$c cast as xs:string
				}
};

declare function f:range($c)
{
	let $book := $c/@book
	let $schap := substring-before(substring-after($c/@start,'.'),'.')  cast as xs:int
	let $svs := substring-after(substring-after($c/@start,'.'),'.')  cast as xs:int
	let $echap := substring-before(substring-after($c/@end,'.'),'.')  cast as xs:int
	let $evs := substring-after(substring-after($c/@end,'.'),'.')  cast as xs:int
	return

		for $v in util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter"))
		where
				 $v/@num >= $schap and $v/@num <= $echap
	
			return  
				
					<chapter>
							{ $v/@num }
							{
								if ($schap = $echap and $v/@num = $schap)
								then
									$v/verse[number(@num) >= $svs and number(@num) <= $evs]
								else
									if ($v/@num = $schap)
								    then
										$v/verse[number(@num) >= $svs]
									else
										if ($v/@num = $echap)
										then
											$v/verse[number(@num) <= $evs]
										else
											$v/verse
									
							}
					</chapter>
					
			
			
	
};

declare function f:getWordGroups($c)
{
let $book := $c/@book
	let $schap := substring-before(substring-after($c/@start,'.'),'.')  cast as xs:int
	let $svs := substring-after(substring-after($c/@start,'.'),'.')  cast as xs:int
	let $echap := substring-before(substring-after($c/@end,'.'),'.')  cast as xs:int
	let $evs := substring-after(substring-after($c/@end,'.'),'.')  cast as xs:int
	let $sid := util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter[@num=", $schap, "]/verse[@num=",$svs,"]/w[1]/@id")) cast as xs:string
	let $eid := util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter[@num=", $echap, "]/verse[@num=",$evs,"]/w[last()]/@id")) cast as xs:string
	
return

	<wordgroups>
		{ 

let $fwg := util:eval(concat("collection('/db/opentext/synopsis/wordgroup')//wg:groups/wg:group[.//wg:word/@xlink:href='", $sid, "']"))
let $lwg := util:eval(concat("collection('/db/opentext/synopsis/wordgroup')//wg:groups/wg:group[.//wg:word/@xlink:href='", $eid, "']"))
return
   if ($fwg/*)
   then
	(
	$fwg,
	for $c in $fwg/following-sibling::wg:group
	where
		$c << $lwg
	return
		$c, 
	$lwg
)		
else
""
		
		}
		{ f:range($c) } 
	</wordgroups>
	
};	
	


declare function f:getClauses($c)
{
	let $book := $c/@book
	let $schap := substring-before(substring-after($c/@start,'.'),'.')  cast as xs:int
	let $svs := substring-after(substring-after($c/@start,'.'),'.')  cast as xs:int
	let $echap := substring-before(substring-after($c/@end,'.'),'.')  cast as xs:int
	let $evs := substring-after(substring-after($c/@end,'.'),'.')  cast as xs:int
	let $sid := util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter[@num=", $schap, "]/verse[@num=",$svs,"]/w[1]/@id")) cast as xs:string
	let $eid := util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter[@num=", $echap, "]/verse[@num=",$evs,"]/w[last()]/@id")) cast as xs:string
	
	return

	<clauses>
		{ 

let $fc := util:eval(concat("collection('/db/opentext/synopsis/clause')//chapter/cl:clause[.//w/@xlink:href='", $sid, "']"))
let $lc := util:eval(concat("collection('/db/opentext/synopsis/clause')//chapter/cl:clause[.//w/@xlink:href='", $eid, "']"))
return
   if ($fc/*)
   then
	(
	$fc,
	for $c in $fc/following-sibling::cl:clause
	where
		$c/following::cl:clause[@id= $lc/@id]
	return
		$c, 
	$lc
)		
else
""
		
		}
		{ f:range($c) } 
	</clauses>
	
};

let $id := request:request-parameter("id","leper")
let $doc := util:eval(concat("document('/db/opentext/synopsis/", $id, ".xml')"))/*
return
	if (contains(request:request-uri(),'synopsis/parallel'))
	then
		$doc
	else
		 f:process($doc)

xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
  
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/wordgroup";
declare namespace pl="http://www.opentext.org/ns/paragraph";
 
 
(::pragma exist:timeout 1000000 ::)
(::pragma exist:output-size-limit 300000 ::)
 
 
 declare variable $ch {
	request:request-parameter("ch",1)
};

 

 declare variable $mode {
	 if ( contains(request:request-uri(), 'editC'))
	 then
		 "edit"
	else
		"view"
 };
 
 declare variable $book { 
	 let $bk := substring-after(request:request-uri(),'Clause/')
	 return
		 if (string-length($bk)>0)
		 then
			 $bk
		else
			let $bk2 := substring-after(request:request-uri(),'Domains/')
			return
				 if (string-length($bk2)>0)
				 then
					 $bk2
				else
					"mark" 
	};
 
 declare variable $user {
        request:request-parameter("uid", "null")
 };
 
 
declare function f:clause($c)
{
	<cl:clause>
		{ $c/@* }
		{ for $ch in $c/*
		  return
				f:processChild($ch)
		}
	</cl:clause>

};

declare function f:processChild($c) 
{
 
	let $nd := $c/local-name()
	return
	
		if ($nd='clause')
		then
			f:clause($c)
		else
			if ($nd='w')
			then
			(:		let $w := util:eval(concat("collection('/db/opentext/", $book, "')"))//w[@id&=$c/@xlink:href]  :)
				let $w := collection('/db/opentext')//w/@id[. &= $c/@xlink:href ]/parent::w
				let $wg := collection('/db/opentext')//wg:group//wg:word[@xlink:href &= $c/@xlink:href]
				
			(:  wg="{$wg/ancestor::wg:group[1]/@id}" role="{$wg/parent::*/local-name()}" wgcnt="{count($wg/ancestor::wg:group[1]//wg:word)}"> :)

					return
					
						<w id="{$w/@id}" vs="{$w/ancestor::verse/@num}">
													{
								$w/*
							}
						</w>
			else
 if ($nd='gloss')
 then
 $c
 else
				element { name($c) }
				{
				    if ($c/@*)
				    then
					for $att in $c/@*
					 
					return
						$att
					else ()
						,
					 
			 
					for $ch in $c/*
	
					return
						
						f:processChild($ch)
					 
				}
	 
};

let $keyword := request:request-parameter('kw','a)gaq/os')
let $wids := util:eval(concat("collection('/db/opentext')//w[wf/@betaLex[.&amp;='", $keyword, "']]/@id"))
let $clauses :=
	
	for $w in $wids 
		let $c := collection('/db/opentext')//w[@xlink:href&=$w]/ancestor::cl:clause[parent::chapter]
	return 
		<line>
		{
			$c/preceding-sibling::cl:clause[1],
			$c,
			$c/following-sibling::cl:clause[1]
			 
		}
		</line>
	 
return
	<data>
		 
	{
			 for $l in $clauses//line
			 return
				f:processChild($l)
		}
		
  {
     document('/db/opentext/lookup/domains.xml')//domains
   }
	 
</data>

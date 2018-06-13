xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
declare namespace transform="http://exist-db.org/xquery/transform";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";
 

 declare variable $book { 
	 let $bk := 
	
		 
			 substring-after(substring-after(request:request-uri(),'WordGroup'),'/')
	 return
		 if (string-length($bk)>0)
		 then
			 $bk
		else
			"mark" 
	};
	
declare variable $filename {
	substring-after(substring-after(request:request-uri(),'WordGroup'),'/')
};
	
	
declare variable $bk {
	
		util:eval(concat("document('/db/papyrus/", $book, "/wordgroup/", ".xml')//text"))
};
  
 
declare function f:clause($c)
{
	if ($c/@level='embedded')
	then
		for $ch in $c/*
		  return
				f:processChild($ch)
	else
	<cl:clause>
	{ $c/@* }
	{
	(:
		 for $ch in $c/*
		  return
	:)
				f:processClause2($c)
	}
	</cl:clause>
};


declare function f:processClause2($c)
{
	let $wds := for  $wd in $c//w return substring-after($wd/@xlink:href,'w') cast as xs:int
	let $w1 :=  min($wds)
	let $w2 := max($wds)
	let $wgexist := 
	
			util:eval(concat("collection('/db/papyrus","/",$book,"/wordgroup')"))//wg:groups/wg:group/wg:head/(wg:word|cl:clause/wg:group[1]/wg:head/wg:word)
	return
	if ($wgexist)
	then
	for $wg in $wgexist
	let $wid := substring-after($wg/@xlink:href,'w') cast as xs:int
	where $wid >= $w1 and $wid <=$w2
	return
			if  ($wg/ancestor::cl:clause/parent::wg:head)
			then
				f:processChildWG($wg/ancestor::cl:clause/ancestor::wg:group)
			else
				f:processChildWG($wg/ancestor::wg:group)
 else 
		 for $nw in $c//w
		 let $w := collection('/db/papyrus')//w[@id&=$nw/@xlink:href]

		return
					
		 
		 <wg:group><wg:head><wg:word id="{$w/@id}" wf="{ $w/wf cast as xs:string }"/></wg:head></wg:group>
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
				let $cid := $c/@xlink:href cast as xs:string
				let $wg := collection('/db/papyrus')//wg:groups/wg:group/wg:head/wg:word[@xlink:href &= $cid]
				return
				if ($wg and $wg/@xlink:href = $cid)
				then
					f:processChildWG($wg/ancestor::wg:group) 
				else
					""
		

			else
				for $ch in $c/*
					return
						f:processChild($ch)
				
				
};



declare function f:processChildWG($c) 
{
	let $nd := $c/local-name()
	return
	
 
			if ($nd='word')
			then

				let $w := collection('/db/papyrus')//w[@id&=$c/@xlink:href]

				return
					<wg:word xlink:href="{$w/@id}" id="{$w/@id}" wf="{ $w/wf cast as xs:string }">
						{
							for $ch in $c/*
					return
						f:processChildWG($ch)
						}
					</wg:word>
			else
			
				if ($nd='clause')
				then
					<cl:clause>
					{
					(
						let $wid := $c//wg:word[1]/@xlink:href
						return
						collection('/db/papyrus')//cl:clause[.//w/@xlink:href=$wid]/@*
							,	
						for $ch in $c/*
					return
						f:processChildWG($ch)
					)
					}
					</cl:clause>					
				else
						
			
				if ($nd='group' and count($c/ancestor::wg:group)>0 and count($c/ancestor::cl:clause)=0)
				then
					f:embeddedClause($c)
				
				else
				
				
				element { name($c) }
				{
					( $c/@*,
					
					for $ch in $c/*
					return
						f:processChildWG($ch)
						)
				}
};

declare function f:embeddedClause($c)
{
	<embeddedClause>
			{
			(
			let $wid := $c//wg:word[1]/@xlink:href
			return
			    
					collection('/db/papyrus')//cl:clause[.//w/@xlink:href=$wid]/@*
			,

			<wg:group>
				{ 
				
				( $c/@*,
					
					for $ch in $c/*
					return
						f:processChildWG($ch)
						)				
				}
			</wg:group>

	)
	}
	</embeddedClause>
};


let $xml :=

<chapter col="/{$book}/wordgroup" ch="-" filename="{$book}-wg">
{
if (exists($bk))

then
	util:eval(concat("document('/db/papyrus/", $book, "/wordgroup/", $book, "-wg.xml')//chapter/@*"))
else
util:eval(concat("document('/db/papyrus/", $book, "/clause/", $book, "-cl.xml')"))//chapter/@*
}
{
for $c in util:eval(concat("document('/db/papyrus/", $book, "/clause/", $book, "-cl.xml')"))//chapter/cl:clause

return
	f:processChild($c)
}
</chapter>

return
	  $xml 
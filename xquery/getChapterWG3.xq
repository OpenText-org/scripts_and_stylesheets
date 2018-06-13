xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
declare namespace transform="http://exist-db.org/xquery/transform";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";
 

declare variable $inSynopsis {
	 if (contains(request:request-uri(),'synopsis'))
	 then
		1
	else
		0

};
 
 declare variable $book { 
	 let $bk := 
		 if ($inSynopsis)
		 then
			 substring-before(substring-after(substring-after(request:request-uri(),'WordGroup'),'/'),'-') 
		 else
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
	
	
declare variable $ch {
	if ($inSynopsis)
	then
		substring-before(substring-after(request:request-uri(),'-'),'-')
	else
		request:request-parameter("ch",1)
};

declare variable $bk {
	if ($inSynopsis)
	then
		util:eval(concat("document('/db/opentext/synopsis/wordgroup/", $book, "/", $filename,".xml')//chapter/@book"))
	else
		util:eval(concat("document('/db/opentext/", $book, "/wordgroup/", $book, "-wg-ch",$ch,".xml')//chapter/@book"))
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
		if ($inSynopsis)
		then
			collection('/db/opentext/synopsis/wordgroup')//chapter[@book=$bk][@num=$ch]/wg:groups/wg:group/wg:head/wg:word
		else
			collection('/db/opentext')//chapter[@book=$bk][@num=$ch]/wg:groups/wg:group/wg:head/(wg:word|cl:clause/wg:group[1]/wg:head/wg:word)
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
		 let $w := collection('/db/opentext')//w[@id&=$nw/@xlink:href]

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
				let $wg := collection('/db/opentext')//wg:groups/wg:group/wg:head/wg:word[@xlink:href &= $cid]
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

				let $w := collection('/db/opentext')//w[@id&=$c/@xlink:href]

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
						collection('/db/opentext')//cl:clause[.//w/@xlink:href=$wid]/@*
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
			    if ($inSynopsis )
			    then
					collection('/db/opentext/synopsis')//cl:clause[.//w/@xlink:href=$wid]/@*
			    else
					collection('/db/opentext')//cl:clause[.//w/@xlink:href=$wid]/@*
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

if ($inSynopsis)
then


<chapter col="/synopsis/wordgroup/{$book}" filename="{$filename}" book="{$book}" 
xmlns:cl="http://www.opentext.org/ns/clause" 
xmlns:pl="http://www.opentext.org/ns/paragraph"
xmlns:wg="http://www.opentext.org/ns/wordgroup"
>
{
	if (exists($bk))
	then
		util:eval(concat("document('/db/opentext/synopsis/wordgroup/", $book, "/", $filename, ".xml')/chapter/@*"))
	else
	util:eval(concat("document('/db/opentext/synopsis/clause/", $book, "/",$filename,".xml')"))//chapter/@*
}
{

	for $c in util:eval(concat("document('/db/opentext/synopsis/clause/", $book, "/",$filename,".xml')"))//chapter/cl:clause

	return
		f:processChild($c)

}
</chapter>



else
<chapter col="/{$book}/wordgroup" ch="{$ch}" filename="{$book}-wg-ch{$ch}">
{
if (exists($bk))

then
	util:eval(concat("document('/db/opentext/", $book, "/wordgroup/", $book, "-wg-ch",$ch,".xml')//chapter/@*"))
else
util:eval(concat("document('/db/opentext/", $book, "/clause/", $book, "-cl-ch",$ch,".xml')"))//chapter/@*
}
{
for $c in util:eval(concat("document('/db/opentext/", $book, "/clause/", $book, "-cl-ch",$ch,".xml')"))//chapter/cl:clause

return
	f:processChild($c)
}
</chapter>

return
  if ($inSynopsis)
  then
   transform:transform($xml,'..\..\XSL\wgclause.xsl', <paramaters/>)  
  else
	 transform:transform($xml,'..\XSL\wgclause.xsl', <paramaters/>)  
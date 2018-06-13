xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
 
declare function f:parts() 
{
	let $chap := request:request-parameter("ch",1)
for $pn in distinct-values(//chapter[@num=$chap]/wg:part/@num)
return
 
   if (contains($pn,'_'))
   then
      for $pn2 in tokenize($pn,'_')
      return
          $pn2
   else
 	$pn		

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
	let $chap := request:request-parameter("ch",1)
	return
	
		if ($nd='clause')
		then
			f:clause($c)
		else
			if ($nd='w')
			then
				<w id="{$c/@xlink:href}">
				{
					let $pref := document('/db/opentext/mark/participant/mark-parts.xml')/participants/partRefs/chapter[@num=$chap]//wg:part[@xlink:href = $c/@xlink:href]
					return
						if ($pref/@*)
						then
							(
							   attribute pnum { $pref/@num },
							   $pref/@*[name()!='num' or local-name()!='href']
							)
						else
							""
				}
				{
					document('/db/opentext/mark/base/mark.xml')//w[@id=$c/@xlink:href]/*
				}
				</w>

			else
				element { name($c) }
				{
					for $att in $c/@*
					return
						$att,
					for $ch in $c/*
					return
						f:processChild($ch)
				}
};

let $ch := request:request-parameter("ch",1)
return
<data>


<chapter>
{
	util:eval(concat("document('/db/opentext/mark/clause/mark-cl-ch",$ch,".xml')/chapter/@*"))
}
{
for $c in util:eval(concat("document('/db/opentext/mark/clause/mark-cl-ch",$ch,".xml')"))//chapter/cl:clause
return
	f:clause($c)
}


</chapter>

{

			<participants xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink">
			{
				let $parts := document('/db/opentext/mark/participant/mark-parts.xml')/participants/partRefs/chapter[@num=$ch]//wg:part
				
				for $p in distinct-values(f:parts())
let $pcnt := count($parts[@num=$p or contains(concat('_',@num,'_'),concat('_',$p,'_'))])
order by $pcnt descending
return
   <part num="{$p}" total="{$pcnt}">
	   {
	document('/db/opentext/mark/participant/mark-parts.xml')//referents/participant[@num=$p]/@name
	   }
   </part>


				
			}
		 
 
			</participants>	


}

</data>
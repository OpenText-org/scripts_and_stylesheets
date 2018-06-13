xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 

declare variable $chap 
{
	substring-before(substring-after(request:request-uri(),'-'),'-')
};

declare variable $book 
{
	substring-before(substring-after(request:request-uri(),'showParticipants/'),'-')
};
 
declare function f:parts() 
{

for $pn in distinct-values(util:eval(concat("document('/db/opentext/synopsis/participant/", $book, "/", $book, "-parts.xml')"))/participants/partRefs/chapter[@num=$chap]//wg:part/@num)
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

	return
	
		if ($nd='clause')
		then
			f:clause($c)
		else
			if ($nd='w')
			then
				<w id="{$c/@xlink:href}">
				{
					let $pref := util:eval(concat("document('/db/opentext/synopsis/participant/", $book, "/", $book, "-parts.xml')/participants/partRefs/chapter[@num=", $chap, "]//wg:part[@xlink:href = $c/@xlink:href]"))
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
					util:eval(concat("collection('/db/opentext/", $book, "/base')//w[@id = '",  $c/@xlink:href,"']/*"))
				}
				</w>

			else
if ($nd='gloss')
 then
 $c
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

let $ch := substring-after(request:request-uri(),'showParticipants/')
return
<data>


<chapter c="{$ch}">
{
	util:eval(concat("document('/db/opentext/synopsis/clause/", $book, "/", $ch, ".xml')/chapter/@*"))
}
{
for $c in util:eval(concat("document('/db/opentext/synopsis/clause/", $book, "/", $ch,".xml')//chapter/cl:clause"))
return
	f:clause($c)
}


</chapter>

{

			<participants xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink">
			{
				let $parts := util:eval(concat("document('/db/opentext/synopsis/participant/", $book, "/", $book, "-parts.xml')"))/participants/partRefs/chapter[@num=$chap]//wg:part
				
				for $p in distinct-values(f:parts())
let $pcnt := count($parts[@num=$p or contains(concat('_',@num,'_'),concat('_',$p,'_'))])
order by $pcnt descending
return
   <part num="{$p}" total="{$pcnt}">
	   {
	util:eval(concat("document('/db/opentext/synopsis/participant/", $book, "/", $book, "-parts.xml')"))//referents/participant[@num=$p]/@name
	   }
   </part>


				
			}
		 
 
			</participants>	


}

</data>
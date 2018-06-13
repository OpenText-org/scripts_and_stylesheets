xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
declare variable $book {

if (contains(request:request-uri(),"edit"))
then
	substring-before(substring-after(substring-after(request:request-uri(),'/edit'),'/'),'-')
 else
 	substring-before(substring-after(substring-after(request:request-uri(),'/show'),'/'),'-')
};

declare variable $filename {

if (contains(request:request-uri(),"edit"))
then
	substring-after(substring-after(request:request-uri(),'/edit'), '/')
else
	substring-after(substring-after(request:request-uri(),'/show'), '/')
};

declare variable $cnum {
	substring-before(substring-after($filename,'-'),'-')
};

declare variable $baseDoc {
	util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')"))
};

 
 
declare function f:clause($c)
{
	<cl:clause >
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
				 
						 
						let $w := $baseDoc//w[@id&=$c/@xlink:href]
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
					for $att in $c/@*
					return
						$att,
					for $ch in $c/*
					return
						f:processChild($ch)
				}
};

<data>
 
<chapter col="/synopsis/clause/{$book}" filename="{$filename}" 
xmlns:cl="http://www.opentext.org/ns/clause" 
xmlns:pl="http://www.opentext.org/ns/paragraph">
{
	util:eval(concat("document('/db/opentext/synopsis/clause/", $book, "/", $filename, ".xml')/chapter/@*"))
}
{
for $c in util:eval(concat("document('/db/opentext/synopsis/clause/", $book, "/", $filename,".xml')"))//chapter/*[local-name()='clause']
return
	f:clause($c)
}
</chapter>
{
	if (contains(request:request-uri(),'editParticipant'))
		then
			<participants xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink">
			{
				util:eval(concat("document('/db/opentext/synopsis/participant/", $book, "/", $book, "-parts.xml')/participants/referents"))
			}
			<partRefs>
			{
				util:eval(concat("document('/db/opentext/synopsis/participant/", $book, "/", $book, "-parts.xml')"))/participants/partRefs/chapter[@num=$cnum]
			}
			</partRefs>
			</participants>	
		else
			let $mode := request:request-parameter("mode","null")
			return
				if (starts-with($mode,'display'))
				then

<domains>
			{

				let $wds := for  $wd in util:eval(concat("document('/db/opentext/synopsis/clause/", $book, "/", $filename, ".xml')//w")) return substring-after($wd/@xlink:href,'w') cast as xs:int
				let $wid1 := min($wds) cast as xs:int
				let $wid2 := max($wds) cast as xs:int
				
 

			
				let $domains :=
					util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter[@num=", $cnum, "]//w[xs:int(substring-after(@id,'w'))  >= ", $wid1, " and xs:int(substring-after(@id,'w') ) <= ", $wid2, "][VBF|VBP|VBN|NON|ADJ|ADV]/sem"))
				
				
				
for $d in distinct-values($domains/domain[@select][1]/@majorNum | $domains[count(domain)=1]/domain/@majorNum)

let $dcnt := count($domains/domain[@majorNum = $d][@select][1] | $domains[count(domain)=1]/domain[@majorNum=$d])
where $d != 92
order by $dcnt descending
return
   <dom num="{$d}" cnt="{$dcnt}" >
   {
     document('/db/opentext/lookup/domains.xml')//domain[@num=$d] cast as xs:string
   }
 
 
   </dom>		

			} 
			
			{
			document('/db/opentext/lookup/domains.xml')//domain
			}
	
</domains>					
				
				else
				""
			}
		</data>
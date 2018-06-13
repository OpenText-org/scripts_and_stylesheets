xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
 
declare variable $mode {

request:request-parameter("mode","null")
};
 
 
 declare variable $book { 
	 let $bk := substring-after(request:request-uri(),'Clause/')
	 return
		 if (string-length($bk)>0)
		 then
			 $bk
		else
			"mark" 
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
					let $w := document('/db/opentext/mark/base/mark.xml')//w[@id=$c/@xlink:href]
					return
						<w id="{$w/@id}" vs="{$w/ancestor::verse/@num}">
							{
								$w/*
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
	util:eval(concat("document('/db/opentext/", $book, "/clause/", $book, "-cl-ch",$ch,".xml')/chapter/@*"))
}
{
for $c in util:eval(concat("document('/db/opentext/", $book, "/clause/", $book, "-cl-ch",$ch,".xml')"))//chapter/cl:clause
return
	f:clause($c)
}


</chapter>

{
	if (contains(request:request-uri(),'editDomains'))
	then
		document('/db/opentext/lookup/domains.xml')//domains
	else
		if (contains(request:request-uri(),'editParticipant'))
		then
			<participants xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink">
			{
				document('/db/opentext/mark/participant/mark-parts.xml')/participants/referents
			}
			<partRefs>
			{
				document('/db/opentext/mark/participant/mark-parts.xml')/participants/partRefs/chapter[@num=$ch]
			}
			</partRefs>
			</participants>	
		else
			""
}

{ if (starts-with($mode,'display'))
then
	<domains>
	
			{


				let $domains := util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter[@num=",$ch,"]//w[VBF|VBP|VBN|NON|ADJ|ADV]/sem"))
				
for $d in distinct-values($domains/dom[@select]/@majorNum | $domains[count(dom)=1]/dom/@majorNum)

let $dcnt := count($domains/dom[@majorNum = $d][@select] | $domains[count(dom)=1]/dom[@majorNum=$d])

order by $dcnt descending

return

   <dom num="{$d}" cnt="{$dcnt}">
   {
     document('/db/opentext/lookup/domains.xml')//domain[@num=$d] cast as xs:string
   }
   </dom>	



				
			}
		 
 
			</domains>	
else
""
}

</data>
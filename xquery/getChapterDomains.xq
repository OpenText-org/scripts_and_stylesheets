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

			<domains>
			{
				let $domains := document('/db/opentext/mark/base/mark.xml')//chapter[@num=$ch]//w[VBF|VBP|VBN|NON|ADJ|ADV|PAR]/sem
				
for $d in distinct-values($domains/domain[@select]/@majorNum | $domains[count(domain)=1]/domain/@majorNum)

let $dcnt := count($domains/domain[@majorNum = $d][@select] | $domains[count(domain)=1]/domain[@majorNum=$d])

order by $dcnt descending

return

   <dom num="{$d}" cnt="{$dcnt}">
   {
     document('/db/opentext/lookup/domains.xml')//domain[@num=$d] cast as xs:string
   }
   </dom>		



				
			}
		 
 
			</domains>	


}

</data>
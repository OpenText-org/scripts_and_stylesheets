xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";

let $wds :=

let $sv := request:request-parameter('start', 'NT.1Thes.1.1')
let $ev := request:request-parameter('end', 'NT.1Thes.1.15')

let $sp := collection('/db/revised/opentext/1thessalonians/clause_with_base')//w[@ref=$sv][1]/ancestor::cl.clause[parent::chapter]
let $ep := collection('/db/revised/opentext/1thessalonians/clause_with_base')//w[@ref=$ev][last()]/ancestor::cl.clause[parent::chapter]



return
	(
	$sp[1],
	for $cl in $sp[1]/following::cl.clause[not(@level='embedded')]
	where $cl << $ep
	return $cl,
	if ($sp = $ep) then () else $ep
	)

return
<data>
	<chapter>
	{
	$wds
	}
	</chapter>

	<domains>
	
			{


			let $domains := $wds//w[pos/(VBF|VBP|VBN|NON|ADJ|ADV)]/sem
				
for $d in distinct-values($domains//domain[@select]/@majorNum | $domains[count(domain)=1]/domain/@majorNum)

let $dcnt := count($domains//domain[@majorNum = $d][@select] | $domains[count(domain)=1]/domain[@majorNum=$d])

order by $dcnt descending

return

   <dom num="{$d}" cnt="{$dcnt}">
   {
     document('/db/opentext/lookup/domains.xml')//domain[@num=$d] cast as xs:string
   }
   </dom>	



				
			}
		 
 
			</domains>	


</data>
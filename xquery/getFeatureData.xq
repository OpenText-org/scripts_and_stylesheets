
(::pragma exist:output-size-limit 200000 ::)

<book name="ephesians">
{
for $c in collection('/db/opentext/ephesians/clause')//cl:clause
let $p := $c/(cl:P|cl:*/cl:P) 
let $wds := for $w in $c//w
		return collection('/db/opentext')//w[@id &= $w/@xlink:href]
order by $c/ancestor::chapter/@num cast as xs:int, substring-after($c/@id,'_') cast as xs:int
return
	<row>
{ $c/@id }
	<predicator>
{
	if ($p)
	then
		$wds//w[(VBF|VBN|VBP)][@id &= $p/w/@xlink:href]/*[1]
	else ()
}
	</predicator>
	<theme>
		{ if ($c/(cl:S|cl:P|cl:C|cl:A))
			then 
				$c/(cl:S|cl:P|cl:C|cl:A)[1]/local-name() 
			else
				""
		}
	</theme>
	<level>
		{ $c/@level cast as xs:string }
	</level>
	<polarity>
		{
			if ($wds/wf/@betaLex='ou)' or $wds/wf/@betaLex='mh/')
			then
				"negative"
			else
				"positive"
		}
	</polarity>
	<person>
		{
			for $p in distinct-values($wds/*[1]/@per)
			return
				<num> { $p } </num>
		}
	</person>
	</row>
}
</book>

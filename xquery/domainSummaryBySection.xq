let $wds :=
let $sv := 'NT.Col.1.1'
let $ev := 'NT.Col.2.15'

let $sp := //w[@ref=$sv]
let $ep := //w[@ref=$ev]



return
	(
	$sp[1],
	for $w in $sp[1]/following::w
	where $w << $ep[last()]
	return $w,
	$ep[last()]
	)

return
	let $wds2 := $wds//w[pos/(VBF|VBP|VBN|NON|ADJ|ADV)]
	for $dom in distinct-values($wds2//domain/@majorNum)
	let $dfreq := count($wds2//domain[@majorNum=$dom])
	let $dname := document('/db/opentext/lookup/domains.xml')//domain[@num=$dom] 
	order by $dfreq descending
	return
		concat($dom, '.', $dname, ' ', $dfreq)
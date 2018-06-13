let $keyword := 'a)poqnh/|skw'
let $window := 6
let $wids := collection('/db/opentext')//w[wf/@betaLex[.&=$keyword]]
let $wds :=
	<line ref="{concat($wids/ancestor::book/@name,'.',$wids/ancestor::chapter/@num,'.',$wids/parent::verse/@num)}">
	{
	for $w in $wids 
	let $wnum := substring-after($w/@id,'w') cast as xs:int
	let $left := if ($wnum < $window) then 1 else $wnum - $window
	let $right := $wnum + $window
	return 
		(
			for $l in reverse(1 to $window)
			return
				$w/preceding::w[$l], 
			<kw> {$w} </kw>, 
			for $r in (1 to $window)
			return
				$w/following::w[$r])
	}
	</line>

return
	<data>
		
	{
			$wds
		}
		
</data>
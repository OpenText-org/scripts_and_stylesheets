xquery version "1.0";

declare namespace util="http://exist-db.org/xquery/util";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace f="http://www.opentext.org/xquery/functions";

declare variable $system {
	request:request-parameter("system",1)
};

declare variable $base {
	if ($system=1)
	then
		"0.478"
	else
		if ($system=2)
		then
			"0.869"
		else
			if ($system=3)
			then
				"0.451"
			else
				if ($system=4)
				then
					"0.543"
				else
					"0.5"
};

let $step := request:request-parameter('step', 20)
let $book := request:request-parameter('book','mark')

let $baseline := $base * 10
let $offsetX := 10
let $yscale := 10
let $data :=
	if ($system = 2)
	then
		 util:eval(concat("document('/db/featureData/", $book ,".xml')"))//predicator[not(.//@tf='fut' or .//@tf='aor')]//@tf
	else
		if ($system = 3)
		then
			util:eval(concat("document('/db/featureData/", $book, ".xml')"))//person/num
		else
			if ($system = 4)
			then
				util:eval(concat("document('/db/featureData/", $book, ".xml')"))//person/num[.!='3rd']
			else
				 util:eval(concat("document('/db/featureData/", $book ,".xml')"))//predicator[not(.//@tf='fut')]//@tf
		
let $width := (count($data) div $step) cast as xs:int		
		
return

<svg:svg xmlns:svg="http://www.w3.org/2000/svg" height="30px" width="{$width + 50}px" id="inline" >
 
 <svg:g transform="scale(2)">
{


 for $i in (0 to $width )
 let $max := ($i + 1) * $step
 let $min := $i * $step
 return
	let $slice := $data[position() > $min and position() <= $max]
	let $x := ($i * 1) + $offsetX
	
	let $cnt :=
		if ($system = 2)
		then
			count($slice[.='per' or .='plu'])
		else
			if ($system = 3)
			then
				count($slice[.!='3rd'])
			else
				if ($system = 4)
				then
					count($slice[.='1st'])
				else
					count($slice[.!='aor'])
	
	let $y := $yscale - ($cnt div $step) * $yscale
	let $color :=
		if ($baseline < $y) 
		then "#7070ff" else "#ff7070"
	return
		<svg:line x1="{$x}" y1="{$baseline}" 
			  x2="{$x}" y2="{$y}"
			style="stroke: {$color}; width: 10px;" />
		
}
{
	let $tcnt :=
		if ($system = 2)
		then
			count($data[.='per' or .='plu'])
		else
			if ($system = 3)
			then
				count($data[.!='3rd'])
			else
				if ($system = 4)
				then
					count($data[.='1st'])
				else
					count($data[.!='aor'])
	let $tprob := $tcnt div count($data)		
	return
		<text x="{$width + 5}" y="15" style="stroke: black; font-size: 8px;  font-family: Courier;">{substring($tprob,1,4)}</text>
}
</svg:g>
</svg:svg>
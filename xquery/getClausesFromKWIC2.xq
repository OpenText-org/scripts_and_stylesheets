xquery version "1.0";


declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
  
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/wordgroup";
declare namespace pl="http://www.opentext.org/ns/paragraph";
 
 
(::pragma exist:timeout 1000000 ::)
(::pragma exist:output-size-limit 300000 ::)

 
 declare variable $keyword {
	request:request-parameter('kw','au)qente/w')
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
			(:		let $w := util:eval(concat("collection('/db/opentext/", $book, "')"))//w[@id&=$c/@xlink:href]  :)
				let $w := collection('/db/opentext')//w/@id[. &= $c/@xlink:href ]/parent::w
				let $wg := collection('/db/opentext')//wg:group//wg:word[@xlink:href &= $c/@xlink:href]
				(:  
				wg="{$wg/ancestor::wg:group[1]/@id}" role="{$wg/parent::*/local-name()}" wgcnt="{count($wg/ancestor::wg:group[1]//wg:word)}"
				:)
					return
					
						<w id="{$w/@id}" vs="{$w/ancestor::verse/@num}" >
							{
								if ($w/wf/@betaLex=$keyword) then attribute kw { "true" } else ()
							}
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
				    if ($c/@*)
				    then
					for $att in $c/@*
					 
					return
						$att
					else ()
						,
					 
			 
					for $ch in $c/*
	
					return
						
						f:processChild($ch)
					 
				}
	 
};


let $window := request:request-parameter('window', 6)
let $wids := util:eval(concat("collection('/db/opentext')//w[wf/@betaLex&amp;='", $keyword, "']"))

let $start := request:request-parameter('start','NULL')
let $end := request:request-parameter('end','NULL')

let $clauses := 

for $w in util:eval(concat("$wids", if ($start != 'NULL' and $end !='NULL') then concat('[position()>=', $start,' and position() <=', $end, ']') else if($end != 'NULL') then concat('[position()<=', $end, ']') else if ($start != 'NULL') then concat('[position()>=', $start,']') else ''))
	let $wnum := substring-after($w/@id,'w') cast as xs:int
	let $left := if ($wnum < $window) then 1 else $wnum - $window
	let $right := $wnum + $window
	let $fwid := concat(substring-before($w/@id,'.w'),'.w',$left)
	let $lwid := concat(substring-before($w/@id,'.w'),'.w',$right)
	let $fc1 := util:eval(concat("//cl:clause//w[@xlink:href &amp;='", $fwid, "']"))[1]/ancestor::cl:clause[parent::chapter]
	let $lc1 := util:eval(concat("//cl:clause//w[@xlink:href &amp;='", $lwid, "']"))[1]/ancestor::cl:clause[parent::chapter]
	
	let $fc := $fc1[1]
	let $lc := $lc1[1]

	
	return 
<line ref="{concat($w/ancestor::book/@name,'.',$w/ancestor::chapter/@num,'.',$w/parent::verse/@num)}" s="{$fwid}" e="{$lwid}">
{	
if ($fc/*)
   then
	(
	$fc,
	for $c in $fc/following-sibling::cl:clause
	where
		$c/following::cl:clause[@id= $lc/@id]
	return
		$c,
	if ($lc/@id = $fc/@id) then () else $lc
)		
else
""
}
</line>

return
	<data>
		{
			for $l in $clauses//line
			return
				f:processChild($l)
		}
		
		   
   {
     document('/db/opentext/lookup/domains.xml')//domains
   }
   
	</data>

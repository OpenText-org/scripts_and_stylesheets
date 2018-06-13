
declare namespace util="http://exist-db.org/xquery/util";
declare namespace f="http://www.opentext.org/functions/xquery";

declare function f:xpath($node)
{

	concat(
	if (name($node)='contains')
	then ""
	else
		name($node),
	if ($node/@*)
	then
		f:atts($node/@*)
	else
		"",
	
	if ($node/*)
	then 
		concat("/", f:xpath($node/*))
	else
		""
	)
};

declare function f:atts($atts as node()+)
{
	
	concat("[@", name($atts[1]) ,"='", $atts[1] ,"']",
	if ($atts[2]) then f:atts(remove($atts,1)) else ""
	)
};


let $query :=
<clause>
	<sequence>
		<contains>
			<wg.group>
				<contains>
					<wg.word>
						<sem><dom majorNum="93"/></sem>
					</wg.word>
				</contains>
			</wg.group>
		</contains>

		 

		<cl.P>
			<wg.group>
				<wg.head>
					<wg.word>
						<VBF tf="pre"/>
					</wg.word>
				</wg.head>
			</wg.group>
		</cl.P>
	</sequence>
</clause>

let $search :=
<search>
for $c in //cl.clause  
{
for $comp at $p in $query//clause/*/*
return
	concat('let $comp', $p, ' := $c/', f:xpath($comp),'
')
 
}
where
{
for $comp at $p in $query//clause/*/*
return
	concat('$comp',$p, if ($p < count($query//clause/*/*)) then ' and ' else '')
}
return $c
</search>

return
 util:eval($search)

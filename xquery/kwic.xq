xquery version "1.0";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace f="http://www.opentext.org/xquery/functions";

(::pragma exist:timeout 30000 ::)

declare variable $spanwindow
{
	request:get-parameter("span",4) cast as xs:int
};

declare variable $keyword 
{
	request:get-parameter("keyword", "a)ga/ph")
};

declare variable $searchCollections 
{
	concat("'/db/opentext/NT/", request:get-parameter("book",'1john'), "'")

};

declare function f:left($node, $pos)
{

	if ($pos=0)
	then
		()
	else
(  
		f:left($node/preceding-sibling::w[1], $pos - 1), $node
)
 

};

declare function f:right($node, $pos)
{

	if ($pos=0)
	then
		()
	else
(  
		$node, 
		f:right($node/following-sibling::w[1], $pos - 1)
)
 

};

<results>
{
for $w in util:eval(concat("collection(",$searchCollections,")//w[wf/@betaLex &amp;= '", $keyword, "']"))
let $col := substring-before(util:collection-name($w),'/base')
order by $w cast as xs:string
return
 
 
	<hit ref="{$w/@ref}">
		{
			f:left($w/preceding::w[1],$spanwindow)
		}
		<keyword>
		{ $w }
		</keyword>
		{

				 f:right($w/following::w[1], $spanwindow)
		}
	</hit>
}
</results>
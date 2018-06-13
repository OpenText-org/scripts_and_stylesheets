xquery version "1.0";

(::pragma exist:output-size-limit 1000000 ::)

declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/ns/xquery";
declare namespace xlink="http://www.w3.org/1999/xlink";

declare function f:process($n)
{
	if ($n/self::w)
	then
		let $id := $n/@xlink:href
		let $col := replace(util:collection-name($n),'/clause$','/base')
		return
			collection($col)//id($id)
	else
		element { $n/name() } {
			($n/@*,
			for $children in $n/*
			return
				f:process($children)
			)
		}
};
let $book := "romans"
let $storeCol := util:eval(concat("xmldb:collection('/db/revised/opentext/", $book, "/clause_with_base', 'admin', 'xyz')"))
let $doc := concat($book,"-clb.xml")
let $xml: =
<book>
{
for $ch in util:eval(concat("collection('/db/revised/opentext/", $book, "/clause')/chapter"))
order by $ch/@num cast as xs:integer
return

	f:process($ch)
}
</book>

	return
		xmldb:store($storeCol,$doc,$xml)

xquery version "1.0";

(:
 script to find the number of clauses that contain a specific clause component,
i.e. SPCA as a percentage of total clauses in certain categories
:)

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";


(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";


declare variable $interval {
	500
};

declare variable $book {
	"acts"
};

declare variable $pos {
	"(VBF|VBP|VBN)"
};

<plot>
{

let $features := util:eval(concat("collection('/db/opentext/", $book, "/base')//w[", $pos, "]"))
let $wcnt := util:eval(concat("count(collection('/db/opentext/", $book, "/base')//w)"))

for $i in (1 to $wcnt)[. mod ($interval) = 0]
return
<point>
	<x>{$i}</x>
	<y>
		{
		let $fc := 
			for $w in $features//w 
				let $wid := substring-after($w/@id,'w') cast as xs:int
			where $wid ge $i and $wid lt $i+$interval 
			return
			    $w
		return
			( 
				<perfective>{ count($fc//@tf[.='aor']) }</perfective>, 
				<imperfective>{ count($fc//@tf[.='pre' or .='imp']) }</imperfective>,
				<stative> { count($fc//@tf[.='per' or .='plu']) } </stative>
				)
		}
	</y>
</point>
}
</plot>
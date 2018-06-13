xquery version "1.0";

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";


(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";

<test>
{
let $text1 := document('/db/opentext/mark/base/mark.xml')//chapter[@num='1']/verse[@num<10] 
let $text2 := document('/db/opentext/luke/base/luke.xml')//chapter[@num='1']/verse[@num<10]
let $text := <text> { $text1 } { $text2} </text>
return	
	for $y in ($text1//w | $text2//w)
	return
		<row> 
{
	for $x in ($text1//w | $text2//w)
	return
		<cell>

		{
			if ($y/wf  = $x/wf )
			then
				1
			else
				0	
		}

		</cell>
	 
	 }
</row>
	 
}
</test>

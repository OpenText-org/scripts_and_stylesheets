xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";

declare namespace wg="http://www.opentext.org/ns/word-group";
 


let $ch := request:request-parameter("ch",1)
return

<chapter xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause" xmlns:xlink="http://www.w3.org/1999/xlink" book="Mar" num="{$ch}">
<wg:groups>
{
for $w in document('/db/opentext/mark/base/mark.xml')//chapter[@num=$ch]//w
return
	<wg:group>
		<wg:word xlink:href="{$w/@id}">{$w/wf cast as xs:string}</wg:word>
	</wg:group>
}
</wg:groups>
</chapter>
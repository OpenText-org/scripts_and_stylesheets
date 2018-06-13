xquery version "1.0";

declare namespace xmldb="http://exist-db.org/xquery/xmldb";

(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";


declare variable $xupdate {
    <xu:modifications version="1.0" xmlns:xu="http://www.xmldb.org/xupdate">
        <xu:update select="/chapter//cl:clause[@level='secondary'][not(@connect)][ancestor::cl:clause]/@level">
            embedded
        </xu:update>
    </xu:modifications>
};

let $collection := xmldb:collection("xmldb:exist:///db/opentext/2corinthians/combined", "admin", "")
let $mods := xmldb:update($collection, $xupdate) 
return
    <result>
        <status>{$mods} modifications processed.</status>
    </result>

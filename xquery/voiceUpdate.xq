xquery version "1.0";

declare namespace xmldb="http://exist-db.org/xquery/xmldb";

(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";

declare namespace xlink="http://www.w3.org/1999/XLink";


declare variable $xupdate {
    <xu:modifications version="1.0" xmlns:xu="http://www.xmldb.org/xupdate">

        <xu:rename select="/chapter//(VBF|VBP|VBN)[@tf='pre' and (@voc='mid' or @voc='pas')]/@voc">voc2</xu:rename>

        <xu:rename select="/chapter//(VBF|VBP|VBN)[@tf='imp' and (@voc='mid' or @voc='pas')]/@voc">voc2</xu:rename>

        <xu:rename select="/chapter//(VBF|VBP|VBN)[@tf='per' and (@voc='mid' or @voc='pas')]/@voc">voc2</xu:rename>

        <xu:rename select="/chapter//(VBF|VBP|VBN)[@tf='plu' and (@voc='mid' or @voc='pas')]/@voc">voc2</xu:rename>



    </xu:modifications>
};

let $collection := xmldb:collection("xmldb:exist:///db/opentext/romans/combined", "admin", "")
let $mods := xmldb:update($collection, $xupdate) 
return
    <result>
        <status>{$mods} modifications processed.</status>
    </result>

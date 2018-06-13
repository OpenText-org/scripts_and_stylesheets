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

<plot>
{

for $c in collection('/db/opentext/1john')//chapter/cl:clause  
let $start := $c//w[1]/@xlink:href cast as xs:string
let $end := $c//w[position()=last()]/@xlink:href cast as xs:string

order by $c/ancestor::chapter/@num, substring-after($c//w[1]/@xlink:href,'w') cast as xs:int 
return 
<clause>
{$c/@id, attribute s { $start  }, attribute e { $end }}
{
	let $sid := substring-after($start ,'w') cast as xs:int
	let $eid := substring-after($end ,'w') cast as xs:int
	for $id in  ($sid to $eid)
	let $wd:= collection('/db/opentext/1john')//w[@id &=  concat('1joh.w',$id) ]
	return
		 if ($wd/VBF/@tf="pre") then <hit>{$id}</hit>  else ()
 }

</clause>

}
</plot>
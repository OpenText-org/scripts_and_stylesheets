xquery version "1.0";

declare namespace f="http://www.OpenText.org/functions/xquery";
declare namespace util="http://exist-db.org/xquery/util";

declare variable $key as xs:string {
	request:request-parameter("k","") 
} ;

declare function f:term-callback($term as xs:string, $data as xs:int+)
as item()* {
        <div> { $term } </div>
};

util:index-keys(collection("/db/opentext"), $key cast as xs:string,
        util:function("f:term-callback", 2), 1000)


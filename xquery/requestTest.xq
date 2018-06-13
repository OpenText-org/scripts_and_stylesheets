xquery version "1.0";

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";

(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";

declare function f:getCollections() as item()+
{
	let $req := request:request-parameter("checks","")
	for $i in (1 to count($req))
	return
		(
		 if ($i = count($req))
		 then
			concat("xcollection('/db/opentext/", $req[$i], "/clause')")
		 else
			concat("xcollection('/db/opentext/", $req[$i], "/clause') |")

	)
};

<html>
	<head>
		<title>Request Test</title>
	</head>

	<body>

		<pre>
					{ 

				let $params := f:getCollections()
return
			  concat("(", $params[1], $params[2], $params[3], $params[4], ")//cl:clause[@level='primary']")

			}
			
		</pre>

	</body>

</html>
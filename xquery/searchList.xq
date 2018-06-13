xquery version "1.0";

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";

(: Namespace for exist util functions :)
declare namespace util="http://exist-db.org/xquery/util";


(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";


<html>
   <head>
      <title>OpenText.org - Data searches</title>
   </head>
   <body>

	<h3>OpenText.org - Data summaries for Pauline Annotation</h3>

	<ul>
		{
			for $search in xcollection('/db/opentext/searches')//search
			return
			<li>
				<a href="searches.xq?search={$search/@document}">{ $search/title cast as xs:string }</a>

			</li>

		}

	</ul>

   </body>

</html>

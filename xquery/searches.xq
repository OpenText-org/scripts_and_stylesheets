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

let $search := request:request-parameter("search","clauseComp1")
return

<html>
   <head>
      <title>Clause Components</title>
   </head>
   <body>
      <form action="clauseComps.xq" target="frame">
      	<h4>
			{ util:eval(concat("document('/db/opentext/searches/",$search,".xml')//title")) cast as xs:string }
		</h4>
      	<div>
      		Romans
      		<input name="book" type="checkbox" value="romans" checked="checked"></input>
       
      	
      
      		1 Corinthains
      		<input name="book" type="checkbox" value="1corinthians"></input>

      		2 Corinthains
      		<input name="book" type="checkbox" value="2corinthians"></input>
      	 
       
      		Philippians
      		<input name="book" type="checkbox" value="philippians"></input>
      	 

      	 
      		Galatians
      		<input name="book" type="checkbox" value="galatians"></input>
            	

      		1 Thessalonians
      		<input name="book" type="checkbox" value="1thessalonians"></input>
      	
      		<input name="search" type="hidden" value="{$search}"/>
      	<input type="submit"/>
      	</div>     
      </form>
      
      <hr/>
      		<table width="100%" height="70%">
			<tbody>
				<tr>
					<td width="40%"> 
						<iframe width="100%" height="100%" border="no" id="frame" name="frame"/>
						
					</td>
					<td>
			 
						<iframe width="100%" height="100%" border="no" id="text" name="text"/>
					</td>
				</tr>
			</tbody>
		</table>
	</body>

</html>

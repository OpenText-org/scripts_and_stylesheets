xquery version "1.0";

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";

(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";


(: get participant list :)

declare function f:partlist() as element()+
{


		<select name="part" onchange="document.getElementById('text').src=''">
			<option>---</option>
		

		{	
			for $pt in document('/db/opentext/romans/participant/romans-part.xml')//participant
			return
			
				<option value="{$pt/@num}">{$pt/@num cast as xs:string}. {$pt/@name cast as xs:string}</option>
		

		}
		</select>
};


<html>
	<head>
		<title>OpenText.org - Participant Profile Tool</title>

		  

	</head>

	<body>
		<h3>Participant Profile Tool</h3>

		<form action="partprofile2.xq" target="frame">
		<span>Participant: { f:partlist() }</span>

		<span>&#160;Chapter: 
			<select id="ch" name="ch">
				<option value="all">all</option>
				{
					for $c in (1 to 16)
					return
						<option value="{$c}">{$c}</option>
				}
			</select>
		</span>
		<span> <input type="submit" value="get results"/></span>
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


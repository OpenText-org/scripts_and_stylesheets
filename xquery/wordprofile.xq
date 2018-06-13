xquery version "1.0";

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";

(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";


(: build lexicon from base file :)
declare function f:getLexicon()as element()+
{
	let $dom := request:request-parameter("dom", "0") 
	return
		<select onchange="document.getElementById('frame').src = 'wordprofile2.xq?word=' + this[this.selectedIndex].value; document.getElementById('text').src=''">
			<option>---</option>
		{
		if ($dom = 0)
		then
			for $lex in distinct-values(document('/db/opentext/romans/base/romans.xml')//wf/@betaLex)
			order by $lex
			return
				<option value="{$lex}"> { $lex } </option>
		else
			for $lex in distinct-values(document('/db/opentext/romans/base/romans.xml')//w[sem/dom/@majorNum=$dom]/wf/@betaLex)
			order by $lex
			return
				<option value="{$lex}"> { $lex } </option>
		}
		</select>

};

declare function f:domlist() as element()+
{
	let $dom := request:request-parameter("dom", "0") 
	return
		<select onchange="window.location = 'wordprofile.xq?dom='+this[this.selectedIndex].value">
		{	
			for $dn in document('/db/opentext/lookup/domains.xml')//domain
			return
				if ($dn/@num = $dom)
				then
					<option value="{$dn/@num}" selected="yes">{$dn/@num cast as xs:string}. {$dn cast as xs:string}</option>
				else
					<option value="{$dn/@num}">{$dn/@num cast as xs:string}. {$dn cast as xs:string}</option>
		}
		</select>


};


<html>
	<head>
		<title>OpenText.org - Word Profile Tool</title>

		  

	</head>

	<body>
		<h3>Word Profile Tool</h3>
		{
		let $dom := request:request-parameter("dom", "")
		return
			<div>Domain: { f:domlist() }
			<span> Word: </span>
{ f:getLexicon() }


			</div>


		 }		
		
		<hr/>
		<table width="100%" height="70%">
			<tbody>
				<tr>
					<td width="40%">
						<iframe width="100%" height="100%" border="no" id="frame"/>
					</td>
					<td>
						<iframe width="100%" height="100%" border="no" id="text" name="text"/>
					</td>
				</tr>
			</tbody>
		</table>
	</body>

</html>


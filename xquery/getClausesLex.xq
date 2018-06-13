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


(: return xml for clauses containing passed lexical item :)

declare variable $books {
	<books>
		<book id="Rom" col="romans"/>
		<book id="1Cor" col="1corinthians"/>
		<book id="2Cor" col="2corinthians"/>
		<book id="Gal" col="galatians"/>
		<book id="Phil" col="philippians"/>
		<book id="1Thes" col="1thessalonians"/>
	</books>

};


(: build collection statement based on input parameters :)

declare function f:book()
{
	let $id := request:request-parameter("cl","Rom.c1_1")
	let $bookAbbr := substring-before($id,'.')
	

	return
		if ($bookAbbr='Rom')
		then
			"romans"
		else
		if ($bookAbbr='1Cor')
		then
			"1corinthians"
		else
		if ($bookAbbr='2Cor')
		then
			"2corinthians"
		else
		if ($bookAbbr='1Thess')
		then
			"1thessalonians"
		else
		if ($bookAbbr='Gal')
		then
			"galatians"
		else
		if ($bookAbbr='Phil')
		then
			"philippians"
		else
			"romans"


};

<clauses>
	
	{
		let $id := request:request-parameter("lex","no/mos")
		return
			util:eval(concat("xcollection('/db/opentext/", f:book(), "/combined')//chapter/cl:clause[.//(cl:S|cl:P|cl:C|cl:A)/w/wf/@betaLex='no/mos']"))
	} 

</clauses>




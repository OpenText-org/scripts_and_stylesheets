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


declare variable $narrative {

('mark', 'matthew', 'luke', 'john', 'acts')

};

declare variable $exposition {
('romans', '1corinthians', '2corinthians', '1thessalonians', 
'2thessalonians', '1timothy', '2timothy', 'philemon', 'colossians', 'ephesians',
'galatians', 'philippians',
'1peter', 'jude', '3john', '1john', 'hebrews')
};

declare variable $books {
('mark', 'matthew', 'luke', 'john', 'acts',
'romans', '1corinthians', '2corinthians', '1thessalonians', 
'2thessalonians', '1timothy', '2timothy', 'philemon', 'colossians', 'ephesians',
'galatians', 'philippians',
'1peter', 'jude', '3john', '1john', 'hebrews')
};

<html>
<head>
<style>

</style>
</head>
<body>
<table>
<thead>
<tr>
<th>Book</th>
<th>Total # of <br/>unembedded clauses</th>
<th>contain P</th>
<th>contain S</th>
 <th>contain S and P</th>
 <th>thematized S</th>
</tr>
</thead>
<tbody>
{
	let $col1 :=
		for $bk at $p in $books
		return
			concat("'/db/opentext/", $bk, "'")
	let $col := concat("collection(", string-join($col1, ', '), " )//cl:clause[not(@level='embedded')]")	
	for $bk at $p in $col1
	let $cl := util:eval(concat("collection(", $bk, ")//cl:clause[not(@level='embedded')]"))
	let $total := count($cl)
	let $containPred := util:eval(concat("collection(", $bk, ")//cl:clause[not(@level='embedded')]/(cl:P|*/cl:P)"))
	let $containSub := util:eval(concat("collection(", $bk, ")//cl:clause[not(@level='embedded')]/(cl:S|*/cl:S)"))
	let $containBoth := util:eval(concat("collection(", $bk, ")//cl:clause[not(@level='embedded')][(cl:S|*/cl:S)][(cl:P|*/cl:P)]"))
	
	let $intialS := util:eval(concat("collection(", $bk, ")//cl:clause[not(@level='embedded')]/(cl:S|cl:P|cl:A|cl:C)[1]"))	
	let $containS := count($containSub)
	let $containP := count($containPred)
	let $containPS := count($containBoth)
	let $themeS := count($intialS//cl:S)
 
 	return	
		<tr>
			<td> { $books[$p] } </td>
			<td style="text-align: right"> { count($cl) } </td>
			<td style="text-align: right"> {  $containP } ({ substring(($containP div $total) * 100,1,5) }%) </td>
			
			<td style="text-align: right"> {  $containS } ({ substring(($containS div $total) * 100,1,5) }%)</td>
	 	 	<td style="text-align: right"> {  $containPS } ({ substring(($containPS div $total) * 100,1,5) }%)</td>
	 	 	<td style="text-align: right"> {   $themeS  } ({ substring(($themeS  div $containS) * 100,1,5) }%)</td>
	 	 
		</tr>
		
		
}</tbody>
</table>
</body>
</html>
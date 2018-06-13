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


(: build collection statement based on input parameters :)

declare function f:getCollections()
{
	let $req := request:request-parameter("book","romans")
	for $i in (1 to count($req))
	return
		(
		 if ($i = count($req))
		 then
			concat("'/db/opentext/", $req[$i], "/combined'")
		 else
			concat("'/db/opentext/", $req[$i], "/combined', ")

		)
};


declare function f:bookParams()
{
	let $req := request:request-parameter("book","romans")
	for $i in (1 to count($req))
	return
		(
		 if ($i = count($req))
		 then
			concat("book=",$req[$i])
		 else
			concat("book=",$req[$i],"&amp;")

		)
};




let $params := f:getCollections()
let $params2 :=  concat("collection(", $params, ")")

let $bk := f:bookParams()
let $bkReq := concat("&amp;",$bk[1], $bk[2], $bk[3], $bk[4], $bk[5], $bk[6])

let $cl1 := util:eval(concat("collection(", $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], ")//cl:clause[@level='primary']"))
let $cl2 := util:eval(concat("collection(", $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], ")//cl:clause[@level='secondary']"))
let $cl3 :=  util:eval(concat("collection(", $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], ")//cl:clause[@level='embedded']"))
let $totalChk := util:eval(concat("collection(", $params[1], $params[2], $params[3], $params[4], $params[5], $params[6], ")//cl:clause"))

return

<html>
	<head>
		<title>OpenText.org - Clause Components</title>
	</head>

	<body>
 
	<table border="1">
			<thead>
				<tr>
					<th>Pattern</th>
					<th>Primary</th>
					<th>%</th>
					<th>Secondary</th>
					<th>%</th>
					<th>Embedded</th>
					<th>%</th>
					<th>Total</th>
					<th>Total Check</th>

				
				</tr>
			</thead>
			<tbody>
					{
					for $r in util:eval(concat("document('/db/opentext/searches/", request:request-parameter("search","clauseComp1"), ".xml')//row"))
			
					return
				
					
					let $pri := util:eval(concat("count($cl1//cl:clause[@level='primary']",$r/xpath,")"))
					let $sec := util:eval(concat("count($cl2//cl:clause[@level='secondary']",$r/xpath,")"))	 
					let $emb := util:eval(concat("count($cl3//cl:clause[@level='embedded']",$r/xpath,")"))	 
					let $check := util:eval(concat("count($totalChk//cl:clause",$r/xpath,")"))	 
					let $total := $pri + $sec + $emb
					return
					<tr>
					<td>{$r/label}</td>
					<td>
						{ 
						if ($pri=0)
						then
							$pri
						else
							<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary']{$r/xpath}{$bkReq}">{$pri}</a>

						} 
					</td>
					<td>{ if ($total>0) 
						then 
							round($pri div $total * 100)
						else
							0
						}</td>
					<td>

						{ 
						if ($sec=0)
						then
							$sec
						else
							<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary']{$r/xpath}{$bkReq}">{$sec}</a>

						} 
					</td>
					<td>{ if ($total>0) 
						then
							round($sec div $total * 100)
						else
							0
						}</td>

					<td>

						{ 
						if ($emb=0)
						then
							$emb
						else
							<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='embedded']{$r/xpath}{$bkReq}">{$emb}</a>

						} 
					</td>
					<td>{ if ($total>0) 
						then
							round($emb div $total * 100)
						else
							0
						}</td>

					<td>{ $total } </td>
					<td>{ $check }</td>
					</tr>
					} 

					

			</tbody>
		</table>		



	</body>

</html>


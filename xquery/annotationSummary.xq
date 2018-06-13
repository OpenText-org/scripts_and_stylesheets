xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";


let $sort := request:get-parameter("sort","Mark")
return
 
<html>

	<head>
		<title>OpenText.org - Annotation Status</title>
		 <link rel="stylesheet" type="text/css" href="summary.css"/>
	</head>
	
	<body>

		<div class="menubar">
			<div class="title">Current Annotation</div>
		</div>
	
	
		<table width="100%">
			<thead>
				<tr>
					<th>Book</th>
					<th>Clause Annotation</th>
					 <th>Word Group Annotation</th>
				</tr>
			</thead>
			<tbody>
				{
					for $col at $p in collection('/db/opentext') 
					let $colname := util:collection-name($col)
					let $book := substring-before(substring-after($colname,'opentext/'),'/base')
				    where contains($colname,'base')
				    order by $colname
					return
						<tr>
							 <td>{ $book } </td>
							 <td >
							 {
							    for $ca in util:eval(concat("collection('/db/opentext/", $book, "/clause')/chapter"))
							    let $cnum := $ca/@num cast as xs:int
							    order by $cnum
							    return
							    <span>
									<a href="showClause/{$book}?ch={$cnum}"> { $ca/@num cast as xs:string } </a>
									&#160;
								</span>	
							 }
							 </td>
							 
							 <td class="col2">
							 {
							    for $wa in util:eval(concat("collection('/db/opentext/", $book, "/wordgroup')/chapter"))
							    let $cnum := $wa/@num cast as xs:int
							    order by $cnum
							    return
							    <span>
									<a href="showWordGroup/{$book}?ch={$cnum}"> { $wa/@num cast as xs:string } </a>
									&#160;
								</span>	
							 }
							 </td>							 
							 
						</tr>
				
				}
			</tbody>
		
		</table>
	
	</body>

</html>


xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";


let $sort := request:request-parameter("sort","Mark")
return
 
<html>

	<head>
		<title>Synoptic Menu</title>
		<link rel="stylesheet" type="text/css" href="synopsis.css"/>
	</head>
	
	<body>

		<div class="menubar">
			<div class="title">Synoptic Menu</div>
		</div>
	
	
		<table class="puTable" width="100%">
			<thead>
				<tr>
					<th>Title</th>
					<th>
					{
						if ($sort != 'Matt')
						then
							<a href="menu?sort=Matt">Matthew</a>
						else
							"Matthew"
					}
					</th>
					<th>
					{
						if ($sort != 'Mark')
						then
							<a href="menu?sort=Mark">Mark</a>
						else
							"Mark"
					}
					</th>
					<th>
					{
						if ($sort != 'Luke')
						then
							<a href="menu?sort=Luke">Luke</a>
						else
							"Luke"
					}
					</th>
				</tr>
			</thead>
			<tbody>
				{
					for $doc in collection('/db/opentext/synopsis')//parallelUnit
					let $ref := substring-after($doc/components/component[@id=$sort]/range[1]/@start,'.')
					let $ch :=  if ($ref) then number(substring-before($ref,'.')) else 100 
					let $vs := number(substring-after($ref,'.'))
					order by $ch, $vs
					return
						<tr>
							<td class="puTitle">  
									<a href="parallel?id={substring-before(util:document-name($doc),'.')}">{ $doc/title cast as xs:string } </a></td>
							<td> { if ($doc/components/component[@id='Matt'])
									  then
										 $doc/components/component[@id='Matt']/label  cast as xs:string
									  else
										  "-"
									} 
							</td>
							<td> { if ($doc/components/component[@id='Mark'])
									  then
										 $doc/components/component[@id='Mark']/label  cast as xs:string
									  else
										  "-"
									} 
							</td>
							<td> { if ($doc/components/component[@id='Luke'])
									  then
										 $doc/components/component[@id='Luke']/label  cast as xs:string
									  else
										  "-"
									} 
							</td>

						</tr>
				
				}
			</tbody>
		
		</table>
	
	</body>

</html>


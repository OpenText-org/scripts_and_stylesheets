xquery version "1.0";

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";

(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";

declare function f:getChapters()
{
	let $ch := request:request-parameter("ch","all")
	return
		if ($ch = 'all')
		then
			""
		else
			concat("//chapter[@num='", $ch, "']")
};

let $part := request:request-parameter("part","1")
let $chapNo := request:request-parameter("ch","")
let $chap := f:getChapters()

let $cl := util:eval(concat("xcollection('/db/opentext/romans/combined')",$chap,"//cl:clause[.//w/@partRef = $part]"))

return


<html>
	<head>
		<title>OpenText.org - Word Profile Tool</title>
	</head>

	<body >
		<table  border="1">
			<thead>
				<tr>
					<th>Subject</th>
					<th>Predicate</th>
					<th>Complement</th>
					<th>Adjunct</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td valign="top">

						<table>
							<tbody>
								<tr>
									<td valign="top">Pri.</td>

									<td valign="top">{ 
										let $ts := count($cl[@level='primary']/cl:S/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span> <a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:S/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>  
									{ let $tsh := count($cl[@level='primary']/cl:S/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='primary']/cl:S/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:S/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:S/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>
									}
									</span>
	
	
 									}
						
									</td>


 
								</tr>
								<tr>
									<td valign="top">Sec.</td>


									<td valign="top">{ 
										let $ts := count($cl[@level='secondary']/cl:S/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:S/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
									{ let $tsh := count($cl[@level='secondary']/cl:S/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='secondary']/cl:S/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:S/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:S/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>
									}
									
	</span>
	
 									}</td>
 
								</tr>
								<tr>
									<td valign="top">Emb.</td>
									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][ancestor::cl:clause]/cl:S/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:S/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
	
									{ let $tsh := count($cl[@level='secondary'][ancestor::cl:clause]/cl:S/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='secondary'][ancestor::cl:clause]/cl:S/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:S/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:S/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>

	
 									}
</span>
}
</td>
								</tr>
								<tr>
									<td valign="top">Total</td>
									<td valign="top">{ 
										let $ts := count($cl/cl:S/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[cl:S/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
									{ let $tsh := count($cl/cl:S/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl/cl:S/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:S/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:S/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>


										} </span> } 

									</td>
								</tr>
							</tbody>
						</table>
					</td>

					<!-- PREDICATE -->
					<td valign="top">
					<table><tbody><tr>
									<td valign="top">Pri.</td>

									<td valign="top">{ 
										let $ts := count($cl[@level='primary']/cl:P/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:P/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
	
	
 									}</td>


 
								</tr>
								<tr>
									<td valign="top">Sec.</td>


									<td valign="top">{ 
										let $ts := count($cl[@level='secondary']/cl:P/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
	
											<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:P/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
	
	
 									}</td>
 
								</tr>
								<tr>
									<td valign="top">Emb.</td>
									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][ancestor::cl:clause]/cl:P/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:P/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
	
	
 									}</td>
								</tr>
								<tr>
									<td valign="top">Total</td>
									<td valign="top">{ 
										let $ts := count($cl/cl:P/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:P/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
										}</td>
								</tr>
							</tbody>
						</table>
					</td>

					<!-- COMPLEMENT -->
							<td valign="top">
					<table><tbody><tr>
									<td valign="top">Pri.</td>

									<td valign="top">{ 
										let $ts := count($cl[@level='primary']/cl:C/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:C/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>

		{ let $tsh := count($cl[@level='primary']/cl:C/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='primary']/cl:C/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:C/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:C/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>
									}
									</span>

	
	
 									}</td>


 
								</tr>
								<tr>
									<td valign="top">Sec.</td>


									<td valign="top">{ 
										let $ts := count($cl[@level='secondary']/cl:C/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:C/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>

									{ let $tsh := count($cl[@level='secondary']/cl:C/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='secondary']/cl:C/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:C/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:C/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>
									}
									
	</span>
	
	
 									}</td>
 
								</tr>
								<tr>
									<td valign="top">Emb.</td>
									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][ancestor::cl:clause]/cl:C/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:C/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
	
								{ let $tsh := count($cl[@level='secondary'][ancestor::cl:clause]/cl:C/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='secondary'][ancestor::cl:clause]/cl:C/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:C/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:C/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>

	
 									}
</span>


	
 									}</td>
								</tr>
								<tr>
									<td valign="top">Total</td>
									<td valign="top">{ 
										let $ts := count($cl/cl:C/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[cl:C/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>


									{ let $tsh := count($cl/cl:C/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl/cl:C/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:C/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:C/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>


										} </span>

										}</td>
								</tr>
							</tbody>
						</table>
					</td>

					<!-- ADJUNCT -->
							<td valign="top">
					<table><tbody><tr>
									<td valign="top">Pri.</td>

									<td valign="top">{ 
										let $ts := count($cl[@level='primary']/cl:A/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:A/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
	
		{ let $tsh := count($cl[@level='primary']/cl:A/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='primary']/cl:A/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:A/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:A/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>
									}
									</span>

	
 									}</td>


 
								</tr>
								<tr>
									<td valign="top">Sec.</td>


									<td valign="top">{ 
										let $ts := count($cl[@level='secondary']/cl:A/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:A/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>
	
	{ let $tsh := count($cl[@level='secondary']/cl:A/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='secondary']/cl:A/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:A/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][cl:A/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>
									}
									
	</span>
	
 									}</td>
 
								</tr>
								<tr>
									<td valign="top">Emb.</td>
									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][ancestor::cl:clause]/cl:A/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:A/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>


								{ let $tsh := count($cl[@level='secondary'][ancestor::cl:clause]/cl:A/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl[@level='secondary'][ancestor::cl:clause]/cl:A/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:A/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:A/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>

	
 									}
</span>

	
	
 									}</td>
								</tr>
								<tr>
									<td valign="top">Total</td>
									<td valign="top">{ 
										let $ts := count($cl/cl:A/w[@partRef=$part]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[cl:A/w/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}"> { $ts } </a>

									{ let $tsh := count($cl/cl:A/w[@role='head'][@partRef=$part])
									  let $tsm := count($cl/cl:A/w[@role!='head'][@partRef=$part])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:A/w[@role='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:A/w[@role!='head']/@partRef='{$part}']&amp;part={$part}&amp;ch={$chapNo}">{$tsm}</a>)</div>


										} </span>


										}</td>
								</tr>
							</tbody>
						</table>
					</td>

				</tr>
			</tbody>
		</table>		
<!--
<div>TOTAL: { count($cl) }</div>
<div>TOTAL CHECK: { count(document('/db/opentext/romans/participant/romans-part.xml')//wg:part[@num=$part]) } </div>
-->
	</body>

</html>



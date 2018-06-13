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
		<select>
		{
		if ($dom = 0)
		then
			for $lex in distinct-values(document('/db/opentext/romans/base/romans.xml')//wf/@betaLex)
			order by $lex
			return
				<option> { $lex } </option>
		else
			for $lex in distinct-values(document('/db/opentext/romans/base/romans.xml')//w[sem/dom/@majorNum=$dom]/wf/@betaLex)
			order by $lex
			return
				<option> { $lex } </option>
		}
		</select>

};

let $word := request:request-parameter("word","no/mos")
let $cl := xcollection('/db/opentext/romans/combined')//cl:clause[.//wf/@betaLex = $word]
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
										let $ts := count($cl[@level='primary']/cl:S/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span> <a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:S/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>  
									{ let $tsh := count($cl[@level='primary']/cl:S/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='primary']/cl:S/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:S/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:S/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>
									}
									</span>
	
	
 									}
						
									</td>


 
								</tr>
								<tr>
									<td valign="top">Sec.</td>


									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][@connect]/cl:S/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:S/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
									{ let $tsh := count($cl[@level='secondary'][@connect]/cl:S/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='secondary'][@connect]/cl:S/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:S/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:S/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>
									}
									
	</span>
	
 									}</td>
 
								</tr>
								<tr>
									<td valign="top">Emb.</td>
									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][ancestor::cl:clause]/cl:S/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:S/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
	
									{ let $tsh := count($cl[@level='secondary'][ancestor::cl:clause]/cl:S/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='secondary'][ancestor::cl:clause]/cl:S/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:S/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:S/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>

	
 									}
</span>
}
</td>
								</tr>
								<tr>
									<td valign="top">Total</td>
									<td valign="top">{ 
										let $ts := count($cl/cl:S/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[cl:S/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
									{ let $tsh := count($cl/cl:S/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl/cl:S/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:S/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:S/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>


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
										let $ts := count($cl[@level='primary']/cl:P/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:P/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
	
	
 									}</td>


 
								</tr>
								<tr>
									<td valign="top">Sec.</td>


									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][@connect]/cl:P/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
	
											<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:P/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
	
	
 									}</td>
 
								</tr>
								<tr>
									<td valign="top">Emb.</td>
									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][ancestor::cl:clause]/cl:P/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:P/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
	
	
 									}</td>
								</tr>
								<tr>
									<td valign="top">Total</td>
									<td valign="top">{ 
										let $ts := count($cl/cl:P/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:P/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
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
										let $ts := count($cl[@level='primary']/cl:C/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:C/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>

		{ let $tsh := count($cl[@level='primary']/cl:C/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='primary']/cl:C/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:C/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:C/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>
									}
									</span>

	
	
 									}</td>


 
								</tr>
								<tr>
									<td valign="top">Sec.</td>


									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][@connect]/cl:C/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:C/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>

									{ let $tsh := count($cl[@level='secondary'][@connect]/cl:C/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='secondary'][@connect]/cl:C/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:C/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:C/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>
									}
									
	</span>
	
	
 									}</td>
 
								</tr>
								<tr>
									<td valign="top">Emb.</td>
									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][ancestor::cl:clause]/cl:C/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:C/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
	
								{ let $tsh := count($cl[@level='secondary'][ancestor::cl:clause]/cl:C/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='secondary'][ancestor::cl:clause]/cl:C/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:C/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:C/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>

	
 									}
</span>


	
 									}</td>
								</tr>
								<tr>
									<td valign="top">Total</td>
									<td valign="top">{ 
										let $ts := count($cl/cl:C/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[cl:C/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>


									{ let $tsh := count($cl/cl:C/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl/cl:C/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:C/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:C/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>


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
										let $ts := count($cl[@level='primary']/cl:A/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:A/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
	
		{ let $tsh := count($cl[@level='primary']/cl:A/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='primary']/cl:A/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:A/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='primary'][cl:A/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>
									}
									</span>

	
 									}</td>


 
								</tr>
								<tr>
									<td valign="top">Sec.</td>


									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][@connect]/cl:A/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:A/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>
	
	{ let $tsh := count($cl[@level='secondary'][@connect]/cl:A/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='secondary'][@connect]/cl:A/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:A/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][@connect][cl:A/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>
									}
									
	</span>
	
 									}</td>
 
								</tr>
								<tr>
									<td valign="top">Emb.</td>
									<td valign="top">{ 
										let $ts := count($cl[@level='secondary'][ancestor::cl:clause]/cl:A/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:A/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>


								{ let $tsh := count($cl[@level='secondary'][ancestor::cl:clause]/cl:A/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl[@level='secondary'][ancestor::cl:clause]/cl:A/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:A/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[@level='secondary'][ancestor::cl:clause][cl:A/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>

	
 									}
</span>

	
	
 									}</td>
								</tr>
								<tr>
									<td valign="top">Total</td>
									<td valign="top">{ 
										let $ts := count($cl/cl:A/w/wf[@betaLex=$word]) 
										return
											if ($ts = 0)
											then
												$ts
											else
												<span><a target="text" href="getClauses.xq?xpath=//cl:clause[cl:A/w/wf/@betaLex='{$word}']&amp;keyword={$word}"> { $ts } </a>

									{ let $tsh := count($cl/cl:A/w[@role='head']/wf[@betaLex=$word])
									  let $tsm := count($cl/cl:A/w[@role!='head']/wf[@betaLex=$word])

									  return
										<div> (<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:A/w[@role='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsh}</a>-<a target="text" href="getClauses.xq?xpath=//cl:clause[cl:A/w[@role!='head']/wf/@betaLex='{$word}']&amp;keyword={$word}">{$tsm}</a>)</div>


										} </span>


										}</td>
								</tr>
							</tbody>
						</table>
					</td>

				</tr>
			</tbody>
		</table>		

<div>TOTAL: { count($cl) }</div>
<div>TOTAL CHECK: { count(document('/db/opentext/romans/base/romans.xml')//wf[@betaLex=$word]) } </div>

	</body>

</html>



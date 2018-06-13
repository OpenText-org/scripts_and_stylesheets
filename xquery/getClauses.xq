xquery version "1.0";

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";
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

declare function f:getChaps($xp)
{
	let $ch := request:request-parameter("ch","all")
	return
		if ($ch = 'all')
		then
			$xp
		else
			concat("//chapter[@num='", $ch, "']",$xp)
};



<html>
	<head>
		<title>OpenText.org - Clause Search</title>
 		<link rel="stylesheet" href="opentext.css" />
	</head>

	<body>
	
		<ol>
		{
		let $params := f:getCollections()
		let $xpath1 := request:request-parameter("xpath","//cl:clause")
		let $xpath := f:getChaps($xpath1)
		let $part := request:request-parameter("part","")
		let $keyword := request:request-parameter("keyword","")
	 	for $c in util:eval(concat("collection(", $params[1],$params[2],$params[3],$params[4],$params[5],$params[6],")",$xpath))  
		order by substring-before($c/@id,'.'), substring-after(substring-before($c/@id,'_'),'c') cast as xs:integer
		return
			<li>
				<span>
					
					(<a target="_viewClause" href="viewClause?cl={$c/@id cast as xs:string}"> { $c/@id cast as xs:string } </a> [{$c//w[1]/@ref }])
				</span>
			
				{
					for $cp in $c/*
					return
						<nobr>
						<span class="comp1"><span style="vertical-align: super; font-size: 8pt"> { $cp/local-name() }</span>[</span>
				
					 	{
						for $w in $cp//wf
						return
							if ($w/@betaLex = $keyword)
							then
							<span class="keyword">{$w}</span>
							else
								if ($w/parent::w/@partRef = $part)
								then
									<span class="part">{$w}</span>

								else
									<span class="grk">{$w}</span>
					 		}
<span class="divide">]</span> </nobr>
				
				}
						
			</li>
		}
		</ol>
	</body>

</html>


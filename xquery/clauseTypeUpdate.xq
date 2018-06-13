xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace f="http://www.opentext.org/xquery/functions";
(: declare namespace xi="http://www.w3.org/2001/XInclude"; :)
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace xupdate="http://www.xmldb.org/xupdate";


declare variable $book
{
	request:request-parameter('book','mark')
};

declare variable $ch
{
	request:request-parameter('ch','1')
};

 
declare variable $xml 
{

<chapter  xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" >
{
	util:eval(concat("document('/db/opentext/", $book, "/clause/", $book, "-cl-ch",$ch,".xml')/chapter/@*"))
}
{
for $c in util:eval(concat("document('/db/opentext/", $book, "/clause/", $book, "-cl-ch",$ch,".xml')"))//chapter/cl:clause
return
	f:clause($c)
}


</chapter>

};
 
 
declare function f:clause($c)
{
	<cl:clause>

		{ for $ca in $c/@*
		   where $ca/local-name()!='clauseType' and  $ca/local-name()!='clauseSubtype' and $ca/local-name()!='connect' and $ca/local-name()!='connectType'
		  return
			   $ca
		  }
		{
			for $param in request:parameter-names()
			where substring-after($param,'_') = $c/@id
			return
				let $val := request:request-parameter($param,"")
				let $att := substring-before($param,'_')
				return
					if ($val != "")
					then
						attribute { $att } { $val }
					else
						$c/@*[name()=$att]

		}
		{ for $ch in $c/*
		  return
				f:processChild($ch)
		}
	</cl:clause>

};

declare function f:processChild($c) 
{
	let $nd := $c/local-name()
	return
	
		if ($nd='clause')
		then
			f:clause($c)
		else
 
				element { name($c) }
				{
					for $att in $c/@*
					return
						$att,
					for $ch in $c/*
					return
						f:processChild($ch)
				}
};




<html>
	
	{
		let $chapter := request:request-parameter("ch","null")
	 
		return
		<head>
		<title>Semantic Domain Update</title>
		<meta http-equiv="Refresh" content="0; url=/opentext/editClause?ch={$chapter}&amp;mode=clauseTypes"/>
	</head>
	}

	<body>
 

 {
		let $collection :=	xmldb:collection('xmldb:exist:///db/opentext/mark/clause','admin','xyz')
		let $file := concat($book, '-cl-ch', $ch, '.xml')
		
	   return
		   	<div>
					<h4>
						{  xmldb:store($collection, $file, $xml) }  updated
					</h4> 
					<div>your browser will return to clause type editing page... please wait
						
						
					</div>
				</div>
}

	</body>	
 </html>


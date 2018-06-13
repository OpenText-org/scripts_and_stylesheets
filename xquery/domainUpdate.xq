xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace f="http://www.opentext.org/xquery/functions";
(: declare namespace xi="http://www.w3.org/2001/XInclude"; :)
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace xupdate="http://www.xmldb.org/xupdate";


(: build the book xupdate query from input parameters :)
declare function f:buildXUpdate()
{
	 <xupdate:modifications version="1.0" xmlns:xupdate="http://www.xmldb.org/xupdate">
	 {
	for $param in request:parameter-names()
	where starts-with($param,'$')
	return
		let $wid := substring-after($param,'$')
		let $domval := request:request-parameter($param,'')
		return
				(
					<xupdate:remove select="/book/chapter/verse/w[@id='{$wid}']/sem/domain/@select"/>,
					<xupdate:append select="/book/chapter/verse/w[@id='{$wid}']/sem/domain[@majorNum={$domval}]">
						<xupdate:attribute name="select">1</xupdate:attribute>
					</xupdate:append>
			 	
			 	)
			
				
	 
		}
		 </xupdate:modifications>

};


declare variable $book {

	request:request-parameter("book","null")

};



<html>
	
	{
		let $chapter := request:request-parameter("chapter","null")
		let $reload := request:request-parameter("reload", concat("editDomains?ch=", $chapter))
	
		return
		<head>
		<title>Semantic Domain Update</title>
		<meta http-equiv="Refresh" content="0; url=/opentext/{$reload}"/>
	</head>
	}

	<body>


 {
		let $xupdate := f:buildXUpdate()
		return
			if ($xupdate = 'error' or $book='null')
			then
				""
			else
			(
				let $collection :=	util:eval(concat("xmldb:collection('xmldb:exist:///db/opentext/", $book, "/base','admin','xyz')"))
				let $modification := xmldb:update($collection, $xupdate)
				return
				<div>
					<h4>
						{ $modification cast as xs:string } words updated
					</h4> 
					<div>your browser will return to domain editing page... please wait
						
						
					</div>
				</div>
			) 
	
}
	</body>	
 </html>


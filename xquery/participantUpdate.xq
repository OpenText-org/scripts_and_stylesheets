xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace f="http://www.opentext.org/xquery/functions";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace xupdate="http://www.xmldb.org/xupdate";


(: build the book xupdate query from input parameters :)
declare function f:buildXUpdate()
{
	 <xupdate:modifications version="1.0" xmlns:xupdate="http://www.xmldb.org/xupdate">
	 {
	 let $book := request:request-parameter("book", "null")
	 let $ch := request:request-parameter("ch","null")
	
	return

				(
					<xupdate:remove select="/participants/partRefs/chapter[@num='{$ch}']"/>,
					<xupdate:append select="/participants/partRefs">
						<chapter num="{$ch}">
						{
						for $param in request:parameter-names()
						where starts-with($param,$book)
						return
							let $num := substring-before(request:request-parameter($param,""),'-')
							let $type := substring-before(substring-after(request:request-parameter($param,""),'-'),'}')
							let $rtype := substring-after(request:request-parameter($param,""),'}')
							return
							<wg:part num="{$num}" type="{$type}" xlink:href="{$param}">
								{ 
									if (string-length($rtype)>0)
									then
										attribute refType {
										$rtype
										}
									else
										""
								}
							</wg:part>
						}
						</chapter>
					</xupdate:append>,
					<xupdate:append select="/participants/referents">
					{
					for $newPart in request:parameter-names()
					where starts-with($newPart,'p')
					return	
							<participant num="{substring-after($newPart,'p')}" name="{request:request-parameter($newPart,'')}"/>
					}
					</xupdate:append>
			 	)
			
				
	 
		}
		 </xupdate:modifications>

};



let $ch := request:request-parameter("ch","null")
let $reload := request:request-parameter("reload", concat("editParticipant?ch=", $ch))
let $bookname := request:request-parameter("bookname", "null")
 return


<html>
	
	<head>
		<title>Participant annotation update</title>
		<meta http-equiv="Refresh" content="0; url=/opentext/{$reload}"/>
	</head>
	<body>


 {
		let $xupdate := f:buildXUpdate()
		return
			
			if ($xupdate = 'error')
			then
				""
			else
			(
				let $collection :=	
				 
						util:eval(concat("xmldb:collection('xmldb:exist:///db/opentext/synopsis/participant/", $bookname, "','admin','xyz')"))
				 
				let $modification := xmldb:update($collection, $xupdate)
				return
				<div>
					<h4>
						{ $modification cast as xs:string } : Updates Complete
					</h4> 
					<div>your browser will return to participant editing page... please wait
						
						
					</div>
				</div>
			) 
	
}
	</body>	
 </html>


xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
declare variable $book {
	substring-before(substring-after(request:request-uri(),'WordGroup/'),'-')
};

declare variable $filename {
	substring-after(request:request-uri(),'WordGroup/')
};

declare variable $baseDoc {
	util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')"))
};

 
 
declare function f:clause($c)
{
	<cl:clause >
		{ $c/@* }
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
	
 
			if ($nd='word')
			then
				let $w :=	collection('/db/opentext')//w[@id=$c/@xlink:href]
				return
					<wg:word id="{$w/@id}" wf="{ $w/wf cast as xs:string }">
						{
							for $ch in $c/*
					return
						f:processChild($ch)
						}
					</wg:word>
			else
				element { name($c) }
				{
					( $c/@*,
					
					for $ch in $c/*
					return
						f:processChild($ch)
						)
				}
};

 
<chapter col="/synopsis/wordgroup/{$book}" filename="{$filename}" book="{$book}" 
xmlns:cl="http://www.opentext.org/ns/clause" 
xmlns:pl="http://www.opentext.org/ns/paragraph"
xmlns:wg="http://www.opentext.org/ns/wordgroup"
>
{
	util:eval(concat("document('/db/opentext/synopsis/wordgroup/", $book, "/", $filename, ".xml')/chapter/@*"))
}
{
for $c in util:eval(concat("document('/db/opentext/synopsis/wordgroup/", $book, "/", $filename,".xml')"))//wg:groups/wg:group
return
	f:processChild($c)
}
</chapter>
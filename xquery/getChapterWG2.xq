xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
declare function f:clause($c)
{
	<cl:clause>
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
				let $w :=	document('/db/opentext/mark/base/mark.xml')//w[@id=$c/@xlink:href]
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

let $ch := request:request-parameter("ch",1)
return
<chapter>
{
	util:eval(concat("document('/db/opentext/mark/clause/mark-cl-ch",$ch,".xml')/chapter/@*"))
}
{
for $c in util:eval(concat("document('/db/opentext/mark/wordgroup/mark-wg-ch",$ch,".xml')"))//wg:groups/wg:group
return
	f:processChild($c)
}
</chapter>
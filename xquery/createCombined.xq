xquery version "1.0";

declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb"; 
declare namespace f="http://www.opentext.org/functions";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace xlink="http://www.w3.org/1999/xlink";


declare variable $clauses {
	document('/db/opentext/3john/clause/3john-cl-ch1.xml')/chapter/cl:clause
};

declare variable $wg {
	document('/db/opentext/3john/wordgroup/3john-wg-ch1.xml')/chapter/wg:groups
};

declare variable $hds {
	$wg/wg:group/wg:head/wg:word/@xlink:href,
	$wg//cl:clause/wg:group/wg:head/wg:word/@xlink:href
};
 
(: serialize the clause structure :)
declare function f:clauseStructure($c)
{
	let $structure :=
	for $comp in $c/*[not(self::gloss)]
	return
		($comp/local-name(), 
		if ($comp/cl:*[not(self::cl:clause)]) 
		then
			for $cp in $c/* return concat("(",$cp/local-name(),")")
		else ()
		)
	return
		string-join($structure,' ')
		
};

declare function f:clause($c)
{
	<cl.clause>
		{ $c/@* }
		{ attribute structure { f:clauseStructure($c) }}
		{ for $ch in $c/*
		  return
				f:processChild($ch)
		}
	</cl.clause>

};

declare function f:processChild($c) 
{
	let $nd := $c/local-name()
	return
	
		if ($nd='clause')
		then
			if (some $i in $wg//cl:clause satisfies $i/@xlink:href=$c/@id)
			then
				()
			else
				f:clause($c)
		else
			if ($nd='w')
			then
				if (some $v in $hds satisfies $v=$c/@xlink:href)
				then		
					let $wid := $c/@xlink:href
					return
						f:processChildWG($wg//wg:group[wg:head/wg:word/@xlink:href=$wid])
				else ()
			else
				(
				element { translate(name($c),':','.') }
				{
					for $att in $c/@*
					return
						$att,
					for $ch in $c/*[not(self::cl:*[not(self::cl:clause)] or self::pl:conj)]
					return
						f:processChild($ch)
				},
				for $ch in $c/(cl:*[not(self::cl:clause)]|pl:conj)
				return 
					f:processChild($ch)
			)
};


(: process child elements in a word group :)

declare function f:processChildWG($c) 
{
	let $nd := $c/local-name()
	return
	
 
			if ($nd='word')
			then

				let $w := collection('/db/opentext')//w[@id &= $c/@xlink:href]

				return
					<wg.word id="{$w/@id}" >
						 
						{
							$w/*, 
							for $ch in $c/*
					return
(
						f:processChildWG($ch) )
						}
					</wg.word>
			else
			
				if ($nd='clause')
				then
					let $cid := $c/@xlink:href
					return
						f:clause($clauses//cl:clause[@id&=$cid])

				else
						
				
				element { translate(name($c),':','.') }
				{
					( $c/@*,
					
					for $ch in $c/*
					return
						f:processChildWG($ch)
						)
				}
};

let $col := xmldb:collection('xmldb:exist:///db/opentext/combined/3john','admin','xyz')
let $doc := '3john-ch1.xml'
let $result :=

<chapter>
{
$clauses/ancestor::chapter/@*, 		

  for $c in $clauses
  return 	
f:clause($c)
 
	
}
</chapter>

return
	xmldb:store($col,$doc,$result)

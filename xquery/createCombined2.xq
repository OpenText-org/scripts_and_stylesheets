xquery version "1.0";

declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb"; 
declare namespace f="http://www.opentext.org/functions";
 
declare namespace xlink="http://www.w3.org/1999/xlink";


declare variable $clauses {
	document('/db/revised/opentext/philemon/clause/philemon-cl-ch1.xml')/chapter/cl.clause
};

declare variable $wg {
	document('/db/revised/opentext/philemon/wordgroup/philemon-wg-ch1.xml')/chapter/wg.groups
};

declare variable $hds {
	$wg/wg.group/wg.head/wg.word/@xlink:href,
	$wg//cl.clause/wg.group/wg.head/wg.word/@xlink:href
};
 



declare function f:clause($c)
{
	<cl.clause>
		{ $c/@* }
		 
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
	
		if ($nd='cl.clause')
		then
			if (some $i in $wg//cl.clause satisfies $i/@xlink:href=$c/@xml:id)
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
						f:processChildWG($wg//wg.group[wg.head/wg.word/@xlink:href=$wid])
				else ()
			else
				(
				element { translate(name($c),':','.') }
				{
					for $att in $c/@*
					return
						$att,
					for $ch in $c/(cl.clause|w)
					return
						f:processChild($ch)
				},
				for $ch in $c/(pl.conj|*[starts-with(name(),'cl.') and not(self::cl.clause)])
				return 
					f:processChild($ch)
			)
};


(: process child elements in a word group :)

declare function f:processChildWG($c) 
{
	let $nd := $c/local-name()
	return
	
 
			if ($nd='wg.word')
			then

				let $w := collection('/db/revised')//id($c/@xlink:href)

				return
					<wg.word xml:id="{$w/@xml:id}" ref="{$w/@ref}">
						 
						{
							$w/*, 
							for $ch in $c/*
					return
(
						f:processChildWG($ch) )
						}
					</wg.word>
			else
			
				if ($nd='cl.clause')
				then
					let $cid := $c/@xlink:href
					return
						f:clause($clauses//cl.clause[@xml:id&=$cid])

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

let $col := xmldb:collection('xmldb:exist:///db/revised/opentext/philemon/combined','admin','xyz')
let $doc := 'philemon-combined.xml'
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

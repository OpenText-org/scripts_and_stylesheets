xquery version "1.0";

(: Namespace for the local functions in this script :)
declare namespace f="http://opentext.org/xquery/local-functions";

(: Namespace for the request module (automatically loaded) :)
declare namespace request="http://exist-db.org/xquery/request";

(: Namespace for exist util functions :)
declare namespace util="http://exist-db.org/xquery/util";


(: OpenText.org namespaces :)
declare namespace pl="http://www.opentext.org/ns/paragraph";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";


declare variable $books {
	<books>
		<book id="Rom" col="romans"/>
		<book id="1Cor" col="1corinthians"/>
		<book id="2Cor" col="2corinthians"/>
		<book id="Gal" col="galatians"/>
		<book id="Phil" col="philippians"/>
		<book id="1Thes" col="1thessalonians"/>
	</books>

};


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
	
		if ($nd='clause')
		then
			f:clause($c)
		else
			if ($nd='w')
			then
					let $w := collection('/db/opentext')//w[@id&=$c/@xlink:href]
					return
					
						<w id="{$w/@id}" vs="{$w/ancestor::verse/@num}">
							{
								$w/*
							}
						</w>
			else
 if ($nd='gloss')
 then
 $c
 else
				element { name($c) }
				{
				    if ($c/@*)
				    then
					for $att in $c/@*
					 
					return
						$att
					else ()
						,
					 
			 
					for $ch in $c/*
	
					return
						
						f:processChild($ch)
					 
				}
	 
};




<clauses>
	
	{
		for $id in request:request-parameter("cl","Rom.c1_1")
		return
			collection('/db/opentext/")//cl:clause[@id &= $id]
	} 

</clauses>




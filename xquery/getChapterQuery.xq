xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
 

 
 
 declare variable $book { 
	 let $bk := substring-after(request:request-uri(),'Clause/')
	 return
		 if (string-length($bk)>0)
		 then
			 $bk
		else
			"mark" 
	};
 
 
 
declare function f:clause($c)
{
	<cl:clause>
		{ $c/@*[local-name()!='connect'] }
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

let $query := request:request-parameter("_query","//cl:clause[cl:P[cl:f][cl:v]]")
return
<data>


<chapter>
{
for $c in util:eval(concat("collection('/db/opentext')", $query))
return
	f:clause($c)

}


</chapter>







</data>
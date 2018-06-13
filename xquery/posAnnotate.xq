xquery version "1.0";

(::pragma exist:timeout 30000000 ::)

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
 

 
 
 declare variable $book { 
	 let $bk := substring-after(request:request-uri(),'editClause/')
	 return
		 if (string-length($bk)>0)
		 then
			 $bk
		else
			"mark" 
	};
 
 
 declare function f:searchWF($n)
 {
	let $wf := translate($n/text(),'[]<>','')
	let $w := collection('/db/opentext')//wf[.&=$wf]/parent::w[@id]
	return
		if (exists($w))
		then
			if (exists($w/sem))
			then
				$w[sem][1]/*
			else
				if (exists($w/(VBF|VBN|VBP|NON|ADJ|PAR|ADV|PRP)))
				then
					$w[1]/*
				else
				( <notag/>,   $n  )
		else
			( <notag/>,   $n  )
 };
 

declare function f:processChild($c) 
{
	let $nd := $c/local-name()
	return
	
		if ($nd='wf')
		then
			f:searchWF($c)
		else
			   
				element { name($c) }
				{
					for $att in $c/@*
					return
						$att,
						
					if ($c/*)
					then
						for $ch in $c/*
						return
							f:processChild($ch)
					else
						$c/text()
				}
};

 let $cnum := request:request-parameter("ch",1)
 
let $doc := document('/db/opentext/AF/diognetus/base/diognetus.xml')//chapter[@num=$cnum]
return
	f:processChild($doc)


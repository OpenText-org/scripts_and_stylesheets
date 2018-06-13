xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
 
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/wordgroup";
declare namespace pl="http://www.opentext.org/ns/paragraph";
 
 declare variable $ch {
	request:request-parameter("ch",1)
};

 

 declare variable $mode {
	 if ( contains(request:request-uri(), 'editC'))
	 then
		 "edit"
	else
		"view"
 };
 
 declare variable $book { 
	 let $bk := substring-after(request:request-uri(),'Clause/')
	 return
		 if (string-length($bk)>0)
		 then
			 $bk
		else
			let $bk2 := substring-after(request:request-uri(),'Domains/')
			return
				 if (string-length($bk2)>0)
				 then
					 $bk2
				else
					"mark" 
	};
 
 declare variable $user {
        request:request-parameter("uid", "null")
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
			(:		let $w := util:eval(concat("collection('/db/opentext/", $book, "')"))//w[@id&=$c/@xlink:href]  :)
				let $w := collection('/db/opentext')//w/@id[. &= $c/@xlink:href ]/parent::w
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


let $doc :=  
	if ($user != 'null')
	then
		util:eval(concat("document('/db/opentext/user/", $user, "/clause/", $book, "-cl-ch",$ch,".xml')"))
	
	else
		util:eval(concat("document('/db/opentext/", $book, "/clause/", $book, "-cl-ch",$ch,".xml')"))
return
	<data>
	{
		if (exists($doc//chapter))
		then
				<chapter>
		{
			$doc//chapter/@*
		}
		{
			for $c in $doc//chapter/cl:clause
			return
				f:clause($c)
		}
		</chapter>
		else

 
		let $bk := util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//book"))
	return
		<chapter num="{$ch}" book="{$bk/@name}">
			{ if ($user != 'null') then attribute user { $user } else () }
		</chapter>

}
{
if ( $mode = 'edit' )
then
<words>
	{
		let $wds := util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter[@num=", $ch, "]//w"))
		for $w in $wds 
		return
			if ($doc//w/@xlink:href = $w/@id)
			then ()
			else
				$w
	
	}
	 
</words>
else
	()
}

{
	if (contains(request:request-uri(),'editDomains'))
	then
		document('/db/opentext/lookup/domains.xml')//domains
	else
 if (request:request-parameter('mode','null')='display')
 then
	<domains>
	
			{


			let $domains := util:eval(concat("document('/db/opentext/", $book, "/base/", $book, ".xml')//chapter[@num=",$ch,"]//w[VBF|VBP|VBN|NON|ADJ|ADV]/sem"))
				
for $d in distinct-values($domains/domain[@select]/@majorNum | $domains[count(domain)=1]/domain/@majorNum)

let $dcnt := count($domains/domain[@majorNum = $d][@select] | $domains[count(domain)=1]/domain[@majorNum=$d])

order by $dcnt descending

return

   <dom num="{$d}" cnt="{$dcnt}">
   {
     document('/db/opentext/lookup/domains.xml')//domain[@num=$d] cast as xs:string
   }
   </dom>		



				
			}
		 
 
			</domains>	

 else ""

}
</data>
xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";



declare variable $lexform 
{
	let $lex := request:request-parameter("lex", "no/mos")
    return $lex
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


declare function f:processChildWG($c) 
{
	let $nd := $c/local-name()
	return
	
 
			if ($nd='word')
			then
				let $w :=	collection('/db/opentext')//w[@id=$c/@xlink:href]
				return
					<wg:word id="{$w/@id}" wf="{ $w/wf cast as xs:string }" >
					{ $w/wf/@betaLex }
						{
							for $ch in $c/*
					return
						f:processChildWG($ch)
						}
					</wg:word>
			else
				element { name($c) }
				{
					( $c/@*,
					
					for $ch in $c/*
					return
						f:processChildWG($ch)
						)
				}
};
 
let $lex := //w[wf/@betaLex=$lexform]
 
return
  <lexicalProfile>
   <word>
     <occurrences>{ count($lex) }</occurrences>
     <POS> { $lex[1]/*[1]/name() } </POS>
     <lexical> { $lex[1]/wf[1]/@betaLex } { $lex[wf[1][@betaForm=$lexform]][1]/wf/text() } </lexical>
     { $lex[sem][1]/sem }
   </word>
   {
       for $wf in distinct-values($lex/wf)
       let $w1 := $lex[wf=$wf]
       let $freq := count($w1)
       order by $freq descending
       return
         <form cnt="{$freq}"> 
          {
             $w1[1]/*[1]
          }
          <wf>{ $wf	} </wf>
          <occurrences> { $freq } </occurrences>
          </form>
   }
 
   <clause>
   {
	   let $cl := 
	         for $wds in $lex 
	         return
	             f:clause(//cl:clause[.//w/@xlink:href=$wds/@id])
	    return
			count($cl)
   }
   </clause>
   <wordgroup>
 {
	   let $wg := 
	         for $wds in $lex 
	         return
	             f:processChildWG(//wg:group[.//wg:word/@xlink:href=$wds/@id])
	    return
			$wg
   }   
   </wordgroup>
</lexicalProfile>


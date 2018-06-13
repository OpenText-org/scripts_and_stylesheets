xquery version "1.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace f="http://www.opentext.org/functions";
declare namespace xlink="http://www.w3.org/1999/xlink";
declare namespace transform="http://exist-db.org/xquery/transform";
declare namespace cl="http://www.opentext.org/ns/clause";
declare namespace wg="http://www.opentext.org/ns/word-group";
 
declare function f:distinct-deep-equals($seq as item()*) as item()* {
   f:dde((), $seq)
};

declare function f:dde($done as item()*, $todo as item()*) as item()* {
   if (empty($todo)) then $done
   else if (some $d in $done satisfies deep-equal($d, $todo[1]))
        then f:dde($done, f:remove($todo, 1))
        else f:dde(($done, $todo[1]), f:remove($todo, 1))
};

declare function f:remove($seq as item()*, $pos) as item()* {
	$seq[position() > 1]
};

 
 <results>
 
 {

let $voc := //w[*/@cas='voc']

for $wf in distinct-values($voc//w/wf/@betaForm)
let $vcnt := count($voc//w[wf/@betaForm=$wf])
let $pos := f:distinct-deep-equals($voc//w[wf/@betaForm=$wf]/*[1])
order by $vcnt descending
return
   <form wf="{$wf}" cnt="{$vcnt}">
	   { $pos }
   </form>
   
  }
  </results>
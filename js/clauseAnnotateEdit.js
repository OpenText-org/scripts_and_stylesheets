

    /* ------- Define global variables ------------------- */
   
    var cnum=1;

    var selected = new Array();

    var moveNode = document.createElement("move");
    var move = false;

    var wdX = 10;
    var wdY = 10;
    var menuX = 600;
    var menuY = 10;

    /* --------------------------------------------------------- */
    
   // create a pull down list of clause component options to allow
   // change from one value to another, i.e. change an 'A' component label to a 'C'
   // without having to create a new component unit and move words

   function compOpts()
   {
	   var copts = document.createElement("select");
	   copts.style.fontSize="10pt"; 
	   copts.style.fontWeight="bold"; 
	   copts.onchange=function () { var comp = this[this.selectedIndex].value; this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.comp = comp;  };
	
	     
	   var S = document.createElement("option");
	   S.value="S";
	   S.style.color = "black";
	   S.appendChild(document.createTextNode("S"));
	   
	   var C = document.createElement("option");
	   C.value="C";
	   C.style.color = "black";
	   C.appendChild(document.createTextNode("C"));

	   var A = document.createElement("option");
	   A.value="A";
	   A.style.color = "black";
	   A.appendChild(document.createTextNode("A"));

	   var gap = document.createElement("option");
	   gap.value="gap";
	   gap.style.color = "black";
	   gap.appendChild(document.createTextNode("gap"));
	   
	   var conj = document.createElement("option");
	   conj.value="conj";
	   conj.style.color = "black";
	   conj.appendChild(document.createTextNode("conj"));
	   
	   copts.appendChild(C);
	   copts.appendChild(A);
	   copts.appendChild(S);
	   copts.appendChild(gap);
	   copts.appendChild(conj);
	   
	   return copts;
   }
   
   
   // show-hide gloss row in clause
   	function showGloss(evtNode)
	{
		event.cancelBubble = true;
		
	    // get TD in next row of clause table
		var gloss = evtNode.parentNode.parentNode.nextSibling.firstChild;
		
		if (gloss.style.display == 'none')
		{
            gloss.style.display = 'inline';		
		}
		else
		{
		    gloss.style.display='none';
		}
	
	}
   
   // projected clauses are indented
   function setProjected(node)
   {
	   event.cancelBubble = true;
	   
	   if (!node) { node=this; }
	   
	   var cl = node.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
	   var ml = cl.style.marginLeft;  
	   ml = ml.substr(0,ml.indexOf('px')==-1 ? 0 : ml.indexOf('px'));
 
	   if (node.checked)
	   {
		   cl.style.marginLeft = ml*1 + 15;
	   }
	   else
	   {
		   cl.style.marginLeft = ml*1 - 15;
	   }
	   
	   
   }
  
    

	// create controls (SPCA comps, delete, connect etc.)
    function controls(cnum)
    { 
       var controls = document.createElement("span");
       controls.id = "con" + cnum;
       var S = document.createElement("img");
       S.src="img/S.gif";
       S.alt="Add subject component";
       S.cl = cnum;
       S.comp = "S";
       S.onclick = addComponent;


       var P = document.createElement("img");
       P.src="img/P.gif";
       P.alt="Add predicate component";
       P.cl = cnum;
       P.comp = "P";
       P.onclick = addComponent;

       var C = document.createElement("img");
       C.src="img/C.gif";
       C.alt="Add complement component";
       C.cl = cnum;
       C.comp = "C";
       C.onclick = addComponent;

       var A = document.createElement("img");
       A.src="img/A.gif";
       A.alt="Add adjunct component";
       A.cl = cnum;
       A.comp = "A";
       A.onclick = addComponent;
 
      var  conj = document.createElement("img");
       conj.src="img/conj.gif";
       conj.alt="Add paragraph level conjunction";
       conj.cl = cnum;
       conj.comp = "conj";
       conj.onclick = addComponent;
       
      var gap = document.createElement("span");
      gap.appendChild(document.createTextNode("gap"));
      gap.alt="Add gap component to hold intervening clauses";
      gap.cl=cnum;
      gap.className = "compButton";
      gap.comp="gap";
      gap.onclick = addComponent

       var remove = document.createElement("img");
       remove.src="img/x.gif";
       remove.alt="Remove clause and empty content";
       remove.cl = cnum;
       remove.onclick = removeClause;

       var form = document.createElement("form");
       level = document.createElement("select");
       level.onclick = bubbleCancel;
       level.onchange = changeLevel;
       primary = document.createElement("option");
       primary.setAttribute("value","primary");
       primary.appendChild(document.createTextNode("Primary"));
      secondary = document.createElement("option");
       secondary.setAttribute("value","secondary");
       secondary.appendChild(document.createTextNode("Secondary"));
      secondary2 = document.createElement("option");
       secondary2.setAttribute("value","secondary2");
       secondary2.appendChild(document.createTextNode("Secondary (dep)"));
       level.appendChild(primary);
       level.appendChild(secondary);
       level.appendChild(secondary2);


       connection = document.createElement("input");
       connection.type = "text";
       connection.size = 8;     
       connection.onclick=bubbleCancel;
       connection.value = bookid + ".c" + chnum + "_";  
      
       connection.style.fontFamily = "Arial";
       connection.style.fontSize = "8pt";
       connection.style.color="green";
       connection.style.backgroundColor="#c0c0c0";
       
       var pspan = document.createElement("span");
       pspan.style.fontFamily = "Arial";
       pspan.style.fontSize = "8pt";
       pspan.style.color="blue";
       pspan.style.whiteSpace="nowrap";
       var project = document.createElement("input");
       project.type="checkbox";
       project.onclick=setProjected;
       project.name="projected";
 
       pspan.appendChild(document.createTextNode("proj"));
       pspan.appendChild(project);

       form.appendChild(level);
       form.appendChild(connection);
       form.appendChild(pspan);
       form.onsubmit = cancelForm;

       controls.appendChild(S);
       controls.appendChild(P);
       controls.appendChild(C);
       controls.appendChild(A);
       controls.appendChild(conj);
       controls.appendChild(gap);
       controls.appendChild(remove);
       controls.appendChild(form);
       
       return controls;
    }
    
    
    	// add FINITE and VERBAL slots to P component
	function addFinite(pnode)
	{
		var container = pnode.parentNode.parentNode.nextSibling.firstChild;
		 

		// finite		
		var Fcon = document.createElement("TABLE");
		var Fcontb = document.createElement("TBODY");
		var Fcontr = document.createElement("TR");
		var Fcontd = document.createElement("TD");
		var F = document.createElement("TABLE");
		Fcon.style.border="solid black 1px";
		Fcon.width=60;
		Fcon.height=60;
		Fcon.style.display="inline";
		var Ftbody = document.createElement("TBODY");
		var Ftr1 = document.createElement("TR");
		var Ftr2 = document.createElement("TR");
		var Fth = document.createElement("TH");
		var Ftd = document.createElement("TD");
		Fth.appendChild(document.createTextNode("f"));
		
		Ftr1.appendChild(Fth);
		Ftr2.appendChild(Ftd);
		Ftbody.appendChild(Ftr1);
		Ftbody.appendChild(Ftr2);
		F.appendChild(Ftbody);
		
		Fcontd.appendChild(F);
		Fcontr.appendChild(Fcontd);
		Fcontb.appendChild(Fcontr);
		Fcon.appendChild(Fcontb);
		
		Fcontd.comp = "f";
		Fcontd.onclick=insert;
		
		// verbal		
		
		var Vcon = document.createElement("TABLE");
		var Vcontb = document.createElement("TBODY");
		var Vcontr = document.createElement("TR");
		var Vcontd = document.createElement("TD");
		var V = document.createElement("TABLE");
		Vcon.style.border="solid black 1px";
		Vcon.style.display="inline";
		Vcon.width=60;
		Vcon.height=60;
		var Vtbody = document.createElement("TBODY");
		var Vtr1 = document.createElement("TR");
		var Vtr2 = document.createElement("TR");
		var Vth = document.createElement("TH");
		var Vtd = document.createElement("TD");
		Vth.appendChild(document.createTextNode("v"));
		
		Vtr1.appendChild(Vth);
		Vtr2.appendChild(Vtd);
		Vtbody.appendChild(Vtr1);
		Vtbody.appendChild(Vtr2);
		V.appendChild(Vtbody);
		
		Vcontd.appendChild(V);
		Vcontr.appendChild(Vcontd);
		Vcontb.appendChild(Vcontr);
		Vcon.appendChild(Vcontb);
		
		Vcontd.comp = "v";
		Vcontd.onclick = insert;
		
		container.appendChild(Fcon);		
		container.appendChild(Vcon);
		
		// remove FV control from P element to prevent multiple fv slots being added
		pnode.parentNode.removeChild(pnode);
	}


	// ---------------------------------------
	//  general utility functions
	// ---------------------------------------

	// cancel event bubble (i.e. stop cascade of event triggers) at passed event
	function setBubbleCancel(evt)
	{
		// IE
		evt.bubbleCancel = true;
	}


	// -----------------------------
	//  add a new clause
	// -----------------------------

	  function addNewClause(cnum)
		{
			var insertID = 'clauses'
			var appendNode = document.getElementById('clauses');
		  
			for (id in selected)
			{
				if (selected[id].tagName=='TABLE')
				{
					selected[id].style.backgroundColor = 'pink';
					delete selected[id];
					insertID = id;
					break;
				}

			}

			if (insert=='clauses')
			{
					appendNode.appendChild(createClause(cnum));
			}
			else
			{
					var cnode = document.getElementById(insertID);
					if (cnode.nextSibling)
					{
						appendNode.insertBefore(createClause(cnum),cnode.nextSibling);
					}
					else
					{
						
						appendNode.appendChild(createClause(cnum));
					}
			}																																					
		}




	// change a static component label to a pull down list
	// to allow component value to be changed easily, i.e. 'C' => 'A'
	function changeComp(node)
	{
	 
		node.replaceChild(compOpts(),node.firstChild);
		node.onclick="";
		node.parentNode.parentNode.parentNode.parentNode.parentNode.comp = "C";
	}


	// build a new clause structure 
    function createClause(cnum)
    {
        cid = cnum;
        ctable = document.createElement("table");
        ctable.id = cid;
        ctable.border = 1;
        ctable.style.background = "pink";
        ctable.onclick = select;

        ctbody = document.createElement("tbody");
        ctrow = document.createElement("tr");
        glossRow = document.createElement("tr");
      glossTD = document.createElement("td");
glossRow.appendChild(glossTD);     
glossInput = document.createElement("input");
glossTD.appendChild(glossInput);
     //   gloss.colspan="100";
        ccell = document.createElement("td");
        ccell.setAttribute("width", "120");
        ccell.setAttribute("height", "10");



        text = document.createElement("span");
	text.id = "clabel" + cid;
	text.appendChild(document.createTextNode(cid));
        ccell.appendChild(text);
        ccell.appendChild(new controls(cnum));
        ctrow.appendChild(ccell);
        ctbody.appendChild(ctrow);
        ctbody.appendChild(glossRow);
  glossTD.style.display="none";
        
        ctable.appendChild(ctbody);

        return ctable;

    }

    function compHeader(cl, comp)
    {

        headTable = document.createElement("table");
        headTable.border= 0;
        headTable.width = "100%";
        headTbody = document.createElement("tbody");
        headTr = document.createElement("tr");
        headTh1 = document.createElement("th");
        headTh1.width = "80%";
        headTh1.align = "center";
        cell = document.createTextNode(comp);
        headTh2 = document.createElement("th");
        headTh2.align = "right";
        rimg = document.createElement("img");
        rimg.src = "img/x.gif";
        rimg.alt = "Remove component";
        rimg.onclick = removeComponent;
        rimg.cl = cl;
        rimg.comp = comp;
        headTh1.appendChild(cell);

	if (comp!='conj' && mode=='process')
	{
				headTh1.appendChild(eval('atts'+comp+'()'));
	}

        headTh1.appendChild(rimg);

	headTh1.style.whiteSpace='nowrap';

        headTr.appendChild(headTh1);
       
        headTbody.appendChild(headTr);

        container = document.createElement("tr");
	contain = document.createElement("td");
	contain.cl = cl;
        container.appendChild(contain);
        headTbody.appendChild(container);

        headTable.appendChild(headTbody);

        return headTable;

    }

    function addComponent(node)
    {

				event.cancelBubble = true; 
				if (node == null) { node = this; }
	

        var cid = node.parentNode.parentNode.parentNode.parentNode.parentNode;
	if (cid.id)
	{
		cid=cid.id;
	}
	else
	{
		cid=cid.parentNode.id;
	}
	
 
        var comp = node.comp;

        var clause = document.getElementById(cid);
	
        row = clause.getElementsByTagName("tr").item(0);
        newComp = document.createElement("td");
        newComp.comp = comp;
        newComp.onclick = insert;

       // newComp.setAttribute("width", "60");

       
        newComp.appendChild(compHeader(this.cl,comp));

        row.appendChild(newComp);

        if ((comp == "S") || (comp == "P"))
        {
           var controlId = "con" + cid;

           var controls = document.getElementById(controlId);     
           if (comp == "S")
           {
              controls.firstChild.width=0;
           }
           else
           {
              controls.childNodes[1].width=0;             
           }
        }
        
	return newComp;
    }

    function bubbleCancel(evt)
    {
	if (window.event)
	{
        	event.cancelBubble = true; // IE Dependent
	}
	else
	{
		evt.stopPropagation();
	}

    }

    function removeClause(node)
    {

	if (node == null) { node=this;}

	if (window.event)
	{
        	event.cancelBubble = true; // IE Dependent
	}
	else
	{
		evt.stopPropagation();
	}

        var cid = node.cl;
        var clause = document.getElementById(cid);
 
        var row = clause.getElementsByTagName("tr").item(0);


        for (var i=row.childNodes.length-1; i>=0; i--)
        {

             if ((row.childNodes[i].tagName == "TD") && i>0)
             {

                removeComp(row.childNodes[i].getElementsByTagName("img").item(0));
             }
             else
             {
                row.removeChild(row.childNodes[i]);
             }
        }

	clause.parentNode.removeChild(clause);

        
    }

    function removeComponent(node)
    {
 
	if (node == null) { node=this; }

	 
        	event.cancelBubble = true; // IE Dependent
	 
	 
        removeComp(node);
    }

    function removeComp(component)
    {
        var cid = component.cl;

        var nodePlace = component.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
        var clause;


        /*  Remove content of component to be removed and replace
            it in appropriate positions
        */
        var content =
component.parentNode.parentNode.parentNode.getElementsByTagName("tr").item(1).getElementsByTagName("TD").item(0);


        while (content.hasChildNodes())
        {
            var current = content.firstChild;
            if (current.tagName == "TABLE")
            {
      
			document.getElementById("clauses").insertBefore(current,nodePlace);

  

               current.style.background = "pink";

	       level = current.getElementsByTagName("form").item(0).firstChild;
	       level.removeChild(level.firstChild);
	       primary = document.createElement("option");
	       primary.setAttribute("value","primary");
	       primary.appendChild(document.createTextNode("Primary"));
	       secondary = document.createElement("option");
			secondary.setAttribute("value","secondary");
	        secondary.appendChild(document.createTextNode("Secondary"));
	/*       connection = document.createElement("input");
	       connection.type = "text";
	       connection.size = 4;     
	       connection.value = "c";
	       connection.onclick = bubbleCancel;
*/
	       level.appendChild(primary);
	 //      level.appendChild(secondary);
	    //   level.parentNode.appendChild(connection);
            }
            else
            {
               if (current.tagName == "SPAN")
               {
		    var curId = current.getAttribute("id").substr(5);
 
                    var words =
        document.getElementById("words").getElementsByTagName("span");

		    for (var i=0; i<words.length; i++)
		    {
		       if (curId > -1) 
		       {


		          if (words[i].hasAttribute && words[i].getAttribute("id").substr(1) > curId)
			  {

			var wds = document.getElementById("words");
			wds.insertBefore(current,words[i]);
				curId = -1;
			  }
		       }
		    }
		    if (curId > -1)
		    {
			document.getElementById("words").appendChild(current);
			var spc = document.createTextNode(" ");
			document.getElementById("words").appendChild(spc);
		    }
               }
            }
        }


        if (component.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id)
        {

           clause = component.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
           var row = clause.getElementsByTagName("tr").item(0);
           row.removeChild(component.parentNode.parentNode.parentNode.parentNode.parentNode);
        }
        else
        {
           

           var container =
component.parentNode.parentNode.parentNode.parentNode.parentNode;

           clause = container.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;


           container.removeChild(component.parentNode.parentNode.parentNode.parentNode);

        }

        var comp = component.comp;

        if ((comp == "S") || (comp == "P"))
        {
           var controlId = "con" + component.cl;
           var controls = clause.getElementsByTagName("span").item(1);

           if (comp == "S")
           {
              controls.firstChild.width=13;
           }
           else
           {
              controls.childNodes[1].width=13;             
           }
        }


    }

    function select(node)
   {

				event.cancelBubble = true // IE dependent 
	
				if (node == null) { node=this; }

        if (move)
        {
              if (node.id)
              {
                  node.getElementsByTagName("tr").item(0).appendChild(moveNode.firstChild);
                  move = false;


                  return;
              }
              return;
        }

        if (node.style.background == "red")
        {

           delete selected[node.id];
           if (node.tagName == "SPAN")
           {

              node.style.background = "white";
           }
           else
           {

              node.style.background = "pink";
           }


        }
        else
        {
           node.style.background = "red";
           // selected.appendChild(this);
           selected[node.id] = node;
           
        }
    }

    function insert(node)
    {

	if (node==null) { node = this; }

 
	if (window.event)
	{
        	event.cancelBubble = true // IE dependent
	}
	else
	{
		evt.stopPropagation();
		event = evt;
	}

       if (move)
       {
           if (event.altKey)
           {
              moveNode.firstChild.style.border = "solid 1pt black";
	      moveNode.style.display = "inline";
              node.getElementsByTagName("td").item(0).appendChild(moveNode.firstChild);
              
           }
           else
           {
              node.parentNode.insertBefore(moveNode.firstChild,node);
           }
          
           move = false; return;
       }
       if (event.ctrlKey || event.shiftKey)
       {
          moveNode.appendChild(node);
          if ((node.comp == "S") || (node.comp == "P"))
          {
          }
          move = true;
          return;
        }

 
        if (node.parentNode.parentNode.parentNode.style.background != "red") 
        {
        var container = node.getElementsByTagName("td").item(0);
 
       
        for (id in selected)
        {
           var firstChild = selected[id];
           if (firstChild.tagName == "TABLE")
           {
              firstChild.style.background = "#e0e0e0";
	      firstChild.style.marginLeft = "4px";

				level = firstChild.getElementsByTagName("select").item(0);

	      if (level.firstChild.value == "primary")
	      {

					 level.firstChild.value='embedded';
					 level.firstChild.innerText='embedded';

	      // level.parentNode.removeChild(level.parentNode.getElementsByTagName("input").item(0));
	      }


           }
           else
           {
              firstChild.style.background = container.style.background;
           }
           container.appendChild(firstChild);
           delete selected[id];
        }
     
  
}
    }


    function output(text)
    {

       var console =
    window.open("","","width=500,height=400,scrollbars=yes,resizable=yes");

       console.document.open('text/plain');
       console.document.writeln(text);
       console.document.close();
							
    }

    function DOMOutput()
    {
	var level;
        var xml = "";
        var comment = "";
        var clauses = document.getElementById("clauses");

        for (var i=0; i<clauses.childNodes.length; i++)
        {

           if (clauses.childNodes[i].tagName == "TABLE")
           {
               var clause = clauses.childNodes[i];
	       var level, connection;
	       var opts = clause.getElementsByTagName("form")[0].getElementsByTagName("option");
	       for (var j=0; j<opts.length; j++)
	       {
	            if (opts[j].selected == true) { level = opts[j].value;}
	       }
               xml += "\n<cl:clause id=\"" + clause.id + "\"";
	       xml += ' level=\"' + level + '\"';
	       
	       var proj = clause.getElementsByTagName("input");
	       for (var k=0; k<proj.length; k++)
	       {
		       if (proj[k].name=='projected' && proj[k].checked)
		       {
			       xml+= ' projected="yes" ';
		       }
	       }
	       connection="";
	       if (connect = clause.getElementsByTagName("input").item(0))
	       {
	        if (connect.value == "c") connect.value = "c?";
	        if (connect.value!="") {
		connection = " connect=\"" + connect.value + "\""; }
	       }
	   
	       xml += connection + ">";
               xml += processClause(clause);
               xml += "\n</cl:clause>";
           }
	   else
           {
              if (clauses.childNodes[i].tagName == "FORM")
	      {
      
                if (clauses.childNodes[i].refers) {
                var status="none";
                com = clauses.childNodes[i];
		com.getElementsByTagName("input");
                for (var y=1; y<4; y++)
                {


		     if (com[y].checked) { status = com[y].name;}
		     }
                


                comment += "\n<comment refersTo=\"" +
           com.refers +" status=\"" + status + "\">";
                
		comment += "\n\t" + com[0].value;
	        comment += "\n</comment>";
		}}
	   }
        }

        return (xml + comment);
    }


	// XPath output
    function XPathOutput()
    {
        var xml = "";
        var comment = "";
        var clauses = document.getElementById("clauses");

        for (var i=0; i<clauses.childNodes.length; i++)
        {

           if (clauses.childNodes[i].tagName == "TABLE")
           {
               var clause = clauses.childNodes[i];
	       var level, connection;
	       var opts = clause.getElementsByTagName("span").item(1).getElementsByTagName("option");
	       for (var j=0; j<opts.length; j++)
	       {
	            if (opts[j].selected == true) { level = opts[j].value;}
	       }
               xml += "\n//cl:clause";
	       xml += "[@level='" + level + "']";


               xml += processXPath(clause);
             
           }

        }

        return (xml);
    }
	


    function processXPath(node)
    {
        var txt="";
	  var closing = ""; 
        var row = node.getElementsByTagName("tr").item(0);
        for (var i=1; i<row.childNodes.length; i++)
        {
           var current = row.childNodes[i];
           var axis = "";
	     if (current.comp)
           {
		   if (i>1) { axis = "following-sibling::";}
               txt += "[" + axis + "cl:" + current.comp + XPathContent(current.getElementsByTagName("TABLE").item(0).getElementsByTagName("td").item(0));

		   closing += "]";
           }
        }
	  txt += closing;
        return txt;
    }
             

    function XPathContent(node)
    {

        var txt = "";
        for (var i=0; i<node.childNodes.length; i++)
        {
            if (node.childNodes[i].nodeType == 1)
            {
               var current = node.childNodes[i];
               if (current.tagName == "TABLE")
               {

                  txt += "[cl:clause[@level=\'secondary\']";
                  txt += processXPath(current);              
                  txt += "]";
               }

               else
               {
                  if (current.tagName == "TD")
                  {
                     txt += "[cl:" + current.comp;
                     txt +=
XPathContent(current.getElementsByTagName("TABLE").item(0).getElementsByTagName("td").item(0));
                     txt += "]";
                  }
                  else
                  {
               //      txt += "<w xlink:href=\"" +
current.id + "\"/>";
                  }
               } 
            }
        }
        return txt;

    }





    function Send()
    {
	if (confirm('Are you sure you want to e-mail your annotation to the working-group chair?'))
	{
         document.xml.annotation.value = DOMOutput();
	 document.xml.submit();
	}
    }

    function processClause(node)
    {
        var txt="";
        
		var row = node.getElementsByTagName("tr").item(0);
       
        var gloss = row.nextSibling.firstChild.firstChild;
        txt += "\n<gloss>" + gloss.value + "</gloss>";        
        
     
        for (var i=1; i<row.childNodes.length; i++)
        {
           var current = row.childNodes[i];
           if (current.comp)
           {
							 var pr = current.comp == "conj" ? "pl" : "cl"
               txt += "\n\t<" + pr + ":" + current.comp + getAtt(current) + ">" + compContent(current.getElementsByTagName("TABLE").item(0).getElementsByTagName("td").item(0)) + "</" + pr + ":" +
current.comp + ">";
           }
        }
        return txt;
    }

    function compContent(node)
    {
        var txt = "";
        for (var i=0; i<node.childNodes.length; i++)
        {
            if (node.childNodes[i].nodeType == 1)
            {
               var current = node.childNodes[i];
               if (current.tagName == "TABLE" && current.id)
               {

                  txt += "\n<cl:clause id=\"" + current.id + "\"";
		  txt += " level=\"embedded\">";
                  txt += processClause(current);              
                  txt += "\n</cl:clause>";
               }
               else
               {
				   // embedded component
				   if (current.tagName == "TABLE")
				   { 
				   
					   if (current.comp=="f" || current.comp=="v")
					   {
					   	 var pr = current.comp == "conj" ? "pl" : "cl";
										 txt += "\n\t<" + pr + ":" + current.comp;
										 txt += getAtt(current);

										 txt += ">";
									
								 
			txt += compContent(current.getElementsByTagName("td").item(0));
					  

										 txt += "</" + pr + ":" + current.comp + ">";
					   }
					   else
					   {
						   txt += compContent(current.getElementsByTagName("TR")[0]);
					   }
				   }
				   else
				   {
					  if (current.tagName == "TD")
					  { 
										 var pr = current.comp == "conj" ? "pl" : "cl";
										 txt += "\n\t<" + pr + ":" + current.comp;
										 txt += getAtt(current);

										 txt += ">";
									
								 
			txt += compContent(current.getElementsByTagName("TABLE").item(0).getElementsByTagName("td").item(0));
					  

										 txt += "</" + pr + ":" + current.comp + ">";
					  }
					 
					  else 
					  {
						 txt += "<w xlink:href=\"" +
current.id + "\"/>";
						  }
					   }
					}
				}
			}
        return txt;
    }


	/* ----------------------------
	    return attribute value
		  on an component if present
	   ---------------------------- */
		function getAtt(comp)
		{
				var sel = comp.getElementsByTagName("select")[0];
				
				if (sel == null || !sel.name)
				{
						return "";
				}
				else
				{
					 var attVal = sel[sel.selectedIndex].value;
					 var att;

					 if (attVal=='')
					 {
							att="";
					 }
					 else
					 {
						 att = ' '+ sel.name + '="' + attVal + '"';
					 }
						return att;
				}
		}


    /* --------------------------------------
	keep word palate and control menu at
	top of window during scrolling
    -------------------------------------- */
    function top()
    {
        document.getElementById("words").style.pixelTop =
document.body.scrollTop + wdY;
        document.getElementById("words").style.pixelLeft =
document.body.scrollLeft + wdX;

        document.getElementById("menu").style.pixelTop =
document.body.scrollTop + menuY;
        document.getElementById("menu").style.pixelLeft = document.body.scrollLeft + menuX;
    }



    /* --------------------------------------
	Renumber clauses in palate order
	beginning with provided number
    -------------------------------------- */
    function clauseRenumber(startNum)
    {
	var clauses = document.getElementById("clauses").getElementsByTagName("table");
	
	for (var i=0; i<clauses.length; i++)
	{
	   if (clauses[i].id)
	   {
	        var cnum = "c" + (startNum++);
		var holder = document.getElementById("clabel" + clauses[i].id);
	        clauses[i].id = cnum;
		holder.replaceChild(document.createTextNode(cnum),holder.firstChild);
		holder.id = "clabel" + cnum;
	   }
	}
    }

    function changeLevel(evt)
    {
	if (window.event)
	{
        	event.cancelBubble = true // IE dependent
        	if (!evt) { evt = this; }
	}
	else
	{
		evt.stopPropagation();
		event = evt;
	}

	var clause =
	evt.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;

	if (evt.value.indexOf("secondary")==0)
	{
	   clause.style.background = "#e0e0e0";
	   clause.style.marginLeft = "60px";
	}
	else
	{
	   clause.style.background = "pink";
	   clause.style.marginLeft = "4px";
	}
    }

    function cancelForm()
    {
        return false;
    }

    function activateWords()
    {

     
    var items = document.getElementById("words").getElementsByTagName("span");

          for (var i=0; i < items.length; i++)
    {
        items[i].onclick = select;

    }

    document.body.onscroll = top;
    }



function postXML()
{
var xmlhttp;
 
if (confirm('Write changes to ' + filename + '?'))
{ 
 
 try {
  xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
 } catch (e) {
  try {
   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  } catch (e) {
   xmlhttp = false;
  }
 }
 

 var posturl = "http://localhost:8080/opentext/servlet/db/opentext/" + col;

 xmlhttp.open("POST", posturl, false);
 xmlhttp.onreadystatechange=function() {
  if (xmlhttp.readyState==4) {
   if (xmlhttp.status=='200') 
   {
   	alert("Clause annotation updated");
   }
   else
   {
   	alert("ERROR: Clause annotation was not updated\n" + xmlhttp.responseText);
   }
  }
 }

 
 xmlhttp.setRequestHeader("Content-Type", "text/xml");
 
 
var xml = '<chapter xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause" xmlns:xlink="http://www.w3.org/1999/xlink" book="' + bookid + '" num="' + chnum + '">' + DOMOutput() + '</chapter>';

 


var query = '<![CDATA[ xquery version "1.0";\n'
	+ 'declare namespace request="http://exist-db.org/xquery/request"; \n'
	+ 'declare namespace util="http://exist-db.org/xquery/util"; \n'
	+ 'declare namespace xmldb="http://exist-db.org/xquery/xmldb"; \n'
	+ 'declare namespace f="http://www.opentext.org/functions"; \n\n'
	+ "let $col := xmldb:collection('xmldb:exist:///db/opentext" + col +   "','admin','xyz')\n"
	+ "let $doc := '" + filename + ".xml'\n"
	 + "let $xml := transform:transform(" + xml + ",document('/db/XSL/clauseRenum.xsl'),<parameters/>)"
	+ ' \nreturn\n'
	+ "xmldb:store($col,$doc,$xml)"
  + '\n ]]>';

 
 xmlhttp.send('<query xmlns="http://exist.sourceforge.net/NS/exist" start="1" max="10">'
    + ' <text>' + query + '</text>' +
    + ' <properties/> '
		+ ' </query>'
		
);
 
}
else
{
	return;
} 

}


/* ------------------------------
	UNEMBED clause
---------------------------------- */
function unembed(location)
{
	
	
       
        for (id in selected)
        {
           var firstChild = selected[id];
           if (firstChild.tagName == "TABLE")
           {
        
			var parentID = firstChild.parentNode.parentNode.parentNode.parentNode.parentNode.cl;
			var parentCl = document.getElementById(parentID);
			
			if (parentCl)
			{
				var cl = document.getElementById('clauses');

				if (location == 'before')
				{
					cl.insertBefore( firstChild, parentCl);
				}
				else
				{
					if (parentCl.nextSibling)
					{
						cl.insertBefore( firstChild, parentCl.nextSibling);
					}
					else
					{
						cl.appendChild(firstChild);
					}
			
				}
				
				firstChild.style.backgroundColor = "pink";
				delete selected[id];
				
				// add proj checkbox + levels to select list
				
       var pspan = document.createElement("span");
       pspan.style.fontFamily = "Arial";
       pspan.style.fontSize = "8pt";
       pspan.style.color="blue";
       pspan.style.whiteSpace="nowrap";
       var project = document.createElement("input");
       project.type="checkbox";
       project.onclick=setProjected;
       project.name="projected";
 
       pspan.appendChild(document.createTextNode("proj"));
       pspan.appendChild(project);
       
       
       level2 = firstChild.getElementsByTagName("select").item(0);

	   pnode = level2.parentNode;

	   level = document.createElement("select");
       level.onclick = bubbleCancel;
       level.onchange = changeLevel;
       primary = document.createElement("option");
       primary.setAttribute("value","primary");
       primary.appendChild(document.createTextNode("Primary"));
      secondary = document.createElement("option");
       secondary.setAttribute("value","secondary");
       secondary.appendChild(document.createTextNode("Secondary"));
      secondary2 = document.createElement("option");
       secondary2.setAttribute("value","secondary2");
       secondary2.appendChild(document.createTextNode("Secondary (dep)"));
       level.appendChild(primary);
       level.appendChild(secondary);
       level.appendChild(secondary2);

	   pnode.replaceChild(level,level2);
	   
	   
       connection = document.createElement("input");
       connection.type = "text";
       connection.size = 8;     
       connection.onclick=bubbleCancel;
       connection.value = bookid + ".c" + chnum + "_";  
      
       connection.style.fontFamily = "Arial";
       connection.style.fontSize = "8pt";
       connection.style.color="green";
       connection.style.backgroundColor="#c0c0c0";
       
       if (pnode.getElementsByTagName("span").length>0)
       {
      
		}
		else
		{
		   pnode.appendChild(connection);
		   pnode.appendChild(pspan);
		}

				
			}

          }

		}

}


/* -----------------------
	move clause
--------------------------- */

function moveClause(direction)
{
	
        for (id in selected)
        {
           var firstChild = selected[id];
           if (firstChild.tagName == "TABLE")
           {
        
			if (firstChild.parentNode.id=='clauses')
			{
				var clauses = document.getElementById('clauses');

				if (direction == 'up')
				{
					var cl = firstChild.previousSibling;
				
					if (cl)
					{
						clauses.insertBefore( firstChild, cl);
					}
				}
				else
				{
					if (firstChild.nextSibling.nextSibling)
					{
						clauses.insertBefore( firstChild, firstChild.nextSibling.nextSibling);
					}
					else
					{
						clauses.appendChild(firstChild);
					}
			
				}
				
			}

          }

		}

}


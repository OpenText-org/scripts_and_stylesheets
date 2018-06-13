

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

    function controls(cnum)
    {
       var controls = document.createElement("span");
       controls.id = "con" + cnum;
       S = document.createElement("img");
       S.src="S.gif";
       S.alt="Add subject component";
       S.cl = cnum;
       S.comp = "S";
       S.onclick = addComponent;


       P = document.createElement("img");
       P.src="P.gif";
       P.alt="Add predicate component";
       P.cl = cnum;
       P.comp = "P";
       P.onclick = addComponent;

       C = document.createElement("img");
       C.src="C.gif";
       C.alt="Add complement component";
       C.cl = cnum;
       C.comp = "C";
       C.onclick = addComponent;

       A = document.createElement("img");
       A.src="A.gif";
       A.alt="Add adjunct component";
       A.cl = cnum;
       A.comp = "A";
       A.onclick = addComponent;


       conj = document.createElement("img");
       conj.src="conj.gif";
       conj.alt="Add paragraph level conjunction";
       conj.cl = cnum;
       conj.comp = "conj";
       conj.onclick = addComponent;

       remove = document.createElement("img");
       remove.src="x.gif";
       remove.alt="Remove clause and empty content";
       remove.cl = cnum;
       remove.onclick = removeClause;

       form = document.createElement("form");
       level = document.createElement("select");
       level.onclick = bubbleCancel;
       level.onchange = changeLevel;
       primary = document.createElement("option");
       primary.setAttribute("value","primary");
       primary.appendChild(document.createTextNode("Primary"));
       secondary = document.createElement("option");
       secondary.setAttribute("value","secondary");
       secondary.appendChild(document.createTextNode("Secondary"));
       level.appendChild(primary);
       level.appendChild(secondary);

       connection = document.createElement("input");
       connection.type = "text";
       connection.size = 4;     
       connection.value = "c";  
       connection.onclick = bubbleCancel;


       form.appendChild(level);
       form.appendChild(connection);
       form.onsubmit = cancelForm;

       controls.appendChild(S);
       controls.appendChild(P);
       controls.appendChild(C);
       controls.appendChild(A);
       controls.appendChild(conj);
       controls.appendChild(remove);
       controls.appendChild(form);
       
       return controls;
    }

    function createClause(cnum)
    {
        cid = "c" + cnum;
        ctable = document.createElement("table");
        ctable.id = cid;
        ctable.border = 1;
        ctable.style.background = "pink";
        ctable.onclick = select;

        ctbody = document.createElement("tbody");
        ctrow = document.createElement("tr");
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
        rimg.src = "x.gif";
        rimg.alt = "Remove component";
        rimg.onclick = removeComponent;
        rimg.cl = cl;
        rimg.comp = comp;
        headTh1.appendChild(cell);
        headTh2.appendChild(rimg);
        headTr.appendChild(headTh1);
        headTr.appendChild(headTh2);
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
 
	

        var cid = node.parentNode.parentNode.parentNode.parentNode.parentNode.id

        var comp = node.comp;

        var clause = document.getElementById(cid);
        row = clause.getElementsByTagName("tr").item(0);
        newComp = document.createElement("td");
        newComp.comp = comp;
        newComp.onclick = insert;

        newComp.setAttribute("width", "60");

       
        newComp.appendChild(compHeader(this.cl,comp));

        row.appendChild(newComp);

        if ((comp == "S") || (comp == "P"))
        {
           var controlId = "con" + node.cl;
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

    function removeClause(evt)
    {
	if (window.event)
	{
        	event.cancelBubble = true; // IE Dependent
	}
	else
	{
		evt.stopPropagation();
	}

        var cid = "c" + this.cl;
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

    function removeComponent(evt)
    {
	if (window.event)
	{
        	event.cancelBubble = true; // IE Dependent
	}
	else
	{
		evt.stopPropagation();
	}
        removeComp(this);
    }

    function removeComp(component)
    {
        var cid = "c" + component.cl;


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
               var clauses = document.getElementById("clauses").getElementsByTagName("table");
	       var flag = 0;
	       for (var i=0; i<clauses.length; i++)
	       {
	          if (clauses[i].parentNode.id == "clauses")	       
		  {
		     if (clauses[i].id.substr(1) > current.id.substr(1))
		     {

			document.getElementById("clauses").insertBefore(current,clauses[i]);
			
			flag = 1;
		     }
		  }
	       }
	       if (flag == 0)
	       {
	          document.getElementById("clauses").appendChild(current);
	       }

               current.style.background = "pink";

	       level = current.getElementsByTagName("form").item(0).firstChild;
	       level.removeChild(level.firstChild);
	       primary = document.createElement("option");
	       primary.setAttribute("value","primary");
	       primary.appendChild(document.createTextNode("Primary"));
	       secondary = document.createElement("option");
	       secondary.setAttribute("value","secondary");
	       secondary.appendChild(document.createTextNode("Secondary"));
	       connection = document.createElement("input");
	       connection.type = "text";
	       connection.size = 4;     
	       connection.value = "c";
	       connection.onclick = bubbleCancel;

	       level.appendChild(primary);
	       level.appendChild(secondary);
	       level.parentNode.appendChild(connection);
            }
            else
            {
               if (current.tagName == "SPAN")
               {
		    var curId = current.getAttribute("id").substr(6);
                    var words =
        document.getElementById("words").getElementsByTagName("span");

		    for (var i=0; i<words.length; i++)
		    {
		       if (curId > -1) 
		       {
		          if (words[i].getAttribute("id").substr(6) > curId)
			  {
				document.getElementById("words").insertBefore(current,words[i]);
				curId = -1;
			  }
		       }
		    }
		    if (curId > -1)
		    {
			document.getElementById("words").appendChild(current);
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
           alert("Embedded!");

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

    function select(evt)
    {
	if (window.event)
	{
        	event.cancelBubble = true // IE dependent 
	}
	else
	{
		evt.stopPropagation();
	}

        if (move)
        {
              if (this.id)
              {
                  this.getElementsByTagName("tr").item(0).appendChild(moveNode.firstChild);
                  move = false;


                  return;
              }
              return;
        }

        if (this.style.background == "red")
        {

           delete selected[this.id];
           if (this.tagName == "SPAN")
           {

              this.style.background = "white";
           }
           else
           {

              this.style.background = "pink";
           }


        }
        else
        {
           this.style.background = "red";
           // selected.appendChild(this);
           selected[this.id] = this;
           
        }
    }

    function insert(evt)
    {
	var node = this;

	if (evt)
	{
	if (evt.create)
	{
	   node = evt;

	}
	}
	else
	{ 
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
              this.getElementsByTagName("td").item(0).appendChild(moveNode.firstChild);
              
           }
           else
           {
              this.parentNode.insertBefore(moveNode.firstChild,this);
           }
          
           move = false; return;
       }
       if (event.ctrlKey)
       {
          moveNode.appendChild(this);
          if ((this.comp == "S") || (this.comp == "P"))
          {
          }
          move = true;
          return;
        }
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
	      level =
        firstChild.getElementsByTagName("select").item(0);

	      if (level.firstChild.value == "primary")
	      {
	      level.removeChild(level.firstChild);
	      level.parentNode.removeChild(level.parentNode.getElementsByTagName("input").item(0));
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
               xml += "\n<cl:clause id=\"" + clause.id + "\"";
	       xml += " level=\"" + level + "\"";
	       if (connect = clause.getElementsByTagName("input").item(0))
	       {
	        if (connect.value == "c") connect.value = "c?";
		connection = " connect=\"" + connect.value + "\"";
	       }
	       else
	       {
	        connection = "";
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
        for (var i=1; i<row.childNodes.length; i++)
        {
           var current = row.childNodes[i];
           if (current.comp)
           {
               txt += "\n\t<cl:" + current.comp + ">" + compContent(current.getElementsByTagName("TABLE").item(0).getElementsByTagName("td").item(0)) + "</cl:" +
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
               if (current.tagName == "TABLE")
               {

                  txt += "\n<cl:clause id=\"" + current.id + "\"";
		  txt += " level=\"secondary\">";
                  txt += processClause(current);              
                  txt += "\n</cl:clause>";
               }
               else
               {
                  if (current.tagName == "TD")
                  {
                     txt += "\n\t<cl:" + current.comp + ">";
                     txt +=
compContent(current.getElementsByTagName("TABLE").item(0).getElementsByTagName("td").item(0));
                     txt += "</cl:" + current.comp + ">";
                  }
                  else
                  {
                     txt += "<w xlink:href=\"" +
current.id + "\"/>";
                  }
               }
            }
        }
        return txt;
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
	}
	else
	{
		evt.stopPropagation();
		event = evt;
	}

	var clause =
	this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;

	if (this.value == "secondary")
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
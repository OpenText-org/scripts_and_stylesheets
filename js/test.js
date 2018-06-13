



    /* ------- Define global variables ------------------- */
   
    var cnum=1;
    var wnum=1;

    var selected = new Array();
    var selectedWd = new Object();

    var moveNode = document.createElement("move");
    var move = false;

    var wdX = 10;
    var wdY = 10;
    var menuX = 600;
    var menuY = 10;

    var POS = new Array('---', 'VBF', 'VBN', 'VBP', 'NON', 'ADJ','ADV', 'PRP', 'PAR');

    var SD = new Array('---', '1: Geographical Objects and Features', '2: Natural Substances', '3: Plants', '4: Animals', '5: Foods and Condiments', '6: Artifacts', '7: Constructions', '8: Body, Body Parts, and Body Products', '9: People', '10: Kinship Terms', '11: Groups and Classes of Persons', '12: Supernatural Beings and Powers', '13: Be, Become, Exist, Happen', '14: Physical Events and States', '15: Linear Movement', '16: Non-Linear Movement', '17: Stances and Events Related to Stances', '18: Attachment', '19: Physical Impact', '20: Violence, Harm, Destroy, Kill', '21: Danger, Risk, Safe, Save', '22: Trouble, Hardship, Relief', '23: Physiological Processes and States', '24: Sensory Events and States', '25: Attitudes and Emotions', '26: Psychological Faculties', '27: Learn', '28: Know', '29: Memory and Recall', '30: Think', '31: Hold a View, Believe, Trust', '32: Understand', '33: Communication', '34: Association', '35: Help, Care For', '36: Guide, Discipline, Follow', '37: Control, Rule', '38: Punish, Reward', '39: Hostility, Strife', '40: Reconciliation, Forgiveness', '41: Behavior and Related States', '42: Perform, Do', '43: Agriculture', '44: Animal Husbandry, Fishing', '45: Building, Constructing', '46: Household Activities', '47: Activities Involving Liquids or Masses', '48: Activities Involving Cloth', '49: Activities Involving Clothing and Adorning', '50: Contests and Play', '51: Festivals', '52: Funerals and Burial', '53: Religious Activities', '54: Maritime Activities', '55: Military Activities', '56: Courts and Legal Procedures', '57: Possess, Transfer, Exchange', '58: Nature, Class, Example', '59: Quantity', '60: Number', '61: Sequence', '62: Arrange, Organize', '63: Whole, Unite, Part, Divide', '64: Comparison', '65: Value', '66: Proper, Improper', '67: Time', '68: Aspect', '69: Affirmation, Negation', '70: Real, Unreal', '71: Mode', '72: True, False', '73: Genuine, Phony', '74: Able, Capable', '75: Adequate, Qualified', '76: Power, Force', '77: Ready, Prepared', '78: Degree', '79: Features of Objects', '80: Space', '81: Spacial Dimensions', '82: Spacial Orientations', '83: Spacial Positions', '84: Spacial Extensions', '85: Existence in Space', '86: Weight', '87: Status', '88: Moral and Ethical Qualities Behavior', '89: Relations', '90: Case', '91: Discourse Markers', '92: Discourse Referentials', '93: Names of Persons and Places'
    );

function createClause()
{
	alert();
}

    /* ---------------------------------------------------------


   
    function addWord(wid)
    {
	var wd = document.createElement('span');
	wd.onclick = bubbleCancel;
	var pos = document.createElement('select');
	pos.style.backgroundColor = "white";
	var sem = document.createElement('select');
	sem.style.backgroundColor = "white";
	var lex = document.createElement('input');

	for (p in POS)
	{
	   var opt = document.createElement('option');
	   opt.appendChild(document.createTextNode(POS[p]));
	   opt.value = POS[p];
	   pos.appendChild(opt);
	}

	for (s in SD)
	{
	   var opt = document.createElement('option');
	   opt.appendChild(document.createTextNode(SD[s]));
	  //opt.value = SD[s];
	   sem.appendChild(opt);
	}

	wd.appendChild(pos);
	wd.appendChild(sem);
	wd.appendChild(lex);

	wd.id = wid;

	return createWord(wd);
    }

/*
create word block
*/
function createWord(wd)
{


	var table = document.createElement("table");
	table.width = "100%";

	

	thead = document.createElement("tbody");
	tr = document.createElement("tr");
	td1 = document.createElement("td");
	td1.appendChild(wd);


	// td1.style.fontFamily = "Georgia Greek";

	add = document.createElement("td");
	add.style.fontFamily = "Arial"; 
	add.style.fontSize = "14px";
	add.style.color = "green";

	add.style.textAlign = "right";
	add.appendChild(document.createTextNode("+"));
	add.onclick = modifierExpand;
	
	tr.appendChild(td1);
	tr.appendChild(add);
	thead.appendChild(tr);
	table.appendChild(thead);	


	var word = document.createElement("table");
	word.setAttribute("id", wd.id);
	wbody = document.createElement("tbody");
	wtr = document.createElement("tr");
	wtd = document.createElement("td");
	wtd.appendChild(table);
	wtd.appendChild(modifiers());
	wtr.appendChild(wtd);
	wbody.appendChild(wtr);
	word.appendChild(wbody);
	word.style.background = "#FFFFFF";
	word.style.border = "1px black solid";
	word.style.marginBottom = "4px";
	word.style.display = "inline";
	word.style.verticalAlign = "top";
	word.onclick = selectWd;
	word.type = "word";
	word.id = "w" + wd.id;


	return word;

}	




/*
Create modifier block for word
*/


function modifiers()
{
	var modifiers = document.createElement("table");
	modifiers.width = "100%";

	modifiers.style.display = "none";  


	tbody = document.createElement("tbody");
        row1 = document.createElement("tr");
	sph = document.createElement("th");
	sph.appendChild(document.createTextNode("sp"));
	sph.onclick = insertWd; 
	dfh = document.createElement("th");
	dfh.appendChild(document.createTextNode("df"));
	dfh.onclick = insertWd;
	qlh = document.createElement("th");
	qlh.appendChild(document.createTextNode("ql"));
	qlh.onclick = insertWd;
	rlh = document.createElement("th");
	rlh.appendChild(document.createTextNode("rl"));
	rlh.onclick = insertWd;
	cnh = document.createElement("th");
	cnh.appendChild(document.createTextNode("cn"));
	cnh.onclick = insertWd;
	row1.appendChild(sph);
	row1.appendChild(dfh);
	row1.appendChild(qlh);
	row1.appendChild(rlh);
	row1.appendChild(cnh);


	/* create slots for modification words */

	row2 = document.createElement("tr");
	sp = document.createElement("td");
	df = document.createElement("td");
	ql = document.createElement("td");
	rl = document.createElement("td");
	cn = document.createElement("td");
	row2.appendChild(sp);
	row2.appendChild(df);
	row2.appendChild(ql);
	row2.appendChild(rl);
	row2.appendChild(cn);
	tbody.appendChild(row1);
	tbody.appendChild(row2);
	
	modifiers.appendChild(tbody);


	return modifiers;
}


function modifierExpand()
{
	var node = this.parentNode.parentNode.parentNode.nextSibling;
	if (window.event)
		{

        		event.cancelBubble = true; // IE Dependent
		}


	if (node.style.display == "none")
	{
		node.style.display = "inline";
	}
	else
	{
		node.style.display = "none";
	}
}		

function bubbleCancel()
{
	event.cancelBubble = true;
}

function selectWd()
{
	if (window.event)
		{

        		event.cancelBubble = true; // IE Dependent
		}

	node = this;

	/* locate outer container element (a table) for word node */
	//node = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;


	if (event.ctrlKey)
	{
		if (node.style.border.match("double"))	
		{
		        node.style.border = "";
		}
		else
		{
			node.style.border = "double 4px #000000";
		}

	}
	else
	{

	/* if word is already selected, remove from array of selected
	words and restore background */
	if (node.style.backgroundColor.match("blue"))
	{
	    node.style.backgroundColor = "white";
	    delete selectedWd[node.id];
	    delete selected[node.id];
	}

	
	/* if word is newly selected at to array of selected words and
	change background color */
	else
	{
	    node.style.backgroundColor = "blue";
	    selectedWd[node.id] = node;
	    selected[node.id] = node;
        }

	}

}

function insertWd()
{
		if (window.event)
		{

        		event.cancelBubble = true; // IE Dependent
		}

	/* locate container TD element for selected relationshop */

	var node = this;
	var pos = 5;
	while (node != null)
	{
		node = node.nextSibling
		pos--;
	}
	

	var container =
	this.parentNode.nextSibling.firstChild;

	for (var i=1; i<= pos; i++)
	{
	    container = container.nextSibling;
	}


	for (id in selectedWd)
	{

           var firstChild = selectedWd[id];
           container.appendChild(firstChild);
	   firstChild.style.background = "#FFFFFF";
	   firstChild.style.display = "block";
           delete selectedWd[id];
	   delete selected[id];
	}



}




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
     //  form.appendChild(connection);
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

    function addComponent(evt)
    {

	var node = this;
	if (evt)
        {	
		node = evt;
	}
	else
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

        var cid = "c" + node.cl;
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

       // return (xml);

	 document.xml.xpath.value = xml;
	 document.xml.submit();
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
		   if (i>1) { axis = "following-sibling::*[1][name()='";}
               txt += "[" + axis + "cl:" + current.comp + XPathContent(current.getElementsByTagName("TABLE").item(0).getElementsByTagName("td").item(0));
		   if (i>1) { txt += "']";}
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
	          if (current.type != 'word')
		  {
                  txt += "[cl:clause[@level=\'secondary\']";
                  txt += processXPath(current);              
                  txt += "]";
		  }
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



/* -----------------------------------------------------------------
*/
/*

function WGXPathOutput()
{
	var xml = "//";

	var groups =
	document.getElementById("clauses").getElementsByTagName("table");


	for (var i=0; i<groups.length; i++)
	{

		/* only process top level groups */
	        if (groups.item(i).type parentNode.id == "clauses")
		{
			xml += processGroup(groups.item(i));

		}
	}

	return xml;

}


function processGroup(node)
{
	var xml="";
	xml += "wg:group[wg:head";
	xml += processWord(node); 
	xml += "]";
	return xml;
}


function processWord(node)
{

	var xml = "";

	/* process embedded word groups */
	if (node.style.border.match("double"))
	{
	    node.style.border="";
	    xml += processGroup(node);
	    node.style.border="double 4px #000000";
	}
	else
	{
	xml += "/wg:word";
	if (hasModifiers(node) == 0)
	{
	   
	}
	else
	{

	   xml += "/wg:modifiers";
	   xml += processModifiers(node);


	}
	}
	return xml;
}



function hasModifiers(node)
{
	var hasModifiers = 0;
	var containerRow =
	node.getElementsByTagName("th").item(0).parentNode.nextSibling;

	container = containerRow.firstChild;
	while (container != null)
	{

		if (container.getElementsByTagName("table").length > 0)
		{
		     hasModifiers = 1;
		}
		container = container.nextSibling;
	}
	return hasModifiers;
}



function processModifiers(node)
{

	var xml = "";
	var containerRow =	
	node.getElementsByTagName("th").item(0).parentNode.nextSibling;

	var containerPos = 0;
	var container = containerRow.firstChild;
	while (container != null)
	{

		if (container.getElementsByTagName("table").length > 0)
		{
		     xml += "/wg:" + containerNames[containerPos];
		     xml += modifierContent(container);

					    
		}
		container = container.nextSibling;
		containerPos++;
	}
	return xml;

}

function modifierContent(node)
{

	var xml = "";
	var child = node.firstChild;
	while (child != null)
	{

	    if (child.id) 
	    { 
	      xml += processWord(child);
	    }
	    child = child.nextSibling;
	}

	return xml;
}

*/

 
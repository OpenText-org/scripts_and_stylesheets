
/*

Word group annotation tool for OpenText.org

version 0.3 (23/2/2002)

mtrout@nycap.rr.com

*/


/*------------- global variables ----------------- */


var selected = new Object();
var wgId = 1;	
var containerNames = ["specifier", "definer", "qualifier", "relator", "connector"]; 


/* ----------------------------------------------- */


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
	td1.appendChild(wd.firstChild);
	td1.onclick = select;
	td1.style.fontFamily = "Georgia Greek";

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
	word.style.background = "#000000";
	word.style.marginBottom = "4px";
	word.style.display = "inline";
	word.style.verticalAlign = "top";


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
	sph.onclick = insert; 
	dfh = document.createElement("th");
	dfh.appendChild(document.createTextNode("df"));
	dfh.onclick = insert;
	qlh = document.createElement("th");
	qlh.appendChild(document.createTextNode("ql"));
	qlh.onclick = insert;
	rlh = document.createElement("th");
	rlh.appendChild(document.createTextNode("rl"));
	rlh.onclick = insert;
	cnh = document.createElement("th");
	cnh.appendChild(document.createTextNode("cn"));
	cnh.onclick = insert;
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

function insert()
{

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


	for (id in selected)
	{

           var firstChild = selected[id];
           container.appendChild(firstChild);
	   firstChild.style.background = "#000000";
	   firstChild.style.display = "block";
           delete selected[id];
	}



}



function modifierExpand()
{
	var node = this.parentNode.parentNode.parentNode.nextSibling;


	if (node.style.display == "none")
	{
		node.style.display = "inline";
	}
	else
	{
		node.style.display = "none";
	}
}		

function select()
{
	/* locate outer container element (a table) for word node */
	node = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;


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
	if (node.style.background.match("red"))
	{
	    node.style.background = "black";
	    delete selected[node.id];
	}
	
	/* if word is newly selected at to array of selected words and
	change background color */
	else
	{
	    node.style.background = "red";
	    selected[node.id] = node;
	
        }

	}

}



	
function activateWords()
{


    var words = document.getElementById("words");

    var word = words.getElementsByTagName("span");

    for (i=0; i<word.length; i++)
    {
        word[i].style.display = "inline";
	words.appendChild(createWord(word[i]));
    }
}


function Send()
{
	if (confirm('Are you sure you want to e-mail your annotation to the working-group chair?'))
	{
         document.xml.annotation.value = OutputDOM();
	 document.xml.submit();
	}
}


/* convert graphical annotation into XML markup */
function OutputDOM()
{
	var xml = "";

	var groups =
	document.getElementById("words").getElementsByTagName("table");

	xml = "<?xml version=\"1.0\"?>\n\n<wg:groups>";
	for (var i=0; i<groups.length; i++)
	{

		/* only process top level groups */
	        if (groups.item(i).parentNode.id == "words")
		{
			xml += processGroup(groups.item(i));

		}
	}
	xml += "\n</wg:groups>";
	return xml;

}




function outputWindow(text)
{

       var console =
    window.open("","","width=500,height=400,scrollbars=yes,resizable=yes");

       console.document.open('text/plain');
       console.document.writeln(text);
       console.document.close();
							
}

function processGroup(node)
{
	var xml="";
	xml += "\n<wg:group id=\"wg" + (wgId++) + "\">";
	xml += "\n\t<wg:head>";
	xml += processWord(node); 
	xml += "\n\t</wg:head>";
	xml += "\n</wg:group>";
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
	xml += "\n\t\t<wg:word xlink:href=\"" + node.id + "\"";
	if (hasModifiers(node) == 0)
	{
	   xml += "/>";
	}
	else
	{
	   xml += ">";
	   xml += "\n\t\t\t<wg:modifiers>";
	   xml += processModifiers(node);
	   xml += "\n\t\t\t</wg:modifiers>";
	   xml += "\n\t\t</wg:word>";
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
		     xml += "\n\t\t\t\t<wg:" +
		containerNames[containerPos] + ">";
		     xml += modifierContent(container);
		     xml += "\n\t\t\t\t</wg:" +
		containerNames[containerPos] + ">";
					    
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

function setId()
{
	var id = prompt("Enter starting word group number");
	
	if (id != null) { wgId = id;}
}	


/*
 
 ************************
 * word group structure *
 ************************

<wg:group>
	<wg:head>
		<wg:word xlink:href="">
				<wg:modifiers>
					<wg:specifier></wg:specifier>
					<wg:definer></wg:definer>
					<wg:qualifer></wg:qualifier>
					<wg:relator></wg:qualifier>
					<wg:connector></wg:connector>
				</wg:modifiers>
		</wg:word>
	</wg:head>
</wg:group>

DTD:

<!ELEMENT wg:groups (wg:group+)>
<!ELEMENT wg:group (wg:head)>
<!ATTLIST wg:group
	id ID #REQUIRED
>

<!ELEMENT wg:head (wg:word)>
<!ELEMENT wg:word (wg:modifiers?)>
<!ELEMENT wg:modifiers (wg:specifier?, wg:definer?, wg:qualifier?, wg:relator?, wg:connector?)>

<!ELEMENT wg:specifier (wg:word+, wg:group*)>
<!ELEMENT wg:qualifier (wg:word+, wg:group*)>
<!ELEMENT wg:definer (wg:word+, wg:group*)>
<!ELEMENT wg:relator (wg:word+, wg:group*)>
<!ELEMENT wg:connector (wg:word)>

<!ATTLIST wg:word
	xlink:href CDATA #REQUIRED
>


*/
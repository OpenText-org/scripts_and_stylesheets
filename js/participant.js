
var partName = new Array();

var partType = "G";
var refType="a";

function addPart()
{


	var name = prompt("Please enter identifying name for new participant");

	if (name != null)
	{
		var select = document.getElementById("partList"); 
		var opt = document.createElement("option");
		opt.value = partNum;
		opt.appendChild(document.createTextNode(partNum + ": "
	+ name));
	        opt.selected = "1";
		select.appendChild(opt);
		partName[partNum] = name;
		partNum++;
	}

}


function activateWords()
{

/*
    var words = document.getElementById("words");

    var word = words.getElementsByTagName("span");

    for (i=0; i<word.length; i++)
    {
		if (word[i].hasAttribute('id'))
		{
			word.item(i).onclick = select;
		}
    }
*/    
}

function select(node)
{
	if (node==null)
	{
		 node = this;
	}
	
	if (node.style.backgroundColor.match("#c0c0c0"))
	{
		node.style.backgroundColor = "#ffffff";
		node.style.padding = "0px";
		node.partNum = ""; 
		node.partType = "";
		node.removeChild(node.getElementsByTagName("span").item(0));
	}
	else
	{
	        node.style.backgroundColor = "#c0c0c0";
		
		var pn = getPartNum();
		var pt = getPartType();
		var rt = getRefType();

		node.partNum = pn;
		node.partType = pt;
		node.refType = rt;
		
		var spanNode = document.createElement("span");
		var text = "p" + pn + " " + pt + rt + " ";;
		spanNode.appendChild(document.createTextNode(text));
		spanNode.style.backgroundColor = "#d0d0d0";
		spanNode.style.fontFamily = "Arial";
		spanNode.style.color = "red";
		spanNode.style.fontSize = "10px";
		spanNode.style.verticalAlign = "top";
		node.appendChild(spanNode);
	}

}

function getPartNum()
{
	var partSelect = document.getElementById("partList");
	
	var partOpts = partSelect.getElementsByTagName("option");

	var num="";
	
	for (var i=0; i<partOpts.length; i++)
	{
		if (partOpts.item(i).selected)
		{
		    if (num > '') { num += "_";}
		    num += partOpts.item(i).value;
		}
	}

	if (num == '') alert("no participants!");	

	return num;
}

function getPartType()
{

	return partType;

}

function getRefType()
{

	if (refType==0)
	{
		return "";
	}
	else
	{
		return refType;
	}

}


function selectPartType(node)
{
	partType = node.value.substr(0,1).toUpperCase();
}

function selectRefType(node)
{
	refType = node.value.substr(0,1);
}

function getParticipantData()
{
	var xml = "";

	xml += "\n<participants>";
	for (var p=1; p< partName.length; p++)
	{
	    if (partName[p] != null)
	    {	        
	    xml += "\n\t<participant num=\"" + p + "\"";
	    xml += " name=\"" + partName[p] + "\"/>";  
	    }
	}
	xml += "\n</participants>";

	xml += "\n<partRefs>";
	var words =
	document.getElementById("words").getElementsByTagName("span");

	for (var i=0; i<words.length; i++)
	{
	    if (words.item(i).style.backgroundColor.match("#c0c0c0"))
	    {
		var rtype = words.item(i).getAttribute("refType");

		xml+= "\n\t<wg:part num=\"" + words.item(i).getAttribute("partNum") + "\"" ;
		xml+= " type=\"" + words.item(i).getAttribute("partType") + "\"";
		if (rtype.length > 0) { xml += " refType=\"" + rtype + "\""; }
		xml+= " xlink:href=\"" + words.item(i).getAttribute("id") + "\"/>";
		
		
	    }
	
	}
	xml += "\n</partRefs>";
	return xml;

}

function formData()
{
	var xmlForm = document.getElementById('xml');
	for (var p=1; p< partName.length; p++)
	{
	    if (partName[p] != null)
	    {	        
	    var part = document.createElement('input');
	    part.type='hidden';
	    part.name="p"+p;
	    part.value=partName[p];
	    
	    xmlForm.appendChild(part);
	    }
	}

	var words =
	document.getElementById("words").getElementsByTagName("span");

	for (var i=0; i<words.length; i++)
	{
	    if (words.item(i).style.backgroundColor.match("#c0c0c0"))
	    {
	    var pn = words.item(i).getAttribute("partNum"); 
	    var wid = words.item(i).getAttribute("id");
		var ptype = words.item(i).getAttribute("partType");
		var rtype = words.item(i).getAttribute("refType");
		var part = document.createElement('input');
	    part.type='hidden';
	    part.value= pn + "-" + ptype + "}" + rtype;
	    part.name=wid;
		xmlForm.appendChild(part);;
	    }
	
	}
	
	xmlForm.submit();
}


function outputWindow(text)
{

       var console =
    window.open("","","width=500,height=400,scrollbars=yes,resizable=yes");

       console.document.open('text/plain');
       console.document.writeln(text);
       console.document.close();
							
}


function Send()
{
	if (confirm('Are you sure you want to e-mail your annotation to the working-group chair?'))
	{
         document.xml.annotation.value = getParticipantData();
	 document.xml.submit();
	}
}

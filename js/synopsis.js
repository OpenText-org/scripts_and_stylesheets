
/*
		synopsis.js
		
		functions for the eSynopsis application
		
		(c) 2004 OpenText.org
		
		ver. 0.1 10/8/04
		
*/
	
/*
		GLOBAL VARIABLES
*/

var selected = new Array();
var selCnt = 0;

var vwin;;

/* hard coded definition of arrays... needs rewriting! */



selected['Mat'] = new Array();
selected['Mar'] = new Array();
selected['Luk'] = new Array();

// -------- END OF GLOBAL VARIABLES --------------- 
	
	
	
	function select(node)
	{

		var id = node.id;
		var bk = id.substr(0,3);
		var wid;

		if (id.indexOf('.w')!=-1 && id.indexOf('.wg')==-1)
		{
				wid = id.substr(5);
	 
		}
		else
		{
			 wid = id;
		}
		
	 
		if (node.style.backgroundColor == '#ffcccc')
		{
			node.style.backgroundColor = '#ffffff';
			selected[bk].sort();
			for (id in selected[bk])
			{
				if (selected[bk][id] == wid)
				{
					delete selected[bk][id];
					selCnt--;
				}
			}
		}
		else
		{
			node.style.backgroundColor = '#ffcccc';
			selected[bk][selected[bk].length]=wid;
			selCnt++;
		}
	}
	
	
	
	// Add selected words/verses/clauses to a new synoptic unit
	function addSynopticUnit()
	{
		
		if (selCnt == 0) { return; }
	
		var units = document.getElementById("units");
		var tbody = units.getElementsByTagName("tbody")[0];
	
		var tr = document.createElement("tr");
		
		 
	
		for (b in order)
		{ 
			var bk = order[b];
			var td = document.createElement("td");
			td.bk = order[b];
			td.style.border="1px black solid";
			td.onclick = function() { insert(this) };
			
			 
				insert(td);
			 
	
		tr.appendChild(td);
	
		tbody.appendChild(tr);
		selCnt = 0;
	}
	
	
	function insert(node)
	{
	
	var bk = node.bk;
	 
	
			selected[bk].sort();
			for (id in selected[bk])
			{ 
				var wid = selected[bk][id];

				if (wid.indexOf('_')==-1)
				{
					wid = bk + '.w' + selected[bk][id];
				}
				 
		
				var wd = document.getElementById(wid);
				
				wd.onclick="";
				wd.style.backgroundColor="#ffffff";
				var nwd = wd.cloneNode(true);
				wd.style.color = "#ccccff";
				node.appendChild(nwd);

				var spc = document.createTextNode(" ");
				node.appendChild(spc);
				
				delete selected[bk][id];
			}
			
		}	
	
	}
	
	// read synoptic units and create XML
	function outputSUnits()
	{
		var units = document.getElementById("units");
		var tbody = units.getElementsByTagName("tbody")[0];
		var rows = tbody.getElementsByTagName("tr");
		var xml = "";
	
		var row = tbody.firstChild;
		var i=0;
	
		while (row != null)
		{
			xml += "\n<synopticUnit>";
			 
			
			var tds = row.firstChild;
			var j=0;
			while (tds != null)
			{
				var wds = tds.getElementsByTagName("span");
				if (wds.length > 0)
				{
					if (wds[0].id)
					{
					xml += "\n\t<component ref=\"" + ref[j] + "\">";
				
					for (var k=0; k<wds.length; k++)
					{
						if (wds[k].id)
						{
							xml += "\n\t\t<w xlink:href=\"" + wds[k].id + "\"/>";
						}
					}
					
					xml += "\n\t</component>";
					}
				}
				tds = tds.nextSibling;
				j++;
			}
			xml += "\n</synopticUnit>";	
			row = row.nextSibling;
			i++;
		}
		
		output(xml);
	}
	
	
	function output(text)
    {

       var console =
    window.open("","","width=500,height=400,scrollbars=yes,resizable=yes");

       console.document.open('text/plain');
       console.document.writeln(text);
       console.document.close();
							
    }


	// opens a view window and loads page
   function viewWindow(url)
   {
	   if (!vwin || vwin.closed)
	   {
		   vwin = window.open(url,"","width=950, height=750,scrollbars=auto, resizable=yes, menubar=no, addressbar=no");
	   }
	   else
		{ 
			vwin.location = url;
			vwin.focus();
		}
   }
   
   
   // show or hide the div container immediately following the element that calls this function 
   // used for FILTERS and SYNOPTIC UNITS panels on view parallel screen
   function showHide(node)
   {
	   window.cancelBubble;
	   var span = node.getElementsByTagName('span')[0];
	   var div = node.nextSibling;
		 
		if (span.firstChild.data =='+')
		{
			span.replaceChild(document.createTextNode('-'),span.firstChild);
			div.style.display='block';
		}
	    else
	    {
			span.replaceChild(document.createTextNode('+'),span.firstChild);
			div.style.display='none';
	    }
   }
   
   
   function viewSUnit()
   {
	   var sus = document.getElementById('sunits');
	   var sel = sus.getElementsByTagName('input');
	   var suid;
	   
	   for (var i=0; sel.length; i++)
	   {
	   alert(sel[i].tagName);
		   if (sel[i].checked)
		   {
			 suid = sel[i].value;
			}
	    }
	    alert(suid);
		return suid;
   }
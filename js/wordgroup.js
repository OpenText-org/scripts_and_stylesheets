
/*

Word group annotation tool for OpenText.org

version 0.2 (22/2/2002)

mtrout@nycap.rr.com

*/



var head = null;
var selected = new Object();


function addModify()
{
    addModifiers(this.parentNode.parentNode);
    this.width = 0;
}

function addModifiers(node)
{
    
    var grel = document.createElement("tr");

    /* Header cells for relationship values */
    var sp = document.createElement("td");
    sp.appendChild(document.createTextNode("sp"));
    sp.onmousedown = insert;
    var df = document.createElement("td");
    df.appendChild(document.createTextNode("df"));
    df.onmousedown = insert;
    var ql = document.createElement("td");
    ql.appendChild(document.createTextNode("ql"));
    ql.onmousedown = insert;
    var rl = document.createElement("td");
    rl.appendChild(document.createTextNode("rl"));
    rl.onmousedown = insert;
    var cj = document.createElement("td");
    cj.appendChild(document.createTextNode("cj"));
    cj.onmousedown = insert;

    grel.appendChild(sp);
    grel.appendChild(df);
    grel.appendChild(ql);
    grel.appendChild(rl);
    grel.appendChild(cj);

    /* container cells for relationships */
    var spc = document.createElement("td");
    spc.rel = "sp";

    var dfc = document.createElement("td");
    dfc.rel = "df";

    var qlc = document.createElement("td");
    qlc.rel = "ql";

    var rlc = document.createElement("td");
    rlc.rel = "rl";

    var cjc = document.createElement("td");
    cjc.rel = "cj";

    var container = document.createElement("tr");
    container.height = 20;
    container.appendChild(spc);
    container.appendChild(dfc);
    container.appendChild(qlc);
    container.appendChild(rlc);
    container.appendChild(cjc);

   
    node.appendChild(grel);
    node.appendChild(container);


    return node;

}

function createWord(type, node)
{
   if (type == "wg")
   {
      var cnt = 0;
      for (items in selected) { cnt++};
      if (cnt == 0)
      {
          alert("Please select head term before creating new word group");
          return;
      }
   }

   var wtable = document.createElement("table");
   wtable.border = 1;
   wbody = document.createElement("tbody");
   wtr = document.createElement("tr");
   wtd = document.createElement("td");
   wtd.colSpan = 5;



   if (type == "w")
   {

      var image = document.createElement("img");
      image.src = "add.gif";
      image.alt = "Add modifiers";
      image.onclick = addModify;
      wtd.appendChild(node);
      wtd.appendChild(image);
   }
   else
   {
      for (id in selected)
      {
          var firstChild = selected[id];
          firstChild.style.background = "white";
          wtd.appendChild(firstChild);
          delete selected[id];
      }
   }

   wtr.appendChild(wtd);

   wbody.appendChild(wtr);
   if (type == "wg") {addModifiers(wbody);}
   wtable.appendChild(wbody);

   if (type == "wg")
   {
       document.getElementById("canvas").appendChild(wtable);
   }
   else
   {
       return wtable;
   }

}

function insert()
{

        var position = null;
        for (var i=0; i<this.parentNode.childNodes.length; i++)
        {
           if (this.parentNode.childNodes[i] == this) { position = i;} 
        }

        var container = this.parentNode.nextSibling.childNodes[position];

        for (id in selected)
        {
           var firstChild = selected[id];
           firstChild.style.background = "white";
           container.appendChild(createWord('w',firstChild));
           delete selected[id];
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

           selected[this.id] = this;
           
        }
    }

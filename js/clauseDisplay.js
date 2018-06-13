
// show popup note at current mouse position
// set events so it is hidden on mouseout
// notes hidden in document with id attribute 
// that matches notenum


function showPopupNote(mode, notenum)
{
	 
	var visibilityValue = mode=='show' ? 'visible' : 'hidden';
	var xMousePos = event.x+document.body.scrollLeft;
        var yMousePos = event.y+document.body.scrollTop;
	
       // xMousePosMax = document.body.clientWidth+document.body.scrollLeft;
       // yMousePosMax = document.body.clientHeight+document.body.scrollTop;
	var note = document.getElementById(notenum);
	 
	note.style.top = yMousePos;
	note.style.left = xMousePos;
	note.style.visibility = visibilityValue;
	
}

function showWordGroup(mode, wg, wcnt, lev)
{

   var clcolor = lev == 'primary' ? 'rgb(255,210,230)' : '#f0f0f0';

	var bgcolor = mode == 'show' ? 'yellow' :  clcolor;
	for (var i=0; i < wcnt; i++) 
	{
		var wgid = wg + '_' + i;
		var wnode = document.getElementById(wgid);
		if (wnode.role == 'head')
		{
			if (mode == 'show')
			{
				wnode.style.color = 'red';
			}
			else
			{
				wnode.style.color = 'black';
			}
		}
		wnode.style.backgroundColor = bgcolor;
	}

}

// to search the html objects in html document
function spm_getById(sID)
{
  if (document.all == null)
    return document.getElementById(sID);
  else
    return document.all(sID);
}

// to focus on found object
function GetFocus(name)
{
	var obj = spm_getById(name);
	if(obj != null)
		obj.focus();
}

function clickButton(eButton)
{
	if(window.event.keyCode == "13")
	{
		eButton.click();
        return false;
	}
}

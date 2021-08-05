
function CheckLetter(obj){
	var sText = new String(obj.value);
	if(sText.length > 0)
		obj.value = sText.substring(0, 1).toUpperCase() + sText.substring(1, sText.length).toLowerCase();
}

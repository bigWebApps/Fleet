
// function return the html objects in html document using ID
function spm_getById(sID)
{
  if (document.all == null)
    return document.getElementById(sID);
  else
    return document.all(sID);
}

// function is enabling or disabling the html objects for setting a new repair
function CheckEditMode()
{
	if(document.Form1.html_chNewRepair != null)
		if(document.Form1.html_chNewRepair.checked){
			ActiveEditMode();
		}
		else
		{
			DeactiveEditMode();
		}

}

// function is enabling html object which depend on setting a new repair
function ActiveEditMode(){
	var linkAddRepair = spm_getById("lbAddRepair");
	if(linkAddRepair != null){
		linkAddRepair.disabled = false;
		if(linkAddRepair.getAttribute("href") == null)
			linkAddRepair.setAttribute("href", "javascript:__doPostBack('lbAddRepair', '')");
		else
			linkAddRepair.href = "javascript:__doPostBack('lbAddRepair', '')";
		}
	var linkAddLog = spm_getById("lbAddLog");
	if(linkAddLog != null){
		linkAddLog.disabled = false;
		if(linkAddLog.getAttribute("href") == null)
			linkAddLog.setAttribute("href", "javascript:__doPostBack('lbAddLog', '')");
		else
			linkAddLog.href = "javascript:__doPostBack('lbAddLog', '')";
		}
	if(document.Form1.ddlRepairCats != null)
		document.Form1.ddlRepairCats.disabled = false;
	if(document.Form1.ddlRepairItems != null)
		document.Form1.ddlRepairItems.disabled = false;
	if(document.Form1.tbNotes != null)
		document.Form1.tbNotes.disabled = false;
	if(document.Form1.tbQty != null)
		document.Form1.tbQty.disabled = false;
	if(document.Form1.tbStock != null)
		document.Form1.tbStock.disabled = false;
	if(document.Form1.tbDesc != null)
		document.Form1.tbDesc.disabled = false;
	if(document.Form1.tbCost != null)
		document.Form1.tbCost.disabled = false;
	if(document.Form1.btnAddPart != null)
		document.Form1.btnAddPart.disabled = false;
	if(document.Form1.tbHours != null)
		document.Form1.tbHours.disabled = false;
	if(document.Form1.tbMinutes != null)
		document.Form1.tbMinutes.disabled = false;
		
	var objInputs = document.Form1.elements;
	var i;
	for(i = 0; i<objInputs.length; i++){
		if(objInputs[i].name.substring(0, 17) == "repReportedIssues"){
			objInputs[i].disabled = false;
			}
		}
}

// function is disabling html object which depend on setting a new repair
function DeactiveEditMode(){
	
	var linkAddRepair = spm_getById("lbAddRepair");
	if(linkAddRepair != null){
		linkAddRepair.disabled = true;
		linkAddRepair.removeAttribute("href");
		}
	var linkAddLog = spm_getById("lbAddLog");
	if(linkAddLog != null){
		linkAddLog.disabled = true;
		linkAddLog.removeAttribute("href");
		}
	if(document.Form1.ddlRepairCats != null)
		document.Form1.ddlRepairCats.disabled = true;
	if(document.Form1.ddlRepairItems != null)
		document.Form1.ddlRepairItems.disabled = true;
	if(document.Form1.tbNotes != null)
		document.Form1.tbNotes.disabled = true;
	if(document.Form1.tbQty != null)
		document.Form1.tbQty.disabled = true;
	if(document.Form1.tbStock != null)
		document.Form1.tbStock.disabled = true;
	if(document.Form1.tbDesc != null)
		document.Form1.tbDesc.disabled = true;
	if(document.Form1.tbCost != null)
		document.Form1.tbCost.disabled = true;
	if(document.Form1.btnAddPart != null)
		document.Form1.btnAddPart.disabled = true;
	if(document.Form1.tbHours != null)
		document.Form1.tbHours.disabled = true;
	if(document.Form1.tbMinutes != null)
		document.Form1.tbMinutes.disabled = true;
	var objInputs = document.Form1.elements;
	var i;
	for(i = 0; i<objInputs.length; i++){
		if(objInputs[i].name.substring(0, 17) == "repReportedIssues"){
			objInputs[i].disabled = true;
			}
		}
}

function ValidRepairItemsWithOpenWindow()
{
    var isValid = ValidRepairItems();
    if (isValid)
    {
        openWindow();
    }
    return isValid;
}

function ValidRepairItems(){
	var ValCat = spm_getById("lblValidatorCategory");
	var ValItem = spm_getById("lblValidatorItem");
	var Cat = spm_getById("ddlRepairCats");
	var Item = spm_getById("ddlRepairItems");
	var NewRepair = spm_getById("html_chNewRepair");

	if(NewRepair != null){
		if(!NewRepair.checked){
			ValCat.style.display = "none";
			ValItem.style.display = "none";
			return true;
			}
		}

	var IsValid = false;
	if(Cat.value == 0){
		ValCat.style.display = "";
		IsValid = false;
		}
	else{
		ValCat.style.display = "none";
		IsValid = true;
		}
	if(Item.value == 0){
		ValItem.style.display = "";
		IsValid = false;
		}
	else{
		ValItem.style.display = "none";
		IsValid = true;
		}

	return IsValid;
}

function spm_getById(sID)
{
  if (document.all == null)
    return document.getElementById(sID);
  else
    return document.all(sID);
}
var objOkay, objFair, objRN;
var objNS, objRepaired, objReplaced;

// function is processing the checkboxes for Okay status of inspection items
// these chechboxes is behaving as radio button, 
// if user click on Okay then another checkboxes will be unselected
function ClickOnOkay(sId)
{
	var result = true;
	var strId = new String(sId);
	strId = strId.substring(0, strId.lastIndexOf("_"));
	objOkay = spm_getById(sId);
	objFair = spm_getById(strId + "_chFair");
	objRN = spm_getById(strId + "_chRNeeded");
	objNS = spm_getById(strId + "_cbNoService");
	objRepaired = spm_getById(strId + "_cbRepaired");
	objReplaced = spm_getById(strId + "_cbReplaced");
	if(objOkay.checked){
		objFair.checked = false;
		if(objRepaired.checked || objReplaced.checked){
			result = confirm("This inspection item has been serviced. Select OK to continue and remove the service.");
			if(result){
				objRN.checked = false;

				objNS.checked = false;
				objNS.disabled = true;
				if(objNS.parentElement!=null)
					objNS.parentElement.disabled = true;

				objRepaired.checked = false;
				objRepaired.disabled = true;
				if(objRepaired.parentElement != null)
					objRepaired.parentElement.disabled = true;

				objReplaced.checked = false;
				objReplaced.disabled = true;
				if(objReplaced.parentElement != null)
					objReplaced.parentElement.disabled = true;
				}
			else{
				objRN.checked = true;
				objOkay.checked = false;
				}
			}
		else{
				objRN.checked = false;

				objNS.checked = false;
				objNS.disabled = true;
				if(objNS.parentElement != null)
					objNS.parentElement.disabled = true;

				objRepaired.checked = false;
				objRepaired.disabled = true;
				if(objRepaired.parentElement != null)
					objRepaired.parentElement.disabled = true;

				objReplaced.checked = false;
				objReplaced.disabled = true;
				if(objReplaced.parentElement != null)
					objReplaced.parentElement.disabled = true;
			}
		}
	return result;
}

// function is processing the checkboxes for the Fair status of inspection items
// these chechboxes is behaving as radio button, 
// if user click on Fair box then another checkboxes will be unselected
function ClickOnFair(sId)
{
	var result = true;
	var strId = new String(sId);
	strId = strId.substring(0, strId.lastIndexOf("_"));
	objFair = spm_getById(sId);
	objOkay = spm_getById(strId + "_chOkay");
	objRN = spm_getById(strId + "_chRNeeded");
	objNS = spm_getById(strId + "_cbNoService");
	objRepaired = spm_getById(strId + "_cbRepaired");
	objReplaced = spm_getById(strId + "_cbReplaced");
	if(objFair.checked){
		objOkay.checked = false;
		if(objRepaired.checked || objReplaced.checked){
			result = confirm("This inspection item has been serviced. Select OK to continue and remove the service.");
			if(result){
				objRN.checked = false;

				objNS.checked = false;
				objNS.disabled = true;
				if(objNS.parentElement!=null)
					objNS.parentElement.disabled = true;

				objRepaired.checked = false;
				objRepaired.disabled = true;
				if(objRepaired.parentElement != null)
					objRepaired.parentElement.disabled = true;

				objReplaced.checked = false;
				objReplaced.disabled = true;
				if(objReplaced.parentElement != null)
					objReplaced.parentElement.disabled = true;
				}
			else{
				objRN.checked = true;
				objFair.checked = false;
				}
			}
		else{
				objRN.checked = false;

				objNS.checked = false;
				objNS.disabled = true;
				if(objNS.parentElement != null)
					objNS.parentElement.disabled = true;

				objRepaired.checked = false;
				objRepaired.disabled = true;
				if(objRepaired.parentElement != null)
					objRepaired.parentElement.disabled = true;

				objReplaced.checked = false;
				objReplaced.disabled = true;
				if(objReplaced.parentElement != null)
					objReplaced.parentElement.disabled = true;
			}
		}
	return result;
}

// function is processing the checkboxes for the RepairNeeded status of inspection items
// these chechboxes is behaving as radio button, 
// if user click on RN checkbox then another checkboxes will be unselected and 
// the Result checkboxes will be enabling 
function ClickOnRN(sId)
{
	var strId = new String(sId);
	strId = strId.substring(0, strId.lastIndexOf("_"));
	objRN = spm_getById(sId);
	objNS = spm_getById(strId + "_cbNoService");
	objOkay = spm_getById(strId + "_chOkay");
	objFair = spm_getById(strId + "_chFair");
	objRepaired = spm_getById(strId + "_cbRepaired");
	objReplaced = spm_getById(strId + "_cbReplaced");
	if(objRN.checked){
		objOkay.checked = false;
		objFair.checked = false;

		objRepaired.disabled = false;
		if(objRepaired.parentElement != null)
			objRepaired.parentElement.disabled = false;

		objReplaced.disabled = false;
		if(objReplaced.parentElement != null)
			objReplaced.parentElement.disabled = false;

		objNS.checked = true;
		objNS.disabled = false;
		if(objNS.parentElement != null)
			objNS.parentElement.disabled = false;
	}
	else{
		if(objRepaired.checked || objReplaced.checked){
			result = confirm("This inspection item has been serviced. Select OK to continue and remove the service.");
			if(result){
				objRN.checked = false;

				objNS.checked = false;
				objNS.disabled = true;
				if(objNS.parentElement != null)
					objNS.parentElement.disabled = true;

				objRepaired.checked = false;
				objRepaired.disabled = true;
				if(objRepaired.parentElement != null)
					objRepaired.parentElement.disabled = true;

				objReplaced.checked = false;
				objReplaced.disabled = true;
				if(objReplaced.parentElement != null)
					objReplaced.parentElement.disabled = true;
				}
			else{
				objRN.checked = true;
				objOkay.checked = false;
				objFair.checked = false;
				}
			}
		else{
			objRepaired.checked = false;
			objRepaired.disabled = true;
			if(objRepaired.parentElement != null)
				objRepaired.parentElement.disabled = true;

			objReplaced.checked = false;
			objReplaced.disabled = true;
			if(objReplaced.parentElement != null)
				objReplaced.parentElement.disabled = true;

			objNS.checked = false;
			objNS.disabled = true;
			if(objNS.parentElement != null)
				objNS.parentElement.disabled = true;
			}
	}
	return true;
}

// this function processing the checkboxes for result status of inspection item
function ClickOnNS(sId)
{
	var strId = new String(sId);
	strId = strId.substring(0, strId.lastIndexOf("_"));
	objNS = spm_getById(sId);
	objRepaired = spm_getById(strId + "_cbRepaired");
	objReplaced = spm_getById(strId + "_cbReplaced");
	if(objNS.checked){
		if(objRepaired.checked || objReplaced.checked){
			result = confirm("This inspection item has been serviced. Select OK to continue and remove the service.");
			if(result){
				objRepaired.checked = false;
				objReplaced.checked = false;
				}
			else{
				objNS.checked = false;
				}
		}
	}
	return true;
}

function ClickOnRepair(sId){
	var strId = new String(sId);
	strId = strId.substring(0, strId.lastIndexOf("_"));
	objRepaired = spm_getById(sId);
	objNS = spm_getById(strId + "_cbNoService");
	objReplaced = spm_getById(strId + "_cbReplaced");
	if(objRepaired.checked){
		objNS.checked = false;
		objReplaced.checked = false;
		}
	else{
		objNS.checked = false;
		objReplaced.checked = false;
		objRepaired.checked = true;
		}
	return true;
}

function ClickOnReplace(sId){
	var strId = new String(sId);
	strId = strId.substring(0, strId.lastIndexOf("_"));
	objReplaced = spm_getById(sId);
	objNS = spm_getById(strId + "_cbNoService");
	objRepaired = spm_getById(strId + "_cbRepaired");
	if(objReplaced.checked){
		objNS.checked = false;
		objRepaired.checked = false;
		}
	else{
		objNS.checked = false;
		objRepaired.checked = false;
		objReplaced.checked = true;
		}
	return true;
}

// Setting the Okay status to the category of the inspection items
function CheckOkayCat(CatId)
{
	var chBoxes;
	var i, N;
	chBoxes = spm_getById(CatId);
	if(chBoxes != null){
		N = chBoxes.length;
		for(i = 0; i < N; i ++){
			if(chBoxes[i].children.length > 0) 
				if(chBoxes[i].children[0].tagName == "INPUT"){
					chBoxes[i].children[0].checked = true;
					ClickOnOkay(chBoxes[i].children[0].name);	
					}
		}
	}
}

// Setting the Fair status to the category of the inspection items
function CheckFairCat(CatId)
{
	var chBoxes;
	var i, N;
	chBoxes = spm_getById(CatId);
	if(chBoxes != null){
		N = chBoxes.length;
		for(i = 0; i < N; i ++){
			if(chBoxes[i].children.length > 0) 
				if(chBoxes[i].children[0].tagName == "INPUT"){
					chBoxes[i].children[0].checked = true;
					ClickOnFair(chBoxes[i].children[0].name);	
					}
		}
	}
}

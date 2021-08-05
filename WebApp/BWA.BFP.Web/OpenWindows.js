var popUp;  // the popup window object
var G_Time; // global time

// function return the html objects in html document using ID
function spm_getById(sID)
{
  if (document.all == null)
    return document.getElementById(sID);
  else
    return document.all[sID];
} 

// function return a popup window with input settings
function _CreateWindow(url, name, features, width, height)
{
	if(features == '')
	{
		if(width > window.screen.availWidth)
			width = window.screen.availWidth - 10;

		if(height > window.screen.availHeight)
			height = window.screen.availHeight - 30;

		var left = (window.screen.availWidth - width) / 2;
		var top = (window.screen.availHeight - height) / 2;

		features = 'toolbars=0,resizable=1,scrollbars=1';

		features += ',left=' + left;
		features += ',top=' + top;
		features += ',width=' + width;
		features += ',height=' + height;
	}
	
    url += '&popup=1';

    var Window = window.open(url, name, features);
	
	if (!Window.opener)
		Window.opener = self;
    if(Window) {
		Window.focus();
		return Window;
	}

	return false;
}

// function open window
function CreateWindow(url, name, features, width, height)
{
    _CreateWindow(url, name, features, width, height)
    return false;
}


// function open popup window for a PM History screen
function AddLS(PMSchedDetailId, WorkOrderId, HistoryId)
{
	return CreateWindow('wo_addPMHistoryforPMItem.aspx?id=' + WorkOrderId + '&scheddetailsid=' + PMSchedDetailId + '&historyid=' + HistoryId, '_blank', '', 375, 250);
}

// function open popup window for a Inspection History screen
function AddLI(IspectSchedDetailId, WorkOrderId, HistoryId)
{
	return CreateWindow('wo_editInspectHistory.aspx?id=' + WorkOrderId + '&inspectid=' + IspectSchedDetailId + '&historyid=' + HistoryId, '_blank', '', 500, 200);
}

// function open window for a calendar screen
function OpenCalendar(idname, postBack, x, y)
{
	if(y > 320)
		y = y - 310;

	popUp = window.open('Calendar.aspx?formname=' + document.forms[0].name + 
		'&id=' + idname + '&selected=' + GetDateFromActiveDate(idname) + '&postBack=' + postBack, 
		'popupcal', 'width=185,height=280,left=' + x + ',top=' + y + ' scrollbars=no');
}

// function open popup window for a Schedule Date screen
function OpenPopUpScheduleDate(idname, postBack)
{
	var x, y, w, h;
	G_Time = "0";
	x = window.screen.availWidth/2;
	y = 0;
	w = window.screen.availWidth/2 - 16;
	h = window.screen.availHeight - 32;	
	
	popUp = window.open('wo_popupScheduleDate.aspx?formname=' + document.forms[0].name + 
		'&id=' + idname + '&selected=' + GetDateFromActiveDate(idname) + '&postBack=' + postBack + '&time=' + G_Time, 
		'_blank', 'width=' + w + ',height=' + h + ',left=' + x + ',top=' + y + ' scrollbars=yes');
}

// function is setting date to ActiveDate ASP.NET control 
function SetDateToActiveDate(formName, id, newDate, postBack, time)
{
	if(popUp != null){
		popUp.close(); 
		SetDateToActiveDateEx(id, newDate, time);
		if (postBack)
			__doPostBack(id, '');
		}
		return;
}

// getting the date string from ActiveDateTime control
function GetDateFromActiveDate(idname)
{
	var adtDay, adtMonth, adtYear, adtHour, adtMinute, adtMeridiem;
	var l_date = new Date(0);
	var iHour = new Number();

	if(navigator.appCodeName == "Mozilla"){
		adtDay  = document.all[idname + "_day"];
		adtMonth = document.all[idname + "_month"];
		adtYear = document.all[idname + "_year"];
		if(document.all[idname + "_hour"] != null)
			adtHour =  document.all[idname + "_hour"];
		if(spm_getById[idname + "_minute"] != null)
			adtMinute = document.all[idname + "_minute"];
		if(document.all[idname + "_meridiem"] != null)
			adtMeridiem = document.all[idname + "_meridiem"];
		}
	else{
		adtDay  = spm_getById(idname + "_day");
		adtMonth = spm_getById(idname + "_month");
		adtYear = spm_getById(idname + "_year");
		if(spm_getById(idname + "_hour") != null)
			adtHour =  spm_getById(idname + "_hour");
		if(spm_getById(idname + "_minute") != null)
			adtMinute = spm_getById(idname + "_minute");
		if(spm_getById(idname + "_meridiem") != null)
			adtMeridiem = spm_getById(idname + "_meridiem");
	};

	
	if(isNaN(parseInt(adtYear.options[adtYear.selectedIndex].value)) == false)
		l_date.setFullYear(parseInt(adtYear.options[adtYear.selectedIndex].value));
	
	if(isNaN(parseInt(adtMonth.options[adtMonth.selectedIndex].value)) == false)
		l_date.setMonth(parseInt(adtMonth.options[adtMonth.selectedIndex].value) - 1);

	if(isNaN(parseInt(adtDay.options[adtDay.selectedIndex].value)) == false)
		l_date.setDate(parseInt(adtDay.options[adtDay.selectedIndex].value));
		
	if(adtHour != null){
		iHour = parseInt(adtHour.options[adtHour.selectedIndex].value)
		if(adtMeridiem.selectedIndex == 1){
			if(iHour != 12)
				iHour = iHour + 12
		}
		else{
			if(iHour == 12)
				iHour = 0
		}
		G_Time = iHour.toString();
		l_date.setHours(iHour);
		}
	else{
		G_Time = "0"
		}
	if(adtMinute != null){
		l_date.setMinutes(parseInt(adtMinute.options[adtMinute.selectedIndex].value));
		}
	l_date.setMinutes(-l_date.getTimezoneOffset())
	
	return l_date.getTime();
}

// setting the date to ActiveDateTime control from date string
function SetDateToActiveDateEx(idname, _date, _time)
{
	var adtDay, adtMonth, adtYear, adtHour, adtMinute, adtMeridiem;
	var i;
	if(_date != null){	
		l_date2 = new Date(_date);

		if(navigator.appCodeName == "Mozilla"){
			adtDay  = document.all[idname + "_day"];
			adtMonth = document.all[idname + "_month"];
			adtYear = document.all[idname + "_year"];
			if(document.all[idname + "_hour"] != null)
				adtHour =  document.all[idname + "_hour"];
			if(spm_getById[idname + "_minute"] != null)
				adtMinute = document.all[idname + "_minute"];
			if(document.all[idname + "_meridiem"] != null)
				adtMeridiem = document.all[idname + "_meridiem"];
		}
		else{
			adtDay  = spm_getById(idname + "_day");
			adtMonth = spm_getById(idname + "_month");
			adtYear = spm_getById(idname + "_year");
			if(spm_getById(idname + "_hour") != null)
				adtHour =  spm_getById(idname + "_hour");
			if(spm_getById(idname + "_minute") != null)
				adtMinute = spm_getById(idname + "_minute");
			if(spm_getById(idname + "_meridiem") != null)
				adtMeridiem = spm_getById(idname + "_meridiem");
		};

		
		var sYear = new String(l_date2.getFullYear());
		for(i = 0; i < adtYear.options.length; i++){
			if(adtYear.options[i].value == sYear)
				adtYear.options[i].selected = true;
			}
		var sMonth = new String(l_date2.getMonth()+1);
		for(i = 0; i < adtMonth.options.length; i++){
			if(adtMonth.options[i].value == sMonth)
				adtMonth.options[i].selected = true;
			}
		var sDay = new String(l_date2.getDate());
		for(i = 0; i < adtDay.options.length; i++){
			if(adtDay.options[i].value == sDay)
				adtDay.options[i].selected = true;
			}
		if(adtHour != null){
			var time = new Number(_time);
			if(time == 0 || time == 12){
				if(time == 0)
					adtMeridiem.options[0].selected = true;
				else
					adtMeridiem.options[1].selected = true;
				for(i = 0; i < adtHour.options.length; i++){
					if(adtHour.options[i].value == "12")
						adtHour.options[i].selected = true;				
					}
			}
			else{
				if(time > 12){
					time = time - 12
					adtMeridiem.options[1].selected = true;
					for(i = 0; i < adtHour.options.length; i++){
						if(adtHour.options[i].value == time.toString(10))
							adtHour.options[i].selected = true;				
						}
				}
				else{
					adtMeridiem.options[0].selected = true;
					for(i = 0; i < adtHour.options.length; i++){
						if(adtHour.options[i].value == time.toString(10))
							adtHour.options[i].selected = true;				
						}
				}
			}
		if(adtMinute != null){
			adtMinute.options[0].selected = true;
			}
		}
	}
	return;
}

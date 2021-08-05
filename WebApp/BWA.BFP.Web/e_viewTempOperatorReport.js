var popUp;  // the popup window object
var G_Time; // global time

// function return the html objects in html document using ID
function spm_getById(sID)
{
	if(document.all == null)
		return document.getElementById(sID);
	else 
		return document.all[sID];
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

// function open window for a calendar screen
function OpenCalendar(idname, postBack, x, y)
{
	if(y > 320)
		y = y - 310;
	popUp = window.open('calendar.aspx?formname=' + document.forms[0].name + 
		'&id=' + idname + '&selected=' + GetDateFromActiveDate(idname) + '&postBack=' + postBack, 
		'popupcal', 'width=185,height=280,left=' + x + ',top=' + y + ' scrollbars=no');
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
	}
	else{
		adtDay  = spm_getById(idname + "_day");
		adtMonth = spm_getById(idname + "_month");
		adtYear = spm_getById(idname + "_year");
	};

	if(spm_getById(idname + "_hour") != null)
		adtHour =  spm_getById(idname + "_hour");
	if(spm_getById(idname + "_minute") != null)
		adtMinute = spm_getById(idname + "_minute");
	if(spm_getById(idname + "_meridiem") != null)
		adtMeridiem = spm_getById(idname + "_meridiem");
	
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
		}
		else{
			adtDay  = spm_getById(idname + "_day");
			adtMonth = spm_getById(idname + "_month");
			adtYear = spm_getById(idname + "_year");
		};
		
		if(spm_getById(idname + "_hour") != null)
			adtHour =  spm_getById(idname + "_hour");
		if(spm_getById(idname + "_minute") != null)
			adtMinute = spm_getById(idname + "_minute");
		if(spm_getById(idname + "_meridiem") != null)
			adtMeridiem = spm_getById(idname + "_meridiem");
		
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

function SetDateRange(DateRangeCtrlName, StartDateCtrlName, EndDateCtrlName){
	var ctrlDateRange;
	var l_iDays;
	var l_CurDate = new Date();
	var l_iCalculate;
	
	ctrlDateRange = spm_getById(DateRangeCtrlName);
	
	l_iDays = parseInt(ctrlDateRange.value, 10);
	
	if(l_iDays < 0){
		// minus days
		SetDateToActiveDateEx(EndDateCtrlName, l_CurDate, null);
		l_CurDate = DayAdd(l_CurDate, l_iDays);
		SetDateToActiveDateEx(StartDateCtrlName, l_CurDate, null);
	}
	else{
		// calculate date range
		if(l_iDays == 1){
			l_iCalculate = l_CurDate.getDay();
			l_CurDate = DayAdd(l_CurDate, 1-l_iCalculate);
			SetDateToActiveDateEx(StartDateCtrlName, l_CurDate, null);
			SetDateToActiveDateEx(EndDateCtrlName, DayAdd(l_CurDate, 6), null);
		};
		if(l_iDays == 2){
			l_iCalculate = l_CurDate.getDate() - 1;
			l_CurDate = DayAdd(l_CurDate, -l_iCalculate);
			SetDateToActiveDateEx(StartDateCtrlName, l_CurDate, null);
			l_CurDate = DayAdd(MonthAdd(l_CurDate, 1), -1);
			SetDateToActiveDateEx(EndDateCtrlName, l_CurDate, null);
		};
		if(l_iDays == 3){
			l_CurDate.setMonth(0);
			l_CurDate.setDate(1);
			SetDateToActiveDateEx(StartDateCtrlName, l_CurDate, null);
			SetDateToActiveDateEx(EndDateCtrlName, DayAdd(YearAdd(l_CurDate, 1), -1), null);
		};
		if(l_iDays == 11){
			l_iCalculate = l_CurDate.getDay();
			l_CurDate = DayAdd(l_CurDate, -6-l_iCalculate);
			SetDateToActiveDateEx(StartDateCtrlName, l_CurDate, null);
			SetDateToActiveDateEx(EndDateCtrlName, DayAdd(l_CurDate, 6), null);
		};
		if(l_iDays == 12){
			l_iCalculate = l_CurDate.getDate() - 1;
			l_CurDate = MonthAdd(DayAdd(l_CurDate, -l_iCalculate), -1);
			SetDateToActiveDateEx(StartDateCtrlName, l_CurDate, null);
			l_CurDate = DayAdd(MonthAdd(l_CurDate, 1), -1);
			SetDateToActiveDateEx(EndDateCtrlName, l_CurDate, null);
		};
		if(l_iDays == 13){
			l_CurDate.setMonth(0);
			l_CurDate.setDate(1);
			l_CurDate = YearAdd(l_CurDate, -1);
			SetDateToActiveDateEx(StartDateCtrlName, l_CurDate, null);
			SetDateToActiveDateEx(EndDateCtrlName, DayAdd(YearAdd(l_CurDate, 1), -1), null);
		};
	};
	
	return;
}

function DateAdd(startDate, numDays, numMonths, numYears) {
	var returnDate = new Date(startDate.getTime());
	var yearsToAdd = numYears;

	var month = returnDate.getMonth() + numMonths;
	if (month > 11) {
		yearsToAdd = Math.floor((month+1)/12);
		month -= 12*yearsToAdd;
		yearsToAdd += numYears;
	}
	returnDate.setMonth(month);
	returnDate.setFullYear(returnDate.getFullYear()	+ yearsToAdd);

	returnDate.setTime(returnDate.getTime()+60000*60*24*numDays);

	return returnDate;
}

function YearAdd(startDate, numYears) {
		return DateAdd(startDate,0,0,numYears);
}

function MonthAdd(startDate, numMonths) {
		return DateAdd(startDate,0,numMonths,0);
}

function DayAdd(startDate, numDays) {
		return DateAdd(startDate,numDays,0,0);
}
	function Reorder(eSelect, iCurrentField, numSelects)
	{
        var eForm = eSelect.form;
        var iNewOrder = eSelect.selectedIndex + 1;
        var iPrevOrder;
        var positions = new Array(numSelects);
        var ix;
        for (ix = 0; ix < numSelects; ix++)
        {
                positions[ix] = 0;
        }
        for (ix = 0; ix < numSelects; ix++)
        {
                positions[eSelect.form["FormPosition" + ix].selectedIndex] = 1;
        }
        for (ix = 0; ix < numSelects; ix++)
        {
                if (positions[ix] == 0)
                {
                        iPrevOrder = ix + 1;
                        break;
                }
        }
        if (iNewOrder != iPrevOrder)
        {
                var iInc = iNewOrder > iPrevOrder? -1:1
                var iMin = Math.min(iNewOrder, iPrevOrder);
                var iMax = Math.max(iNewOrder, iPrevOrder);
                for (var iField = 0; iField < numSelects; iField++)
                {
                        if (iField != iCurrentField)
                        {
                                if (eSelect.form["FormPosition" + iField].selectedIndex + 1 >= iMin && eSelect.form["FormPosition" + iField].selectedIndex + 1<= iMax)
                                {
                                        eSelect.form["FormPosition" + iField].selectedIndex += iInc;
                                }
                        }
                }
        }
	}


<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:output method="html" encoding="ISO-8859-1" indent="no"/>
 <xsl:param name="selected" select="''" />
 <xsl:param name="formname" select="''" />
 <xsl:param name="id" select="''" />
 <xsl:param name="postBack" select="''" />
 <xsl:param name="TimeSelected" select="''" />

 <xsl:template match="/">
<table cellSpacing="0" width="100%" align="center" border="0">
	<tr>
		<td bgColor="#000000" colspan="2"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td width="10%" bgColor="#cccccc">12 AM</td>
		<td style="CURSOR:pointer;" bgColor="#fff4bc">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=0&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#12AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=0">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="12AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=0]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=0">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=0]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">01 AM</td>
		<td style="CURSOR:pointer;" bgColor="#fff4bc">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=1&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#1AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=1">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="1AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=1]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=1">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=1]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">02 AM</td>
		<td style="CURSOR:pointer;" bgColor="#fff4bc">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=2&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#2AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=2">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="2AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=2]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=2">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=2]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">03 AM</td>
		<td style="CURSOR:pointer;" bgColor="#fff4bc">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=3&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#3AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=3">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="3AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=3]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=3">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=3]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">04 AM</td>
		<td style="CURSOR:pointer;" bgColor="#fff4bc">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=4&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#4AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=4">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="4AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=4]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=4">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=4]"/>
				 </tr>
				</table>
	           </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">05 AM</td>
		<td style="CURSOR:pointer;" bgColor="#fff4bc">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=5&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#5AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=5">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="5AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=5]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=5">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=5]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">06 AM</td>
		<td style="CURSOR:pointer;" bgColor="#fff4bc">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=6&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#6AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=6">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="6AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=6]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=6">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=6]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">07 AM</td>
		<td style="CURSOR:pointer;" bgColor="#fff4bc">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=7&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#7AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=7">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="7AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=7]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=7">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=7]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">08 AM</td>
		<td style="CURSOR:pointer;" bgColor="#ffffd5">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=8&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#8AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=8">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="8AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=8]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=8">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=8]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">09 AM</td>
		<td style="CURSOR:pointer;" bgColor="#ffffd5">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=9&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#9AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=9">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="9AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=9]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=9">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=9]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">10 AM</td>
		<td style="CURSOR:pointer;" bgColor="#ffffd5">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=10&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#10AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=10">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="10AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=10]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=10">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=10]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">11 AM</td>
		<td style="CURSOR:pointer;" bgColor="#ffffd5">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=11&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#11AM'</xsl:attribute>
			<xsl:if test="$TimeSelected=11">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="11AM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=11]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=11">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=11]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">12 PM</td>
		<td bgColor="#ffffd5" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=12&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#12PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=12">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="12PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=12]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=12">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=12]"/>
				 </tr>
				</table>
               </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">01 PM
		</td>
		<td bgColor="#ffffd5" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=13&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#1PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=13">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="1PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=13]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=13">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=13]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">02 PM</td>
		<td bgColor="#ffffd5" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=14&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#2PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=14">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="2PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=14]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=14">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=14]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">03 PM</td>
		<td bgColor="#ffffd5" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=15&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#3PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=15">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="3PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=15]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=15">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=15]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">04 PM</td>
		<td bgColor="#ffffd5" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=16&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#4PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=16">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="4PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=16]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#ffffd5">
				<xsl:if test="$TimeSelected=16">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=16]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">05 PM</td>
		<td bgColor="#fff4bc" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=17&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#5PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=17">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="5PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=17]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=17">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=17]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">06 PM</td>
		<td bgColor="#fff4bc" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=18&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#6PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=18">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="6PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=18]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=18">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=18]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">07 PM</td>
		<td bgColor="#fff4bc" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=19&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#7PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=19">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="7PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=19]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=19">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=19]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">08 PM</td>
		<td bgColor="#fff4bc" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=20&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#8PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=20">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="8PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=20]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=20">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=20]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">09 PM</td>
		<td bgColor="#fff4bc" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=21&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#9PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=21">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="9PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=21]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=21">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=21]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">10 PM</td>
		<td bgColor="#fff4bc" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=22&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#10PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=22">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="10PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=22]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=22">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=22]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#a9a9a9"></td>
		<td bgColor="#ead098"></td>
	</tr>
	<tr vAlign="middle" align="center" class="pop01">
		<td bgColor="#cccccc">11 PM</td>
		<td bgColor="#fff4bc" style="CURSOR:pointer;">
			<xsl:attribute name="OnClick">javascript:location.href='wo_popupScheduleDate.aspx?time=23&amp;selected=<xsl:value-of select="$selected"/>&amp;id=<xsl:value-of select="$id"/>&amp;formname=<xsl:value-of select="$formname"/>&amp;postBack=<xsl:value-of select="$postBack"/>#11PM'</xsl:attribute>
			<xsl:if test="$TimeSelected=23">
				<xsl:attribute name="bgColor">#ffff77</xsl:attribute>
			</xsl:if>
			<a name="11PM"></a>
			<xsl:choose>
			  <xsl:when test="WorkOrders/Order[Time=23]">
				<table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="#fff4bc">
				<xsl:if test="$TimeSelected=23">
					<xsl:attribute name="bordercolor">#ffff77</xsl:attribute>
				</xsl:if>
 			 	 <tr>
		  		    <xsl:apply-templates select="WorkOrders/Order[Time=23]"/>
				 </tr>
				</table>
	                  </xsl:when>
			</xsl:choose>
		</td>
	</tr>
	<tr>
		<td bgColor="#000000" colspan="2"></td>
	</tr>
</table>
 </xsl:template>

 <xsl:template match="Order">
  <xsl:element name="td">
	<xsl:attribute name="BgColor"><xsl:value-of select="Color"/></xsl:attribute>
	<xsl:value-of select="Equipment"/> - <xsl:value-of select="Operator"/>
  </xsl:element>
 </xsl:template>
</xsl:stylesheet>

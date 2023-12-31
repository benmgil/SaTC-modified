﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">
<title><#828#> - <#2523#></title>
<link rel="stylesheet" type="text/css" href="index_style.css">
<link rel="stylesheet" type="text/css" href="form_style.css">
<link rel="stylesheet" type="text/css" href="tmmenu.css">
<link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<script language="JavaScript" type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script language="JavaScript" type="text/javascript" src="/general.js"></script>
<script language="JavaScript" type="text/javascript" src="/tmmenu.js"></script>
<script language="JavaScript" type="text/javascript" src="/tmhist.js"></script>
<script language="JavaScript" type="text/javascript" src="/popup.js"></script>
<script language="JavaScript" type="text/javascript" src="/js/jquery.js"></script>
<script language="JavaScript" type="text/javascript" src="/js/httpApi.js"></script>
<script type='text/javascript'>
var nvram = httpApi.nvramGet(["wan_ifname", "lan_ifname", "rstats_enable", "http_id"])
var daily_history = [];
<% bandwidth("daily"); %>
function redraw(){
var h;
var grid;
var rows;
var ymd;
var d;
var lastt;
var lastu, lastd;
var getYMD = function(n){
return [(((n >> 16) & 0xFF) + 1900), ((n >>> 8) & 0xFF), (n & 0xFF)];
}
if (daily_history.length > 0) {
ymd = getYMD(daily_history[0][0]);
d = new Date((new Date(ymd[0], ymd[1], ymd[2], 12, 0, 0, 0)).getTime() - ((30 - 1) * 86400000));
E('last-dates').innerHTML = '(' + ymdText(d.getFullYear(), d.getMonth(), d.getDate()) + ' ~ ' + ymdText(ymd[0], ymd[1], ymd[2]) + ')';
lastt = ((d.getFullYear() - 1900) << 16) | (d.getMonth() << 8) | d.getDate();
}
lastd = 0;
lastu = 0;
rows = 0;
block = '';
gn = 0;
grid = '<table width="730px" class="FormTable_NWM">';
grid += "<tr><th style=\"height:30px;\"><#1632#></th>";
grid += "<th><#3102#></th>";
grid += "<th><#3109#></th>";
grid += "<th><#3112#></th></tr>";
for (i = 0; i < daily_history.length; ++i) {
h = daily_history[i];
if (h[0] >= lastt) {
ymd = getYMD(h[0]);
grid += makeRow(((rows & 1) ? 'odd' : 'even'), ymdText(ymd[0], ymd[1], ymd[2]), rescale(h[1]), rescale(h[2]), rescale(h[1] + h[2]));
++rows;
lastd += h[1];
lastu += h[2];
}
}
if(rows == 0)
grid +='<tr><td style="color:#FFCC00;" colspan="4"><#2285#></td></tr>';
E('bwm-daily-grid').innerHTML = grid + '</table>';
E('last-dn').innerHTML = rescale(lastd);
E('last-up').innerHTML = rescale(lastu);
E('last-total').innerHTML = rescale(lastu + lastd);
}
function init(){
var s;
if (nvram.rstats_enable != '1') return;
if ((s = cookie.get('daily')) != null) {
if (s.match(/^([0-2])$/)) {
E('scale').value = scale = RegExp.$1 * 1;
}
}
show_menu();
initDate('ymd');
daily_history.sort(cmpHist);
redraw();
if(bwdpi_support){
document.getElementById('content_title').innerHTML = "<#762#>";
}
}
function switchPage(page){
if(page == "1")
location.href = "/Main_TrafficMonitor_realtime.asp";
else if(page == "2")
location.href = "/Main_TrafficMonitor_last24.asp";
else
return false;
}
</script>
</head>
<body onload="init();" class="bg">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
<form method="post" name="form" action="apply.cgi" target="hidden_frame">
<input type="hidden" name="current_page" value="Main_TrafficMonitor_daily.asp">
<input type="hidden" name="next_page" value="Main_TrafficMonitor_daily.asp">
<input type="hidden" name="group_id" value="">
<input type="hidden" name="modified" value="0">
<input type="hidden" name="action_mode" value="">
<input type="hidden" name="action_wait" value="">
<input type="hidden" name="action_script" value="">
<input type="hidden" name="first_time" value="">
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>">
<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>">
<table class="content" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="23">&nbsp;</td>
<td valign="top" width="202">
<div id="mainMenu"></div>
<div id="subMenu"></div>
</td>
<td valign="top">
<div id="tabMenu" class="submenuBlock"></div>
<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr>
<td align="left" valign="top">
<table width="100%" border="0" cellpadding="4" cellspacing="0" class="FormTitle" id="FormTitle">
<tbody>
<tr>
<td bgcolor="#4D595D" valign="top">
<table width="740px" border="0" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3">
<tr><td><table width=100%" >
<tr>
<td class="formfonttitle" align="left">
<div id="content_title" style="margin-top:5px;"><#367#> - <#762#></div>
</td>
<td>
<div align="right">
<select class="input_option" style="width:120px" onchange="switchPage(this.options[this.selectedIndex].value)">
<!--option><#3059#></option-->
<option value="1"><#2521#></option>
<option value="2"><#2522#></option>
<option value="3" selected><#2523#></option>
</select>
</div>
</td>
</tr>
</table></td></tr>
<tr>
<td height="5"><div class="splitLine"></div></td>
</tr>
<tr>
<td bgcolor="#4D595D">
<table width="730" border="1" align="left" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
<thead>
<tr>
<td colspan="2"><#3080#></td>
</tr>
</thead>
<tbody>
<tr class='even'>
<th width="40%"><#1632#></th>
<td>
<select class="input_option" style="width:130px" onchange='changeDate(this, "ymd")' id='dafm'>
<option value=0>yyyy-mm-dd</option>
<option value=1>mm-dd-yyyy</option>
<option value=2>mm, dd, yyyy</option>
<option value=3>dd.mm.yyyy</option>
</select>
</td>
</tr>
<tr class='even'>
<th width="40%"><#2906#></th>
<td>
<select style="width:70px" class="input_option" onchange='changeScale(this)' id='scale'>
<option value=0>KB</option>
<option value=1>MB</option>
<option value=2 selected>GB</option>
</select>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr >
<td>
<div id='bwm-daily-grid' style='float:left'></div>
</td>
</tr>
<tr >
<td bgcolor="#4D595D">
<table width="730" border="1" align="left" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" >
<thead>
<tr>
<td colspan="2" id="TriggerList" style="text-align:left;"><#2465#> <span style="color:#FFF;background-color:transparent;" id='last-dates'></span></td>
</tr>
</thead>
<tbody>
<tr class='even'><th width="40%"><#3102#></th><td id='last-dn'>-</td></tr>
<tr class='odd'><th width="40%"><#3109#></th><td id='last-up'>-</td></tr>
<tr class='footer'><th width="40%"><#3112#></th><td id='last-total'>-</td></tr>
</tbody>
</table>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</div>
</td>
<td width="10" align="center" valign="top">&nbsp;</td>
</tr>
</table>
<div id="footer"></div>
</body>
</html>


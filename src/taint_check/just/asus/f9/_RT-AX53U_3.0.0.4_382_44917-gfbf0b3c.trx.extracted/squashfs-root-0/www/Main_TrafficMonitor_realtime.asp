﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title><#828#> - <#762#> : <#2521#></title>
<link rel="stylesheet" type="text/css" href="index_style.css">
<link rel="stylesheet" type="text/css" href="form_style.css">
<link rel="stylesheet" type="text/css" href="tmmenu.css">
<link rel="stylesheet" type="text/css" href="menu_style.css"> <link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<script language="JavaScript" type="text/javascript" src="help.js"></script>
<script language="JavaScript" type="text/javascript" src="state.js"></script>
<script language="JavaScript" type="text/javascript" src="general.js"></script>
<script language="JavaScript" type="text/javascript" src="tmmenu.js"></script>
<script language="JavaScript" type="text/javascript" src="tmcal.js"></script>
<script language="JavaScript" type="text/javascript" src="popup.js"></script>
<script language="JavaScript" type="text/javascript" src="/js/jquery.js"></script>
<script language="JavaScript" type="text/javascript" src="/js/httpApi.js"></script>
<script type='text/javascript'>
var nvram = httpApi.nvramGet(["wan_ifname", "lan_ifname", "wl_ifname", "wan_proto", "web_svg", "rstats_enable", "rstats_colors", "bond_wan", "rc_support", "http_id"])
var cprefix = 'bw_r';
var updateInt = 2;
var updateDiv = updateInt;
var updateMaxL = 300;
var updateReTotal = 1;
var prev = [];
var speed_history = [];
var debugTime = 0;
var avgMode = 0;
var wdog = null;
var wdogWarn = null;
var href_lang = get_supportsite_lang();
switch("<% nvram_get("preferred_lang"); %>"){
case "KR":
href_lang = "/";
break;
case "RO":
href_lang = "/";
break;
case "HU":
href_lang = "/";
break;
case "IT":
href_lang = "/";
break;
case "DA":
href_lang = "/";
break;
case "BR":
href_lang = "/";
break;
case "SV":
href_lang = "/";
break;
case "FI":
href_lang = "/";
break;
case "NO":
href_lang = "/";
break;
case "TH":
href_lang = "/";
break;
case "DE":
href_lang = "/";
break;
case "PL":
href_lang = "/";
break;
case "CZ":
href_lang = "/";
break;
default:
break;
}
AUTOLOGOUT_MAX_MINUTE = 0;
var ref = new TomatoRefresh('update.cgi', 'output=netdev', 2);
ref.stop = function() {
this.timer.start(1000);
}
ref.refresh = function(text) {
var c, i, h, n, j, k;
watchdogReset();
++updating;
try {
netdev = null;
eval(text);
n = (new Date()).getTime();
if (this.timeExpect) {
if (debugTime) E('dtime').innerHTML = (this.timeExpect - n) + ' ' + ((this.timeExpect + 2000) - n);
this.timeExpect += 2000;
this.refreshTime = MAX(this.timeExpect - n, 500);
}
else {
this.timeExpect = n + 2000;
}
for (i in netdev) {
c = netdev[i];
if ((p = prev[i]) != null) {
h = speed_history[i];
h.rx.splice(0, 1);
h.rx.push((c.rx < p.rx) ? (c.rx + (0xFFFFFFFF - p.rx)) : (c.rx - p.rx));
h.tx.splice(0, 1);
h.tx.push((c.tx < p.tx) ? (c.tx + (0xFFFFFFFF - p.tx)) : (c.tx - p.tx));
}
else if (!speed_history[i]) {
speed_history[i] = {};
h = speed_history[i];
h.rx = [];
h.tx = [];
for (j = 300; j > 0; --j) {
h.rx.push(0);
h.tx.push(0);
}
h.count = 0;
}
prev[i] = c;
}
loadData();
}
catch (ex) {
}
--updating;
}
function watchdog()
{
watchdogReset();
ref.stop();
wdogWarn.style.display = '';
}
function watchdogReset()
{
if (wdog) clearTimeout(wdog)
wdog = setTimeout(watchdog, 10000);
}
function init()
{
speed_history = [];
initCommon(2, 0, 0, 1);
wdogWarn = E('warnwd');
watchdogReset();
ref.start();
document.getElementById("faq0").href = "https://www.asus.com/support/FAQ/114483/" ;
var ctf_disable = '<% nvram_get("ctf_disable"); %>';
if(ctf_disable == "0"){
document.getElementById("ctfLevelDesc").style.display = "";
}
else{ // ctf_disable == 1 or ctf_disable is not existed
document.getElementById("ctfLevelDesc").style.display = "none";
}
if(bwdpi_support){
document.getElementById('content_title').innerHTML = "<#762#>";
}
document.getElementById('traffic_unit').value = getTrafficUnit();
}
function switchPage(page){
if(page == "1")
return false;
else if(page == "2")
location.href = "/Main_TrafficMonitor_last24.asp";
else
location.href = "/Main_TrafficMonitor_daily.asp";
}
function setUnit(unit){
cookie.set('ASUS_TrafficMonitor_unit', unit);
initCommon(2, 0, 0, 1);
}
</script>
</head>
<body onload="show_menu();init();" class="bg">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
<form method="post" name="form" action="apply.cgi" target="hidden_frame">
<input type="hidden" name="current_page" value="Main_TrafficMonitor_realtime.asp">
<input type="hidden" name="next_page" value="Main_TrafficMonitor_realtime.asp">
<input type="hidden" name="group_id" value="">
<input type="hidden" name="modified" value="0">
<input type="hidden" name="action_mode" value="">
<input type="hidden" name="action_script" value="">
<input type="hidden" name="action_wait" value="">
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
<td bgcolor="#4D595D" valign="top" >
<table width="740px" border="0" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="TMTable">
<tr>
<td>
<table width="100%" >
<tr>
<td class="formfonttitle" align="left">
<div id="content_title" style="margin-top:5px;"><#367#> - <#762#></div>
</td>
<td>
<div align="right">
<select onchange="switchPage(this.options[this.selectedIndex].value)" class="input_option">
<!--option><#3059#></option-->
<option value="1" selected><#2521#></option>
<option value="2"><#2522#></option>
<option value="3"><#2523#></option>
</select>
</div>
</td></tr></table>
</td>
</tr>
<tr>
<td height="5"><div class="splitLine"></div></td>
</tr>
<tr>
<td height="30" align="left" valign="middle" >
<div class="formfontcontent"><p class="formfontcontent"><#3140#></p></div>
</td>
</tr>
<tr>
<td align="left" valign="middle">
<table width="95%" border="1" align="left" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="DescTable" style="font-size:12px; border: 1px solid #000000; border-collapse: collapse;">
<tr><th style="color:#FFFFFF; font-weight:normal; line-height:15px; height: 30px; text-align:left; font-size:12px; padding-left: 10px; border-collapse: collapse;" width="16%"></th><th class="tm_title_bg" style="color:#FFFFFF; font-weight:normal; line-height:15px; height: 30px; text-align:left; font-size:12px;padding-left: 10px;border-collapse: collapse;" width="26%"><#2205#></th><th class="tm_title_bg" style="color:#FFFFFF; font-weight:normal; line-height:15px; height: 30px; text-align:left; font-size:12px; padding-left: 10px;border-collapse: collapse;" width="29%"><#3110#></th><th class="tm_title_bg" style="color:#FFFFFF; font-weight:normal; line-height:15px; height: 30px; text-align:left; font-size:12px; padding-left: 10px; border-collapse: collapse;" width="29%"><#3111#></th></tr>
<tr><th class="tm_title_bg" style="color:#FFFFFF; font-weight:normal; line-height:15px; height: 30px; text-align:left; font-size:12px; padding-left: 10px; border-collapse: collapse;"><#3102#></th><td style="color:#FF9000;padding-left: 10px; border-collapse: collapse;"><#3103#></td><td style="color:#3CF;padding-left: 10px;border-collapse: collapse;"><#3104#></td><td style="color:#3CF;padding-left: 10px;border-collapse: collapse;"><#3105#></td></tr>
<tr><th class="tm_title_bg" style="color:#FFFFFF; font-weight:normal; line-height:15px; height: 30px; text-align:left; font-size:12px; padding-left: 10px;border-collapse: collapse;"><#3109#></th><td style="color:#3CF;padding-left: 10px;border-collapse: collapse;"><#3106#></td><td style="color:#FF9000;padding-left: 10px;;border-collapse: collapse;"><#3107#></td><td style="color:#FF9000;padding-left: 10px;border-collapse: collapse;"><#3108#></td></tr>
</table>
</td>
</tr>
<tr>
<td>
<div style="display:flex;align-items: center;margin: 4px 0;">
<div><#2906#></div>
<div style="margin-left: 24px;">
<select class="input_option" id="traffic_unit" onchange="setUnit(this.value);">
<option value="0">KB</option>
<option value="1">MB</option>
<option value="2">GB</option>
<option value="3">TB</option>
</select>
</div>
</div>
</td>
</tr>
<tr>
<td height="30" align="left" valign="middle" >
<div class="formfontcontent"><p class="formfontcontent"><#3141#></p></div>
<div id="ctfLevelDesc" style="display:none" class="formfontcontent">
<p class="formfontcontent">
<b><#905#></b> <#3142#>
<#1591#>
</p>
</div>
<div class="formfontcontent"><p class="formfontcontent"><a id="faq0" href="" target="_blank" style="font-weight: bolder;text-decoration:underline;"><#762#> FAQ</a></p></div>
</td>
</tr>
<tr>
<td>
<span id="tab-area"></span>
<span id="iftitle" style="font-weight: bold; color: #A0B06B; position: absolute; top: 375px; left: 45%; min-width: 180px;"></span>
<!--[if IE]>
<div id="svg-table" align="left" class="IE8HACK">
<object id="graph" src="tm.svg" classid="image/svg+xml" width="730" height="350">
</div>
<![endif]-->
<!--[if !IE]>-->
<object id="graph" data="tm.svg" type="image/svg+xml" width="730" height="350">
<!--<![endif]-->
</object>
</td>
</tr>
<tr>
<td>
<table width="730px" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable_NWM" style="margin-top:0px;margin-left:-1px;*margin-left:-10px;margin-left:-12px \9;">
<tr>
<th style="text-align:center; width:160px;"><#1627#></th>
<th style="text-align:center; width:160px;"><#1388#></th>
<th style="text-align:center; width:160px;"><#2515#></th>
<th style="text-align:center; width:160px;"><#3112#></th>
</tr>
<tr>
<td style="text-align:center;font-weight: bold; background-color:#111;"><div id="rx-current"></div></td>
<td style="text-align:center; background-color:#111;" id='rx-avg'></td>
<td style="text-align:center; background-color:#111;" id='rx-max'></td>
<td style="text-align:center; background-color:#111;" id='rx-total'></td>
</tr>
<tr>
<td style="text-align:center;font-weight: bold; background-color:#111;"><div id="tx-current"></div></td>
<td style="text-align:center; background-color:#111;" id='tx-avg'></td>
<td style="text-align:center; background-color:#111;" id='tx-max'></td>
<td style="text-align:center; background-color:#111;" id='tx-total'></td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr style="display:none">
<td bgcolor="#FFFFFF">
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
<thead>
<tr>
<td colspan="5" id="TriggerList">Display Options</td>
</tr>
</thead>
<div id='bwm-controls'>
<tr>
<th width='50%'></th>
<td>
<a href='javascript:switchAvg(1)' id='avg1'>Off</a>,
<a href='javascript:switchAvg(2)' id='avg2'>2x</a>,
<a href='javascript:switchAvg(4)' id='avg4'>4x</a>,
<a href='javascript:switchAvg(6)' id='avg6'>6x</a>,
<a href='javascript:switchAvg(8)' id='avg8'>8x</a>
</td>
</tr>
<tr>
<th></th>
<td>
<a href='javascript:switchScale(0)' id='scale0'>Uniform</a>,
<a href='javascript:switchScale(1)' id='scale1'>Per IF</a>
</td>
</tr>
<tr>
<th></th>
<td>
<a href='javascript:switchDraw(0)' id='draw0'>Solid</a>,
<a href='javascript:switchDraw(1)' id='draw1'>Line</a>
</td>
</tr>
<tr>
<th></th>
<td>
<a href='javascript:switchColor()' id='drawcolor'>-</a><a href='javascript:switchColor(1)' id='drawrev'></a>
</td>
</tr>
</div>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<div id="footer"></div>
</body>
</html>


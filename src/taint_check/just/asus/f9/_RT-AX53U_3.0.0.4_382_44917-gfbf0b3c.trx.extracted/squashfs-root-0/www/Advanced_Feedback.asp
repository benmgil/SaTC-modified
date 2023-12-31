﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns:v>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">
<link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<title><#828#> - <#2519#></title>
<link rel="stylesheet" type="text/css" href="index_style.css">
<link rel="stylesheet" type="text/css" href="form_style.css">
<script language="JavaScript" type="text/javascript" src="/state.js"></script>
<script language="JavaScript" type="text/javascript" src="/general.js"></script>
<script language="JavaScript" type="text/javascript" src="/popup.js"></script>
<script language="JavaScript" type="text/javascript" src="/help.js"></script>
<script language="JavaScript" type="text/javascript" src="/validator.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/oauth.js"></script>
<script type="text/javascript" src="js/httpApi.js"></script>
<style>
.noUSBHint, .storeUSBHint {
color: #FC0;
margin-left: 10px;
display: none;
}
.dblog_service_item {
margin-right: 5px;
}
.dblog_enabled_status {
display: none;
}
.dblog_stop_text {
cursor: pointer;
text-decoration: underline;
}
</style>
<script>
var usb_status_last_time = false;
var orig_page = '<% get_parameter("origPage"); %>';
var fb_trans_id = '<% generate_trans_id(); %>';
var default_provider = '<% get_parameter("provider"); %>';
var reload_data = parseInt('<% get_parameter("reload"); %>');
var dblog_trans_id = '<% generate_trans_id(); %>';
var fb_total_size;
var is_CN_sku = in_territory_code("CN");
var reboot_schedule_enable_orig = httpApi.nvramGet(["reboot_schedule_enable"], true).reboot_schedule_enable;
var wl0_radio_orig = httpApi.nvramGet(["wl0_radio"], true).wl0_radio;
var wl1_radio_orig = httpApi.nvramGet(["wl1_radio"], true).wl1_radio;
var wl2_radio_orig = httpApi.nvramGet(["wl2_radio"], true).wl2_radio;
var wl0_timesched_orig = httpApi.nvramGet(["wl0_timesched"], true).wl0_timesched;
var wl1_timesched_orig = httpApi.nvramGet(["wl1_timesched"], true).wl1_timesched;
var wl2_timesched_orig = httpApi.nvramGet(["wl2_timesched"], true).wl2_timesched;
function initial(){
show_menu();
if(dsl_support){
change_dsl_diag_enable(0);
document.getElementById("fb_desc1").style.display = "";
}
else{
document.getElementById("fb_desc0").style.display = "";
inputCtrl(document.form.fb_ISP, 0);
inputCtrl(document.form.fb_Subscribed_Info, 0);
document.form.attach_syslog_id.checked = true;
document.form.attach_cfgfile_id.checked = true;
document.form.attach_iptables.checked = false;
document.form.attach_modemlog.checked = true;
document.form.attach_wlanlog_id.checked = true;
document.getElementById("attach_iptables_span").style.display = "none";
inputCtrl(document.form.dslx_diag_enable[0], 0);
inputCtrl(document.form.dslx_diag_enable[1], 0);
inputCtrl(document.form.dslx_diag_duration, 0);
inputCtrl(document.form.fb_availability, 0);
}
gen_ptype_list(orig_page);
Reload_pdesc(document.form.fb_ptype,orig_page);
if(is_CN_sku && support_site_modelid == "RT-AX89X"){
inputCtrl(document.form.fb_phone, 1);
}
else{
inputCtrl(document.form.fb_phone, 0);
}
if(!modem_support || nomodem_support){
document.form.attach_modemlog.checked = false;
document.getElementById("attach_modem_span").style.display = "none";
}
if(dblog_support)
init_diag_feature();
else {
$(".dblog_support_class").remove();
}
if(false){
$("#fb_email_provider_field").show();
var fb_email_provider = '<% nvram_get("fb_email_provider"); %>';
if(fb_email_provider=="" && default_provider!=""){
document.form.fb_email_provider.value = default_provider;
}
else{
document.form.fb_email_provider.value = fb_email_provider;
}
change_fb_email_provider();
$("#oauth_google_btn").click(
function() {
oauth.google(onGoogleLogin);
}
);
if(document.form.fb_email_provider.value == "google") {
$(".oauth_google_status").hide();
if(httpApi.nvramGet(["oauth_google_refresh_token"], true).oauth_google_refresh_token != "") {
$("#oauth_google_loading").show();
document.form.fb_email.value = "";
check_refresh_token_valid(
function(_callBackValue) {
$("#oauth_google_loading").hide();
show_google_auth_status(_callBackValue);
}
);
}
else
show_google_auth_status();
}
}
if(reload_data==1){
document.form.fb_country.value = decodeURIComponent('<% nvram_char_to_ascii("", "fb_country"); %>');
document.form.fb_ptype.value = decodeURIComponent('<% nvram_char_to_ascii("", "fb_ptype"); %>');
Reload_pdesc(document.form.fb_ptype);
document.form.fb_pdesc.value = decodeURIComponent('<% nvram_char_to_ascii("", "fb_pdesc"); %>');
document.form.fb_comment.value = decodeURIComponent('<% nvram_char_to_ascii("", "fb_comment"); %>');
}
httpApi.nvramGetAsync({
data: ["preferred_lang"],
success: function(resp){
var preferredLang = resp.preferred_lang;
lang_str = (preferredLang == "EN" || preferredLang == "SL") ? "" : (preferredLang.toLowerCase() + '/');
if(preferredLang == "CN")
url = "https://www.asus.com.cn/Terms_of_Use_Notice_Privacy_Policy/Privacy_Policy";
else{
if(preferredLang == "SV")
lang_str = "se/";
else if(preferredLang == "UK")
lang_str = "ua-ua/";
else if(preferredLang == "MS")
lang_str = "my/";
else if(preferredLang == "DA")
lang_str = "dk/";
url = "https://www.asus.com/" + lang_str +"Terms_of_Use_Notice_Privacy_Policy/Privacy_Policy";
}
$("#eula_content").find($("a")).attr({
"href": url
})
}
})
}
function check_wan_state(){
if(sw_mode != 3 && document.getElementById("connect_status").className == "connectstatusoff"){
document.getElementById("fb_desc_disconnect").style.display = "";
document.form.fb_country.disabled = true;
document.form.fb_email.disabled = true;
document.form.fb_serviceno.disabled = true;
document.form.attach_syslog.disabled = true;
document.form.attach_cfgfile.disabled = true;
document.form.attach_modemlog.disabled = true;
document.form.attach_wlanlog.disabled = true;
document.form.fb_ptype.disabled = true;
document.form.fb_pdesc.disabled = true;
document.form.fb_comment.disabled = true;
document.form.btn_send.disabled = true;
if(dsl_support){
document.form.fb_ISP.disabled = true;
document.form.fb_Subscribed_Info.disabled = true;
document.form.attach_iptables.disabled = true;
document.form.dslx_diag_enable[0].disabled = true;
document.form.dslx_diag_enable[1].disabled = true;
document.form.dslx_diag_duration.disabled = true;
document.form.fb_availability.disabled = true;
}
}
else{
document.getElementById("fb_desc_disconnect").style.display = "none";
document.form.fb_country.disabled = "";
document.form.fb_email.disabled = "";
document.form.fb_serviceno.disabled = "";
document.form.attach_syslog.disabled = "";
document.form.attach_modemlog.disabled = "";
document.form.attach_wlanlog.disabled = "";
document.form.attach_cfgfile.disabled = "";
document.form.fb_ptype.disabled = "";
document.form.fb_pdesc.disabled = "";
document.form.fb_comment.disabled = "";
document.form.btn_send.disabled = "";
if(dsl_support){
document.form.fb_ISP.disabled = "";
document.form.fb_Subscribed_Info.disabled = "";
document.form.attach_iptables.disabled = "";
document.form.dslx_diag_enable[0].disabled = "";
document.form.dslx_diag_enable[1].disabled = "";
document.form.dslx_diag_duration.disabled = "";
document.form.fb_availability.disabled = "";
}
}
setTimeout("check_wan_state();", 3000);
}
function gen_ptype_list(url){
ptypelist = new Array();
ptypelist.push(["<#713#> ...", "No_selected"]);
ptypelist.push(["<#1923#>", "Setting_Problem"]);
ptypelist.push(["<#1875#>", "Connection_or_Speed_Problem"]);
ptypelist.push(["<#1867#>", "Compatibility_Problem"]);
ptypelist.push(["<#1927#>", "Suggestion"]);
ptypelist.push(["<#1938#>", "Technical_Support"]);
ptypelist.push(["<#882#>", "Other_Problem"]);
free_options(document.form.fb_ptype);
document.form.fb_ptype.options.length = ptypelist.length;
for(var i = 0; i < ptypelist.length; i++){
document.form.fb_ptype.options[i] = new Option(ptypelist[i][0], ptypelist[i][1]);
}
if(url) //with url : Setting Problem
document.form.fb_ptype.options[1].selected = "1";
}
function Reload_pdesc(obj, url){
free_options(document.form.fb_pdesc);
var ptype = obj.value;
desclist = new Array();
url_group = new Array();
timelist = new Array();
desclist.push(["<#713#> ...","No_selected"]);
url_group.push(["select"]);//false value
if(ptype == "Setting_Problem"){
desclist.push(["<#479#>","QIS"]);
url_group.push(["QIS"]);
desclist.push(["<#369#>","Network Map"]);
url_group.push(["index"]);
desclist.push(["<#281#>","Guest Network"]);
url_group.push(["Guest_network"]);
desclist.push(["<#1250#>","AiProtection"]);
url_group.push(["AiProtection"]);
desclist.push(["<#883#>","Adaptive QoS"]); //5
url_group.push(["AdaptiveQoS"]);
desclist.push(["<#1853#>","Traditional QoS"]);
url_group.push(["AiProtection"]);
desclist.push(["<#876#>","Gaming"]);
url_group.push(["GameBoost"]);
desclist.push(["<#3128#>/<#367#>","Traffic Analyzer/Manager"]);
url_group.push(["TrafficMonitor"]);
desclist.push(["<#457#>","Parental Ctrl"]);
url_group.push(["ParentalControl"]);
desclist.push(["<#368#>","USB Application"]); //10
url_group.push(["APP_", "AiDisk", "aidisk", "mediaserver", "PrinterServer", "TimeMachine"]);
desclist.push(["AiCloud","AiCloud"]);
url_group.push(["cloud"]);
desclist.push(["AiMesh","AiMesh"]);
url_group.push(["AiMesh"]);
desclist.push(["<#371#>","Wireless"]);
url_group.push(["ACL", "WAdvanced", "Wireless", "WMode", "WSecurity", "WWPS"]);
desclist.push(["<#382#>","WAN"]);
url_group.push(["WAN_", "PortTrigger", "VirtualServer", "Exposed", "NATPassThrough"]);
desclist.push(["<#220#>","Dual WAN"]); //15
url_group.push(["WANPort"]);
desclist.push(["<#378#>","LAN"]);
url_group.push(["LAN", "DHCP", "GWStaticRoute", "IPTV", "SwitchCtrl"]);
desclist.push(["<#392#>","USB dongle"]);
url_group.push(["Modem"]);
desclist.push(["<#1729#>","DM"]);
url_group.push(["DownloadMaster"]);//false value
desclist.push(["<#387#>","DDNS"]);
url_group.push(["DDNS"]);
desclist.push(["IPv6","IPv6"]); //20
url_group.push(["IPv6"]);
desclist.push(["VPN","VPN"]);
url_group.push(["VPN"]);
desclist.push(["<#393#>","Firewall"]);
url_group.push(["Firewall", "KeywordFilter", "URLFilter"]);
desclist.push(["<#399#>","Administration"]);
url_group.push(["OperationMode", "System", "SettingBackup"]);
desclist.push(["<#735#>","System Log"]);
url_group.push(["System"]);
desclist.push(["<#2649#>","Network Tools"]); //25
url_group.push(["Status_"]);
desclist.push(["<#2841#>","Rescue"]);
url_group.push(["Rescue"]);//false value
desclist.push(["<#1871#>","Other Devices"]);
url_group.push(["Other_Device"]);//false value
desclist.push(["<#3515#>","Fail to access"]);
url_group.push(["GUI"]);//false value
desclist.push(["<#403#>","FW update"]);
url_group.push(["FirmwareUpgrade"]);
if(isSupport("Instant_Guard")){
desclist.push(["<#3975#>","Instant Guard"]); //30 //Untranslated
url_group.push(["Instant_Guard"]);
}
}
else if(ptype == "Connection_or_Speed_Problem"){
desclist.push(["<#1876#>","Wireless speed"]);
desclist.push(["<#1877#>","Wired speed"]);
desclist.push(["<#1879#>","Unstable connection"]);
desclist.push(["<#1878#>","Router reboot"]);
desclist.push(["<#1880#>","Wireless disconnected"]);
}
else if(ptype == "Compatibility_Problem"){
desclist.push(["<#1870#>","modem"]);
desclist.push(["<#1872#>","other router"]);
desclist.push(["<#1868#>","OS or Application"]);
desclist.push(["<#1873#>","printer"]);
desclist.push(["<#1874#>","USB modem"]);
desclist.push(["<#1869#>","external hardware disk"]);
desclist.push(["<#1871#>","network devices"]);
}
else if(ptype == "Suggestion"){
desclist.splice(0,1);
desclist.push(["<#1930#>","Translation"]);
desclist.push(["<#1931#>","UI/UX"]);
desclist.push(["<#1928#>","Current Feature"]);
desclist.push(["<#1929#>","New Feature Request"]);
}
else if(ptype == "Technical_Support"){
desclist.splice(0,1);
desclist.push(["<#1936#>","tech_ASUS"]);
desclist.push(["<#1934#>","tech_Amazon"]);
desclist.push(["<#1937#>","tech_iOS"]);
desclist.push(["<#1935#>","tech_Android"]);
}
else{ //Other_Problem
desclist.splice(0,1);
desclist.push(["<#882#>","others"]);
}
if(ptype == "Setting_Problem" && url){
for(var i = 0; i < url_group.length; i++){
document.form.fb_pdesc.options[i] = new Option(desclist[i][0], desclist[i][1]);
for(var j = 0; j < url_group[i].length; j++){
if(url.search(url_group[i][j]) >= 0){
document.form.fb_pdesc.options[i].selected = "1";
}
}
}
}
else{
for(var i = 0; i < desclist.length; i++){
document.form.fb_pdesc.options[i] = new Option(desclist[i][0], desclist[i][1]);
}
}
Change_pdesc(document.form.fb_pdesc);
free_options(document.form.fb_when_occur);
$(".when_occur_tr").css("display", "none");
if(ptype == "Setting_Problem" || ptype == "Compatibility_Problem"){
$(".when_occur_tr").css("display", "");
timelist.push(["<#713#> ...","No_selected"]);
timelist.push(["Just Now","Just Now"]);
timelist.push(["Within 1 hour","Within 1 hour"]);
timelist.push(["1 - 3 hour(s) ago","1 - 3 hour(s) ago"]);
timelist.push(["3 - 12 hours ago","3 - 12 hours ago"]);
timelist.push(["Today","Today"]);
timelist.push(["Recently","Recently"]);
timelist.push(["I don’t recall","I don’t recall"]);
for(var i = 0; i < timelist.length; i++){
document.form.fb_when_occur.options[i] = new Option(timelist[i][0], timelist[i][1]);
}
}
}
function Change_pdesc(obj){
timelist = new Array();
bandlist = new Array();
unstablelist = new Array();
if(document.form.fb_ptype.value != "Setting_Problem" && document.form.fb_ptype.value != "Compatibility_Problem"){
free_options(document.form.fb_when_occur);
$(".when_occur_tr").css("display", "none");
if(obj.value == "Wireless speed" || obj.value == "Wired speed" || obj.value == "Unstable connection" || obj.value == "Router reboot" || obj.value == "Wireless disconnected"){
$(".when_occur_tr").css("display", "");
timelist.push(["<#713#> ...","No_selected"]);
timelist.push(["Just Now","Just Now"]);
timelist.push(["Within 1 hour","Within 1 hour"]);
timelist.push(["1 - 3 hour(s) ago","1 - 3 hour(s) ago"]);
timelist.push(["3 - 12 hours ago","3 - 12 hours ago"]);
timelist.push(["Today","Today"]);
timelist.push(["Recently","Recently"]);
timelist.push(["I don’t recall","I don’t recall."]);
for(var i = 0; i < timelist.length; i++){
document.form.fb_when_occur.options[i] = new Option(timelist[i][0], timelist[i][1]);
}
}
}
free_options(document.form.fb_which_band);
$(".which_band_tr").css("display", "none");
if(obj.value == "Wireless speed" || obj.value == "Wireless disconnected"){
$(".which_band_tr").css("display", "");
bandlist.push(["<#713#> ...","No_selected"]);
bandlist.push(["2.4GHz","2.4GHz"]);
bandlist.push(["5GHz","5GHz"]);
bandlist.push(["5GHz-1","5GHz-1"]);
bandlist.push(["5GHz-2","5GHz-2"]);
bandlist.push(["6GHz","6GHz"]);
bandlist.push(["All","All"]);
bandlist.push(["I am not sure","I am not sure"]);
bandlist.push(["Issue with the main router","Issue with the main router"]);
bandlist.push(["Issue with node(s)","Issue with node(s)"]);
for(var i = 0; i < bandlist.length; i++){
document.form.fb_which_band.options[i] = new Option(bandlist[i][0], bandlist[i][1]);
}
}
free_options(document.form.fb_unstable_conn);
$(".unstable_conn_tr").css("display", "none");
if(obj.value == "Unstable connection"){
$(".unstable_conn_tr").css("display", "");
unstablelist.push(["<#713#> ...","No_selected"]);
unstablelist.push(["All WiFi","All WiFi"]);
unstablelist.push(["2.4GHz","2.4GHz"]);
unstablelist.push(["5GHz","5GHz"]);
unstablelist.push(["5GHz-1","5GHz-1"]);
unstablelist.push(["5GHz-2","5GHz-2"]);
unstablelist.push(["6GHz","6GHz"]);
unstablelist.push(["WAN","WAN"]);
unstablelist.push(["Both WiFi and WAN","Both WiFi and WAN"]);
unstablelist.push(["I am not sure","I am not sure"]);
unstablelist.push(["Issue with the main router","Issue with the main router"]);
unstablelist.push(["Issue with node(s)","Issue with node(s)"]);
for(var j = 0; j < unstablelist.length; j++){
document.form.fb_unstable_conn.options[j] = new Option(unstablelist[j][0], unstablelist[j][1]);
}
}
if(obj.value == "Router reboot" && reboot_schedule_enable_orig == 1){
$("#occur_hint").show()
.css("text-decoration", "underline")
.css("cursor", "pointer")
.html("<br>- Reboot Scheduler currently enabled, please check scheduler setting")
.click( function(){ redirect_page("reboot_schedule_enable_x"); } );
$("#occur_hint2").hide();
}
else if(obj.value == "Wireless disconnected"){
if(wl0_timesched_orig == 1 || wl1_timesched_orig == 1 || wl2_timesched_orig == 1){
$("#occur_hint").show()
.css("text-decoration", "underline")
.css("cursor", "pointer")
.html("<br>- Wireless Scheduler currently enabled, please check scheduler setting")
.click( function(){ redirect_page("wl_timesched"); } );
}
if(wl0_radio_orig == 0 || wl1_radio_orig == 0 || wl2_radio_orig == 0){
$("#occur_hint2").show()
.css("text-decoration", "underline")
.css("cursor", "pointer")
.html("<br>- 2.4GHz or 5GHz or 5GHz-1 or 5GHz-2(or 2.4GHz and 5GHz-2 and so on) or All bands currently disabled, please check WiFi radio setting.")
.click( function(){ redirect_page("wl_radio"); } );
}
}
else{
$("#occur_hint").hide();
$("#occur_hint2").hide();
}
if(obj.value == "tech_ASUS"){
inputCtrl(document.form.fb_serviceno, 1);
inputCtrl(document.form.fb_tech_account, 0);
}
else if(obj.value == "tech_Amazon" || obj.value == "tech_iOS" || obj.value == "tech_Android"){
inputCtrl(document.form.fb_serviceno, 0);
inputCtrl(document.form.fb_tech_account, 1);
}
else{
inputCtrl(document.form.fb_serviceno, 0);
inputCtrl(document.form.fb_tech_account, 0);
}
}
function updateUSBStatus(){
if(allUsbStatus.search("storage") == "-1"){
document.getElementById("storage_ready").style.display = "none";
document.getElementById("be_lack_storage").style.display = "";
}
else{
document.getElementById("storage_ready").style.display = "";
document.getElementById("be_lack_storage").style.display = "none";
}
}
function redirect_page(flag){
switch(flag) {
case "reboot_schedule_enable_x" :
document.location.href = "Advanced_System_Content.asp?af=reboot_schedule_enable_x";
break;
case "wl_radio" :
document.location.href = "Advanced_WAdvanced_Content.asp?af=wl_radio";
break;
case "wl_timesched" :
document.location.href = "Advanced_WAdvanced_Content.asp?af=wl_timesched";
break;
}
}
function redirect(){
document.location.href = "Feedback_Info.asp";
}
function applyRule(){
if(!document.form.eula_checkbox.checked){
alert('<#1941#>');
return false;
}
/*if(document.form.feedbackresponse.value == "3"){
alert("Feedback report daily maximum(10) send limit reached.");
return false;
}*/
if(document.form.attach_syslog.checked == true)
document.form.fb_attach_syslog.value = 1;
else
document.form.fb_attach_syslog.value = 0;
if(document.form.attach_cfgfile.checked == true)
document.form.fb_attach_cfgfile.value = 1;
else
document.form.fb_attach_cfgfile.value = 0;
if(document.form.attach_modemlog.checked == true)
document.form.fb_attach_modemlog.value = 1;
else
document.form.fb_attach_modemlog.value = 0;
if(document.form.attach_wlanlog.checked == true)
document.form.fb_attach_wlanlog.value = 1;
else
document.form.fb_attach_wlanlog.value = 0;
if(dsl_support){
if(document.form.attach_iptables.checked == true)
document.form.fb_attach_iptables.value = 1;
else
document.form.fb_attach_iptables.value = 0;
document.form.fb_availability.value = (document.form.fb_availability.value=="No_selected")?"":document.form.fb_availability.value;
}
if(document.form.fb_email.value == ""){
if(!confirm("<#1900#>")){
document.form.fb_email.focus();
return false;
}
}
else{ //validate email
if(!isEmail(document.form.fb_email.value)){
alert("<#1899#>");
document.form.fb_email.focus();
return false;
}
}
if(document.form.fb_phone.value.length > 0 && (document.form.fb_phone.value.length < 9 || !validator.integer(document.form.fb_phone.value)) ){
alert("<#1919#>");
document.form.fb_phone.focus();
return false;
}
if(document.form.fb_pdesc.value == "tech_ASUS"){
var re_asus = new RegExp("^[a-zA-Z][0-9]{8,11}","gi");
var re_crs = new RegExp("^[0-9]{5}","gi");
var re_valid = 0;
document.form.fb_tech_account.disabled = "";
document.form.fb_tech_account.value = "";
if(document.form.fb_serviceno.value == "" || document.form.fb_serviceno.value.length == 0){
alert("<#313#>");
document.form.fb_serviceno.focus();
return false;
}
if(document.form.fb_serviceno.value != ""){
if(!re_asus.test(document.form.fb_serviceno.value)){
re_valid++;
}
if(document.form.fb_serviceno.value.length != 5 || !re_crs.test(document.form.fb_serviceno.value)){
re_valid++;
}
if(re_valid == 2){
alert("<#325#>");
document.form.fb_serviceno.focus();
return false;
}
}
}
else if(document.form.fb_pdesc.value == "tech_Amazon" || document.form.fb_pdesc.value == "tech_iOS" || document.form.fb_pdesc.value == "tech_Android"){
document.form.fb_serviceno.disabled = "";
document.form.fb_serviceno.value = "";
if(document.form.fb_tech_account.value == "" || document.form.fb_tech_account.value.length == 0){
alert("<#313#>");
document.form.fb_tech_account.focus();
return false;
}
}
else{
document.form.fb_serviceno.disabled = "";
document.form.fb_serviceno.value = "";
document.form.fb_tech_account.disabled = "";
document.form.fb_tech_account.value = "";
}
if(fb_trans_id != "")
{
document.form.fb_transid.value = fb_trans_id;
}
document.form.fb_ptype.value = (document.form.fb_ptype.value=="No_selected")?"":document.form.fb_ptype.value;
document.form.fb_pdesc.value = (document.form.fb_pdesc.value=="No_selected")?"":document.form.fb_pdesc.value;
document.form.fb_which_band.value = (document.form.fb_which_band.value=="No_selected")?"":document.form.fb_which_band.value;
document.form.fb_when_occur.value = (document.form.fb_when_occur.value=="No_selected")?"":document.form.fb_when_occur.value;
document.form.fb_unstable_conn.value = (document.form.fb_unstable_conn.value=="No_selected")?"":document.form.fb_unstable_conn.value;
if(dblog_support) {
document.form.dblog_tousb.disabled = true;
document.form.dblog_service.disabled = true;
document.form.dblog_duration.disabled = true;
document.form.dblog_transid.disabled = true;
var dblog_enable_status = httpApi.nvramGet(["dblog_enable"], true).dblog_enable;
var dblog_enable = getRadioValue($('form[name="form"]').children().find('input[name=dblog_enable]'));
if(dblog_enable_status == "0" && dblog_enable == "1") {
var service_list_checked = $("input:checkbox[name=dblog_service_list]:checked").map(function() {
return $(this).val();
}).get();
var dblog_service = 0;
if(service_list_checked.length == 0) {
alert("<#1894#>");
return false;
}
for(var idx in service_list_checked){
if(service_list_checked.hasOwnProperty(idx)) {
dblog_service += parseInt(service_list_checked[idx]);
}
}
document.form.dblog_tousb.disabled = false;
document.form.dblog_tousb.value = "0";
if(usb_support) {
if(allUsbStatus.search("storage") != "-1") {
if($("input[name=dblog_tousb_cb]").prop("checked")) {
document.form.dblog_tousb.value = "1";
}
}
}
document.form.dblog_service.disabled = false;
document.form.dblog_service.value = dblog_service;
document.form.dblog_duration.disabled = false;
document.form.dblog_transid.disabled = false;
if(dblog_trans_id != "")
document.form.dblog_transid.value = dblog_trans_id;
}
}
if(document.form.fb_attach_wlanlog.value == "1")
httpApi.update_wlanlog();
document.form.fb_browserInfo.value = navigator.userAgent;
startLogPrep();
document.form.submit();
}
function isEmail(strE) {
if (strE.search(/^[A-Za-z0-9]+((-[A-Za-z0-9]+)|(\.[A-Za-z0-9]+)|(_[A-Za-z0-9]+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/) != -1)
return true;
else
return false;
}
function textCounter(field, cnt, upper) {
if (field.value.length > upper)
field.value = field.value.substring(0, upper);
else
cnt.value = upper - field.value.length;
}
function change_dsl_diag_enable(value) {
if(value) {
if(allUsbStatus.search("storage") == "-1"){
alert("USB disk required in order to store the debug log, please plug-in a USB disk to <#829#> and Enable DSL Line Diagnostic again.");/*untranslated*/
document.form.dslx_diag_enable[1].checked = true;
return;
}
else{
alert("<#1888#> <#1886#>");
}
showhide("dslx_diag_duration",1);
}
else {
showhide("dslx_diag_duration",0);
}
}
function init_diag_feature() {
var dblog_enable = '<% nvram_get("dblog_enable"); %>';
var dblog_remaining = parseInt('<% nvram_get("dblog_remaining"); %>');
setRadioValue($('form[name="form"]').children().find('input[name=dblog_enable]'), dblog_enable);
if(dblog_enable == "1" && dblog_remaining > 0) {
$(".dblog_disabled_status").find("input, textarea, button, select").attr("disabled", true);
$(".dblog_disabled_status").css("display", "none");
$(".dblog_enabled_status").css("display", "inline");
var transformTime = function(_sec) {
var days = Math.floor(dblog_remaining / 60 / 60 / 24);
var hours = Math.floor(dblog_remaining / 60 / 60 % 24);
var minutes = Math.floor(dblog_remaining / 60 % 60);
var seconds = Math.floor(dblog_remaining % 60);
var remaining_time_str = "<#2614#> : ";
if(dblog_remaining == 0) {
remaining_time_str += "0" + " " + "(Prepare data...)"; //Untranslated
return remaining_time_str;
}
if(days)
remaining_time_str += days + " <#1640#> ";
if(hours)
remaining_time_str += hours + " <#2159#> ";
if(minutes)
remaining_time_str += minutes + " <#2530#> ";
if(seconds)
remaining_time_str += seconds + " <#2907#> ";
return remaining_time_str;
};
$(".dblog_remaining_text").html(transformTime(dblog_remaining));
var transformTimeInterval = setInterval(function(){
if(dblog_remaining == 0 || isNaN(dblog_remaining))
clearInterval(transformTimeInterval);
else {
dblog_remaining--;
$(".dblog_remaining_text").html(transformTime(dblog_remaining));
}
}, 1000);
var dblog_service = parseInt('<% nvram_get("dblog_service"); %>');
var dblog_service_mapping = ["", "WiFi", "<#1729#>", "<#766#>", "AiMesh"];
var dblog_service_text = "";
for(var i = 1; dblog_service != 0 && i <= 4; i++) {
if(dblog_service & 1) {
if(dblog_service_text != "")
dblog_service_text += ", " + dblog_service_mapping[i];
else
dblog_service_text += dblog_service_mapping[i];
}
dblog_service = dblog_service >> 1;
}
$(".dblog_service_text").html(dblog_service_text);
}
else {
$(".dblog_item_tr").css("display", "none");
$(".dblog_disabled_status").find("input, textarea, button, select").attr("disabled", false);
$("input[name=dblog_tousb_cb]").prop("checked", false);
if(usb_support) {
var usb_exist = (('<% show_usb_path(); %>').search("storage") != "-1") ? true : false;
if(usb_exist) {
$(".noUSBHint").css("display", "none");
$(".storeUSBHint").css("display", "inline");
var dblog_tousb = '<% nvram_get("dblog_tousb"); %>';
$("input[name=dblog_tousb_cb]").prop("checked", ((dblog_tousb == "1") ? true : false));
usb_status_last_time = true;
}
else {
$(".noUSBHint").css("display", "inline");
$(".storeUSBHint").css("display", "none");
usb_status_last_time = false;
}
}
else {
$(".noUSBHint").css("display", "none");
$(".storeUSBHint").css("display", "none");
}
$("input[name=dblog_service_list_all]").prop("checked", false);
$("input[name=dblog_service_list]").prop("checked", false);
diag_tune_service_option();
diag_create_duration_option();
}
}
function diag_change_dblog_status() {
var dblog_enable = getRadioValue($('form[name="form"]').children().find('input[name=dblog_enable]'));
if(dblog_enable == "1") {
$(".dblog_item_tr").css("display", "");
if(usb_support) {
if(allUsbStatus.search("storage") == "-1")
alert("<#1887#>");
else {
if($("input[name=dblog_tousb_cb]").prop("checked"))
alert("<#1888#>");
else
alert("<#1887#>");
}
}
else
alert("<#1887#>");
}
else {
$(".dblog_item_tr").css("display", "none");
}
}
function diag_control_usb_status() {
var dblog_enable = '<% nvram_get("dblog_enable"); %>';
if(dblog_enable == "0") {
if(usb_support) {
var usb_status_current = (allUsbStatus.search("storage") != "-1") ? true : false;
if(usb_status_current != usb_status_last_time) {
$(".noUSBHint").css("display", "none");
$(".storeUSBHint").css("display", "none");
$("input[name=dblog_tousb_cb]").prop("checked", false);
if(usb_status_current) {
$(".noUSBHint").css("display", "none");
$(".storeUSBHint").css("display", "inline");
var dblog_tousb = '<% nvram_get("dblog_tousb"); %>';
$("input[name=dblog_tousb_cb]").prop("checked", ((dblog_tousb == "1") ? true : false));
usb_status_last_time = true;
}
else {
$(".noUSBHint").css("display", "inline");
$(".storeUSBHint").css("display", "none");
usb_status_last_time = false;
}
diag_tune_service_option();
diag_create_duration_option();
}
}
}
}
function diag_change_storeUSB() {
diag_tune_service_option();
if($("input[name=dblog_service_list_all]").prop("checked")) {
$("input[name=dblog_service_list]").prop("checked", true);
}
diag_create_duration_option();
}
function diag_create_duration_option() {
$("select[name=dblog_duration]").empty();
var hour_to_sec = function(_hours) {
var sec = 0;
sec = _hours*60*60;
return sec;
};
var selectOption = "";
if(usb_support && $("input[name=dblog_tousb_cb]").prop("checked")) {
selectOption = { "12 <#2159#>" : hour_to_sec(12), "1 <#1640#>" : hour_to_sec(24), "2 <#1640#>" : hour_to_sec(48), "3 <#1640#>" : hour_to_sec(72) };
}
else {
selectOption = { "6 <#2159#>" : hour_to_sec(6), "12 <#2159#>" : hour_to_sec(12), "24 <#2159#>" : hour_to_sec(24) };
}
$.each(selectOption, function(item, value) {
$("select[name=dblog_duration]")
.append($("<option></option>")
.attr("value",value)
.text(item));
});
}
function diag_change_service_list_all() {
if($("input[name=dblog_service_list_all]").prop("checked")) {
$("input[name=dblog_service_list]").prop("checked", true);
}
else {
$("input[name=dblog_service_list]").prop("checked", false);
}
}
function diag_change_service_list() {
var service_list_all_option_count = $("input:checkbox[name=dblog_service_list]").length;
var service_list_click_option_count = $("input:checkbox[name=dblog_service_list]:checked").length;
if(service_list_all_option_count == service_list_click_option_count)
$("input[name=dblog_service_list_all]").prop("checked", true);
else
$("input[name=dblog_service_list_all]").prop("checked", false);
}
function diag_tune_service_option() {
var gen_service_option = function(_value, _text, _class) {
var $labelHtml = $("<label>");
$labelHtml.addClass("dblog_service_item");
$labelHtml.addClass(_class);
var $inputHtml = $('<input/>');
$inputHtml.attr({"type" : "checkbox"});
$inputHtml.attr({"name" : "dblog_service_list"});
$inputHtml.val(_value);
$inputHtml.click(function() {
diag_change_service_list();
});
$labelHtml.append($inputHtml);
$labelHtml.append(_text);
return $labelHtml;
};
if(amesh_support && (isSwMode("rt") || isSwMode("ap")) && ameshRouter_support) {
if($(".dblog_service_item.AiMesh").length == 0)
$(".dblog_service_item.all").after(gen_service_option(8, "AiMesh", "AiMesh"));
}
if(usb_support) {
if($(".dblog_service_item.noUSB").length > 0)
$(".dblog_service_item.noUSB").remove();
if($("input[name=dblog_tousb_cb]").prop("checked")) {
if(media_support)
$(".dblog_service_item.all").after(gen_service_option(4, "<#766#>", "noUSB"));
if(!nodm_support)
$(".dblog_service_item.all").after(gen_service_option(2, "<#1729#>", "noUSB"));
}
}
if($(".dblog_service_item.wifi").length == 0)
$(".dblog_service_item.all").after(gen_service_option(1, "WiFi", "wifi"));
}
function dblog_stop() {
showLoading(3);
document.stop_dblog_form.submit();
}
function check_refresh_token() {
var interval_retry = 0;
interval_status = setInterval(function(){
var refresh_token = httpApi.nvramGet(["oauth_google_refresh_token"], true).oauth_google_refresh_token;
if(refresh_token == "" && interval_retry == 5) {
show_google_auth_status("0");
$("#oauth_google_loading").hide();
clearInterval(interval_status);
}
else if(refresh_token != "") {
clearInterval(interval_status);
check_refresh_token_valid(
function(_callBackValue) {
$("#oauth_google_loading").hide();
show_google_auth_status(_callBackValue);
}
);
}
interval_retry++;
}, 1000);
}
function onGoogleLogin(_parm) {
if(_parm.code != "error") {
$("#oauth_google_hint").hide();
$("#oauth_google_loading").show();
document.form.fb_email.value = "";
httpApi.nvramSet({
"oauth_google_auth_code" : _parm.code,
"fb_email_provider" : "google",
"action_mode": "apply",
"rc_service": "oauth_google_gen_token_email"
}, check_refresh_token);
}
}
function change_fb_email_provider(obj){
if(document.form.fb_email_provider.value == "google") {
$("#option_google").show();
document.form.fb_email.value = httpApi.nvramGet(["oauth_google_user_email"], true).oauth_google_user_email;
document.form.fb_email.readOnly = true;
}
else {
$("#option_google").hide();
document.form.fb_email.value = "";
document.form.fb_email.readOnly = false;
}
}
function check_refresh_token_valid(callBackFun) {
httpApi.nvramSet({
"action_mode": "apply",
"rc_service": "oauth_google_check_token_status"
},
function(){
var interval_retry = 0;
interval_status = setInterval(function(){
var token_status = httpApi.nvramGet(["oauth_google_token_status"], true).oauth_google_token_status;
if(token_status == "" && interval_retry >= 5) {
callBackFun("0");
clearInterval(interval_status);
}
else if(token_status != "") {
callBackFun(token_status);
clearInterval(interval_status);
}
interval_retry++;
}, 1000);
}
);
}
function show_google_auth_status(_status) {
$("#oauth_google_hint").show();
var auth_status_hint = "<#1384#>";
document.form.fb_email.value = "";
switch(_status) {
case "0" :
auth_status_hint = "<#532#>";
break;
case "1" :
auth_status_hint = "<#1383#>";
var googleAuthInfo = httpApi.nvramGet(["oauth_google_user_email"], true);
document.form.fb_email.value = googleAuthInfo.oauth_google_user_email;
break;
}
$("#oauth_google_hint").html(auth_status_hint);
}
function startLogPrep(){
dr_advise();
}
var redirect_info = 0;
function CheckFBSize(){
$.ajax({
url: '/ajax_fb_size.asp',
dataType: 'script',
timeout: 1500,
error: function(xhr){
redirect_info++;
if(redirect_info < 10){
setTimeout("CheckFBSize();", 1000);
}
else{
showLoading(35);
setTimeout("redirect()", 35000);
}
},
success: function(){
if(fb_state == 0)
setTimeout("CheckFBSize()", 3000);
else
setTimeout("redirect()", 1000);
}
});
}
</script>
</head>
<body onload="initial();" onunLoad="return unload_body();" class="bg">
<div id="TopBanner"></div>
<div id="hiddenMask" class="popup_bg">
<table cellpadding="5" cellspacing="0" id="dr_sweet_advise" class="dr_sweet_advise" align="center">
<tr>
<td>
<div class="drword" id="drword" style="height:110px;"><#361#> <#671#>...
<br/>
<br/>
</div>
</td>
</tr>
</table>
</div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
<form method="post" name="stop_dblog_form" class="dblog_support_class" action="/start_apply.htm" target="hidden_frame">
<input type="hidden" name="preferred_lang" value="<% nvram_get("preferred_lang"); %>">
<input type="hidden" name="current_page" value="Advanced_Feedback.asp">
<input type="hidden" name="dblog_enable" value="0">
<input type="hidden" name="action_mode" value="apply">
<input type="hidden" name="action_script" value="stop_dblog">
<input type="hidden" name="action_wait" value="3">
</form>
<form method="post" name="form" action="/start_apply.htm" target="hidden_frame">
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>">
<input type="hidden" name="current_page" value="Advanced_Feedback.asp">
<input type="hidden" name="action_mode" value="apply">
<input type="hidden" name="action_script" value="restart_sendfeedback">
<input type="hidden" name="action_wait" value="60">
<input type="hidden" name="fb_attach_syslog" value="">
<input type="hidden" name="fb_attach_cfgfile" value="">
<input type="hidden" name="fb_attach_iptables" value="">
<input type="hidden" name="fb_attach_modemlog" value="">
<input type="hidden" name="fb_attach_wlanlog" value="">
<input type="hidden" name="feedbackresponse" value="<% nvram_get("feedbackresponse"); %>">
<input type="hidden" name="fb_experience" value="<% nvram_get("fb_experience"); %>">
<input type="hidden" name="fb_browserInfo" value="">
<input type="hidden" name="fb_transid" value="123456789ABCDEF0">
<input type="hidden" name="dblog_service" class="dblog_support_class" value="">
<input type="hidden" name="dblog_tousb" class="dblog_support_class" value="">
<input type="hidden" name="dblog_transid" class="dblog_support_class" value="0123456789ABCDEF">
<table class="content" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="17">&nbsp;</td>
<td valign="top" width="202">
<div id="mainMenu"></div>
<div id="subMenu"></div>
</td>
<td valign="top">
<div id="tabMenu" class="submenuBlock"></div>
<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr>
<td align="left" valign="top">
<table width="760px" border="0" cellpadding="5" cellspacing="0" class="FormTitle" id="FormTitle">
<tbody>
<tr>
<td bgcolor="#4D595D" valign="top" >
<div>&nbsp;</div>
<div class="formfonttitle"><#399#> - <#2519#></div>
<div style="margin:10px 0 10px 5px;" class="splitLine"></div>
<div id="fb_desc0" class="formfontdesc" style="display:none;"><#1895#></div>
<div id="fb_desc1" class="formfontdesc" style="display:none;"><#1896#></div>
<div id="fb_desc_disconnect" class="formfontdesc" style="display:none;color:#FC0;"><#1897#> <a href="mailto:router_feedback@asus.com?Subject=<%nvram_get("productid");%>" target="_top" style="color:#FFCC00;">router_feedback@asus.com</a></div>
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
<tr>
<th width="30%"><#1882#> *</th>
<td>
<input type="text" name="fb_country" maxlength="30" class="input_25_table" value="" autocorrect="off" autocapitalize="off">
</td>
</tr>
<tr>
<th><#1909#> *</th>
<td>
<input type="text" name="fb_ISP" maxlength="40" class="input_25_table" value="" autocorrect="off" autocapitalize="off">
</td>
</tr>
<tr>
<th>Subscribed Plan/Service/Package *</th> <td>
<input type="text" name="fb_Subscribed_Info" maxlength="50" class="input_25_table" value="" autocorrect="off" autocapitalize="off">
</td>
</tr>
<tr id="fb_email_provider_field" style="display: none;">
<th><#2814#></th>
<td>
<div style="float:left;">
<select class="input_option" name="fb_email_provider" onChange="change_fb_email_provider(this);">
<option value="">ASUS</option>
<option value="google">Google</option>
</select>
</div>
<div id="option_google" style="float:left;">
<div id="oauth_google_btn" class="oauth_google_btn"></div>
<img id="oauth_google_loading" src="/images/InternetScan.gif" class="oauth_google_status">
<span id="oauth_google_hint" class="oauth_google_status"></span>
</div>
</td>
</tr>
<tr>
<th><#1898#> *</th>
<td>
<input type="text" name="fb_email" maxlength="50" class="input_25_table" value="" autocorrect="off" autocapitalize="off">
</td>
</tr>
<th><#1918#></th>
<td>
<input type="text" name="fb_phone" maxlength="12" class="input_15_table" onKeyPress="return validator.isNumber(this,event);" value="" autocorrect="off" autocapitalize="off">
</td>
</tr>
<tr>
<th><#1901#> *</th>
<td>
<input type="checkbox" class="input" name="attach_syslog" id="attach_syslog_id"><label for="attach_syslog_id"><#735#></label>&nbsp;&nbsp;&nbsp;
<input type="checkbox" class="input" name="attach_cfgfile" id="attach_cfgfile_id"><label for="attach_cfgfile_id"><#1922#></label>&nbsp;&nbsp;&nbsp;
<span id="attach_iptables_span" style="color:#FFFFFF;"><input type="checkbox" class="input" name="attach_iptables" id="attach_iptables_id"><label for="attach_iptables_id"><#1908#></label></span>
<span id="attach_modem_span" style="color:#FFFFFF;"><input type="checkbox" class="input" name="attach_modemlog" id="attach_modemlog_id"><label for="attach_modemlog_id"><#1864#></label></span>
<input type="checkbox" class="input" name="attach_wlanlog" id="attach_wlanlog_id"><label for="attach_wlanlog_id"><#1942#></label>
</td>
</tr>
<tr>
<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(25,11);"><#1891#> *</a></th>
<td>
<input type="radio" name="dslx_diag_enable" class="input" value="1" onclick="change_dsl_diag_enable(1);"><#188#>
<input type="radio" name="dslx_diag_enable" class="input" value="0" onclick="change_dsl_diag_enable(0);" checked><#187#>
<br>
<span id="storage_ready" style="display:none;color:#FC0">* <#3282#></span>
<span id="be_lack_storage" style="display:none;color:#FC0">* <#2672#></span>
</td>
</tr>
<tr id="dslx_diag_duration">
<th><#1885#> *</th>
<td>
<select class="input_option" name="dslx_diag_duration">
<option value="0" selected><#154#></option>
<option value="3600">1 <#2159#></option>
<option value="18000">5 <#2159#></option>
<option value="43200">12 <#2159#></option>
<option value="86400">24 <#2159#></option>
<option value="172800">48 <#2159#></option>
</select>
</td>
</tr>
<tr class="dblog_support_class">
<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(34, 1);"><#1892#></a></th>
<td>
<div class="dblog_disabled_status">
<input type='radio' name='dblog_enable' id='dblog_status_en' value="1" onclick="diag_change_dblog_status();"><label for='dblog_status_en'><#188#></label>
<input type='radio' name='dblog_enable' id='dblog_status_dis' value="0" onclick="diag_change_dblog_status();" checked><label for='dblog_status_dis'><#187#></label>
<label class="storeUSBHint"><input type="checkbox" name="dblog_tousb_cb" value="1" onclick="diag_change_storeUSB();" checked><#1893#></label>
<span class="noUSBHint">* <#2672#></span>
</div>
<div class="dblog_enabled_status">
<span>* <#1884#></span>
<br>
<span class="dblog_stop_text" onclick="dblog_stop();"><#1883#></span>
</div>
</td>
</tr>
<tr class="dblog_item_tr dblog_support_class">
<th><#1889#></th>
<td class="dblog_item_td">
<div class="dblog_disabled_status">
<label class="dblog_service_item all"><input type="checkbox" name="dblog_service_list_all" onclick="diag_change_service_list_all();"><#1358#></label>
</div>
<div class="dblog_enabled_status">
<span class="dblog_service_text"></span>
</div>
</td>
</tr>
<tr class="dblog_item_tr dblog_support_class">
<th><#1885#></th>
<td>
<div class="dblog_disabled_status">
<select class="input_option" name="dblog_duration"></select>
</div>
<div class="dblog_enabled_status">
<span class="dblog_remaining_text"></span>
</div>
</td>
</tr>
<tr>
<th><#1881#></th>
<td>
<select class="input_option" name="fb_availability">
<option value="No_selected"><#713#> ...</option>
<option value="Stable_connection"><#1924#></option>
<option value="Occasional_interruptions"><#1916#></option>
<option value="Frequent_interruptions"><#1907#></option>
<option value="Unavailable"><#1939#></option>
</select>
</td>
</tr>
<tr>
<th><#1921#></th>
<td>
<select class="input_option" name="fb_ptype" onChange="Reload_pdesc(this);">
</select>
</td>
</tr>
<tr>
<th><#1920#></th>
<td>
<select class="input_option" name="fb_pdesc" onChange="Change_pdesc(this);">
</select>
</td>
</tr>
<tr class="which_band_tr" style="display:none;">
<th><a class="hintstyle" href="javascript:void(0);" onClick="">Which band(s)?</a></th> <td>
<select class="input_option" name="fb_which_band" onChange="">
</select>
</td>
</tr>
<tr class="when_occur_tr" style="display:none;">
<th><a class="hintstyle" href="javascript:void(0);" onClick="">When did it occur?</a></th> <td>
<select class="input_option" name="fb_when_occur" onChange="">
</select>
<span id="occur_hint" style="color:#FC0;display:none;"></span>
<span id="occur_hint2" style="color:#FC0;display:none;"></span>
</td>
</tr>
<tr class="unstable_conn_tr" style="display:none;">
<th><a class="hintstyle" href="javascript:void(0);" onClick="">Issue specifically with WiFi or WAN?</a></th> <td>
<select class="input_option" name="fb_unstable_conn" onChange="">
</select>
</td>
</tr>
<tr style="display:none;">
<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(34,2);"><#1382#></a></th>
<td>
<input type="text" name="fb_serviceno" maxlength="11" class="input_15_table" value="" autocorrect="off" autocapitalize="off">
</td>
</tr>
<tr style="display:none;">
<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(34,3);"><#1933#></a></th>
<td>
<input type="text" name="fb_tech_account" maxlength="64" class="input_32_table" value="" autocorrect="off" autocapitalize="off">
</td>
</tr>
<tr>
<th>
<#1866#> *
</th>
<td>
<textarea name="fb_comment" maxlength="2000" cols="55" rows="8" class="textarea_ssh_table" style="font-family:'Courier New', Courier, mono; font-size:13px;" onKeyDown="textCounter(this,document.form.msglength,2000);" onKeyUp="textCounter(this,document.form.msglength,2000)"></textarea>
<span style="color:#FC0"><#1910#> : </span>
<input type="text" class="input_6_table" name="msglength" id="msglength" maxlength="4" value="2000" autocorrect="off" autocapitalize="off" readonly>
</td>
</tr>
<tr>
<td colspan="2">
<div>
<div style="float: left;"><input type="checkbox" name="eula_checkbox"/></div>
<div id="eula_content" style="margin-left: 20px;"><#1940#></div>
</div>
<input class="button_gen" style="margin-left: 305px; margin-top:5px;" name="btn_send" onclick="applyRule()" type="button" value="<#1478#>"/>
</td>
</tr>
<tr>
<td colspan="2">
<strong><#2057#></strong>
<ul>
<li><#1915#><br><a style="font-weight: bolder;text-decoration:underline;cursor:pointer;" href="https://www.asus.com/support/CallUs/" target="_blank">https://www.asus.com/support/CallUs/</a></li>
</ul>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</form>
</tr>
</table>
</td>
<td width="10" align="center" valign="top">&nbsp;</td>
</tr>
</table>
<div id="footer"></div>
</body>
</html>
<td width="10" align="center" valign="top">&nbsp;</td>
</tr>
</table>
<div id="footer"></div>
</body>
</html>


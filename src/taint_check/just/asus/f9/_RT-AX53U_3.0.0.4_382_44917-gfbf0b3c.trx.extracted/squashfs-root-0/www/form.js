﻿function combineIP(obj){ //combine all IP info before validation and submit
var IP_List = document.getElementById(obj+"_div").childNodes;
var IP_str = "";
for(var i=0; i < IP_List.length; i++){
if(IP_List[i].type == "text"){
if(IP_List[i].value != ""){
IP_List[i].value = parseInt(IP_List[i].value,10);
}
IP_str += IP_List[i].value;
}
else if(IP_List[i].nodeValue.indexOf(".") != -1){
IP_str += ".";
}
}
if(IP_str != "..."){
document.getElementById(obj).value = IP_str;
}else{
document.getElementById(obj).value = "";
}
}
function IPinputCtrl(obj, t){
var IP_List = document.getElementById(obj.name+"_div").childNodes;
document.getElementById(obj.name+"_div").style.background = (t==0)?"#999999":"#FFFFFF";
for(var i=0; i < IP_List.length; i++){
if(IP_List[i].type == "text"){
IP_List[i].disabled = (t==0)?true:false;
IP_List[i].style.color = (t==0)?"#FFFFFF":"#000000";
IP_List[i].style.background = (t==0)?"#999999":"#FFFFFF";
}
}
}
function cal_panel_block(obj, multiple) {
var isMobile = function() {
var tmo_support = ('<% nvram_get("rc_support"); %>'.search("tmo") == -1) ? false : true;
if(!tmo_support)
return false;
if( navigator.userAgent.match(/iPhone/i) ||
navigator.userAgent.match(/iPod/i) ||
navigator.userAgent.match(/iPad/i) ||
(navigator.userAgent.match(/Android/i) && (navigator.userAgent.match(/Mobile/i) || navigator.userAgent.match(/Tablet/i))) ||
(navigator.userAgent.match(/Opera/i) && (navigator.userAgent.match(/Mobi/i) || navigator.userAgent.match(/Mini/i))) || // Opera mobile or Opera Mini
navigator.userAgent.match(/IEMobile/i) || // IE Mobile
navigator.userAgent.match(/BlackBerry/i) //BlackBerry
) {
return true;
}
else {
return false;
}
};
var blockmarginLeft;
var winWidth = 0;
if (window.innerWidth) {
winWidth = window.innerWidth;
}
else if ((document.body) && (document.body.clientWidth)) {
winWidth = document.body.clientWidth;
}
if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
winWidth = document.documentElement.clientWidth;
}
if(winWidth > 1050) {
winPadding = (winWidth - 1050) / 2;
winWidth = 1105;
blockmarginLeft = (winWidth * multiple) + winPadding;
}
else if(winWidth <= 1050) {
if(isMobile()) {
if(document.body.scrollLeft < 50) {
blockmarginLeft= (winWidth) * multiple + document.body.scrollLeft;
}
else if(document.body.scrollLeft >320) {
blockmarginLeft = 320;
}
else {
blockmarginLeft = document.body.scrollLeft;
}
}
else {
blockmarginLeft = (winWidth) * multiple + document.body.scrollLeft;
}
}
if(re_mode == "1"){
document.getElementById(obj).style.left = "50%";
document.getElementById(obj).style.marginLeft = "-250px";
}
else
document.getElementById(obj).style.marginLeft = blockmarginLeft + "px";
}
function adjust_TM_eula_height(_objID) {
var scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
document.getElementById(_objID).style.top = (scrollTop + 10) + "px";
var visiable_height = document.documentElement.clientHeight;
var tm_eula_container_height = parseInt(document.getElementById(_objID).offsetHeight);
var tm_eula_visiable_height = visiable_height - tm_eula_container_height;
if(tm_eula_visiable_height < 0) {
var tm_eula_content_height = parseInt(document.getElementById("tm_eula_content").style.height);
document.getElementById("tm_eula_content").style.height = (tm_eula_content_height - Math.abs(tm_eula_visiable_height) - 20) + "px"; //content height - overflow height - margin top and margin bottom
}
}
function adjust_panel_block_top(_objID, _offsetHeight) {
var scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
document.getElementById(_objID).style.top = (scrollTop + _offsetHeight) + "px";
}


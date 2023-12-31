﻿/* menuTree_bwdpi_no_traffic_analyzer.js */
define(function(){
var menuTree = {
list: [
/*
{
menuName: "Title",
index: "Assign an index to this menu, it is also used for filtering",
tab: [
{
url: "Put url here",
tabName: "
Assign a title for this tab, leave this field empty to bypass this tab,
fill in '__HIDE__' to hide the tab switcher,
fill in '__INHERIT__' to inhert tab index from referred page.
"
}
]
}
*/
{
menuName: "<#479#>",
index: "menu_QIS",
tab: [
{url: "QIS_wizard.htm", tabName: "__HIDE__"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
/* ============================================================================================================ */
{
menuName: "<#372#>",
index: "menu_Split",
tab: [
{url: "NULL", tabName: "__HIDE__"}
]
},
{
menuName: "<#369#>",
index: "menu_Index",
tab: [
{url: "<% networkmap_page(); %>", tabName: "__HIDE__"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "AiMesh",
index: "menu_AiMesh",
tab: [
{url: "AiMesh.asp", tabName: "AiMesh"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#281#>",
index: "menu_GuestNetwork",
tab: [
{url: "Guest_network.asp", tabName: "<#281#>"},
{url: "Captive_Portal.asp", tabName: "Free WiFi"},
{url: "Captive_Portal_Advanced.asp", tabName: "<#3783#>"},
{url: "Guest_network_fbwifi.asp", tabName: "Facebook WiFi"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#1250#>",
index: "menu_AiProtection",
tab: [
{url: "AiProtection_HomeSecurity.asp", tabName: "__HIDE__"},
{url: "AiProtection_HomeProtection.asp", tabName: "<#1203#>"},
{url: "AiProtection_MaliciousSitesBlocking.asp", tabName: "<#1247#>"},
{url: "AiProtection_IntrusionPreventionSystem.asp", tabName: "<#1266#>"},
{url: "AiProtection_InfectedDevicePreventBlock.asp", tabName: "<#1160#>"},
{url: "AiProtection_WebProtector.asp", tabName: "<#457#>"},
{url: "ParentalControl.asp", tabName: "<#457#>"},
{url: "AiProtection_AdBlock.asp", tabName: "Ad Blocking"},
{url: "AiProtection_Key_Guard.asp", tabName: "Key Guard"},
{url: "YandexDNS.asp", tabName: "<#3739#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "网易UU加速器",
index: "menu_UU",
tab: [
{url: "UUAccelerator.asp", tabName: "网易UU加速器"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#883#>",
index: "menu_BandwidthMonitor",
tab: [
{url: "AdaptiveQoS_Bandwidth_Monitor.asp", tabName: "<#1391#>"},
{url: "QoS_EZQoS.asp", tabName: "<#2524#>"},
{url: "AdaptiveQoS_WebHistory.asp", tabName: "<#878#>"},
{url: "AdaptiveQoS_ROG.asp", tabName: "<table style='margin-top:-7px;'><tr><td><img src='/images/ROG_Logo.png' style='border:0px;width:32px;'></td><td>ROG First</td></tr></table>"},
{url: "Main_Spectrum_Content.asp", tabName: "<#3002#>"},
{url: "AdaptiveQoS_TrafficLimiter.asp", tabName: "Traffic Limiter"},
{url: "Advanced_QOSUserPrio_Content.asp", tabName: "__INHERIT__"},
{url: "Advanced_QOSUserRules_Content.asp", tabName: "__INHERIT__"},
{url: "AdaptiveQoS_Adaptive.asp", tabName: "__INHERIT__"},
{url: "Main_TrafficMonitor_realtime.asp", tabName: "<#762#>"},
{url: "Main_TrafficMonitor_last24.asp", tabName: "__INHERIT__"},
{url: "Main_TrafficMonitor_daily.asp", tabName: "__INHERIT__"},
{url: "AdaptiveQoS_InternetSpeed.asp", tabName: "<#2209#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#2065#>",
index: "menu_GameBoost",
tab: [
{url: "GameBoost.asp", tabName: "<#2065#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "腾讯网游加速器",
index: "menu_TencentAcceleration",
tab: [
{url: "GameBoost_Tencent.asp", tabName: "Tencent Game Acceleration"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#368#>",
index: "menu_APP",
tab: [
{url: "APP_Installation.asp", tabName: "__HIDE__"},
{url: "aidisk.asp", tabName: "__INHERIT__"},
{url: "mediaserver.asp", tabName: "<#766#>"},
{url: "Advanced_AiDisk_samba.asp", tabName: "<#389#>".concat(WebDav_support?" / <#1554#>":"")},
{url: "Advanced_AiDisk_ftp.asp", tabName: "<#390#>"},
{url: "PrinterServer.asp", tabName: "__INHERIT__"},
{url: "Advanced_Modem_Content.asp", tabName: "__INHERIT__"},
{url: "Advanced_TimeMachine.asp", tabName: "__INHERIT__"},
{url: "fileflex.asp", tabName: "__INHERIT__"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#943#>",
index: "menu_AiCloud",
tab: [
{url: "cloud_main.asp", tabName: "AiCloud 2.0"},
{url: "cloud_sync.asp", tabName: "<#2993#>"},
{url: "cloud_router_sync.asp", tabName: "<#2926#>"},
{url: "cloud_settings.asp", tabName: "<#2946#>"},
{url: "cloud_syslog.asp", tabName: "<#2490#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
/* ============================================================================================================ */
{
menuName: "<#370#>",
index: "menu_Split",
tab: [
{url: "NULL", tabName: "__HIDE__"}
]
},
{
menuName: "<#371#>",
index: "menu_Wireless",
tab: [
{url: "Advanced_Wireless_Content.asp", tabName: "<#372#>"},
{url: "Advanced_WWPS_Content.asp", tabName: "<#373#>"},
{url: "Advanced_WMode_Content.asp", tabName: "WDS"},
{url: "Advanced_ACL_Content.asp", tabName: "<#375#>"},
{url: "Advanced_WSecurity_Content.asp", tabName: "<#376#>"},
{url: "Advanced_WAdvanced_Content.asp", tabName: "<#377#>"},
{url: "Advanced_WProxy_Content.asp", tabName: "<#3519#>"},
{url: "Advanced_Roaming_Block_Content.asp", tabName: "<#3522#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#378#>",
index: "menu_LAN",
tab: [
{url: "Advanced_LAN_Content.asp", tabName: "<#379#>"},
{url: "Advanced_DHCP_Content.asp", tabName: "<#380#>"},
{url: "DNSFilter.asp", tabName: "DNSFilter"},
{url: "Advanced_MultiSubnet_Content.asp", tabName: "<#380#>"},
{url: "Advanced_GWStaticRoute_Content.asp", tabName: "<#381#>"},
{url: "Advanced_IPTV_Content.asp", tabName: "IPTV"},
{url: "Advanced_SwitchCtrl_Content.asp", tabName: "<#3039#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#382#>",
index: "menu_WAN",
tab: [
{url: "Advanced_WAN_Content.asp", tabName: "<#383#>"},
{url: "Advanced_DSL_Content.asp", tabName: "<#383#>"},
{url: "Advanced_Modem_Content.asp", tabName: "<#383#>"},
{url: "Advanced_MobileBroadband_Content.asp", tabName: "<#383#>"},
{url: "Advanced_WANPort_Content.asp", tabName: "<#220#>"},
{url: "Advanced_PortTrigger_Content.asp", tabName: "<#384#>"},
{url: "Advanced_VirtualServer_Content.asp", tabName: "<#385#>"},
{url: "Advanced_Exposed_Content.asp", tabName: "<#386#>"},
{url: "Advanced_ASUSDDNS_Content.asp", tabName: "<#387#>"},
{url: "Advanced_NATPassThrough_Content.asp", tabName: "<#415#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "Alexa & IFTTT",
index: "menu_Alexa_IFTTT",
tab: [
{url: "Advanced_Smart_Home_Alexa.asp", tabName: "__INHERIT__"},
{url: "Advanced_Smart_Home_IFTTT.asp", tabName: "__INHERIT__"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "IPv6",
index: "menu_IPv6",
tab: [
{url: "Advanced_IPv6_Content.asp", tabName: "IPv6"},
{url: "Advanced_IPv61_Content.asp", tabName: "__INHERIT__"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "VPN",
index: "menu_VPN",
tab: [
{url: "Advanced_VPN_PPTP.asp", tabName: "<#171#>"},
{url: "Advanced_VPN_OpenVPN.asp", tabName: "__INHERIT__"},
{url: "Advanced_VPN_IPSec.asp", tabName: "__INHERIT__"},
{url: "Advanced_VPNClient_Content.asp", tabName: (vpn_fusion_support) ? "<#3877#>" : "<#3461#>"},
{url: "Advanced_TOR_Content.asp", tabName: "TOR"},
{url: "Advanced_Instant_Guard.asp", tabName: "<#3975#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#393#>",
index: "menu_Firewall",
tab: [
{url: "Advanced_BasicFirewall_Content.asp", tabName: "<#372#>"},
{url: "Advanced_URLFilter_Content.asp", tabName: "<#394#>"},
{url: "Advanced_KeywordFilter_Content.asp", tabName: "<#397#>"},
{url: "Advanced_Firewall_Content.asp", tabName: "<#396#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#399#>",
index: "menu_Setting",
tab: [
{url: "Advanced_OperationMode_Content.asp", tabName: "<#400#>"},
{url: "Advanced_System_Content.asp", tabName: "<#402#>"},
{url: "Advanced_FirmwareUpgrade_Content.asp", tabName: "<#403#>"},
{url: "Advanced_SettingBackup_Content.asp", tabName: "<#404#>"},
{url: "Advanced_PerformanceTuning_Content.asp", tabName: "<#1859#>"},
{url: "Advanced_ADSL_Content.asp", tabName: "<#366#>"},
{url: "Advanced_Feedback.asp", tabName: "<#2519#>"},
{url: "Feedback_Info.asp", tabName: "__INHERIT__"},
{url: "Advanced_SNMP_Content.asp", tabName: "SNMP"},
{url: "Advanced_TR069_Content.asp", tabName: "TR-069"},
{url: "Advanced_Notification_Content.asp", tabName: "Notification"},
{url: "Advanced_Privacy.asp", tabName: "<#3908#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#735#>",
index: "menu_Log",
tab: [
{url: "Main_LogStatus_Content.asp", tabName: "<#405#>"},
{url: "Main_WStatus_Content.asp", tabName: "<#407#>"},
{url: "Main_DHCPStatus_Content.asp", tabName: "<#406#>"},
{url: "Main_IPV6Status_Content.asp", tabName: "IPv6"},
{url: "Main_RouteStatus_Content.asp", tabName: "<#409#>"},
{url: "Main_IPTStatus_Content.asp", tabName: "<#408#>"},
{url: "Main_AdslStatus_Content.asp", tabName: "<#365#>"},
{url: "Main_ConnStatus_Content.asp", tabName: "<#1577#>"},
/* {url: "###Main_ConnStatus_Content.asp", tabName: "Captive Portal Connection Log"}, */
{url: "NULL", tabName: "__INHERIT__"}
]
},
{
menuName: "<#2649#>",
index: "menu_NekworkTool",
tab: [
{url: "Main_Analysis_Content.asp", tabName: "<#2644#>"},
{url: "Main_Netstat_Content.asp", tabName: "Netstat"},
{url: "Main_WOL_Content.asp", tabName: "<#2665#>"},
{url: "Advanced_Smart_Connect.asp", tabName: "<#2986#>"},
{url: "NULL", tabName: "__INHERIT__"}
]
}
],
exclude: {
menus: function(){
var retArray = [];
if(!multissid_support){
retArray.push("menu_GuestNetwork");
}
if(!bwdpi_support){
retArray.push("menu_AiProtection");
retArray.push("menu_TrafficAnalyzer");
retArray.push("menu_BandwidthMonitor");
}
if(!adaptiveqos_support){
for(i=0; i<menuTree.list.length; i++){
if(menuTree.list[i].menuName == '<#883#>'){
menuTree.list[i].menuName = '<#2524#>';
}
}
}
if(!usb_support){
retArray.push("menu_APP");
}
if((!cloudsync_support && !aicloudipk_support) || nocloudsync_support){
retArray.push("menu_AiCloud");
}
if(!ifttt_support && !alexa_support){
retArray.push("menu_Alexa_IFTTT");
}
if(!IPv6_support){
retArray.push("menu_IPv6");
}
if(!networkTool_support){
retArray.push("menu_NekworkTool");
}
if(!pptpd_support && !openvpnd_support && !vpnc_support){
retArray.push("menu_VPN");
}
if(!tagged_based_vlan){
retArray.push("menu_VLAN");
}
if(!wtfast_support) {
retArray.push("menu_GameBoost");
}
if(!tencent_qmacc_support)
retArray.push("menu_TencentAcceleration");
if(!uu_support){
retArray.push("menu_UU");
}
if(!amesh_support)
retArray.push("menu_AiMesh");
else{
if(ameshRouter_support){
if(!isSwMode("rt") && !isSwMode("ap"))
retArray.push("menu_AiMesh");
}
else if(ameshNode_support)
retArray.push("menu_AiMesh");
}
/* Operation Mode */
if(isSwMode("re")){
retArray.push("menu_GuestNetwork");
retArray.push("menu_AccessControl");
retArray.push("menu_TrafficAnalyzer");
retArray.push("menu_QoS");
retArray.push("menu_BandwidthMonitor");
retArray.push("menu_AiProtection");
retArray.push("menu_WAN");
retArray.push("menu_IPv6");
retArray.push("menu_VPN");
retArray.push("menu_VLAN");
retArray.push("menu_Firewall");
retArray.push("menu_Wireless");
if(ifttt_support || alexa_support){
retArray.push("menu_Alexa_IFTTT");
}
}
else if(isSwMode("ap")){
retArray.push("menu_AccessControl");
retArray.push("menu_TrafficAnalyzer");
retArray.push("menu_QoS");
retArray.push("menu_BandwidthMonitor");
retArray.push("menu_AiProtection");
retArray.push("menu_WAN");
retArray.push("menu_IPv6");
retArray.push("menu_VPN");
retArray.push("menu_VLAN");
retArray.push("menu_Firewall");
if(ifttt_support || alexa_support){
retArray.push("menu_Alexa_IFTTT");
}
}
else if(isSwMode("mb")){
retArray.push("menu_GuestNetwork");
retArray.push("menu_AccessControl");
retArray.push("menu_TrafficAnalyzer");
retArray.push("menu_QoS");
retArray.push("menu_BandwidthMonitor");
retArray.push("menu_AiProtection");
retArray.push("menu_Wireless");
retArray.push("menu_WAN");
retArray.push("menu_IPv6");
retArray.push("menu_VPN");
retArray.push("menu_VLAN");
retArray.push("menu_Firewall");
if(ifttt_support || alexa_support){
retArray.push("menu_Alexa_IFTTT");
}
}
return retArray;
},
tabs: function(){
var retArray = [];
/* By RC Support */
if(!bwdpi_support){
retArray.push("AdaptiveQoS_Bandwidth_Monitor.asp");
retArray.push("AdaptiveQoS_WebHistory.asp");
retArray.push("AdaptiveQoS_Adaptive.asp");
retArray.push("AiProtection_HomeSecurity.asp");
retArray.push("AiProtection_HomeProtection.asp");
retArray.push("AiProtection_WebProtector.asp");
retArray.push("AiProtection_AdBlock.asp");
retArray.push("AiProtection_Key_Guard.asp");
retArray.push("AiProtection_AdBlock.asp");
retArray.push("TrafficAnalyzer_Statistic.asp");
}
if(!bwdpi_webFilter_support){
retArray.push("AiProtection_WebProtector.asp");
}
if(!bwdpi_mals_support){
retArray.push("AiProtection_MaliciousSitesBlocking.asp");
}
if(!bwdpi_cc_support){
retArray.push("AiProtection_InfectedDevicePreventBlock.asp");
}
if(!bwdpi_vp_support){
retArray.push("AiProtection_IntrusionPreventionSystem.asp");
}
if(!bwdpi_bwMonitor_support){
retArray.push("AdaptiveQoS_Bandwidth_Monitor.asp");
}
if(!bwdpi_webHistory_support){
retArray.push("AdaptiveQoS_WebHistory.asp");
}
if(!traffic_analyzer_support){
retArray.push("TrafficAnalyzer_Statistic.asp");
}
if(!traffic_limiter_support){
retArray.push("AdaptiveQoS_TrafficLimiter.asp");
}
if(downsize_4m_support){
retArray.push("Main_ConnStatus_Content.asp");
retArray.push("Main_TrafficMonitor_realtime.asp");
}
if(!ParentalCtrl2_support){
retArray.push("ParentalControl.asp");
}
if(!pptpd_support){
retArray.push("Advanced_VPN_PPTP.asp");
}
if(!openvpnd_support){
retArray.push("Advanced_VPN_OpenVPN.asp");
}
if(!ipsec_srv_support){
retArray.push("Advanced_VPN_IPSec.asp");
}
if(!vpnc_support){
retArray.push("Advanced_VPNClient_Content.asp");
}
if(!isSupport("Instant_Guard"))
retArray.push("Advanced_Instant_Guard.asp");
if(!yadns_support){
retArray.push("YandexDNS.asp");
}
if(!frs_feedback_support) {
retArray.push("Advanced_Feedback.asp");
retArray.push("Feedback_Info.asp");
}
if(noftp_support){
retArray.push("Advanced_AiDisk_ftp.asp");
}
if(!dualWAN_support){
retArray.push("Advanced_WANPort_Content.asp");
retArray.push("Advanced_Modem_Content.asp");
retArray.push("Advanced_MobileBroadband_Content.asp");
}
else{
if(!dualwan_enabled && usb_index == 0){
retArray.push("Advanced_WAN_Content.asp");
if(!gobi_support)
retArray.push("Advanced_MobileBroadband_Content.asp");
else
retArray.push("Advanced_Modem_Content.asp");
}
else{
retArray.push("Advanced_MobileBroadband_Content.asp");
retArray.push("Advanced_Modem_Content.asp");
}
}
if(!SwitchCtrl_support){
retArray.push("Advanced_SwitchCtrl_Content.asp");
}
if(!tr069_support){
retArray.push("Advanced_TR069_Content.asp");
}
if(!snmp_support){
retArray.push("Advanced_SNMP_Content.asp");
}
if(!nt_center_support){
retArray.push("Advanced_Notification_Content.asp");
}
if(!smart_connect_support || Qcawifi_support){
retArray.push("Advanced_Smart_Connect.asp");
}
if(!adBlock_support){
retArray.push("AiProtection_AdBlock.asp");
}
if(!keyGuard_support){
retArray.push("AiProtection_Key_Guard.asp");
}
if(!tor_support){
retArray.push("Advanced_TOR_Content.asp");
}
if(!dsl_support) {
retArray.push("Advanced_DSL_Content.asp");
retArray.push("Advanced_ADSL_Content.asp");
retArray.push("Main_AdslStatus_Content.asp");
retArray.push("Main_Spectrum_Content.asp");
}
else{
retArray.push("Advanced_WAN_Content.asp");
retArray.push("Advanced_OperationMode_Content.asp");
if(!spectrum_support)
retArray.push("Main_Spectrum_Content.asp");
}
if(hwmodeSwitch_support){
retArray.push("Advanced_OperationMode_Content.asp");
}
if(noiptv_support){
retArray.push("Advanced_IPTV_Content.asp");
}
if(!media_support || nomedia_support){
retArray.push("mediaserver.asp");
}
if(!rog_support){
retArray.push("AdaptiveQoS_ROG.asp");
}
if(!wtfast_support){
retArray.push("GameBoost.asp");
}
if(!tencent_qmacc_support)
retArray.push("GameBoost_Tencent.asp");
if(!alexa_support){
retArray.push("Advanced_Smart_Home_Alexa.asp");
}
if(!ifttt_support){
retArray.push("Advanced_Smart_Home_IFTTT.asp");
}
if(!IPv6_support){
retArray.push("Main_IPV6Status_Content.asp");
}
if(!fbwifi_support){
retArray.push("Guest_network_fbwifi.asp");
}
if(!tagged_based_vlan){
retArray.push("Advanced_TagBasedVLAN_Content.asp");
retArray.push("Advanced_MultiSubnet_Content.asp");
}
else
retArray.push("Advanced_DHCP_Content.asp");
if(!wifiproxy_support || !concurrep_support || !isSwMode("re")){
retArray.push("Advanced_WProxy_Content.asp");
}
if(!captivePortal_support) {
retArray.push("Captive_Portal.asp");
retArray.push("Captive_Portal_Advanced.asp");
}
else {
if(!cp_freewifi_support)
retArray.push("Captive_Portal.asp");
if(!cp_advanced_support)
retArray.push("Captive_Portal_Advanced.asp");
}
if(!cooler_support){
retArray.push("Advanced_PerformanceTuning_Content.asp");
}
if(!rrsut_support)
retArray.push("cloud_router_sync.asp");
if(!amesh_support)
retArray.push("Advanced_Roaming_Block_Content.asp");
else{
if(ameshRouter_support){
if(!isSwMode("rt") && !isSwMode("ap"))
retArray.push("Advanced_Roaming_Block_Content.asp");
}
else if(ameshNode_support)
retArray.push("Advanced_Roaming_Block_Content.asp");
}
if(!fileflex_support)
retArray.push("fileflex.asp");
if(!dnsfilter_support)
retArray.push("DNSFilter.asp");
/* Operation Mode */
if(isSwMode("re")){
retArray.push("GameBoost.asp");
retArray.push("TrafficAnalyzer_Statistic.asp");
retArray.push("Advanced_DHCP_Content.asp");
retArray.push("Advanced_MultiSubnet_Content.asp");
retArray.push("Advanced_GWStaticRoute_Content.asp");
retArray.push("Advanced_IPTV_Content.asp");
retArray.push("Main_DHCPStatus_Content.asp");
retArray.push("Main_IPV6Status_Content.asp");
retArray.push("Main_RouteStatus_Content.asp");
retArray.push("Main_IPTStatus_Content.asp");
retArray.push("Main_ConnStatus_Content.asp");
retArray.push("Advanced_Smart_Connect.asp");
retArray.push("DNSFilter.asp");
if(userRSSI_support){
retArray.push("Advanced_ACL_Content.asp");
if(!concurrep_support){
retArray.push("Advanced_Wireless_Content.asp");
}
retArray.push("Advanced_WWPS_Content.asp");
retArray.push("Advanced_WMode_Content.asp");
retArray.push("Advanced_WSecurity_Content.asp");
}
}
else if(isSwMode("ap")){
retArray.push("GameBoost.asp");
retArray.push("TrafficAnalyzer_Statistic.asp");
if(!dhcp_override_support){
retArray.push("Advanced_DHCP_Content.asp");
}
retArray.push("Advanced_MultiSubnet_Content.asp");
retArray.push("Advanced_GWStaticRoute_Content.asp");
retArray.push("Advanced_IPTV_Content.asp");
retArray.push("Main_DHCPStatus_Content.asp");
retArray.push("Main_IPV6Status_Content.asp");
retArray.push("Main_RouteStatus_Content.asp");
retArray.push("Main_IPTStatus_Content.asp");
retArray.push("Main_ConnStatus_Content.asp");
retArray.push("Captive_Portal.asp");
retArray.push("Captive_Portal_Advanced.asp");
retArray.push("Guest_network_fbwifi.asp");
retArray.push("DNSFilter.asp");
}
else if(isSwMode("mb")){
retArray.push("GameBoost.asp");
retArray.push("TrafficAnalyzer_Statistic.asp");
retArray.push("Advanced_DHCP_Content.asp");
retArray.push("Advanced_MultiSubnet_Content.asp");
retArray.push("Advanced_GWStaticRoute_Content.asp");
retArray.push("Advanced_IPTV_Content.asp");
retArray.push("Main_DHCPStatus_Content.asp");
retArray.push("Main_IPV6Status_Content.asp");
retArray.push("Main_RouteStatus_Content.asp");
retArray.push("Main_IPTStatus_Content.asp");
retArray.push("Main_ConnStatus_Content.asp");
retArray.push("Advanced_Smart_Connect.asp");
retArray.push("DNSFilter.asp");
}
/* System Status Changed */
/* MODELDEP */
if(based_modelid == "RT-N10U"){
retArray.push("Advanced_WMode_Content.asp");
}
else if(based_modelid == "RT-AC87U" && '<% nvram_get("wl_unit"); %>' == '1'){
retArray.push("Advanced_WSecurity_Content.asp");
}
else if(based_modelid == "RT-N300"){
retArray.push("Advanced_WMode_Content.asp");
retArray.push("Advanced_IPTV_Content.asp");
}
if(!internetSpeed_support){
retArray.push("AdaptiveQoS_InternetSpeed.asp");
}
return retArray;
}
}
}
return menuTree;
});


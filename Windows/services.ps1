########## THIS IS FOR WINDOWS 10!!! I HAVE NOT CHECKED THIS FOR WINDOWS SERVER COMPATABILITY ##########

##### Asking if services are critical #####

$remote_desktop_service = Read-Host "Enter 'y' if Remoted Desktop Services is a critical service"
$iis_crit_service = Read-Host "Enter 'y' if IIS is a critical service"
$file_print_sharing = Read-Host "Enter 'y' if SMB/file/printing sharing is a critical service"
$bluetooth_crit_service = Read-Host "Enter 'y'if Bluetooth is a critical service"

########## Do not disable if remote access is needed (applies to everything below stopping at the comment) ##########

if ($remote_desktop_service -ne 'y') {
    Stop-Service -Name RemoteAccess
    Set-Service -Name RemoteAccess -StartupType Disabled

    Stop-Service -Name WinRM
    Set-Service -Name WinRm -StartupType Disabled

    Stop-Service -Name RemoteRegistry
    Set-Service -Name RemoteRegistry -StartupType Disabled

    Stop-Service -Name RpcLocator
    Set-Service -Name RpcLocator -StartupType Disabled

    Stop-Service -Name UmRdpService
    Set-Service -Name UmRdpService -StartupType Disabled

    Stop-Service -Name TermService
    Set-Service -Name TermService -StartupType Disabled

    Stop-Service -Name SessionEnv
    Set-Service -Name SessionEnv -StartupType Disabled

    Stop-Service -Name RasAuto
    Set-Service -Name RasAuto -StartupType Disabled

    Stop-Service -Name RasMan
    Set-Service -Name RasMan -StartupType Disabled
}
#####################################################################################################################

##### May disable IIS. Make sure IIS is not a crit service #####

if ($iis_crit_service -ne 'y') {
    Stop-Service -Name W3SVC
    Set-Service -Name W3SVC -StartupType Disabled
}
##### If file, print, and named-print sharing is required this should not be disabled #####

if ($file_print_sharing -ne 'y') {
    Stop-Service -Name LanmanServer
    Set-Service -Name LanmanServer -StartupType Disabled
    Stop-Service -Name LanmanWorkstation
    Set-Service -Name LanmanWorkstation -StartupType Disabled
}

##### Do not disable if bluetooth is needed #####
if ($bluetooth_crit_service -ne 'y') {
    Stop-Service -Name BluetoothUserService_956c5
    Set-Service -Name BluetoothUserService_956c5 -StartupType Disabled

    Stop-Service -Name bthserv
    Set-Service -Name bthserv -StartupType Disabled

    Stop-Service -Name BTAGService
    Set-Service -Name BTAGService -StartupType Disabled
}

Stop-Service -Name PushToInstall
Set-Service -Name PushToInstall -StartupType Disabled

Stop-Service -Name perceptionsimulation
Set-Service -Name perceptionsimulation -StartupType Disabled

Stop-Service -Name spectrum
Set-Service -Name spectrum -StartupType Disabled

Stop-Service -Name icssvc
Set-Service -Name icssvc -StartupType Disabled

Stop-Service -Name LicenseManager
Set-Service -Name LicenseManager -StartupType Disabled

Stop-Service -Name WerSvc
Set-Service -Name WerSvc -StartupType Disabled

Stop-Service -Name WbioSrvc
Set-Service -Name WbioSrvc -StartupType Disabled

Stop-Service -Name seclogon
Set-Service -Name seclogon -StartupType Disabled

Stop-Service -Name XboxNetApiSvc
Set-Service -Name XboxNetApiSvc -StartupType Disabled

Stop-Service -Name XblGameSave
Set-Service -Name XblGameSave -StartupType Disabled

Stop-Service -Name XblAuthManager
Set-Service -Name XblAuthManager -StartupType Disabled

Stop-Service -Name XboxGipSvc
Set-Service -Name XboxGipSvc -StartupType Disabled

Stop-Service -Name WpnService
Set-Service -Name WpnService -StartupType Disabled

Stop-Service -Name WMPNetworkSvc
Set-Service -Name WMPNetworkSvc -StartupType Disabled

Stop-Service -Name Wecsvc
Set-Service -Name Wecsvc -StartupType Disabled

Stop-Service -Name upnphost
Set-Service -Name upnphost -StartupType Disabled

Stop-Service -Name SSDPSRV
Set-Service -Name SSDPSRV -StartupType Disabled

Stop-Service -Name sacsvr
Set-Service -Name sacsvr -StartupType Disabled

Stop-Service -Name SNMP
Set-Service -Name SNMP -StartupType Disabled

Stop-Service -Name simptcp
Set-Service -Name simptcp -StartupType Disabled

Stop-Service -Name wercplsupport
Set-Service -Name wercplsupport -StartupType Disabled

Stop-Service -Name bthserv
Set-Service -Name bthserv -StartupType Disabled

Stop-Service -Name CDPUserSvc
Set-Service -Name CDPUserSvc -StartupType Disabled

Stop-Service -Name PimIndexMaintenanceSvc
Set-Service -Name PimIndexMaintenanceSvc -StartupType Disabled

Stop-Service -Name lfsvc
Set-Service -Name lfsvc -StartupType Disabled

Stop-Service -Name SharedAccess
Set-Service -Name SharedAccess -StartupType Disabled

Stop-Service -Name NcbService
Set-Service -Name NcbService -StartupType Disabled

Stop-Service -Name PhoneSvc
Set-Service -Name PhoneSvc -StartupType Disabled

Stop-Service -Name Spooler
Set-Service -Name Spooler -StartupType Disabled

Stop-Service -Name PrintNotify
Set-Service -Name PrintNotify -StartupType Disabled

Stop-Service -Name QWAVE
Set-Service -Name QWAVE -StartupType Disabled

Stop-Service -Name RmSvc
Set-Service -Name RmSvc -StartupType Disabled

Stop-Service -Name ShellHWDetection
Set-Service -Name ShellHWDetection -StartupType Disabled

Stop-Service -Name p2pimsvc
Set-Service -Name p2pimsvc -StartupType Disabled

Stop-Service -Name p2psvc
Set-Service -Name p2psvc -StartupType Disabled

Stop-Service -Name PNRPsvc
Set-Service -Name PNRPsvc -StartupType Disabled

Stop-Service -Name InstallService
Set-Service -Name InstallService -StartupType Disabled

Stop-Service -Name AppVClient
Set-Service -Name AppVClient -StartupType Disabled

Stop-Service -Name wlidsvc
Set-Service -Name wlidsvc -StartupType Disabled

Stop-Service -Name MessagingService
Set-Service -Name MessagingService -StartupType Disabled

Stop-Service -Name Fax
Set-Service -Name Fax -StartupType Disabled

Stop-Service -Name MapsBroker
Set-Service -Name MapsBroker -StartupType Disabled

Stop-Service -Name DiagTrack
Set-Service -Name DiagTrack -StartupType Disabled

Set-Service -Name wuauserv -StartupType Manual
Set-Service -Name WaaSMedicSvc -StartupType Manual
Set-Service -Name SecurityHealthService -StartupType Manual
Set-Service -Name WEPHOSTSVC -StartupType Manual
Set-Service -Name Sense -StartupType Manual
Set-Service -Name TrustedInstaller -StartupType Manual
Set-Service -Name Wcmsvc -StartupType Manual
Set-Service -Name SDRSVC -StartupType Manual
Set-Service -Name Netlogon -StartupType Manual
Set-Service -Name WdNisSvc -StartupType Manual
Set-Service -Name PolicyAgent -StartupType Manual

Set-Service -Name EventLog -StartupType Automatic
Start-Service -Name EventLog

Set-Service -Name mpssvc -StartupType Automatic
Start-Service -Name mpssvc

Set-Service -Name UsoSvc -StartupType Automatic
Start-Service -Name UsoSvc

Set-Service -Name Schedule -StartupType Automatic
Start-Service -Name Schedule

Set-Service -Name sppsvc -StartupType Automatic
Start-Service -Name sppsvc

Set-Service -Name wscsvc -StartupType Automatic
Start-Service -Name wscsvc

Set-Service -Name SamSs -StartupType Automatic
Start-Service -Name SamSs

Set-Service -Name WinDefend -StartupType Automatic
Start-Service -Name WinDefend

Set-Service -Name WdNisDrv -StartupType Automatic
Start-Service -Name WdNisDrv

Set-Service -Name gpsvc -StartupType Automatic
Start-Service -Name gpsvc

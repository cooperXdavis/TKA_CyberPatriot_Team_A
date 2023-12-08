#This script is a combination of everything I (Owen Summers) have done (or found from others) in PowerShell for CyberPatriot

Write-Host "Do not skip past anything without actually doing the action. For example, do not skip past Admin auditing without actually ensuring all admins are correct." -ForegroundColor Red
Write-Host "Press enter when you are ready to start the script..."
Read-Host
Clear-Host
Write-Host " "

########## Authorized Users ##########

mkdir C:\points
New-Item C:\points\users.txt
Write-Host "Copy and paste all users into the file, make sure to get rid of any lines that are not usernames. Also, do not include your user because then auto-login will not work. Press enter to open file, copy and paste users, save and close the file, and then hit enter to continue."
Read-Host
notepad.exe C:\points\users.txt
Read-Host 
Clear-Host

# Specifies the paths to the authorized user files
$authorizedUsersFile = "C:\points\users.txt"

# Read the contents of the authorized user files into arrays
$authorizedUsers = Get-Content $authorizedUsersFile

# Get a list of all users on the system
$allUsers = Get-LocalUser

# Get the current user without the machine name
$me = (whoami).Split("\")[-1]

# These are users to exclude in the unauthorized users
$usersToExclude = @("Administrator", "DefaultAccount", "Guest", "WDAGUtilityAccount")

# Check for unauthorized users
$unauthorizedUsers = $allUsers | Where-Object { $_.Name -notin $authorizedUsers -and $_.Name -notin $usersToExclude -and $_.Name -ne $me }

if ($unauthorizedUsers) {
    Write-Host "Unauthorized users found and deleted:" -ForegroundColor Red
    Write-Host " "
    $unauthorizedUsers | Select-Object -ExpandProperty Name
    Remove-LocalUser $unauthorizedUsers
}
else {
    Write-Host "No unauthorized users found."
}


########## Current Admins ##########

Write-Host " "
Write-Host "Press enter when you are ready to continue onto current admins."
Read-Host

$currentAdmins = Get-LocalGroupMember -Group "Administrators"

Write-Host "Current Administrators:"
Write-Host " "
foreach ($admin in $currentAdmins) {
    Write-Host $admin.Name
}

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
Write-Host " "
Write-Host "Press enter when you are ready to continue onto automatic processes."
Read-Host
Write-Host " "
########## Changing Passwords ##########


# Set the path to the file containing the usernames
$usersFilePath = "C:\points\users.txt"

# Read the usernames from the file
$usernames = Get-Content -Path $usersFilePath
Write-Host "Changing passwords..."
# Loop through each username and change the password
foreach ($username in $usernames) {
    # Change the password using net user command
    net user $username Cyberpatriot23!! | Out-Null

    # Check the success of the password change
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Password changed successfully for user: $username"
    } else {
        Write-Host "Failed to change password for user: $username" -ForegroundColor Red
    }
}
Write-Host " "

########## Setting Passwords to Expire ##########

Write-Host "Setting passwords to expire..."
foreach ($username in $usernames) {
    WMIC USERACCOUNT WHERE "Name='$username'" SET PasswordExpires=TRUE | Out-Null

     if ($LASTEXITCODE -eq 0) {
        Write-Host "Password set to expire changed successfully for user: $username"
    } else {
        Write-Host "Failed to change password to expire for user: $username" -ForegroundColor Red
    }
}
Write-Host " "

########## Ensuring that all accounts are enabled ##########
Write-Host "Ensuring that all accounts are enabled..."
foreach ($username in $usernames) {
    WMIC USERACCOUNT WHERE "Name='$username'" SET Disabled=FALSE | Out-Null

     if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully enabled account for user: $username"
    } else {
        Write-Host "Failed to enable account for user: $username" -ForegroundColor Red
    }
}
Write-Host " "

########## Enabling users to change their password ##########
Write-Host "Enabling users to change their password..."
foreach ($username in $usernames) {
   net user $username /PasswordChg:Yes | Out-Null

     if ($LASTEXITCODE -eq 0) {
        Write-Host "User $username can now change their password."
    } else {
        Write-Host "Failed to enable user $username ability to change their password." -ForegroundColor Red
    }
}
Write-Host " "

########## Firewall ##########
Write-Host "Starting Firewall..."

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Set-NetFirewallProfile -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen True -AllowUnicastResponseToMulticast True  

Write-Host " "
########## Prohibited File Search ##########

Write-Host "Searching file system for prohibited files..."

new-item -path C:\points -name "Prohibited Media Files" -type directory
new-item -path "C:\points\Prohibited Media Files" -name "Files to delete.txt" -type "file"
Get-ChildItem C:\Users\ -force -filter *.mp3 -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.mp4 -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.avi -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.mov -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.jpg -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.gif -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.wav -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.png -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.txt -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\Users\ -force -filter *.exe -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\ -force -filter "*backdoor*" -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\ -force -filter "*malicious*" -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\ -force -filter "*trojan*" -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\ -force -filter "*horse*" -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"
Get-ChildItem C:\ -force -filter "*hack*" -Recurse -ErrorAction SilentlyContinue | Out-File -append "C:\points\Prohibited Media Files\Files to delete.txt"

# Lists users files to find potentially malicous files
New-Item -Path C:\points -name "Users Files" -type File
Get-ChildItem -Path 'C:\Users\*\Desktop\' -Force -Recurse -Exclude "desktop.ini" | Out-File -Append "C:\points\Users Files"
Get-ChildItem -Path 'C:\Users\*\Documents\' -Force -Recurse -Exclude "desktop.ini", "My Music", "My Pictures", "My Videos" -ErrorAction SilentlyContinue | Out-File -Append "C:\points\Users Files"
Get-ChildItem -Path 'C:\Users\*\Downloads\' -Force -Recurse -Exclude "desktop.ini" | Out-File -Append "C:\points\Users Files"
Get-ChildItem -Path 'C:\Users\*\Music\' -Force -Recurse -Exclude "desktop.ini" | Out-File -Append "C:\points\Users Files"
Get-ChildItem -Path 'C:\Users\*\Videos\' -Force -Recurse -Exclude "desktop.ini" | Out-File -Append "C:\points\Users Files"
Get-ChildItem -Path 'C:\Users\*\Pictures\' -Force -Recurse -Exclude "desktop.ini" | Out-File -Append "C:\points\Users Files"
Get-ChildItem -Path 'C:\Users\*\Contacts\' -Force -Recurse -Exclude "desktop.ini" | Out-File -Append "C:\points\Users Files"
Get-ChildItem -Path 'C:\Users\*\Saved Games\' -Force -Recurse -Exclude "desktop.ini" | Out-File -Append "C:\points\Users Files"


########## Finding and Fixing Unquoted Service Paths ##########
#####################################################################################################
## Code Author: Jeff Liford
## Modified by: Seth Feaganes (@Net_Sec_Jedi)
## Original: http://www.ryanandjeffshow.com/blog/2013/04/11/powershell-fixing-unquoted-service-paths-complete/
##
## A powershell script which will search the registry for unquoted service paths and properly quote
## them. If run in a powershell window exclusively, this script will produce no output other than
## a line with "The operation completed successfully" when it fixes a bad key. Verbose output can
## be enabled by uncommenting the Write-Progress or Write-Output lines OR running the original scripts
## as intended with command pipes.
##
## This script was modified from the original three scripts named Get-SVCPath.ps1, Find-BADSVCPath.ps1,
## and Fix-BADSVCPath.ps1 to allow it to be run as a single script on one system or for use in mass
## deployment systems such as PDQDeploy, KACE, etc for example. If you require the functionality of those
## scripts for auditing, execution over multiple systems, or any other options those scripts provide, please
## use those scripts instead. I am posting this modification as reference to something useful in situations
## where a quick fix is necessary. 
##
## Myself nor the original author of this code cannot be held liable for any damage incurred running
## this in a production environment. Please take proper precautions before modifying the registry
## such as running this script with the REG ADD line commented out or taking a backup of the registry
## prior to running the script. Or obviously on virtual environments, etc.
#####################################################################################################

# Add a comment from VSCode for fun :-D

## Grab all the registry keys pertinent to services
$result = Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services'
$ServiceItems = $result | Foreach-Object {Get-ItemProperty $_.PsPath}

# Iterate through the keys and check for Unquoted ImagePath's
ForEach ($si in $ServiceItems) {
	if ($si.ImagePath -ne $nul) { 
		$obj = New-Object -Typename PSObject
		$obj | Add-Member -MemberType NoteProperty -Name Status -Value "Retrieved"
		# There is certianly a way to use the full path here but for now I trim it until I can find time to play with it
        	$obj | Add-Member -MemberType NoteProperty -Name Key -Value $si.PSPath.TrimStart("Microsoft.PowerShell.Core\Registry::")
        	$obj | Add-Member -MemberType NoteProperty -Name ImagePath -Value $si.ImagePath
		
		########################################################################
    		# Find and Fix Bad Keys for each key object
    		########################################################################
		
		#We're looking for keys with spaces in the path and unquoted
		$examine = $obj.ImagePath
		if (!($examine.StartsWith('"'))) { #Doesn't start with a quote
			if (!($examine.StartsWith("\??"))) { #Some MS Services start with this but don't appear vulnerable
				if ($examine.contains(" ")) { #If contains space
					#when I get here, I can either have a good path with arguments, or a bad path
					if ($examine.contains("-") -or $examine.contains("/")) { #found arguments, might still be bad
						#split out arguments
						$split = $examine -split " -", 0, "simplematch"
						$split = $split[0] -split " /", 0, "simplematch"
						$newpath = $split[0].Trim(" ") #Path minus flagged args
						if ($newpath.contains(" ")){
							#check for unflagged argument
							$eval = $newpath -Replace '".*"', '' #drop all quoted arguments
							$detunflagged = $eval -split "\", 0, "simplematch" #split on foler delim
							if ($detunflagged[-1].contains(" ")){ #last elem is executable and any unquoted args
								$fixarg = $detunflagged[-1] -split " ", 0, "simplematch" #split out args
								$quoteexe = $fixarg[0] + '"' #quote that EXE and insert it back
								$examine = $examine.Replace($fixarg[0], $quoteexe)
								$examine = $examine.Replace($examine, '"' + $examine)
								$badpath = $true
							} #end detect unflagged
							$examine = $examine.Replace($newpath, '"' + $newpath + '"')
							$badpath = $true
						} #end if newpath
						else { #if newpath doesn't have spaces, it was just the argument tripping the check
							$badpath = $false
						} #end else
					} #end if parameter
					else
					{#check for unflagged argument
						$eval = $examine -Replace '".*"', '' #drop all quoted arguments
						$detunflagged = $eval -split "\", 0, "simplematch"
						if ($detunflagged[-1].contains(" ")){
							$fixarg = $detunflagged[-1] -split " ", 0, "simplematch"
							$quoteexe = $fixarg[0] + '"'
							$examine = $examine.Replace($fixarg[0], $quoteexe)
							$examine = $examine.Replace($examine, '"' + $examine)
							$badpath = $true
						} #end detect unflagged
						else
						{#just a bad path
							#surround path in quotes
							$examine = $examine.replace($examine, '"' + $examine + '"')
							$badpath = $true
						}#end else
					}#end else
				}#end if contains space
				else { $badpath = $false }
			} #end if starts with \??
			else { $badpath = $false }
		} #end if startswith quote
		else { $badpath = $false }

		#Update Objects
		if ($badpath -eq $false){
			$obj | Add-Member -MemberType NoteProperty -Name BadKey -Value "No"
			$obj | Add-Member -MemberType NoteProperty -Name FixedKey -Value "N/A"
			$obj = $nul #clear $obj
		}
			
		# Plans to change this check. I believe it can be done more efficiently. But It works for now!
		if ($badpath -eq $true){
			$obj | Add-Member -MemberType NoteProperty -Name BadKey -Value "Yes"
			#sometimes we catch doublequotes
			if ($examine.endswith('""')){ $examine = $examine.replace('""','"') }
			$obj | Add-Member -MemberType NoteProperty -Name FixedKey -Value $examine
			if ($obj.badkey -eq "Yes"){
				#Write-Progress -Activity "Fixing $($obj.key)" -Status "Working..."
				$regpath = $obj.Fixedkey
				$obj.status = "Fixed"
	        		$regkey = $obj.key.replace('HKEY_LOCAL_MACHINE', 'HKLM:')
	        		# Comment the next line out to run without modifying the registry
				# Alternatively uncomment any line with Write-Output or Write-Object for extra verbosity.
				Set-ItemProperty -Path $regkey -name 'ImagePath' -value $regpath
			}				
		$obj = $nul #clear $obj
		}
	}
}	
########## End of Finding and Fixing Unquoted Service Paths ##########

########## Password Policies ##########

net accounts /minpwlen:14
if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully set minimum password length to 14
    "
    }

net accounts /maxpwage:30
if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully set maximum password age to 30
    "
    }

net accounts /minpwage:14
if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully set minimum passowrd age to 14
    "
    }

net accounts /uniquepw:15
if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully set number of passwords remembered to 15
    "
    }

net accounts /forcelogoff:5
if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully set machine to logoff after 5 minutes of inactivity
    "
    }

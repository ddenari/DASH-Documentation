#!/bin/sh


# Check parameters in case of typos on a manual run
declare -a param1=("admincomputer" "advisorcomputer" "bonnerlabcomputer" "presentation" "consultingcomputer" "dashlabcomputer" "facultystaffcomputer" "labcomputer")
declare -a param2=("shared" "notshared")
declare -a param3=("student" "nostudent")
declare -a param4=("backup" "nobackup")

if [[ ! " ${param1[@]} " =~ " $1 " ]]
then
  if [[ " ${param2[@]} " =~ " $1 " ]]
  then
    echo "*****MERGED RESTORE FAILURE*****
Error: No manifest argument
Quitting merged restore run..."
    exit 1
  else
    echo "*****MERGED RESTORE FAILURE*****
Error: Invalid manifest: $1
Quitting merged restore run..."
    exit 1
  fi
fi

if [[ ! " ${param2[@]} " =~ " $2 " ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Invalid shared status: $2
Quitting merged restore run..."
  exit 1
fi

if [[ ! " ${param3[@]} " =~ " $3 " ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Invalid AD login restriction: $3
Quitting merged restore run..."
  exit 1
fi

if [[ ! " ${param4[@]} " =~ " $4 " ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Invalid backup status: $4
Quitting merged restore run..."
  exit 1
fi

# Set interpreter and various constants
kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
systemsetup="/usr/sbin/systemsetup"
networksetup="/usr/sbin/networksetup"
defaults="/usr/bin/defaults"
airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
hcstorage="http://hc-storage.cougarnet.uh.edu"

# Turn off AirPort. This makes sure that all network communications run through the Ethernet port. Wi-Fi interferes with Cougarnet access. It also required an administrator password to turn Wi-Fi on.
function turnOffAirport {
  $networksetup -detectnewhardware
  echo "Turning off airport..."
  $networksetup -setairportpower en1 off
  $airport en1 prefs RequireAdminPowerToggle=YES
  $systemsetup -setwakeonnetworkaccess on
}

# Turn on SSH. This allows remote access through the command line.
function turnOnSSH {
  echo "Turning on ssh..."
  $systemsetup -setremotelogin on
}

# Turn on Remote Desktop. This allows Remote Access through Apple Remote Desktop.
function turnOnRemoteDesktop {
  echo "Turning on RemoteManagement..."
  $kickstart -activate -configure -allowAccessFor -specifiedUsers -configure -users hcadmin -access -on
  $kickstart -configure -users hcadmin -privs -all -restart -agent
}

# Get ManagedInstalls.plist. This uses the first parameter to get the correct list of software to for the computer (munki will process the lists later).
function getManagedInstallsPlist {
  echo "Getting ManagedInstalls.plist..."
  if [ "$1" == "facultystaffcomputer" ]
  then
    /usr/bin/curl -s --show-error $hcstorage/managedinstalls/facultystaff_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "presentation" ]
  then
    /usr/bin/curl -s --show-error $hcstorage/managedinstalls/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "consultingcomputer" ]
  then
    /usr/bin/curl -s --show-error $hcstorage/managedinstalls/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "advisorcomputer" ]
  then
    /usr/bin/curl -s --show-error $hcstorage/managedinstalls/advisor_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "labcomputer" ]
  then
    /usr/bin/curl -s --show-error $hcstorage/managedinstalls/lab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "dashlabcomputer" ]
  then
    /usr/bin/curl -s --show-error $hcstorage/managedinstalls/dashlab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "bonnerlabcomputer" ]
  then
    /usr/bin/curl -s --show-error $hcstorage/managedinstalls/bonnerlab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "admincomputer" ]
  then
    /usr/bin/curl -s --show-error $hcstorage/managedinstalls/admin_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  else
    echo "*********MERGED RESTORE FAILURE*********
****************************************
Error: Can't load ManagedInstalls.plist.
    Check connection to hc-storage.
****************************************"
  fi

  if [ ! -d "/usr/local/honors" ]
  then
    mkdir /usr/local/honors
    echo "Creating /usr/local/honors..."
  else
    echo "/usr/local/honors exists"
  fi
echo "Changing permissions for /usr/local/honors..."
chmod 755 /usr/local/honors
chown root:wheel /usr/local/honors
}

# Enable the Guest Account
function enableGuestAccount {
  echo "Enabling Guest account..."
  $defaults write /Library/Preferences/com.apple.loginwindow.plist GuestEnabled -bool YES
}

# Install PaperCut LaunchAgent. This installs a script that keeps PaperCut constantly open.
function getPaperCutLaunchAgent {
  echo "Getting PaperCut login script..."
  /usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.papercut.plist -o "/Library/LaunchAgents/edu.uh.honors.papercut.plist"
  /bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.papercut.plist
}

# Install Default Lab Printer LaunchAgent. This installs a script that sets the default printer for lab computers.
function getLabPrinterLaunchAgent {
  echo "Installing Default Lab Printer script..."
  /usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.labprinters.plist -o "/Library/LaunchAgents/edu.uh.honors.labprinters.plist"
  /bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.labprinters.plist

  /usr/bin/curl -s --show-error $hcstorage/scripts/set_default_printer.sh -o "/usr/local/honors/set_default_printer.sh" --create-dirs
  /bin/chmod +x /usr/local/honors/set_default_printer.sh
}

# Uninstall PaperCut LaunchAgent. This uninstalls the script that keeps PaperCut constantly open, if it exists
function uninstallPaperCutLaunchAgent {
  echo "Uninstalling Papercut login script..."
  rm -f /Library/LaunchAgents/edu.uh.honors.papercut.plist
}

# Uninstall Default Lab Printer LaunchAgent. This uninstalls a script that sets the default printer for lab computers, if it exists
function uninstallLabPrinterLaunchAgent {
  echo "Uninstalling Default Lab Printer script..."
  rm -f /usr/local/honors/set_default_printer.sh
  rm -f /Library/LaunchAgents/edu.uh.honors.labprinters.plist
}

# Setting Guest account to automatically login after the computer started.
function setAutomaticGuestLogin {
  echo "Setting guest to automatic login..."
  $defaults write /Library/Preferences/com.apple.loginwindow.plist autoLoginUser guest
}

# Disable automatic login of Guest account, in case it is enabled
function disableAutomaticGuestLogin {
  echo "Disabling automatic guest login..."
  $defaults delete /Library/Preferences/com.apple.loginwindow.plist autoLoginUser
}

# Install Screen Lock LaunchAgent. This installs a script on shared computers to disable the screen lock.
function getScreenLockLaunchAgent {
  echo "Installing script to disable screen lock..."
  rm -f /usr/local/honors/enable_screen_lock.sh
  rm -f /Library/LaunchAgents/edu.uh.honors.enablescreenlock.plist

  /usr/bin/curl -s --show-error $hcstorage/scripts/disable_screen_lock.sh -o "/usr/local/honors/disable_screen_lock.sh" --create-dirs
  /bin/chmod +x /usr/local/honors/disable_screen_lock.sh

  /usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.disablescreenlock.plist -o "/Library/LaunchAgents/edu.uh.honors.disablescreenlock.plist"
  /bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.disablescreenlock.plist
}

# Uninstall Screen Lock LaunchAgent. This uninstalls the script on nonshared computers to disable the screen lock, if it exists
function uninstallScreenLockLaunchAgent {
  echo "Uninstalling script that disables screen lock..."
  rm -f /usr/local/honors/disable_screen_lock.sh
  rm -f /Library/LaunchAgents/edu.uh.honors.disablescreenlock.plist

  /usr/bin/curl -s --show-error $hcstorage/scripts/enable_screen_lock.sh -o "/usr/local/honors/enable_screen_lock.sh" --create-dirs
  /bin/chmod +x /usr/local/honors/enable_screen_lock.sh

  /usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.enablescreenlock.plist -o "/Library/LaunchAgents/edu.uh.honors.enablescreenlock.plist"
  /bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.enablescreenlock.plist
}

# Install Keychain Reset LaunchDaemon. This installs a script that resets the keychain nightly (useful on shared computers).
function getKeychainResetLaunchDaemon {
  echo "Getting Keychain Fix Script..."
  /usr/bin/curl -s --show-error $hcstorage/scripts/reset_keychains.sh -o "/usr/local/honors/reset_keychains.sh" --create-dirs
  /bin/chmod +x /usr/local/honors/reset_keychains.sh

  /usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.resetkeychains.plist -o "/Library/LaunchDaemons/edu.uh.honors.resetkeychains.plist"
  /bin/chmod 644 /Library/LaunchDaemons/edu.uh.honors.resetkeychains.plist
}

# Uninstall Keychain Reset LaunchDaemon. This uninstalls the script that resets the keychain nightly.
function uninstallKeychainResetLaunchDaemon {
  echo "Uninstalling Keychain Fix Script..."
  rm -f /usr/local/honors/reset_keychains.sh
  rm -f /Library/LaunchDaemons/edu.uh.honors.resetkeychains.plist
}


# Restrict the AD logins to certain Groups (we are using HC Admins, HC Autheticated Users & HC Students)
function restrictActiveDirectoryLogins {
  echo "Restricting Active Directory logins..."
  /usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts
  /usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts Password "*"
  /usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts RealName "Login Window's custom net accounts"
  /usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts PrimaryGroupID 206

  /usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Admins -t group com.apple.loginwindow.netaccounts
  /usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Authenticated\ Users -t group com.apple.loginwindow.netaccounts

  if [ "$1" == "student" ]
  then
    echo "Adding students to allowed user list..."
    /usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Students -t group com.apple.loginwindow.netaccounts
  fi

  if [ "$1" == "nostudent" ]
  then
    echo "Ensuring students are not on allowed user list..."
    /usr/sbin/dseditgroup -o edit -n /Local/Default -d HC\ Students -t group com.apple.loginwindow.netaccounts
  fi

  /usr/bin/dscl . -create /Groups/com.apple.access_loginwindow
  /usr/bin/dscl . -create /Groups/com.apple.access_loginwindow Password "*"
  /usr/bin/dscl . -create /Groups/com.apple.access_loginwindow PrimaryGroupID 223
  /usr/bin/dscl . -create /Groups/com.apple.access_loginwindow RealName "Login Window ACL"

  /usr/sbin/dseditgroup -o edit -n /Local/Default -a localaccounts -t group com.apple.access_loginwindow
  /usr/sbin/dseditgroup -o edit -n /Local/Default -a com.apple.loginwindow.netaccounts -t group com.apple.access_loginwindow
}

# Install Backup LaunchDaemon. This installs the backup script and schedules regular backups.
function getBackupLaunchDaemon {
  echo "Getting Backup Script..."
  /usr/bin/curl -s --show-error $hcstorage/scripts/backup.sh -o "/usr/local/honors/backup.sh" --create-dirs
  /bin/chmod +x /usr/local/honors/backup.sh

  /usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.backup.plist -o "/Library/LaunchDaemons/edu.uh.honors.backup.plist"
  /bin/chmod 644 /Library/LaunchDaemons/edu.uh.honors.backup.plist
}

# Uninstall Backup LaunchDaemon. This deletes the backup script.
function uninstallBackupLaunchDaemon {
  rm -f /usr/local/honors/backup.sh
  rm -f /Library/LaunchDaemons/edu.uh.honors.backup.plist
}

# Install Office Setup LaunchAgent. This installs a script that suppresses the Office Setup screen when a user logs into a computer.
function getOfficeSetupLaunchAgent {
  echo "Getting Office setup script..."
  /usr/bin/curl -s --show-error $hcstorage/scripts/curl_office_plists.sh -o "/usr/local/honors/curl_office_plists.sh" --create-dirs
  /bin/chmod +x /usr/local/honors/curl_office_plists.sh

  echo "Getting Office preferences login script..."
  /usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.curlofficeprefs.plist -o "/Library/LaunchAgents/edu.uh.honors.curlofficeprefs.plist"
  /bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.curlofficeprefs.plist
}

# Disable System Sleep
function disableSystemSleep {
  echo "Disabling system sleep..."
  /usr/bin/pmset sleep 0
}

# Disable save Window state at logout
function disableSaveWindowState {
  echo "Disable the save window state at logout..."
  $defaults write com.apple.loginwindow.plist 'TALLogoutSavesState' -bool false
}

# Disable Automatic Software Updates. We are using Munki to handle this.
function disableAutomaticSoftwareUpdates {
  echo "Disabling Software Update Automatic Checks"
  softwareupdate --schedule off
}

# Disable Gatekeeper. Gatekeeper helps to protect your Mac from malware and misbehaving apps downloaded from the Internet. But disable it in order for our scripts to run.
function disableGatekeeper {
  echo "Disabling Gatekeeper..."
  spctl --master-disable
}

# Show username & password fields in Login Window instead of circles.
function enableUsernameAndPasswordFields {
  echo "Enabling username and password fields..."
  $defaults write /Library/Preferences/com.apple.loginwindow.plist SHOWFULLNAME -bool TRUE
}

# Munki in Bootstrap mode. Used with DeployStudio workflows. When DeployStudio reboots the machine again, Munki will run on the second reboot.
function bootstrapMunki {
  echo "Setting munki to bootstrap mode..."
  touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup
}

# Add "Important CougarNet Information" dialog box to the lock screen
function policyBanner {
  echo "Downloading policyBanner..."
  /usr/bin/curl -s --show-error $hcstorage/scripts/PolicyBanner.rtf -o "/Library/Security/PolicyBanner.rtf"
}

# If this is a Sierra or High Sierra machine we need to suppress the setup of Siri and a couple other things for first time logins
function highSierraSiriSuppression {
os_vers="$(sw_vers -productVersion | awk -F. '{print $2}')"
  if [ $os_vers == 12 ] || [ $os_vers == 13 ]
  then
    echo "Downloading Siri suppression script..."
    /usr/bin/curl -s --show-error $hcstorage/scripts/sierra_suppressions.sh -o "/usr/local/honors/sierra_suppressions.sh" --create-dirs
    echo "Running Siri suppression script..."
    /bin/bash /usr/local/honors/sierra_suppressions.sh
    echo "Removing Siri suppression script..."
    /bin/rm /usr/local/honors/sierra_suppressions.sh
  fi
}

# Run the functions that are generic to all workflows & setups.
echo "Running merged_restore.sh script..."
turnOffAirport
turnOnSSH
turnOnRemoteDesktop
getManagedInstallsPlist $1
enableGuestAccount

# Enable persistent PaperCut on lab computers
if [ "$1" == "labcomputer" ]
then
  getPaperCutLaunchAgent
  getLabPrinterLaunchAgent
else
  uninstallPaperCutLaunchAgent
  uninstallLabPrinterLaunchAgent
fi

# Automatic guest login on classroom and podium computers
if [ "$1" == "presentation" ]
then
  setAutomaticGuestLogin
else
  disableAutomaticGuestLogin
fi

# If computer is shared, we want keychains to reset, and to not lock the screen
if [ "$2" == "shared" ]
then
  getScreenLockLaunchAgent
  getKeychainResetLaunchDaemon
else
  uninstallScreenLockLaunchAgent
  uninstallKeychainResetLaunchDaemon
fi

# If students are logging in, this can't be an employee computer. Therefore, if not a student, run all other actions.
if [ "$3" == "student" ]
then
  restrictActiveDirectoryLogins student
else
  restrictActiveDirectoryLogins nostudent
fi

if [ "$4" = "backup" ]
then
  getBackupLaunchDaemon
else
  uninstallBackupLaunchDaemon
fi

# Run actions common to all systems
getOfficeSetupLaunchAgent
disableSystemSleep
disableSaveWindowState
disableAutomaticSoftwareUpdates
disableGatekeeper
enableUsernameAndPasswordFields
policyBanner
bootstrapMunki

# Suppress Siri setup for new users on 10.13 users
highSierraSiriSuppression $2

echo "Done."

sleep 15

exit 0

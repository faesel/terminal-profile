# INSTALL (run these in powershell)
#Install-Module -Name BurntToast 
#Install-Module -Name ColoredText 
#Install-Module -Name Tree (this has another dependency here: http://gnuwin32.sourceforge.net/packages/tree.htm)
#Install-Module -Name Terminal-Icons
#Install-Module -Name WifiTools

# THEMES
Set-Theme Paradox

# IMPORTS
Import-Module -Name Terminal-Icons

# IMPORT CUSTOM FILES
. "C:\Users\faese\Documents\WindowsPowerShell\Custom\BurntToast.ps1"

# SHORTCUTS
function se {
    Get-ChildItem | Format-Wide
}

function treels {
    Get-ChildItemTree . -I 'node_modules|bin|obj|.git|.vs'
}

function treef ([string] $pattern) {
    Get-ChildItemTree . -P $pattern -I 'node_modules|bin|obj|.git|.vs'
}

function cc {
    cd C:\code 
    se
}

function ccp { 
    cd C:\code\Plum
    se
}

function ccf {
    cd c:\code\faesel
    se
}

function newb([string]$branchName){
    git br $branchName
    git co $branchName

    $message = "Finished creating branch: " + $branchName

    cprint black $message on rainbow print
}

function publish {
    $branchName = git brn
    git publish $branchName

    $message = "Finished publishing branch: " + $branchName

    cprint black $message on rainbow print
}

function clonem([string] $url) {
    git clone $url
    New-BurntToastNotification -AppLogo 'C:\Icons\completed.png' -Text "Finished!", 'Finished cloning repo'
}

function reminder([int]$minuites, [string]$text) {
    New-ToastReminder -AppLogo 'C:\Icons\reminder.png' -Minutes $minuites -ReminderTitle 'Reminder Reminder!' -ReminderText $text
}
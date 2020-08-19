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

function dockerremove() {
    docker rm @(docker ps -a -q)

    cprint black "Finished cleaning docker containers" on rainbow print
}

function dockerstop() {
    docker stop @(docker ps -a -q)

    cprint black "Finished stopping docker containers" on rainbow print
}

function portainer() {
    docker pull portainer/portainer
    docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

    cprint black "Now listening on http://localhost:9000/" on rainbow print
}

function sqlserver() {
    docker run --name 'sqlserver' -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=yourStrong(!)Password' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-CU8-ubuntu
}

function gitm() {
    git co master
    git up

    cprint black "Finished updating master" on rainbow print
}

function editprofile() {
    $profilePath = $PROFILE
    $message = "Editing profile: " + $profilePath

    cprint black $message on rainbow print

    code $profilePath
}

function view([string] $filename) {
    Get-Content -Path .\$filename
}

function view_small([string] $filename) {
    Get-Content -Path .\$filename -TotalCount 20
}

function view_last([string] $filename) {
    Get-Item -Path .\$filename | Get-Content -Tail 20
}
# INSTALL (run these in powershell)
#Install-Module -Name BurntToast 
#Install-Module -Name ColoredText 
#Install-Module -Name Tree (this has another dependency here: http://gnuwin32.sourceforge.net/packages/tree.htm)
#Install-Module -Name Terminal-Icons
#Install-Module -Name WifiTools

# THEMES
Set-PoshPrompt -Theme agnoster

# IMPORTS
Import-Module -Name Terminal-Icons


# IMPORT CUSTOM FILES
. "C:\Users\faese\Documents\WindowsPowerShell\Custom\BurntToast.ps1"

# GLOCAL VARIABLES
$NEWLINE = "`r`n"

# ALIAS
Set-Alias -Name k -Value kubectl
Set-Alias -Name g -Value git

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
    gitplum
    se
}

function ccp { 
    cd C:\code\Plum
    gitplum
    se
}

function ccf {
    cd c:\code\faesel
    gitpersonal
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

function editfile([string] $filename) {
    $command = "nano " + $filename
    bash -c $command
}

function gitpersonal() {
    git config --global user.name "Faesel Saeed"
    git config --global user.email "faesel@gmail.com"

    cprint black "Now using faesel@gmail.com" on rainbow print
}

function localk8() {
    kubectl config use-context docker-desktop
}

function gitprune() {
    $branches = git br | Sort-Object
    Foreach ($branch in $branches)
    {
        $branch = $branch.trimstart('*');
        $branch = $branch.trimstart();

        if ($branch.ToString() -in "master", "QA", "working", "main")
        {            
            $bm = 'Keeping => ' + $branch + $NEWLINE
            cprint green $bm on black print
        }
        else 
        {
            git brd $branch -D

            $bm = 'Deleting => ' + $branch + $NEWLINE
            cprint red $bm on black print
        }
    }
}

function help() {
    Write-Output "--------------"
    Write-Output "NAVIGATION";
    Write-Output "--------------"
    Write-Output "se - View all files in the current directory";
    Write-Output "treels - View all files in the current directory as a tree";
    Write-Output "treef - Search for a file in the tree";
    Write-Output "cc - navigate to code folder";
    Write-Output "ccf - navigate to personal code folder";

    Write-Output "--------------"
    Write-Output "GIT";
    Write-Output "--------------"
    Write-Output "newb - Create a new branch, checkout and track";
    Write-Output "publish - Publish branch";
    Write-Output "clonem - Clone branch and toast notify";
    Write-Output "gitm - Checkout master and get latest code";
    
    Write-Output "--------------"
    Write-Output "FILES";
    Write-Output "--------------"
    Write-Output "view - View contents of a file";
    Write-Output "view_small - View the first 20 lines of a file";
    Write-Output "view_last - View the last 20 lines of a file";
    
    Write-Output "--------------"
    Write-Output "DOCKER";
    Write-Output "--------------"
    Write-Output "dockerremove - remove all containers";
    Write-Output "dockerstop - stop all containers";
    Write-Output "portainer - spin up portainer in an container";
    Write-Output "sqlserver - spin up sqlserver in a container";
    
    Write-Output "--------------"
    Write-Output "UTILITIES";
    Write-Output "--------------"
    Write-Output "reminder - Create a reminder usage for 1 minuite: reminder 1 this is the reminder";
    Write-Output "editprofile - Edit the powershell profile";
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

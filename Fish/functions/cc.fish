function cc
    cd ~/code/
end

function ccf
    cd ~/code/faesel
end

function ccp
    cd ~/code/faesel
end

function cct
    cd ~/code/faesel
end

function newb
    git br $argv
    git co $argv

    echo 'Finished creating branch ' + $argv
end

function editconfig --description="Edit the config file"
    code ~/.config/fish
end

function editgitconfig --description="Edit the git config file"
    code ~/.gitconfig
end

function publish
    git publish (git brn)
end

function gitplum
    git config --global user.name "Faesel Saeed"
    git config --global user.email "faesel.saeed@plumguide.com"
end

function gitpersonal
    git config --global user.name "Faesel Saeed"
    git config --global user.email "faesel@gmail.com"
end

function gitm
    git co master
    git up
end

function updateall
    echo '|||||||||||||||| Starting apt ||||||||||||||||'
    sudo apt update && sudo apt upgrade
    
    echo '|||||||||||||||| Updating snap ||||||||||||||||'
    sudo snap refresh

    echo '|||||||||||||||| Updating flatpak ||||||||||||||||'
    sudo flatpak update

    echo '|||||||||||||||| Updating apt-get ||||||||||||||||'
    sudo apt-get update
    sudo apt-get upgrade

    sudo apt-get dist-upgrade
end
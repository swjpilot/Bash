#!/bin/bash
firefox -CreateProfile "$1"
cd .icons
wget -O $1.png $2/favicon.ico
sudo touch "/usr/share/applications/$1.desktop"
echo "[Desktop Entry]
Version=1.0
Type=Application
Exec=firefox -p $1 -url=$2
Name=$1
Icon=$HOME/.icons/$1.png
Categories=Network"  | sudo tee -a "/usr/share/applications/$1.desktop"
cd $HOME/.mozilla/firefox/"$(grep 'Path=' ~/.mozilla/firefox/profiles.ini | sed s/^Path=// | grep "$1")"
touch user.js
echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);'>> user.js
mkdir chrome
cd chrome 
touch userChrome.css
echo '
@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");
#TabsToolbar {visibility: collapse;}
#navigator-toolbox {visibility: collapse;}
browser {margin-right: -14px; margin-bottom: -14px;}' >> userChrome.css

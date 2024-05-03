#!/bin/bash
function print_usage()
{
  printf "-i   icon file location (Optional)"
  printf "-w   Website to use"
  printf "-n   Application Title"
  printf "-p   Path to Install to"
  printf "-h   Help"
  printf "Example: ./createapp.sh -w https://github.com/ -n Github"
  exit 1
}

args=()
while getopts 'iw:n:ph' flag; do
  case "${flag}" in
    i) icon="$OPTARG" ;;
    w) website="$OPTARG" ;;
    n) appname="$OPTARG" ;;
    p) installpath="$OPTARG" ;;
    h) print_usage
       exit 0 ;;
    *) print_usage 
       exit 1 ;;
  esac
done

if [ -z "$website" ] && [ -z "$icon" ] && [ -z "$appname" ] && [ -z "$installpath" ]; then
    pushd /tmp
    nativefier --name ${$appname | sed -e 's/ //g'} --browserwindow-options ""{ "darkTheme": "true", "partition": "persist": "${$appname | sed -e 's/ //g'}", "tabbingIdentifier": "${$appname | sed -e 's/ //g'}", "titleBarOverlay": "true", "webPrefrences": ""{ "experimentalFeatures": "true",  "plugins": "true", "nodeIntegration": "true", "nodeIntegrationInWorker": "true", "nodeIntegrationInSubFrames": "true"  }""  }"" --portable "true" --icon $icon --internal-urls ".*?" "$website"
    sudo mv ${$appname | sed -e 's/ //g'}* $installpath/${$appname | s}e"d -e 's/ //g'}
    sudo chown -R $(whoami):$(whoami) $installpath/$($appname | sed -e 's/ //g')
    mv "$installpath/${$appname | sed -e 's/ //g'}/${$appname | sed -e 's/ //g'}*" $installpath/${$appname | sed -e 's/ //g')/${$appname | sed -e 's/ //g'}
elif [ -z "$website" ] && [ ! -z "$icon" ] && [ -z "$appname" ] && [ -z "$installpath" ]; then
    pushd /tmp
    nativefier --name ${$appname | sed -e 's/ //g'} --browserwindow-options ""{ "darkTheme": "true", "partition": "persist": "${$appname | sed -e 's/ //g'}", "tabbingIdentifier": "${$appname | sed -e 's/ //g'}", "titleBarOverlay": "true", "webPrefrences": ""{ "experimentalFeatures": "true",  "plugins": "true", "nodeIntegration": "true", "nodeIntegrationInWorker": "true", "nodeIntegrationInSubFrames": "true"  }""  }"" --portable "true" --internal-urls ".*?" "$website"
    sudo mv "$($appname | sed -e 's/ //g')*" "$installpath/$($appname | sed -e 's/ //g')"
    sudo chown -R $(whoami):$(whoami) "$installpath/$($appname | sed -e 's/ //g')"
    mv "$installpath/$($appname | sed -e 's/ //g')/$($appname | sed -e 's/ //g')*" $installpath/$($appname | sed -e 's/ //g')/$($appname | sed -e 's/ //g')
fi
cat << EOF > "/home/$(whoami)/.local/share/applications/$($appname | sed -e 's/ //g').desktop"
[Desktop Entry]
Name=$appname
Comment=$appname
Terminal=false
GenericName=$appname
Exec=$installpath/$($appname | sed -e 's/ //g')/$($appname | sed -e 's/ //g')
Icon=$installpath/$($appname | sed -e 's/ //g')/resources/app/icon.png
Type=Application
StartupNotify=true
StartupWMClass=$($appname | sed -e 's/ //g')
Categories=Internet
EOF
popd
exit 0
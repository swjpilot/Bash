#!/bin/bash
while getopts 'mtlwoga' flag; do
  case "${flag}" in
    m) loc='missy' ;;
    t) loc='theo' ;;
    l) loc='linux'  ;;
    w) loc='windows' ;;
    o) loc='theo-win' ;;
    g) loc='missy-win' ;;
    a) loc='all-sys' ;;
    *) print_usage
       exit 1 ;;
  esac
done
setting=${@:$OPTIND:1}
if test ${setting:0:1} = "/"; then
    ap='true'
fi
if [[ -d $setting && "$ap" = "true" ]]; then
    apath=${setting%/*}
elif [[ -d $setting && ! "$ap" = "true" ]]; then
    apath=$(pwd)/${setting%/*}
elif [[ -f $setting && "$ap" = "true" ]]; then
    apath=${setting%/*}
    file=$(echo $setting | rev | cut -d"/" -f1 | rev)
elif [[ -f $setting && ! "$ap" = "true" ]]; then
    apath=$(pwd)/${setting%/*}
    file=$(echo $setting | rev | cut -d "/" -f1 | rev)
else
    echo "Invalid path" 
    print_usage
    exit 1
fi
if [[ ! "$(echo $apath | rev | cut -c 1)" = "/" ]]; then
    apath="$apath/"
fi
user=$(whoami)
if [ ! -d "$HOME/Nextcloud/Settings/$loc$apath" ];
then
    mkdir -p $HOME/Nextcloud/Settings/$loc$apath
    printf "Making Directory:  $HOME/Nextcloud/Settings/$loc$apath\n"
fi
sudo cp -r $apath$file $HOME/Nextcloud/Settings/$loc$apath$file
sudo chown -R $user:$user $HOME/Nextcloud/Settings/$loc$apath$file
printf "Backed up setting:  $HOME/Nextcloud/Settings/$loc$apath$file\n"
printf "$setting setting has been backed up\n"

print_usage() {
  printf "-m   Send Setting to Missy Linux"
  printf "-t   Send Setting to Theo Linux"
  printf "-l   Send Setting to Both Linux Systems"
  printf "-w   Send Setting to Both Windows Systems"
  printf "-o   Send Setting to Missy Windows"
  printf "-g   Send Setting to Theo Windows"
  printf "-a   Send Setting to All Systems"
}

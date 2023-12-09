#!/bin/bash
declare -a args()
while getopts 'mtlwoga' flag; do
  case "${flag}" in
    m) args+="missy" ;;
    t) args+="theo" ;;
    l) args+="linux" ;;
    w) args+="windows" ;;
    o) args+="theo-win" ;;
    g) args+="missy-win" ;;
    a) args+="all-sys" ;;
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
for dir in \
        "$HOME/Nextcloud/Settings/missy" \
        "$HOME/Nextcloud/Settings/theo" \
        "$HOME/Nextcloud/Settings/linux" \
        "$HOME/Nextcloud/Settings/theo" \
        "$HOME/Nextcloud/Settings/windows" \
        "$HOME/Nextcloud/Settings/theo-win" \
        "$HOME/Nextcloud/Settings/missy-win" \
        "$HOME/Nextcloud/Settings/all-sys" 
do
    found="false"
    args=""
    if [ -d $dir$apath ]; then
        case $(echo $dir | rev | cut -d "/" -f1 | rev) in
            missy) read -p "Settings found already for missy would you like to use those settings? (Y)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; args+="missy"; found="true" ||  ;;
            theo) read -p "Settings found already for theo would you like to use those settings? (Y)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; args+="theo"; found="true" ||  ;;
            linux) read -p "Settings found already for linux would you like to use those settings? (Y)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; args+="linux"; found="true" ||  ;;
            windows) read -p "Settings found already for windows would you like to use those settings? (Y)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; args+="windows"; found="true" ||  ;;
            theo-win) read -p "Settings found already for theo windows would you like to use those settings? (Y)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; args+="theo-win"; found="true" ||  ;;
            missy-win) read -p "Settings found already for missy windows would you like to use those settings? (Y)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; args+="missy-win"; found="true" ||  ;;
            all-sys) read -p "Settings found already for all systems would you like to use those settings? (Y)" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; args+="all-sys"; found="true" ||  ;;
        esac
done
if [[ "$found" = "true" ]]; then
    printf "Multiple Settings folders have been found for that location which one do you want to link to?"
    for i in "${!args[@]}"
    do
        echo "$i" "${args[$i]}"
    done
    read -p "Settings found already for missy windows would you like to use those settings? (Y)" choice
    loc=${args[$choice]}
    if [ -L $apath$file ];
    then
        printf "The Requested directory is already symlinked\n"
        printf "$(ls-lah $apath$afile)"
        exit 1
    fi
    sudo rm -rf $apath$file
    sudo ln -s $HOME/Nextcloud/Settings/$loc$apath$file $apath$file
    sudo chown -R $user:$user $HOME/Nextcloud/Settings/$loc$apath$file
    sudo chown -R $user:$user $apath$file
    printf "Linked config dir:  $apath$file"
    printf "$setting config dir has been linked up\n"
    exit 0
fi
for i in "${args[0]}"
do
    loc=$i
    if [ -L $apath$file ];
    then
        printf "The Requested directory is already symlinked\n"
        printf "$(ls-lah $apath$afile)"
        exit 1
    fi
    if [ ! -d "$HOME/Nextcloud/Settings/$loc$apath" ];
    then
    mkdir -p $HOME/Nextcloud/Settings/$loc$apath
    printf "Making Directory:  $HOME/Nextcloud/Settings/$loc$apath\n"
    fi
    sudo mv -r $apath$file $HOME/Nextcloud/Settings/$loc$apath$file
    sudo ln -s $HOME/Nextcloud/Settings/$loc$apath$file $apath$file
    sudo chown -R $user:$user $HOME/Nextcloud/Settings/$loc$apath$file
    sudo chown -R $user:$user $apath$file
    printf "Linked config dir:  $HOME/Nextcloud/Settings/$loc$apath$file\n"
    printf "$setting config dir has been linked up\n"
done
exit 0

print_usage() {
  printf "-m   Send Setting to Missy Linux"
  printf "-t   Send Setting to Theo Linux"
  printf "-l   Send Setting to Both Linux Systems"
  printf "-w   Send Setting to Both Windows Systems"
  printf "-o   Send Setting to Missy Windows"
  printf "-g   Send Setting to Theo Windows"
  printf "-a   Send Setting to All Systems"
}

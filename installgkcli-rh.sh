#!/bin/bash
cd ~
curl -s https://api.github.com/repos/gitkraken/gk-cli/releases/latest \
| grep "browser_download_url.*Linux_x86_64.rpm" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
sudo dnf install -y ~/gk_*Linux_x86_64.rpm
rm -rf gk_*Linux_x86_64.rpm

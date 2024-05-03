#!/bin/bash
export address=0.0.0.0
export httpport=80
export debug=true
export sslport=443
export certfile=/root/.acme.sh/webssh-qa.pomeroy.com_ecc/fullchain.cer
export keyfile=/root/.acme.sh/webssh-qa.pomeroy.com_ecc/webssh-qa.pomeroy.com.key
export loglevel=debug
export logprefix=/var/log/wssh/wssh.log
export logwhen=D
export logtype=time
export loginterval=1
export logskeep=30
export wpintvl=20
export httpsredir=true
export encoding=utf-8
export xsrf=false
export font=
export maxconn=100
export recycledelay=5
export sshtimeout=3600
export xheaders=true
export forbidhttp=true
export trusteddownstream='10.236.2.48,10.236.2.29'
export username=webssh
export password=cHC5G4XXwAFf9Q59wuTUfzTB89zYgQn5
export term=vt100
export sshhost=10.236.2.81
export sshport=22
export font='OfficeCodePro-Regular.otf'
export autoconnect=false
export bgcolor=black
export fgcolor=white
export curcolor=white

#export cors='https://cmsqa.pomeroy.com:443,https://cms.pomeroy.com'
export cors='*'

if test "$1" == "start"; then
        wsshauto  --font=$font --curcolor=$curcolor --fgcolor=$fgcolor --bgcolor=$bgcolor --autoconnect=$autoconnect --sshhost=$sshhost --user=$username --password=$password --term=$term --sshport=$sshport --tdstream=$trusteddownstream --fbidhttp=$forbidhttp --xheaders=$xheaders --timeout=$sshtimeout --delay=$recycledelay --maxconn=$maxconn --font=$font --encoding=$encoding  --redirect=$httpsredir --xsrf=$xsrf --wpintvl=$wpintvl --debug=$debug --address=$address --port=$httpport --sslport=$sslport --certfile=$certfile --keyfile=$keyfile --logging=$loglevel --log-file-prefix=$logprefix --log-rotate-when=$logwhen --log-rotate-mode=$logtype --log-file-num-backups=$logskeep --log-rotate-interval=$loginterval --origin=$cors &
elif test "$1" == "restart"; then
        killall wsshauto
        wsshauto  --font=$font --curcolor=$curcolor --fgcolor=$fgcolor --bgcolor=$bgcolor --autoconnect=$autoconnect --sshhost=$sshhost --user=$username --password=$password --term=$term --sshport=$sshport --tdstream=$trusteddownstream --fbidhttp=$forbidhttp --xheaders=$xheaders --timeout=$sshtimeout --delay=$recycledelay --maxconn=$maxconn --font=$font --encoding=$encoding  --redirect=$httpsredir --xsrf=$xsrf --wpintvl=$wpintvl --debug=$debug --address=$address --port=$httpport --sslport=$sslport --certfile=$certfile --keyfile=$keyfile --logging=$loglevel --log-file-prefix=$logprefix --log-rotate-when=$logwhen --log-rotate-mode=$logtype --log-file-num-backups=$logskeep --log-rotate-interval=$loginterval --origin=$cors &
elif test "$1" == "stop"; then
        killall wsshauto
fi

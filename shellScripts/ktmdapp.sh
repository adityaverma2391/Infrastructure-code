#!/bin/sh
#set -x
# Gajanan Arkshali

if [ "$#" != 2 ]
then
        echo "$0 {start|stop|kill|shell} <appname>"
        exit
fi

ACTION=$1
KTMDAPP=$2
EMAIL_ADDR="aditya.verma@cadienttalent.com CloudOperations@cadienttalent.com TechSupportAll@cadienttalent.com pagesystems@unciru.com UATNotifications@cadienttalent.com"

TOP_DIR="/vol/app/$KTMDAPP"

if [ ! -d "$TOP_DIR" ]
then
        echo "$TOP_DIR does not exist"
        exit
fi

export PS1="\t [*$KTMDAPP*] \u@\h:\w > "
export HOME=$TOP_DIR

echo "Setting Environment for: $KTMDAPP"

if [ -f "$HOME/custom.env" ]
then
    echo "Loading Custom Environment: $HOME/custom.env"
    . $HOME/custom.env
fi


if [ "$ACTION" = "shell" ]
then
    echo "Spawning a SHELL for: $KTMDAPP"
    exec bash
fi

function getdetails()
{
    printf "Please enter your name: "
    read USERNAME
    printf "Please enter the reason: "
    read REASON
    EMAILBODY="Date/Time: `date`\nAction   : ${ACTION} Application\nResource : ${USERNAME}\nReason   : ${REASON}"
}


if [ "$ACTION" = "start" ]
then
    if [ -f $HOME/bin/startapp ]
        then
	    while [ ! "${REASON}" ] || [ ! "${USERNAME}" ]; do getdetails; done
            if [ "`ulimit -n`" -lt "2048" ];then echo "ulimit -n is too low, exiting.\n";exit 0;fi
            printf "${EMAILBODY}"| /bin/mail  -s "INFO: `hostname|cut -d. -f1` ${KTMDAPP} start initiated by \"${USERNAME}\"" ${EMAIL_ADDR}
            $HOME/bin/startapp
        else
           echo "cannot find: $HOME/bin/startapp"
            exit 1
        fi
fi

if [ "$ACTION" = "stop" ]
then
    if [ -f $HOME/bin/stopapp ]
        then
            while [ ! "${REASON}" ] || [ ! "${USERNAME}" ]; do getdetails; done
            printf "${EMAILBODY}"| /bin/mail  -s "INFO: `hostname|cut -d. -f1` ${KTMDAPP} stop initiated by \"${USERNAME}\"" ${EMAIL_ADDR}
            $HOME/bin/stopapp
        else
            echo "cannot find: $HOME/bin/stopapp"
            exit 1
        fi
fi

if [ "$ACTION" = "kill" ]
then
    if [ -f $HOME/bin/killapp ]
        then
	    while [ ! "${REASON}" ] || [ ! "${USERNAME}" ]; do getdetails; done
            printf "${EMAILBODY}"| /bin/mail  -s "INFO: `hostname|cut -d. -f1` ${KTMDAPP} kill initiated by \"${USERNAME}\"" ${EMAIL_ADDR}
            $HOME/bin/killapp
        else
            echo "cannot find: $HOME/bin/killapp"
            exit 1
        fi
fi

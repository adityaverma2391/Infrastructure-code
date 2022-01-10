#!/bin/sh
#if [ ! "`/usr/bin/pgrep -u atao run.sh`" ];then printf "The application is already down. Nothing to do here, exiting.\n"; exit 0;fi
if [ ! "`jps | grep jboss-modules.jar`" ];then printf "The application is already down. Nothing to do here, exiting.\n"; exit 0;fi
printf "Verifying user..."
if [ `whoami` != "atao" ];then printf "ERROR: This application can only be stopped as \"atao\" user.\nexitting.\n";exit 1;fi
printf "done.\nVerifying host..."
if [ `hostname|cut -d. -f1` != "uat-atao-vm10" ];then printf "ERROR: This application can only be stopped on uat-atao-vm10\nexiting...\n";exit 1;fi
printf "done.\nPlease wait while I take a thread dump..."
kill -QUIT `pgrep -u atao java`
printf "done.\n"
#$HOME/jboss/jboss-as/bin/shutdown.sh -S -u admin -p nWYanFhB
$JBOSS_HOME/bin/jboss-cli.sh -c --controller=uat-atao-vm10.corp.unicru.com:9999 --command=":shutdown()"
while true
do
if [ ! "`ps -ef |grep jboss|grep -v grep|grep atao|awk '{print $2}'`" ];then
printf "shutdown complete\n"
exit 0
else
printf "-"
sleep 1
printf "|"
fi
done

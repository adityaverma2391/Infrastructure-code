#!/bin/sh
# Updated on 6 Dec 2018 By Aditya Verma
# StartApp Script

TODAY=`date +%F-%H-%M-%S-%p`

if [ "`jps | grep jboss-modules.jar`" ];then printf "The application is already running. Nothing to do here, exiting.\n"; exit 0;fi
printf "Verifying user..."
if [ `whoami` != "atao" ];then printf "ERROR: This application can only be started as \"atao\" user.\nexitting.\n";exit 1;fi
printf "done.\nVerifying host..."
if [ `hostname|cut -d. -f1` != "uat-atao-vm10" ];then printf "ERROR: This application can only be started on uat-atao-vm10\nexiting...\n";exit 1;fi

# Clearing Temp
printf "done.\nClearing Temp...\n\n"
rm -rvf $JBOSS_HOME/standalone/tmp
printf "done.\nCopying logs files to $HOME/jboss/logs/archives folder..."

cp $JBOSS_HOME/standalone/log/uat-atao-vm10_startup-console.log $HOME/jboss/logs/archives/${TODAY}-startup-console.log
cp $JBOSS_HOME/standalone/log/uat-atao-vm10_startup-error.log $HOME/jboss/logs/archives/${TODAY}-startup-error.log
cp $JBOSS_HOME/standalone/log/uat-atao-vm10_gc.log $HOME/jboss/logs/archives/${TODAY}-gc.log
printf "done.\n"
source $HOME/.bash_profile
cd $HOME/jboss/logs
#$HOME/jboss/jboss-as/bin/run.sh -b 0.0.0.0 -g uatcluster -u 230.0.0.200 1>$JBOSS_HOME/server/production/log/uat-atao-vm10_startup-console.log 2>$JBOSS_HOME/server/production/log/uat-atao-vm10_startup-error.log &
#$HOME/jboss/jboss-as/bin/run.sh -b uat-atao-vm10.corp.unicru.com -g uatcluster -u 230.0.0.230 1>$HOME/jboss/jboss-as/logs/startup-console.log 2>$HOME/jboss/jboss-as/logs/startup-error.log 
nohup sh $JBOSS_HOME/bin/standalone.sh -c standalone-full-ha.xml -b 0.0.0.0 -Djboss.messaging.group.address=230.0.0.200 -Djboss.node.name=Node10 1>$JBOSS_HOME/standalone/log/uat-atao-vm10_startup-console.log 2>$JBOSS_HOME/standalone/log/uat-atao-vm10_startup-error.log &

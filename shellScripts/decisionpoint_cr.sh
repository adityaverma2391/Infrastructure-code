#!/bin/bash
# VARIABLES
_appProcess = $(pidof python)
#_bkpfiles=(atao/ decisionpoint_app.py)
_filesToBeDeleted=(atao/ None* nohup.out decisionpoint_app.py __pycache__/)
_ataoBundle=/tmp/DP-1.zip
#_appFile=/tmp/decisionpoint_app.py

## ! Kill decisionpoint app server
## Only for Non-Prod Servers
printf "Killing the app process... \n"
kill -9 $_appProcess

echo "##################################"
echo "##################################"

printf "Starting Backup... \n"

echo "##################################"
echo "##################################" && sleep 5s
echo

##for k in ${_bkpfiles[@]}; do
    tar -zcvf dp_backup__$(date +"%Y%m%d").tar.gz atao/ decisionpoint_app.py
##done

printf "done! \n\n"


## remove the files advised
printf "Deleting Old Files.... \n"

for i in ${_filesToBeDeleted[@]}; do
    rm -rvf $i
done

printf "done! \n"

echo "##################################"
printf "unzipping atao bundle...."
echo "##################################"
# unzip /tmp/atao.zip
unzip $_ataoBundle
#unzip atao.zip
printf "done..!\n"

## copy decisionpoint app code file
printf "Updating application.........."
echo "##################################"
#cp $_appFile .
printf "done..!"
echo
echo
#Command to start decisionpoint server
printf "Starting decisionpoint app server"
echo "##################################"
nohup uvicorn decisionpoint_app:decisionpoint_app --host 0.0.0.0 --port 8000 &
printf "done..!"
echo "##################################"
echo "##################################"
echo
echo
echo
#Check application process
printf "Application Process is - \n"
echo $(ps -ef | grep python)
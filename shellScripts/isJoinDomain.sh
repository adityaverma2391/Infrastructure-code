###########################################################################################
########        Execute Below commands to Join Domain       ###############################
########################################################################################### 
sudo systemctl stop ntp && \
sudo ntpdate cadienttalent.com && \
sudo systemctl start ntp && \
kinit -V aditya.verma@CADIENTTALENT.COM && \
sudo realm join --verbose CADIENTTALENT.COM -U 'aditya.verma@CADIENTTALENT.COM' --install=/

###########################################################################################
########       Comment Out the Below Line to avoid the Error        #######################
###########################################################################################
sudo vi /etc/sssd/sssd.conf
# Comment out the following line
# use_fully_qualified_names = True
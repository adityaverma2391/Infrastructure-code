::SMTP Server troubleshooting commands

::FIREWALL COMMANDS
:: Show SMTP Incoming Firewall setting
netsh advfirewall firewall show rule name="Simple Mail Transfer Protocol (SMTP-In)"

:: Enable input of new messages to relay
netsh advfirewall firewall set rule name="Simple Mail Transfer Protocol (SMTP-In)" new enable=yes

:: Disable input of new messages to relay
netsh advfirewall firewall set rule name="Simple Mail Transfer Protocol (SMTP-In)" new enable=no

::IIS SMTP SERVER
::IIS SMTP SERVER FOLDERS
:: D:\inetpub\mailroot\pickup  - Mail flow starting point. All messages coming into the relay start here. They will come from outside world or PDXEXCHG01.
:: D:\inetpub\mailroot\drop    - Local delivery messages. Mostly NDR's going back to sending servers.  99% trash.  
::                               "hostingsupport@unicru.com" mail routes here, then is picked up by Exchange.
:: D:\inetpub\mailroot\queue   - Outgoing mail that fails first delivery attempt.  SMTP Service will repeat attempts to deliver, up to configured settings.
:: D:\inetpub\mailroot\badmail - Undeliverable messages from QUEUE after all configured attempts have been tried.  

::DELIVERY QUEUE
:: Display number of files in outgoing mail queues.
dir \\pdxsmtp01.dmz.unicru.com\d$\inetpub\mailroot\queue | find "File(s)"
dir \\pdxsmtp02.dmz.unicru.com\d$\inetpub\mailroot\queue | find "File(s)"
dir \\pdxsmtp03.dmz.unicru.com\d$\inetpub\mailroot\queue | find "File(s)"
dir \\pdxsmtp04.dmz.unicru.com\d$\inetpub\mailroot\queue | find "File(s)"

:: 'STIRRING' THE QUEUE'S:
:: Moving the *.eml files from the QUEUE folder to the PICKUP folder re-processes them through the mail relay software.  
:: This may help thin out the queue if stuck.  This is also the process to move messages to another relay for delivery.
:: Stopping services is not necessary, and this can be performed on live systems.  
:: The IIS Process locks files in use, so they cannot be moved without stopping the vServer.
:: For example, today, I did the following, delaying a few minutes between each command to allow processing:
move \\pdxsmtp04.dmz.unicru.com\d$\inetpub\mailroot\queue\*.eml \\pdxsmtp01.dmz.unicru.com\d$\inetpub\mailroot\pickup
move \\pdxsmtp01.dmz.unicru.com\d$\inetpub\mailroot\queue\*.eml \\pdxsmtp02.dmz.unicru.com\d$\inetpub\mailroot\pickup

move \\pdxsmtp02.dmz.unicru.com\d$\inetpub\mailroot\queue\*.eml \\pdxsmtp03.dmz.unicru.com\d$\inetpub\mailroot\pickup
move \\pdxsmtp03.dmz.unicru.com\d$\inetpub\mailroot\queue\*.eml \\pdxsmtp04.dmz.unicru.com\d$\inetpub\mailroot\pickup


C:\Windows\system32>dir \\pdxsmtp01.dmz.unicru.com\d$\inetpub\mailroot\queue | find "File(s)"
             978 File(s)     15,385,614 bytes

C:\Windows\system32>dir \\pdxsmtp02.dmz.unicru.com\d$\inetpub\mailroot\queue | find "File(s)"
            1071 File(s)     17,366,649 bytes

C:\Windows\system32>dir \\pdxsmtp03.dmz.unicru.com\d$\inetpub\mailroot\queue | find "File(s)"
             852 File(s)     13,390,936 bytes

C:\Windows\system32>dir \\pdxsmtp04.dmz.unicru.com\d$\inetpub\mailroot\queue | find "File(s)"
             966 File(s)     14,143,016 bytes


**Take VM Snapshot before executing CR**
1.	Add a 2nd Disk.
2.  Format the drive and name it with a temporary drive letter (H:\).
3.	Copy the data from D:\ to H:\ using below command –
	    ROBOCOPY.EXE D:\ H:\ *.* /S /E /ZB /COPYALL /V /FP /BYTES /NP /MT:128 /LOG:C:\WINDOWS\TEMP\ROBOCOPY.LOG
4.	Remove drive letter from existing D: drive.
5.	Change the temporary drive letter H:\ to D:\ and get it tested by Engineering.
6.	Once Engineering confirms the functionality, add the freed space to C:\ and delete the partition.

:: Commands for installation of DXC Builds
::
:: Environment - TestApp
setup d:\releases\TST-Environment.xml /s /monitoruserid-CORPUNICRU\svc_uat5mon /monitorpassword-uat5mon
::
:: Environment - UAT
setup d:\releases\UAT-Environment.xml /s /monitoruserid-CORPUNICRU\svc_uat6mon /monitorpassword-uat6mon


setup d:\releases\environment-v9.xml /s /monitoruserid-CORPUNICRU\svc_dxmon01 /monitorpassword-5E@h8WetuDa
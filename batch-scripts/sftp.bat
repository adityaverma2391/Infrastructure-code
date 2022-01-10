$ sftp adverma@uat-bg-app1:/tmp <<< $'put {local-path}'


setup d:\releases\TST-Environment-Lib10.xml /s /monitoruserid-CORPUNICRU\svc_uat5mon /monitorpassword-uat5mon 

<token name="ArchiveFilePath" desc="" tokenname="ArchiveFilePath" tokenvalue="\\CADIENTTLNT_rtp_ntap_NAS_73.corp.unicru.com\dxc_cifs\uat\Archive"/>
<token name="FTPRootDirectory" desc="Root Directory for FTP Server" tokenname="FTPRootDirectory" tokenvalue="\\CADIENTTLNT_rtp_ntap_NAS_73.corp.unicru.com\vftproot$\dmzunicru"/>
<token name="SFTPRootDirectory" desc="Root Directory for SFTP Server" tokenname="SFTPRootDirectory" tokenvalue="\\CADIENTTLNT_rtp_ntap_NAS_73.corp.unicru.com\prd_sftp$\qtree_prd_sftp\home"/>


<token name="ArchiveFilePath" desc="" tokenname="ArchiveFilePath" tokenvalue="\\pdx_svm_nas_73.corp.unicru.com\dxc_cifs\testapp\archive"/>
<token name="FTPRootDirectory" desc="Root Directory for FTP Server" tokenname="FTPRootDirectory" tokenvalue="\\pdx_svm_nas_73.corp.unicru.com\vftproot$\dmzunicru"/>
<token name="SFTPRootDirectory" desc="Root Directory for SFTP Server" tokenname="SFTPRootDirectory" tokenvalue="\\pdx_svm_nas_73.corp.unicru.com\prd_sftp$\qtree_prd_sftp\home"/>
	
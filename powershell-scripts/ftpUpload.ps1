$file = "D:\New folder\file1.txt"
$ftpuri = "ftp://root:123@192.168.1.11/tmp/file1.txt"
$webclient = New-Object System.Net.WebClient
$uri = New-Object System.Uri($ftpuri)
$webclient.UploadFile($uri, $file)
#!/bin/bash
HOST=sftp.cadienttalent.com
PORT=22
USER=sftp_securitasus_t
PASSWORD=jGg4ojsa4IDacKbN
SOURCE_FILE=/tmp/backup_*
TARGET_DIR=/home/incoming/decisionpoint

/usr/bin/expect<<EOD

spawn /usr/bin/sftp -o Port=$PORT $USER@$HOST
expect "password:"
send "$PASSWORD\r"
expect "sftp>"
send "put $SOURCE_FILE $TARGET_DIR\r"
expect "sftp>"
send "bye\r"
EOD
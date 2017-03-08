MySQL database backup script
============================
This script uses mysqldump to create database backups in a given directory.
In order to use it, you'll need to edit the script with your database credentials 
and set up a cron job so that the script runs automatically. 

You can specify within the script where the backups should be stored and how many 
backups to store. 

I recommend setting the permissions of the file to 750 and creating a special 
database username and password for this file. The user should only have the permissions
necessary to copy the database tables. 

To have the script run daily at midnight, execute:
```
crontab -eu <USER>
```
And enter:
```
  0 0 * * * /path_to_script/db_backup.sh 
```
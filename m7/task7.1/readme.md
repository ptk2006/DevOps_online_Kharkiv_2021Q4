# Linux administration with bash
## Task A.
```
Create a script that uses the following keys:
1. When starting without parameters, it will display a list of possible keys and their description.
2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet
3. The --target key displays a list of open system TCP ports.
The code that performs the functionality of each of the subtasks must be placed in a separate function
```
[Script A](netscan.sh) use fping and nmap command. It is required to install them.

![image](https://user-images.githubusercontent.com/88320899/147492064-e9d41407-fdf0-4ae1-b37b-4d9cc1c4e034.png)
## Task B.
```
Using Apache log example create a script to answer the following questions:
1. From which ip were the most requests?
2. What is the most requested page?
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)
```
[Script B](parser.sh). It need to write apache log file name as parameter.

![image](https://user-images.githubusercontent.com/88320899/147493123-688c1286-a2d6-40f1-b671-1ef58e2e2775.png)
## Task C.
Create a data backup script that takes the following data as parameters:
1. Path to the syncing directory.
2. The path to the directory where the copies of the files will be stored.
In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, type of operation and file name. (The command to run the script must be added to crontab with a run frequency of one minute)

[Script C](backup.sh) require rsync command. Usage: ./backup.sh source_dir destination_dir
Added to current user crontab file
```
$ crontab -l
* * * * * ~/DevOps_online_Kharkiv_2021Q4/m7/task7.1/backup.sh ~/test/ ~/backup/
```
Logs in backup.log
```
$ cat backup.log
sending incremental file list
created directory /home/aobuh/backup
2021/12/29 19:28:01 home/aobuh/test/. 0
2021/12/29 19:28:01 home/aobuh/test/hard_lnk_labwork2 4152
2021/12/29 19:28:01 home/aobuh/test/labwork2 36
2021/12/29 19:28:01 home/aobuh/test/soft_lnk_labwork2 0
2021/12/29 19:28:01 home/aobuh/test/dir1 0
2021/12/29 19:28:01 home/aobuh/test/dir1/testfile 36

sent 4,476 bytes  received 132 bytes  9,216.00 bytes/sec
total size is 16,306  speedup is 3.54
sending incremental file list

sent 231 bytes  received 13 bytes  488.00 bytes/sec
total size is 16,306  speedup is 66.83
sending incremental file list

sent 231 bytes  received 13 bytes  488.00 bytes/sec
total size is 16,306  speedup is 66.83
sending incremental file list
deleting dir1/testfile
deleting dir1/
2021/12/29 19:31:01 home/aobuh/test/. 0

sent 172 bytes  received 41 bytes  426.00 bytes/sec
total size is 16,306  speedup is 76.55
```

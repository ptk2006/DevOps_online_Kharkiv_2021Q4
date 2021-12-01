# Linux task
## Task2
1) Analyze the structure of the /etc/passwd and /etc/group file, what fields are present in it, what users exist on the system? Specify several pseudo-users, how to define them?
#### Pseudo user (UID 1-499)
### sudo awk -F ":" '$3>1 && $3<500 {print $1}' /etc/passwd
2) What are the uid ranges? What is UID? How to define it?
```
The Linux Standard Base Core Specification specifies that UID values in the range 0 to 99 should be statically allocated by the system,
and shall not be created by applications, while UIDs from 100 to 499 should be reserved for dynamic allocation by system administrators and post install scripts.
```
3) What is GID? How to define it?
#### Group identifier
4) How to determine belonging of user to the specific group?
### groups <username>
5) What are the commands for adding a user to the system? What are the basic parameters required to create a user?
### sudo useradd <username>
6) How do I change the name (account name) of an existing user?
### sudo usermod -l <new_username> <old_username>
7) What is skell_dir? What is its structure?
#### Directory /etc/skel/ (skel is derived from the “skeleton”) is used to initiate home directory when a user is first created.
### sudo ls -la /etc/skel/
#### drwxr-xr-x.  2 root root   62 Nov  2 12:49 .
#### drwxr-xr-x. 98 root root 8192 Dec  1 21:23 ..
#### -rw-r--r--.  1 root root   18 May 27  2021 .bash_logout
#### -rw-r--r--.  1 root root  141 May 27  2021 .bash_profile
#### -rw-r--r--.  1 root root  376 May 27  2021 .bashrc  
8) How to remove a user from the system (including his mailbox)?
### sudo userdel -r username
9) What commands and keys should be used to lock and unlock a user account?
### sudo usermod -L username
### sudo usermod -U username
10) How to remove a user's password and provide him with a password-free login for subsequent password change?
### sudo passwd [username]
#### enter
### sudo passwd -e [username]  
11) Display the extended format of information about the directory, tell about the information columns displayed on the terminal.
### sudo ls -ld /etc
12) What access rights exist and for whom (i. e., describe the main roles)? Briefly describe the acronym for access rights.
```
File type. There are three possibilities for the type. It can either be a regular file (–), a directory (d) or a link (i).
File permission of the user (owner)
File permission of the owner’s group
File permission of other users
The characters r, w, and x stand for read, write, and execute.  
```
13) What is the sequence of defining the relationship between the file and the user?

14) What commands are used to change the owner of a file (directory), as well as the mode of access to the file? Give examples, demonstrate on the terminal.
###  sudo chown root:root ~/test/labwork2
15) What is an example of octal representation of access rights? Describe the umask command.
### umask
#### 0002
### touch umask_test
### ls -l umask_test
#### -rw-rw-r--. ...
16) Give definitions of sticky bits and mechanism of identifier substitution. Give an example of files and directories with these attributes.
```
When sticky bit set on a directory, files in that directory may only be unlinked or renamed by root or the directory owner or the file owner.  
```  
17) What file attributes should be present in the command script?
#### x attribute

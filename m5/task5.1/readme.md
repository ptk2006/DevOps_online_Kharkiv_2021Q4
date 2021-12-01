# Linux task

## Task1.Part1
1) Log in to the system as root.
### su -
2) Use the passwd command to change the password. Examine the basic parameters of the command. What system file does it change *?
### passwd [username] (change file /etc/passwd)
3) Determine the users registered in the system, as well as what commands they execute. What additional information can be gleaned from the command execution?
### w (USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT)
4) Change personal information about yourself.
### sudo yum install finger
### chfn
5) Become familiar with the Linux help system and the man and info commands. Get help on the previously discussed commands, define and describe any two keys for these commands. Give examples.
### man [command]
6) Explore the more and less commands using the help system. View the contents of files .bash* using commands.
### less ~/.bash_history
7) * Describe in plans that you are working on laboratory work 1. Tip: You should read the documentation for the finger command.
### -l    Produces a multi-line format displaying all of the information described for the -s option as well as the user's home directory, home phone number, login shell, mail status, and the contents of the files “.plan”,
###          “.project”, “.pgpkey” and “.forward” from the user's home directory.
8) * List the contents of the home directory using the ls command, define its files and directories. Hint: Use the help system to familiarize yourself with the ls command.
### ls -la ~/

## Task1.Part2
1) Examine the tree command. Master the technique of applying a template, for example, display all files that contain a character c, or files that contain a specific sequence of characters. List subdirectories of the root directory up to and including the second nesting level.
### tree -P s* ~
### tree -L 2 /
2) What command can be used to determine the type of file (for example, text or binary)? Give an example.
### tree -p ~
3) Master the skills of navigating the file system using relative and absolute paths. How can you go back to your home directory from anywhere in the filesystem?
### cd ~
4) Become familiar with the various options for the ls command. Give examples of listing directories using different keys. Explain the information displayed on the terminal using the -l and -a switches.
### ls -alh
### get a long listing of every file in a directory, including the hidden files
5) Perform the following sequence of operations: - create a subdirectory in the home directory; - in this subdirectory create a file containing information about directories located in the root directory (using I/O redirection operations);
- view the created file;
- copy the created file to your home directory using relative and absolute addressing.
- delete the previously created subdirectory with the file requesting removal;
- delete the file copied to the home directory.
### mkdir ~/test
### tree -df > ~/test/test.txt
### cat ~/test/test.txt
### cp ~/test/test.txt ~/
### rm -R ~/test
### rm ~/test.txt
6) Perform the following sequence of operations:
- create a subdirectory test in the home directory;
- copy the .bash_history file to this directory while changing its name to labwork2;
- create a hard and soft link to the labwork2 file in the test subdirectory;
- how to define soft and hard link, what do these
concepts;
- change the data by opening a symbolic link. What changes will happen and why
- rename the hard link file to hard_lnk_labwork2;
- rename the soft link file to symb_lnk_labwork2 file;
- then delete the labwork2. What changes have occurred and why?
### mkdir ~/test
### cd ~
### cp .bash_history test/labwork2
### ln -v test/labwork2 test/hard_lnk_labwork2
### ln -sv test/labwork2 test/soft_lnk_labwork2
### ln -l /test
### sudo nano test/soft_lnk_labwork2
#### [ Error writing test/soft_lnk_labwork2: No such file or directory ]
### rm test/labwork2
### ls -l test/
#### total 16
#### rw-------. 1 h h 16293 Dec  1 13:21 hard_lnk_labwork2
#### lrwxrwxrwx. 1 h h    13 Dec  1 13:32 soft_lnk_labwork2 -> test/labwork2
7) Using the locate utility, find all files that contain the squid and traceroute sequence.
### sudo yum install mlocate
### sudo updatedb
### sudo locate -b squid -c
8) Determine which partitions are mounted in the system, as well as the types of these partitions.
### df -Th
9) Count the number of lines containing a given sequence of characters in a given file.
### wc -l ~/test/hard_lnk_labwork2
10) Using the find command, find all files in the /etc directory containing the host character sequence.
### sudo find /etc -name *host*
11) List all objects in /etc that contain the ss character sequence. How can I duplicate a similar command using a bunch of grep?
### sudo find /etc -name *ss*
### sudo ls -l /etc |grep ss
12) Organize a screen-by-screen print of the contents of the /etc directory. Hint: You must use stream redirection operations.
### sudo ls -l /etc | less
13) What are the types of devices and how to determine the type of device? Give examples.
### sudo yum install lshw
### sudo lshw
### sudo lsblk
### sudo lspci
14) How to determine the type of file in the system, what types of files are there?
### file -f ~/*
15) * List the first 5 directory files that were recently accessed in the /etc directory.
### sudo ls -lht /etc/* |head -5

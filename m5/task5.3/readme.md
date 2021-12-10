# Linux task
## Task3.Part1
1. How many states could has a process in Linux?
```
   R  running or runnable (on run queue)
   D  uninterruptible sleep (usually IO)
   S  interruptible sleep (waiting for an event to complete)
   Z  defunct/zombie, terminated but not reaped by its parent
   T  stopped, either by a job control signal or because it is being traced
```
2. Examine the pstree command. Make output (highlight) the chain (ancestors) of the current process.
### sudo yum install psmisc
### sudo pstree -h
3. What is a proc file system?
```
The proc filesystem (procfs) is a special filesystem in Unix-like operating systems that presents information about processes
and other system information in a hierarchical file-like structure, providing a more convenient and standardized method for
dynamically accessing process data held in the kernel than traditional tracing methods or direct access to kernel memory.
```
4. Print information about the processor (its type, supported technologies, etc.).
### cat /proc/cpuinfo
5. Use the ps command to get information about the process. The information should be as follows: the owner of the process, the arguments with which the process was launched for execution, the group owner of this process, etc.
### ps ax o user,pid,%cpu,%mem,vsz,rss,tty,stat,start,time,args,group,gid
6. How to define kernel processes and user processes?
#### Kernel processes
### ps --ppid 2 -p 2 -o  user,pid,ppid,stat,time,cmd
#### User processes
### ps --ppid 2 -p 2  --deselect -o  user,pid,ppid,stat,time,cmd
7. Print the list of processes to the terminal. Briefly describe the statuses of the processes. What condition are they in, or can they be arriving in?
### ps -aux
```
               D    uninterruptible sleep (usually IO)
               R    running or runnable (on run queue)
               S    interruptible sleep (waiting for an event to complete)
               T    stopped by job control signal
               t    stopped by debugger during the tracing
               W    paging (not valid since the 2.6.xx kernel)
               X    dead (should never be seen)
               Z    defunct ("zombie") process, terminated but not reaped by
                    its parent

       For BSD formats and when the stat keyword is used, additional
       characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads
                    do)
               +    is in the foreground process group
```
8. Display only the processes of a specific user.
### ps -u [username]
9. What utilities can be used to analyze existing running tasks (by analyzing the help for the ps command)?
#### pgrep, pstree, top, atop 
10. What information does top command display?
```
PID: Process ID.
USER: The owner of the process.
PR: Process priority.
NI: The nice value of the process.
VIRT: Amount of virtual memory used by the process.
RES: Amount of resident memory used by the process.
SHR: Amount of shared memory used by the process.
S: Status of the process. (See the list below for the values this field can take).
%CPU: The share of CPU time used by the process since the last update.
%MEM: The share of physical memory used.
TIME+: Total CPU time used by the task in hundredths of a second.
COMMAND: The command name or command line (name + options).
```
11. Display the processes of the specific user using the top command.
### top -u [username]
12. What interactive commands can be used to control the top command? Give a couple of examples.
```
'h' help
'ESC' update
'k' kill process
'u' filter by user
'n' set max number of tasks displayed
```
13. Sort the contents of the processes window using various parameters (for example, the amount of processor time taken up, etc.)
```
                command   sorted-field                  supported
                A         start time (non-display)      No
                M         %MEM                          Yes
                N         PID                           Yes
                P         %CPU                          Yes
                T         TIME+                         Yes
```
14. Concept of priority, what commands are used to set priority?
```
r  :Renice-a-Task
              You will be prompted for a PID and then the value to nice
              it to.

              Entering no PID or a negative number will be interpreted
              as the default shown in the prompt (the first task
              displayed).  A PID value of zero means the top program
              itself.
```
15. Can I change the priority of a process using the top command? If so, how?
#### r  :Renice-a-Task
16. Examine the kill command. How to send with the kill command process control signal? Give an example of commonly used signals.
```
kill PID
kill -s signalName PID
kill -signalName PID
kill -signalNumber PID
kill -HUP pid_number
killall -HUP command
```
17. Commands jobs, fg, bg, nohup. What are they for? Use the sleep, yes command to demonstrate the process control mechanism with fg, bg.
### sleep 200 &
### jobs
```
[1]+  Running                 sleep 200 &
```
### fg 1
```
sleep 200
^Z
[1]+  Stopped                 sleep 200
```
### bg 1
```
[1]+ sleep 200 &
```
## Task3.Part2
1. Check the implementability of the most frequently used OPENSSH commands in the MS Windows operating system. (Description of the expected result of the commands + screenshots: command – result should be presented)
```
PS C:\Windows\system32> Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Client*'


Name  : OpenSSH.Client~~~~0.0.1.0
State : Installed
```
### scp -P 10018 aobuh@centos-test:/home/aobuh/.ssh/id_ed25519 d:\
![image](https://user-images.githubusercontent.com/88320899/145564255-da79ff6f-64ea-4d62-b191-e333feabdcf2.png)
### ssh aobuh@centos-test -p 10018 -i "d:\id_ed25519"
![image](https://user-images.githubusercontent.com/88320899/145564467-fd988d8b-3427-4d2e-99ef-39e699cdd91f.png)
2. Implement basic SSH settings to increase the security of the client-server connection (at least
- Use SSH public key based login
- Disable root user login
```
PermitRootLogin no
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
```
- Disable password based login
```
AuthenticationMethods publickey
PubkeyAuthentication yes
```
3. List the options for choosing keys for encryption in SSH. Implement 3 of them.
```
SH supports several public key algorithms for authentication keys. These include:
rsa - an old algorithm based on the difficulty of factoring large numbers. A key size of at least 2048 bits is recommended for RSA; 4096 bits is better. RSA is getting old and significant advances are being made in factoring. Choosing a different algorithm may be advisable. It is quite possible the RSA algorithm will become practically breakable in the foreseeable future. All SSH clients support this algorithm.
dsa - an old US government Digital Signature Algorithm. It is based on the difficulty of computing discrete logarithms. A key size of 1024 would normally be used with it. DSA in its original form is no longer recommended.
ecdsa - a new Digital Signature Algorithm standarized by the US government, using elliptic curves. This is probably a good algorithm for current applications. Only three key sizes are supported: 256, 384, and 521 (sic!) bits. We would recommend always using it with 521 bits, since the keys are still small and probably more secure than the smaller keys (even though they should be safe as well). Most SSH clients now support this algorithm.
ed25519 - this is a new algorithm added in OpenSSH. Support for it in clients is not yet universal. Thus its use in general purpose applications may not yet be advisable.
The algorithm is selected using the -t option and key size using the -b option. The following commands illustrate:
ssh-keygen -t rsa -b 4096 ssh-keygen -t dsa ssh-keygen -t ecdsa -b 521 ssh-keygen -t ed25519
```
4. Implement port forwarding for the SSH client from the host machine to the guest Linux virtual machine behind NAT.
### ssh -R [REMOTE:]REMOTE_PORT:DESTINATION:DESTINATION_PORT [USER@]SSH_SERVER
5*. Intercept (capture) traffic (tcpdump, wireshark) while authorizing the remote client on the server using ssh, telnet, rlogin. Analyze the result.
### sudo tcpdump -v port 22

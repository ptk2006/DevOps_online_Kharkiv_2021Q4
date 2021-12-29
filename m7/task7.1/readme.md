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

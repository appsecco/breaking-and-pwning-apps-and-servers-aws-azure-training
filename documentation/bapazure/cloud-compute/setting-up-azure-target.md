# Setting up a Azure Virtual machine to attack

## Introduction

An Azure machine, just like any other server on the Internet, requires some due diligence to be permformed in terms of network rules, application setup and system security configuration. A system hosting an application can be attacked if a vulnerability allows an attacker to reach the OS from the application.

## What are we going to cover?

This chapter will setup an Azure VM instance, install XAMPP on it and deploy our application target on it.

## Setting up the machine

### Create a new Windows Virtual Machine

Create a new Windows Virtual Machine using the Azure Portal

1. Click on `Virtual Machines` under Favorites
2. Virtual machine name - `Windows-Web-App`
3. Select Image - `Windows 10 Pro 1803`
4. Change the Size to `B2s`
5. Authentication Type password. Username - `winadmin`. Set a strong password and note it
6. Set Inbound port rule none. We will set this through the Network Security Group settings later
7. Click on `Next: Disks`
8. Select `Standard HDD` and click Next
9. Set Inbound ports to None
10. Keep defaults for the next sections till you reach the final review screen
11. Click create to launch your VM

## Setting up access via RDP

We need to open TCP port 3389 in the Azure's firewall so that we can login and perform some post login configuration.

1. Select the VM in Azure portal and select `Networking`
2. Click on `Add Inbound port rule button`
3. Add port 3389 as destination and source IP as your student VM's public IP (Visit `https://x41.co` for your public IP)
4. If RDP is already added to the rules then ensure that the source is pointed to your external IP

## Setting up the Web server and the App

1. Login into the VM using remote desktop. 
2. If you are on Windows you can use `Start > Run > mstsc`. If you are on Mac or Linux, you can use the student VM to launch `xfreerdp -u:winadmin -v:IP-AZURE-VM` via terminal
3. Launch powershell **as administrator** (right click Runas Administrator)
4. Allow powershell to run scripts downloaded from the Internet by running `Set-ExecutionPolicy Unrestricted -Force`
5. run `wget -UseBasicParsing https://s3.amazonaws.com/bapawsazure-artifacts/app-setup.ps1 -OutFile app-setup.ps1`
6. After the script is downloaded, execute it by running it `.\app-setup.ps1`
7. Wait for the setup to finish
8. Add another firewall rule to the VM for TCP port 80, add port 80 as destination and source IP as your cloud attacker IP
9. Once the setup is done, the app should be deployed at `http://Azure-VM-Public-IP/` but accessible only from the attacker IP
10. You can access the application by using the SOCKS proxy running on port 9090. If not, then use the same setup (Firefox > Burp > SOCKS Proxy > Attacker machine > Target) that we created earlier.

## References

- [Create a Windows virtual machine](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal)
- [NSG Quick start tutorials](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/nsg-quickstart-portal)
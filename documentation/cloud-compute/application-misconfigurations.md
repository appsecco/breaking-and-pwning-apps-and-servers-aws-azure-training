# Application Misconfigurations


## Introduction

This chapter covers common application misconfigurations that can be used to attack hidden applications on the server. Some misconfigurations can reveal additional secrets and information that may result in the compromise of the entire AWS account.

## What is a Security Misconfiguration?

This is A6 on the OWASP Top 10 2017

Security misconfigurations are settings that have been altered from the standard set of secure options. These may result in the application leaking information or the application/service/system providing access that the user was not meant to have.

Security misconfiguration can happen at any level of an application stack, including the network services, platform, web server, application server, database, frameworks, custom code, and pre-installed virtual machines, containers, or storage. Automated scanners are useful for detecting misconfigurations, use of default accounts or configurations, unnecessary services, legacy options, etc.


## Steps to setup browser

On the student machine launch Firefox and Burp

Setup a SSH tunnel between the student machine and the internal application via the attacker machine's SSH connection

    ssh -D 9090 cloudhacker@$cloudhackerip
    
In Burp, on the student VM, make the following change

    User Options tab > SOCKS Proxy

    Check Use SOCKS Proxy

    SOCKS proxy host - 127.0.0.1
    SOCKS proxy port - 9090

This will tunnel all web traffic through the SSH connection to the attacker EC2 instance.

Lastly, configure Firefox to use Burp. This can be done using `Preferences > General > Network Settings`.

- Select "Manual proxy configuration" and set the following values
    - HTTP Proxy : 127.0.0.1
    - Port: 8080
- Click "OK"

This will setup Firefox to use Burp, which inturn is using the SSH tunnel to send traffic, allowing you to browse the application running on the EC2 instance even though its not accessible directly.

## Steps to create a DNS name for the app server

On the student VM, add a host file entry to point your system to a domain name for the web application.

To do this, follow these steps

1. identify your unique name that was generated earlier and is now in your bash prompt (something like `jumping-tractor`)
2. open the `/etc/hosts` file as root
3. add the following to the end of the file. Replace the text unique-name with your unique-name

`10.0.100.11 publicsite-unique-name.cloudsec.training`

For example, in our case the line entry would look like

`10.0.100.11 publicsite-jumping-tractor.cloudsec.training`


## Steps to attack

### Misconfigured web server

Each one of you has access to your own web application accessible via a unique URL. This URL is created from your unique name. For example, if your unique name is `dancing-wallet` then your URL for this exercise would be `http://publicsite-dancing-wallet.cloudsec.training`.

Browse to your website

    http://publicsite-unique-name.cloudsec.training

Identify the IP address of the application server (in this case we know it is 10.0.100.11)

The server is misconfigured to provide a default site when no `Host` header is set.

Browse to 
    
    http://<TARGET-IPADDRESS-HERE>
    
Inspect the JS code to find hard-coded credentials

Post login check if there is anything useful here?

There is a folder called `/code/`

This contains an Android app which could possibly contain secrets

### Extraction of keys from apk/jar file - (Demo)

- You can use the `serverhealth.apk` provided in the `extras` folder
- use a tool like `jadx-gui` to find hardcoded keys etc.

## Additional references

- [OWASP Top 10-2017 A6-Security Misconfiguration](https://www.owasp.org/index.php/Top_10-2017_A6-Security_Misconfiguration)
- [Misconfigurations can leave you vulnerable to attackers](https://www.calavista.com/misconfiguration-can-leave-vulnerable-attackers/) 
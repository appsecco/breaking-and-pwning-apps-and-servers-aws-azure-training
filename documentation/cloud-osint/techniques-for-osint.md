# Techniques for OSINT

## Introduction

With the varied number of services that Amazon AWS provides, there is bound to be information floating around the Internet that can leak company asset information in the form of IP addresses, hostnames, S3 bucket names, open ports and services, leaked keys and secrets and accidentally exposed snapshots/backup.

There are several techniques that can be used to find and isolate information to plan for attacks. Open Source Intelligence Gathering (OSINT) is the art of collecting information using various open source sources that can be used to weaponize and plan for attacks.

## What are we going to cover?

This chapter covers various open source techniques that can be used to perform OSINT on cloud targets.

## OSINT Techniques

### Azure IP ranges

- [Azure IP ranges](https://azurerange.azurewebsites.net/)

### AWS IP Address Ranges

Amazon Web Services (AWS) publishes its current IP address ranges in JSON format. To view the current ranges, download the .json file. Multiple revisions of this file can be downloaded and maintained for version control.

Download the json file from the Amazon website

    wget https://ip-ranges.amazonaws.com/ip-ranges.json

The `jq` tool can be used to query the json

    sudo apt-get install jq

You can get the file creation date for example using

    jq .createDate < ip-ranges.json
    
Getting information for a specific region

    jq  '.prefixes[] | select(.region=="us-east-1")' < ip-ranges.json

Get all IP addresses from the file

    jq -r '.prefixes | .[].ip_prefix' < ip-ranges.json

### Obtaining IP information

Online services that can provide IP and host information and historical DNS data.

    https://viewdns.info/

    https://securitytrails.com/

### Shodan

Shodan is a search engine for Internet-connected devices. Advanced search queries may need a (free) account.

Note of caution: Do not browse to the targets that the search engine throws up.

We can use Shodan to search for various assets that belong to the AWS IP ranges for example

    https://www.shodan.io/

    https://www.shodan.io/search?query=net%3A%2234.227.211.0%2F24%22

### Censys

Censys is another search engine that is used to search through the Internet's public facing data.

    https://censys.io/

    https://censys.io/ipv4?q=s3

### Google dorks

Google advanced search queries can be used to find information about AWS assets and other resources. 

The entire list of advanced search operators can be found at

    https://www.google.com/advanced_search

For finding specific AWS EC2 and RDS instance names that leak on the Internet, we can use the following operators (this is a subset of the many available)

Note of caution: Do not click on any of the following search results.

    site:*.amazonaws.com -www "compute"

    site:*.amazonaws.com -www "compute" "ap-south-1"

The following search phrase can be used to find people leaking their RDS endpoint names on the Internet. You can follow search results from the following search:

    site:pastebin.com "rds.amazonaws.com" "u " pass OR password

Sites like hackerone which run bug bounty programs have some AWS related reports made public. These reports often contain information about AWS assets and resources

Try this as an example

    site:hackerone.com inurl:reports -support.hackerone.com "AWS" "s3"

### Certificate Transparency Logs

Certificate Transparency (CT) is an experimental Internet security standard and open source framework for monitoring and auditing digital certificates. The standard creates a system of public logs that seek to eventually record all certificates issued by publicly trusted certificate authorities, allowing efficient identification of mistakenly or maliciously issued certificates.

You could use `https://crt.sh` to search for subdomains of targets based on the idea that a SSL/TLS cert was created for them at one point. Using this information, you can identify which are cloud resources using DNS resolution (A or CNAME) and then map them to the naming convention used for the cloud provider.

#### Exercise 

1. Pick a target 
2. Use `https://crt.sh` to find the subdomains of that target using the wildcard character %
3. Example: `%.netflix.com`

## Additional references

- [AWS IP Ranges documentation](https://docs.aws.amazon.com/general/latest/gr/aws-ip-ranges.html#aws-ip-download)
- [Shodan Help](https://help.shodan.io/the-basics/what-is-shodan)
- [Shodan for Penetration Testers](https://www.defcon.org/images/defcon-18/dc-18-presentations/Schearer/DEFCON-18-Schearer-SHODAN.pdf)  
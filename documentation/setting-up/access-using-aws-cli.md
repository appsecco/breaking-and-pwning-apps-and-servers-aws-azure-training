# Access to AWS CLI

## Introduction

The AWS cli is the command line SDK for the Amazon APIs which allow you to control, create, destroy, edit, move and perform other actions on your AWS assets. The AWS cli can be used to automate a lot of AWS related tasks from a multitude of other command line programs.

Programmatic access to the AWS cli is obtained using a key/secret pair of unqiue credentials.

## What are we going to cover?

In this chapter we shall cover the steps to setup and configure AWS cli access to your AWS account.

## Steps to Configure AWS CLI

**When ever you encounter line like below please either type this or copy paste it in the terminal of your student VM**

![Student VM custom panel](images/student-vm-custom-panel.png)

Run the following command

    aws configure

You will need to provide the `access key ID` and `secret access key`, which you have saved earlier

Type the following values

Default region name [None]: `us-east-1`

Default output format [None]: `json`

These credentials get stored in the file at  `~/.aws/credentials`

Run the following command to confirm if you are setup or not. This command should show your Account ID

    aws sts get-caller-identity

**Note:** Autocomplete has been setup for you to type the commands more easily. Use tab to show options when using the aws cli.

## Automated AWS CLI Configuration

Run the following command

    aws-cli-access-checker

This script will

* Use the stored credentials to check if your aws cli access is proper or not
* If it is successful it will print your unique name that will be used throughout the training
* Please let the trainer know these unique values


## Additional Information

- [Setting up access using CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
- [Setting up auto complete for AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html)
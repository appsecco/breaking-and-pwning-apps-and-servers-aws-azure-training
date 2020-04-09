# Running aws-nuke to cleanup

## Introduction

During the course of our trianing we have started multiple EC2 instances, worked with multiple RDS instances and created several S3 buckets as part of the training. You can continue to work with these resources or choose to terminate them as you will incur some charges if they are kept running.

## What are we going to cover

In this chapter, we will cover the steps required to run a binary that will terminate your AWS assets.

## Steps to complete this

First we have to download the aws-nuke linux binary from releases [aws-nuke-v2.14.0-linux-amd64](https://github.com/rebuy-de/aws-nuke/releases)

Then update the permissions for the binary

    chmod +x aws-nuke-v2.14.0-linux-amd64

Now we have to create the configuration file to perform the clean up of entire AWS account using aws-nuke.

Create a new file `nuke-config.yml` with following information. Replace the "111111111111" with your account number. You can get this from `aws sts get-caller-identity`

```
regions:
- us-east-1

account-blacklist:
- "000000000000"  # production

accounts:
  "111111111111": {} # aws-nuke-example
```

Now to perform the operation we have to run the following. It returns the information about deleting from the account number given configuration.

    ./aws-nuke-v2.14.0-linux-amd64 -c nuke-config.yml

If you see a message that tells you that there is no account alias created, you need to create an account alias using

    aws iam create-account-alias --account-alias unique-name

Then to perform real delete operation it is required to add `--no-dry-run` flag

    ./aws-nuke-v2.14.0-linux-amd64 -c nuke-config.yml --no-dry-run

It will prompt for twice to confirm before performing the delete operation

### Additional References

- [AWS Nuke](https://github.com/rebuy-de/aws-nuke)
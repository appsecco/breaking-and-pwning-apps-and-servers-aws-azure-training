# Install the SSM Agent on the Target

## Introduction

To use the SSM service to run commands on our EC2 instances, you have to install the agent on the remote machine.

- SSM Agent is installed, by default, on Amazon Linux base AMIs dated 2017.09 and later. SSM Agent is also installed, by default, on Amazon Linux 2 AMIs.
- You must manually install SSM Agent on other versions of Linux, including non-base images like Amazon ECS-Optimized AMIs.

## What are we going to cover?

Installation of the agent on our attacker machine

## Steps to achieve this

Follow these steps to install the agent on the remote machine

ssh into the cloudhacker machine

    ssh -l cloudhacker $cloudhackerip

Download and install the package

    wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb

    sudo dpkg -i amazon-ssm-agent.deb

Check if the service is running (on Ubuntu 16.04)

    sudo systemctl status amazon-ssm-agent

## Additional References

- [Installing the Agent on Ubuntu](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-manual-agent-install.html#agent-install-ubuntu)
# AWS Systems Manager

## Introduction

This section covers an introduction to the AWS Systems Manager and shows some of its capabilities in managing resources and automate tasks on AWS EC2 instances and other AWS resources at scale without requiring shell access.

AWS Systems Manager, formerly known as "Amazon Simple Systems Manager", provides capabilities that allow it to work with AWS Resource Groups, provide Insights to view data centrally, execute Actions and manage Shared Resources.

## What are we going to cover

This chapter will primarily cover

- Take a quick look at How SSM works
- Install the SSM agent on the target machine
- Creating and attaching a SSM Policy to a running EC2
- Execute commands using stolen keys on the target EC2
- Host a shell script and use AWS SSM's capability to execute remote shell scripts to gain a shell using stolen keys
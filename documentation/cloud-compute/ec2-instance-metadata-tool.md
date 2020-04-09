# Using EC2 instance metadata tool

## Introduction

AWS has a tool, essentially a bash script, to work with the metadata instance. It allows you to interact and run commands on the metadata instance. By design, this will query only the current machines metadata service.

## What are we going to cover?

This chapter will cover some of the tools that can be used to discover and leak additional information from AWS resources by querying the metadata service.

## Scenarios

1. To see help menu

```
ec2-metadata v0.1.1
Use to retrieve EC2 instance metadata from within a running EC2 instance. 
e.g. to retrieve instance id: ec2-metadata -i
		 to retrieve ami id: ec2-metadata -a
		 to get help: ec2-metadata --help
For more information on Amazon EC2 instance meta-data, refer to the documentation at
http://docs.amazonwebservices.com/AWSEC2/2008-05-05/DeveloperGuide/AESDG-chapter-instancedata.html

Usage: ec2-metadata <option>
Options:
--all                     Show all metadata information for this host (also default).
-a/--ami-id               The AMI ID used to launch this instance
-l/--ami-launch-index     The index of this instance in the reservation (per AMI).
-m/--ami-manifest-path    The manifest path of the AMI with which the instance was launched.
-n/--ancestor-ami-ids     The AMI IDs of any instances that were rebundled to create this AMI.
-b/--block-device-mapping Defines native device names to use when exposing virtual devices.
-i/--instance-id          The ID of this instance
-t/--instance-type        The type of instance to launch. For more information, see Instance Types.
-h/--local-hostname       The local hostname of the instance.
-o/--local-ipv4           Public IP address if launched with direct addressing; private IP address if launched with public addressing.
-k/--kernel-id            The ID of the kernel launched with this instance, if applicable.
-z/--availability-zone    The availability zone in which the instance launched. Same as placement
-c/--product-codes        Product codes associated with this instance.
-p/--public-hostname      The public hostname of the instance.
-v/--public-ipv4          NATted public IP Address
-u/--public-keys          Public keys. Only available if supplied at instance launch time
-r/--ramdisk-id           The ID of the RAM disk launched with this instance, if applicable.
-e/--reservation-id       ID of the reservation.
-s/--security-groups      Names of the security groups the instance is launched in. Only available if supplied at instance launch time
-d/--user-data            User-supplied data.Only available if supplied at instance launch time.
```

2. For example, to obtain IPv4 information, run `ec2-metadata -v`

## References

- [https://aws.amazon.com/code/ec2-instance-metadata-query-tool/](https://aws.amazon.com/code/ec2-instance-metadata-query-tool/)
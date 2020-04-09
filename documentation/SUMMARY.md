# Summary

* [Introduction](README.md)

## Getting Started with AWS

* [Setting up access to AWS](setting-up/README.md)
  * [Warning](setting-up/warning.md)
  * [Setup Student Virtual Machine](setting-up/setup-student-virtual-machine.md)
  * [Access to AWS Console](setting-up/access-to-aws-console.md)
  * [Create IAM user](setting-up/creating-an-iam-admin-user.md)
  * [Access using awscli](setting-up/access-using-aws-cli.md)
  * [Setting up and accessing the attacker VM](setting-up/setting-up-and-accessing-the-attacker-vm.md)

## Getting Started with Azure

* [Setting up access to Azure](bapazure/setup/README.md)
    * [Software Required](bapazure/setup/software-required.md)
    * [Getting started with Azure CLI](bapazure/setup/getting-started-with-azure-cli.md)
    * [Getting Started with Azure Portal](bapazure/setup/getting-started-with-azure-portal.md)

## What the network will look like

* [The AWS and Azure network access for this training](entire-network/README.md)

## Introduction to Azure Cloud Services

* [Introduction to Azure](bapazure/introduction/README.md)
    * [Azure Services in Plain English](bapazure/introduction/azure-services-in-plain-english.md)
    * [Mapping Azure Services to AWS Services](bapazure/introduction/mapping-azure-services-to-aws-services.md)

## Cloud Compute with AWS

* [Cloud compute](cloud-compute/README.md)
  * [Attacking EC2 via exposed ports](cloud-compute/attacking-ec2s-via-exposed-ports.md)
  * [Application Misconfigurations](cloud-compute/application-misconfigurations.md)
  * [EC2 meta data abuse](cloud-compute/ec2-meta-data-abuse.md)
  * [Stealing credentials](cloud-compute/stealing-credentials.md)
  * [AWS EC2 Metadata Tool](cloud-compute/ec2-instance-metadata-tool.md)
  * [AWS EC2 Metadata Updates](cloud-compute/ec2-meta-data-version-2.md)
  * [Attacking Serverless endpoints](cloud-compute/attacking-serverless-lambda-endpoints.md)
  * [Using AWS Inspector for audits and attacks](cloud-compute/using-aws-inspector-for-audits-and-attacks.md)

## Cloud Compute with Azure

* [Cloud compute in Azure](bapazure/cloud-compute/README.md)
    * [Setting up an Azure Target](bapazure/cloud-compute/setting-up-azure-target.md)
    * [Azure Virtual Machines](bapazure/cloud-compute/azure-virtual-machines.md)
    * [Azure Functions](bapazure/cloud-compute/azure-functions.md)

## Cloud Storage with AWS

* [Cloud storage](cloud-storage/README.md)
  * [Abusing AWS S3 misconfigurations](cloud-storage/abusing-aws-s3-misconfigurations.md)
  * [Discovering and pillaging EBS](cloud-storage/discovering-and-pillaging-ebs.md)
  * [Cloud forensics for discovery and attacks](cloud-storage/cloud-forensics-for-discovery-and-attacks.md)

## Cloud Storage with Azure

* [Cloud Storage in Azure - Azure Storage Account](bapazure/cloud-storage/README.md)
    * [Azure Storage Block Blobs](bapazure/cloud-storage/azure-storage-block-blobs.md)
    * [Attacking Azure Storage Blobs](bapazure/cloud-storage/attacking-azure-storage-blobs.md)
    * [Cloud forensics for Windows disks in Azure](bapazure/cloud-storage/cloud-forensics-for-windows-disks-in-Azure.md)

## Cloud Databases in AWS

* [Cloud Databases](cloud-databases/README.md)
  * [AWS RDS misconfigurations](cloud-databases/aws-rds-misconfigurations.md)
  * [Data pilferage](cloud-databases/data-pilferage.md)

## OSINT against Cloud Targets

* [OSINT against cloud targets](cloud-osint/README.md)
  * [Techniques for OSINT](cloud-osint/techniques-for-osint.md)
  * [Tools for finding public buckets](cloud-osint/tools-for-finding-public-buckets.md)
  * [Tools for discovering, stealing keys and endpoints](cloud-osint/tools-for-discovering-stealing-keys-and-endpoints.md)

## Other Services in Azure

* [Other Services](bapazure/other-services/README.md)
    * [Azure App Services Subdomain Takeover](bapazure/other-services/azure-app-services-subdomain-takeover.md)
    * [Azure Run Command](bapazure/other-services/run-command.md)
    * [Azure Databases](bapazure/other-services/azure-databases.md)

## AWS Systems Manager

* [AWS Systems Manager](aws-systems-manager/README.md)
  * [How AWS SSM works](aws-systems-manager/how-ssm-works.md)
  * [Install the SSM Agent](aws-systems-manager/install-the-agent.md)
  * [Create and attach a SSM Policy](aws-systems-manager/create-attach-policy.md)
  * [Executing commands on EC2 without SSH](aws-systems-manager/execute-commands.md)
  * [Gaining a shell using a hosted script](aws-systems-manager/reverse-shell.md)

## AWS Services and Concepts for Security

* [AWS services and concepts for security](aws-services-and-concepts-for-security/README.md)
  * [AWS IAM](aws-services-and-concepts-for-security/aws-iam.md)
  * [AWS VPCs](aws-services-and-concepts-for-security/aws-vpcs.md)
    * [AWS Security Groups](aws-services-and-concepts-for-security/aws-security-groups.md)
    * [AWS Flowlogs](aws-services-and-concepts-for-security/aws-flowlogs.md)
  * [AWS CloudTrail](aws-services-and-concepts-for-security/aws-cloudtrail.md)
  * [Requirements for Pentesting AWS Cloud Infra](aws-services-and-concepts-for-security/requirements-for-pentesting-aws-cloud-infra.md)

## Network Diagram for our AWS Lab

* [Network Lab Environment for AWS](closing/final-lab.md)

## Nuking Resources in AWS and Azure

* [Running aws-nuke](closing/aws-nuke.md)
* [Azure Delete Resources](bapazure/closing/delete-azure-resources.md)

## Additional References

* [Additional References](references/references.md)

### About Us

* [About Us](about-us/README.md)
  * [About Appsecco](about-us/about-appsecco.md)
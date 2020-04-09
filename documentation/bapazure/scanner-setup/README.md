# Security Scanners and the Cloud

# Introduction

This section covers the setup and running of a popular system and software scanner called OpenVAS. We will setup a Ubuntu 16.04 machine in Azure and deploy OpenVAS on it. We will then use it to perform a scan on one of our Azure VM.

The setup is generic. You can deploy the same in an AWS environment as well or on a local network. The tooling and steps will remain the same.

Both the AWS and Azure Marketplace have vulnerability scanners like Nessus and Qualys listed. However, these solutions can soon become expensive in terms of disk usage and data transfer pricing. We use OpenVAS as an example in this chapter. This can be replaced with any vulnerability scanner that works for you.

## What are we going to cover

This chapter will primarily cover 

- Deploying an Ubuntu 16.04 machine in Azure
- Installing OpenVAS on it
- Configuring and running a scan using OpenVAS

## Additional Information

No additional information for this section
# EC2 Instance Meta Data Service version 2 (IMDSv2)

## Introduction

Amazon introduced version 2 of the AWS metadata service called Instance Meta Data Service version 2 (IMDSv2) in November 2019 which promises to protect against all exploitation attempts to access the metadata service via vanilla SSRF weaknesses.

## What are we going to cover?

In this chapter, we will update the metadata service on our target to version 2 and see how our attacks fail and why the update actually secures the Instance metadata service.

## What problem did the update solve?

Server Side Request Forgery can be an extremely lucrative finding to an attacker because of the ability to make requests from the target machine. When discovered on a cloud instance, things get a little more interesting as attackers can access the metadata instance, available via a APIPA range IP address over HTTP— http://169.254.169.254/, and accessible only from the target.
For AWS this has always been a cause for concern as there was no authentication present to access this instance, and no requirement for a custom header that both GCP and Azure have.

In the most simple cases of an SSRF, a request to an attacker supplied URL is made from the server. For example, if there is a web application running on an AWS EC2 instance, a user supplied input like http://169.254.169.254/latest/meta-data/iam/security-credentials/role-name would initiate a web request to the endpoint from the AWS EC2 resulting in a response being sent back to the client.

This works because

1. The most basic form of SSRF is a GET based vulnerability. A response for a user supplied URL is fetched via a HTTP GET request by the vulnerable web app/web server.
2. There is no authentication at the Instance Metadata endpoint. This allows for a simple GET request with no additional/custom headers to retrieve information.

The new Instance Metadata Service v2 (IMDSv2) tackles both of these conditions. IMDSv2 adds the following exploit mitigating changes to access the endpoint

1. The requirement of a HTTP header called x-aws-ec2-metadata-token that contains a value generated via a PUT request to http://169.254.169.254/latest/api/token
2. A PUT request to http://169.254.169.254/latest/api/token with the custom header x-aws-ec2-metadata-token-ttl-seconds with the value of the number of seconds for which the token needs to be active. This PUT request generates the token to be used in Step 1.

For a SSRF to succeed with this update, the attacker would need to be able to control the HTTP Method (force server to make a PUT instead of the standard GET) and be able to pass custom headers to the server, which the server then will use to make the requests.

This update fixes all vanilla SSRF where the attacker can only control the URL.

## Steps to complete the exercise

To change the version of the metadata instance, we need to know the `instance-id` of the target machine. 

You can obtain this from the AWS console, from the command line using `aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,PrivateIpAddress,Tags]'` or from the output that was displayed on screen when you ran `deploy-compute-target`.

Add the `instance-id` to the following command to upgrade the version of the metadata instance

    aws ec2 modify-instance-metadata-options --http-endpoint enabled --http-token required --instance-id <INSTANCE-ID-HERE>

Once the command has completed, try performing the previous SSRF exercises and see the difference in output

## Additional exercise

After the upgrade is applied, you can use the following commands to work with the Instance Metadata Service. You need to be on the system to do this. Use a SSH session using the password that was found in the previous chapter.

Generate a token using the following command

    curl -X PUT -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" "http://169.254.169.254/latest/api/token"

Pass the token in the following command

    curl -H "X-aws-ec2-metadata-token:TOKEN-HERE" -v "http://169.254.169.254/latest/meta-data"
    
## Additional references

- [Defense in Depth - Enhancements to the EC2 Instance Metadata Service](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/)
- [Server Side Request Forgery (SSRF) and AWS EC2 instances after Instance Meta Data Service version 2(IMDSv2)](https://blog.appsecco.com/server-side-request-forgery-ssrf-and-aws-ec2-instances-after-instance-meta-data-service-version-38fc1ba1a28a)
- [Getting started with Version 2 of AWS EC2 Instance Metadata service (IMDSv2)](https://blog.appsecco.com/getting-started-with-version-2-of-aws-ec2-instance-metadata-service-imdsv2-2ad03a1f3650)
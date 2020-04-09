# AWS Identity and Access Management (IAM)

AWS has resources and services.

## What is an AWS Resource

An entity that users can work with in AWS, such as an EC2 instance, an Amazon DynamoDB table, an Amazon S3 bucket, an IAM user, an AWS OpsWorks stack, and so on.

## What is an AWS Service

| Service Name | Resource Name | Funny Name |
| -- | -- | -- |
| Elastic Cloud Compute | EC2 Instance | Amazon Virtual Servers |
| IAM | IAM Users, Groups, Certificates, Keys & Policies | Users, Keys and Certs |
| Simple Storage Service | S3 bucket | Amazon Unlimited FTP Server |
| Virtual Private Cloud | Virtual Network, VLANs | Amazon Virtual Colocated Rack |

*Funny names courtesy [AWS in Plain English](https://www.expeditedssl.com/aws-in-plain-english)*

AWS Identity and Access Management enables fine grained access control to AWS resources. AWS IAM is a completely free to use service and a fundamental service to have security for everything in AWS.

## Introduction

- `AWS services` need to be managed
- This requires access to these services
- These services allow us to work with `AWS resources`
- IAM allows us to **manage access securely**

> You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use resources.

## Key Terms (Identities)

This section has many new terms that may be confusing for a new user. We will look at a few of them needed for us to get going.

### Root Account

This identity has complete access to all AWS services and resources in the account. The complete technical term is `AWS account root user`.

As per AWS security best practices, this account should only be used to create the first IAM user.

### IAM Users

An IAM user is an `entity` that you create in AWS. The IAM user represents the person or service who uses the IAM user to interact with AWS. Usually used to

1. Login to the AWS console
2. Programatically access AWS resources

A user in AWS consists of a name, a password to sign into the AWS Management Console, and up to two access keys that can be used with the API or CLI

### IAM Groups

An `IAM group` is a collection of IAM users. You can use groups to specify permissions for a collection of users, which can make those permissions easier to manage for those users.

### IAM Roles

An `IAM role` is very similar to a user, in that it is an identity with permission policies that determine what the identity can and cannot do in AWS.

However, a role does not have any credentials (password or access keys) associated with it. Instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it.

An IAM user can assume a role to temporarily take on different permissions for a specific task.

### Role

A set of permissions that grant access to actions and resources in AWS. These permissions are attached to the role, not to an IAM user or group. Roles can be used by the following:

- An IAM user in the same AWS account as the role
- An IAM user in a different AWS account as the role
- A web service offered by AWS such as Amazon Elastic Compute Cloud (Amazon EC2)
- An external user authenticated by an external identity provider (IdP) service that is compatible with SAML 2.0 or OpenID Connect, or a custom-built identity broker.

### When to Create an IAM Role (Instead of a User)

| Scenario | Security Benefit |
| -- | -- |
| An application that runs on an EC2 instance and that application makes requests to AWS | Rather an embedding a user's credentials when the role is applied, temporary security credentials are generated. The credentials have the permissions specified in the policies attached to the role. |
| You're creating an app that runs on a mobile phone and that makes requests to AWS | Don't create an IAM user and distribute the user's access key with the app. Instead, use an identity provider like Login with Amazon, Amazon Cognito, Facebook, or Google to authenticate users and map the users to an IAM role. The app can use the role to get temporary security credentials that have the permissions specified by the policies attached to the role. |
| Users in your company are authenticated in your corporate network and want to be able to use AWS without having to sign in again | Use the Single Sign On capabilities of your organisations Directory and establish trust between that and AWS |

## Key Terms (Access Management)

This section has many new terms that may confuse. We will look at a few of them needed for us to get going.

### IAM Policies

A policy is an entity in AWS that, when attached to an identity or resource, defines their permissions.

#### Best News Ever

> [Use the New Visual Editor to Create and Modify Your AWS IAM Policies](https://aws.amazon.com/blogs/security/use-the-new-visual-editor-to-create-and-modify-your-aws-iam-policies/)

AWS evaluates these policies when a principal, such as a user, makes a request.

- Permissions in the policies determine whether the request is allowed or denied
- Policies are stored in AWS as JSON documents
  - When they are attached to principals we call them `identity-based policies`
  - When they are attached to resources we call them `resource-based policies`

### Identity-Based Policies

Identity-based policies are permission policies that you can attach to a principal (or identity), such as an IAM user, role, or group.

The types of policies you will see

#### Managed Policies

Standalone identity-based policies that you can attach to multiple users, groups, and roles in your AWS account.

1. AWS managed policies
  Managed policies that are created and managed by AWS
2. Customer managed policies
  Managed policies that you create and manage in your AWS account

> AWS recommends (so do we) that whenever possible prefer to use AWS managed policies unless and until you are a *policy guru*

### Resource-Based Policies

Resource-based policies are JSON policy documents that you attach to a resource such as an Amazon S3 bucket.

These policies control what actions a specified `principal` can perform on that `resource` and under what conditions.

Resource-based policies are inline policies, and there are no managed resource-based policies.

*[AWS User Guide - Access Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)*

### Sample Policy

        {
        "Version": "2012-10-17",
        "Statement": {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::example_bucket"
            }
        }

You can attach this policy to an IAM identity (group, user, or role). If that's the only policy for the identity, the identity is allowed to perform only this one action (ListBucket) on one Amazon S3 bucket (example_bucket).

#### Policy Elements

- **Effect** – whether the policy allows or denies access
- **Action** – the list of actions that are allowed or denied by the policy
- **Resource** – the list of resources on which the actions can occur
- **Condition (Optional)** – the circumstances under which the policy grants permission

## Demo

Create a new instance and attach an IAM role with s3 read-only policy

Login to the instance and get the credentials metadata

    curl http://169.254.169.254/latest/meta-data/iam/security-credentials/<ROLENAME>

Then use the credentials to access the services by exporting as AWS environment variables

    export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXX
    export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXX
    export AWS_SESSION_TOKEN=XXXXXXXXXXXXXXXXXXX

Now, we can use aws command line tool to access the services using available credentials

    aws s3 ls

## Additional references

- [JSON Policy Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html)
- [IAM Policy Visual Editor](https://aws.amazon.com/blogs/security/use-the-new-visual-editor-to-create-and-modify-your-aws-iam-policies/)
- [IAM Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html)
- [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
# Abusing AWS S3 misconfigurations

## Introduction

AWS S3 is a storage service by Amazon. Any kind of file. Permissions can be then given per object and per bucket.

Most often than not, AWS S3 buckets have been discovered with weak permissions on individual objects or the entire buckets itself. Files and folders which should not be public are made world readable and available to the world for inspection.

## What are we going to cover?

This chapter covers the common attacks that can occur on misconfigured buckets and data leak that can occur due to this.

## Steps to setup lab

Run the following script in student VM to set up the target environment

    deploy-vuln-s3

> If you see any error, please inform one of the trainers

We will use the following dictionary to search for S3 buckets

```
/home/cloudhacker/tools/AWSBucketDump/BucketNames.txt
```

Make a backup of the BucketNames.txt file using 

```
cp /home/cloudhacker/tools/AWSBucketDump/BucketNames.txt /home/cloudhacker/tools/AWSBucketDump/BucketNames.txt.backup
```

just in case we mess up the file while doing the search replacement in the next section :)

Add '-unique-name-awscloudsec' to the end of every line in the dictionary. Replace your unique-name here. This is so that your dictionary can be used to attack and find your own buckets on the Internet. You can do this with sed

    sed -i "s,$,-$bapname-awscloudsec,g" /home/cloudhacker/tools/AWSBucketDump/BucketNames.txt

## Steps to attack

We will use AWSBucketDump to complete this exercise although any other tool that can fetch bucket information would do. A great alternate tool to use is Digi Ninja's `bucket_finder` ruby script

Open Terminal and navigate to the `~/tools/AWSBucketDump` folder

Create a zero byte grep file and provide it to AWSBucketDump. This is used by AWSBucketDump to grep through the results, but since here we create a 0 byte file, it will show everything (which is what we want).

    source /home/cloudhacker/tools/AWSBucketDump/bin/activate

    touch s.txt

    python AWSBucketDump.py -D -l BucketNames.txt -g s.txt

Kill the script once it reaches the end of the file and is stuck. 

To see the results, open the `interesting_file.txt` to see the discovered content.

Did you find anything interesting in the bucket(s)?

## Bucket hunting on Steroids

[Slurp](https://github.com/0xbharath/Slurp-v2) is an advanced and versatile tool for Amazon S3 bucket enumeration. Slurp supports various S3 bucket enumeration techniques along with permutation based enumeration. As Slurp is written in Golang it is blazing fast and it is available as single portable binary file.

Following techniques are supported by Slurp for enumerating S3 buckets - 

1. Permutations - Similar to other S3 enumeration tools where buckets are discovered using known patterns
2. AWS Credentials - Slurp can use existing AWS Credentials to discover any mis-configured buckets in the AWS account that corresponds to the credentials
2. Domain - Discovers S3 buckets using a domain name


### Slurp - DEMO

**keyword mode**

    ./slurp keyword -p permutations.json -t netflix -c 25

**domain mode**

    ./slurp domain -t amazon.com 

**internal mode (Using AWS credentials)**

Unlike other modes in Slurp, this mode works with AWS credentials stored as named profiles in `~/.aws/credentials`

This mode is used to identify mis-configurations in S3 Buckets that the set of AWS credentials can access.

This mode is only supported in the newer version of slurp.

*For this technique to work, make sure atleast one profile is configured under ~/.aws/credentials*

Run the following commands to download latest version of Slurp and do an internal scan using `default` named profile - 

    wget https://github.com/0xbharath/slurp/releases/download/1.1.0/slurp-1.1.0-linux-amd64 && && chmod +x slurp-1.1.0-linux-amd64 && ./slurp internal


## Additional exercise - Writing data to a bucket

Enumerate a bucket's ACL using the command

    aws s3api get-bucket-acl --bucket bucket-name-here

For example

    aws s3api get-bucket-acl --bucket admin-immense-noise-awscloudsec

For S3 buckets that have public read AND write access, the output will have the permission set to "FULL_CONTROL".

You can write to such a bucket using the credentials of any AWS account in the world, as shown below. The command attempts to upload a file called `readme.txt` using the credentials of a user added to AWS configure profiles

    aws s3 cp readme.txt  s3://bucket-name-here --profile newuserprofile

You can see if the file has been uploaded using 

    aws s3 ls s3://bucket-name-here --profile newuserprofile

## Additional references

- [Digi Ninja Bucket Finder](https://digi.ninja/projects/bucket_finder.php)
- [AWS Bucket Dump](https://github.com/jordanpotti/AWSBucketDump)
- [A deep dive into AWS S3 access controls](https://labs.detectify.com/2017/07/13/a-deep-dive-into-aws-s3-access-controls-taking-full-control-over-your-assets/)
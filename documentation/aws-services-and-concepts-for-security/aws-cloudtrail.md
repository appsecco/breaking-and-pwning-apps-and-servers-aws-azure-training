# AWS CloudTrail

CloudTrail allows for tracking of user activity and API usage. With CloudTrail, you can log, continuously monitor, and retain account activity related to actions across your AWS infrastructure. CloudTrail provides event history of your AWS account activity, including actions taken through the AWS Management Console, AWS SDKs, command line tools, and other AWS services. This event history simplifies security analysis, resource change tracking, and troubleshooting.

## Why use CloudTrail

The data produced by CloudTrail can help you to answer questions such as

- What actions did a given user take over a specific time period?
- For a given resource, which AWS user has taken action on it over a given time period?
- What is the source IP address of a particular activity?

### Services Supported Currently

- Elastic Compute Cloud (EC2)
- Elastic Block Store (EBS)
- Virtual Private Cloud (VPC)
- Relational Database Service (RDS)
- Identity and Access Management (IAM)
- Security Token Service (STS)
- Redshift
- CloudTrail

## Exercise to see CloudTrail in action

1. In the AWS console, under services, go to CloudTrail
2. You can view the Event history for your your account. The event history will show all API requests made across AWS by the user that made the requests
3. Click on Create Trail
4. Give a name to your Trail
5. Select `Select all S3 buckets in your account`
6. Under Storage Location, create a new S3 bucket called `unique-name-cloudtrail-logs`
7. Click on Create

### Trigger API events to populate the logs

1. Use the CLI to put a file in one of your buckets
2. Use the CLI to stop the `compute-target-machine` instance
3. Use the CLI to stop the `db-target-machine` instance
4. Use the CLI to download the python code from the lambda function (you will have to list the lambda functions first)

### View the logs

1. Go to the S3 bucket containing the logs > `AWSLogs` > Your Account number > `CloudTrail` > `us-east-1` > `2019` > `06` > `28`
2. Download the log files and extract them using `gunzip <file-name>`
3. You can read the json file with mousepad or jq (`cat file-name | jq`) 

## Additional references

- [Logging IAM Events with AWS CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html)
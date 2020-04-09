# Cloud Storage

Cloud Storage is one of the most popular AWS services that is attacked. Amazon's S3 and EBS can each lead to interesting findings with the tools available in the aws cli.

Individual Amazon S3 objects can range in size from a minimum of 0 bytes to a maximum of 5 terabytes. The largest object that can be uploaded in a single PUT is 5 gigabytes. For objects larger than 100 megabytes, customers should consider using the Multipart Upload capability.

## What is this

This section covers the attacks for services under the Cloud Storage umbrella of AWS. 

- Attacking S3 misconfigurations
- Working with EBS snapshots to mount and inspect for data
- Working with EBS snapshots to perform digital forensics

## Additional Information

No additional information for this section
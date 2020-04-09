# AWS Virtual Private Clouds (VPCs)

Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined. This virtual network closely resembles a traditional network that you'd operate in your own data center, with the benefits of using the scalable infrastructure of AWS.

## VPCs and Subnets

A virtual private cloud (VPC) is a `virtual` network dedicated to your AWS account. It is `logically` isolated from other virtual networks in the AWS Cloud.

- You can launch your AWS resources, such as Amazon EC2 instances, into your VPC
- You can configure your VPC by modifying its IP address range, create subnets, and configure route tables, network gateways, and security settings

Amazon VPC provides features that you can use to increase and monitor the security for your VPC

### Security groups

Act as a firewall for associated Amazon EC2 instances, controlling both inbound and outbound traffic at the instance level

### Network access control lists (ACLs)

Act as a firewall for associated subnets, controlling both inbound and outbound traffic at the subnet level

### Flow logs

Capture information about the IP traffic going to and from network interfaces in your VPC

## Fundamental Pillar of your Security Architecture

Since VPCs essentially give you your own almost unlimited datacenter in the cloud, any security strategy should start from enforcing tradtional IT security controls for the VPC.

These can range from

- Strict regulation of production server access to authorized personnel
- End to end automation of deployment and logging which means that someone actually successfully SSHing is flagged and a Root Cause Analysis is conducted

## Additional references

- [Defending the Cloud from the Full Stack Hack](https://www.rsaconference.com/writable/presentations/file_upload/csv-w03-_defending-the-cloud-from-the-full-stack-hack.pdf)
- [VPC Lab](https://amazon.qwiklabs.com/focuses/6211?locale=en)
- [VPC Flow Logs 101](https://www.sumologic.com/aws/vpc/)
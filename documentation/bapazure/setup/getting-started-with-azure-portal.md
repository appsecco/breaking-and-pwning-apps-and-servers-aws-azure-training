# Getting Started With Azure Portal

The best way to learn about the navigating the Azure Portal is by trying it to solve something for us.

As an example and to get familiar with the Azure Portal, let's create a Ubuntu based Virtual Machine

## Create a Resource Group

From the burger menu, select `Resource Groups` and create a new resource group. You can also use the same resource group that you created in the previous chapter for Azure Cloud shell.

All the services we use can be made to operate within a resource group. This makes it easier to delete the objects all at once instead of independently removing them.

## Creating an Ubuntu based Virtual Machine

Creating a new virtual machine in Azure Portal is all about doing the following

- Choose the base operating system for the virtual machine (VM)
- Choose under which resource group will the VM run
- Fill in the values
  - for region where the VM should spin up
  - select a VM size
  - add a user and SSH key for access
  - open a port to allow SSH access
- Once the VM is created, use the provided information to login

The first step is to start by clicking on resource groups

**In this example, Resource Group name is `bapazure`. Please use the Resource Group name that you have created.**

![Click on our resource](images/azure-portal-basic-vm-2.png)

Click on add and type `Ubuntu Server 18.04 LTS`

![Add and filter for Ubuntu Server 18.04 LTS](images/azure-portal-basic-vm-4.png)

Click the `Create` button at the bottom

### Creating a Virtual machine by filling a form

Fill information about the resource group name in project details

![Choose resource group](images/azure-portal-basic-vm-5.png)

Fill in instance details

![Instance details information](images/azure-portal-basic-vm-6.png)

Select a VM size by clicking on `Change Size`. Select `B1s` for now.

![Select a VM size](images/azure-portal-basic-vm-7.png)

SSH key details. Read the public key from the student VM by `cat ~/.ssh/id_rsa.pub`

![SSH key details](images/azure-portal-basic-vm-8.png)

Inbound port information

![Inbound port information](images/azure-portal-basic-vm-9.png)

Configuration validated

![Validation passed](images/azure-portal-basic-vm-10.png)

Deployment is underway

![Deployment is underway](images/azure-portal-basic-vm-10b.png)

Deployed

![Deployed](images/azure-portal-basic-vm-10c.png)

### Connecting to our newly setup virtual machine

Once VM is up, SSH to it

![Click connect](images/azure-portal-basic-vm-11.png)

SSH information we need to for connecting. Step 4 is what you need. Your private key is already added to ssh agent on the student machine. Use the command without the `-i` flag else to follow the screen, the private key is the `~/.ssh/id_rsa` file on the student machine.

![SSH information to use for connecting](images/azure-portal-basic-vm-12.png)

A complete Ubuntu Server setup on the internet for our use in less than 5 minutes

![Logged in using SSH](images/azure-portal-basic-vm-13.png)

## Additional Exercise

As an exercise to continue practising after the training, attempt to do the following

1. Configure the Azure Virtual Machine's firewall to allow SSH access only from the attacker machine
2. Make a copy of the private key from the student machine's `~/.ssh/id_rsa` folder or add a new public key to the Azure virtual machine
3. Verify that the Azure Virtual Machine firewall allows access as per the rules you have defined

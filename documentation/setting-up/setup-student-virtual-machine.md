# Setting up and accessing the student virtual machine

# Setup Files

This document describes how to use the files inside the `setup-files` folder to create a local student machine that can be used to then do the rest of the training.

**It is really important to follow the instructions in this document before starting with the actual training materiel as this document used to setup your labs and access.**

## Initial setup

Setup a Ubuntu 18.04 Desktop virtual machine with a Desktop (GUI) environment. We prefer the machine to be deployed as a Virtualbox virtual machine, but you can use any other virtualisation software.

The username on the student virtual machine **has to be ** `student`.

- Create a new user with the name `student`
- Add the `student` user to the sudoers group using `sudo usermod -aG sudo student`
- Login as the `student` user
- Add the `/home/student/.local/bin` folder to $PATH

## Software needed on the virtual machine

Install the following software on the student virtual machine

1. python3 pip (`sudo apt install python3-pip`)
2. Terraform (`sudo apt install unzip;wget https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip;unzip terraform_0.11.3_linux_amd64.zip;sudo mv terraform /usr/local/bin/`)
3. aws-cli (`pip3 install --upgrade --user awscli`)
4. ansible (`sudo apt install ansible`)
5. codenamize (`pip3 install codenamize --user`)
6. boto3 (`pip3 install boto3`)
7. Azure cli (`curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`)
8. cli53 - get the binary release from `https://github.com/barnybug/cli53/releases`
9. Mousepad/Leafpad
10. Burpsuite
11. Firefox
12. Virtualbox guest additions
13. chalice (`pip3 install --user chalice`)

## Steps to setup the student virtual machine

### Step 1 - Adding scripts in /usr/bin

1. Copy all files from the `bin` folder to `/usr/bin/`
2. Make them executable using `chmod +x filename`

### Step 2 - Adding terraform scripts in home directory

1. Create a folder called `terraform` in the `student` user's home directory using `mkdir terraform`
2. Verify if the folder is created using `ls -ltra /home/student/terraform`
3. Recursively copy files from inside the `terraform` folder into the `/home/student/terraform` folder. You can use `cp -r  setup-files/terraform/* /home/student/terraform/` to do this.
4. Verify if the files have been copied using `ls -ltra /home/student/terraform/`

**The VM is now ready for the training**

## Additional information

No additional information for this section

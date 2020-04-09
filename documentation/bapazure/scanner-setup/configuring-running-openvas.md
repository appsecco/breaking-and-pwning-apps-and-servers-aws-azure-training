# Configuring and running an OpenVAS scan

## Introduction

**This is a demo chapter. If time permits, the students will be able to practice this chapter.**

Once the OpenVAS system is up, we can schedule or run a scan immediately based on our requirement. Although, the UI is not very intuitive, the flow is fairly common against security scanners.

1. Define targets
2. Define credentials (if any)
3. Select type of scan or create your own
4. Schedule or run now
5. Run scan

OpenVAS presents multiple HTML forms that when filled give you access to various features as mentioned below.

## What are we going to cover?

This chapter shows how you can create a simple 1 IP scan and extend if required to run this within your own environment.

### Configuring and running a scan

Launch the web portal for OpenVAS and login with your admin credentials.

#### Define targets

1. Under Assets > Hosts, add a host (`Target: 10.0.1.5`)

#### Define credentials

1. Under Configuration > Credentials, add Ubuntu Linux Target credentials (`linux:MojaveWaterPumpkin@3`)

#### Creating a Target of the Host

1. Under Assets > Hosts, click the star icon in front of the host on which the scan is to be run
2. Give the scan a name
3. From the Port list, select all ports
4. From the credentials drop down, select SSH and select the creds added in the previous section
5. Click OK

#### Running the scan

1. Under Scans > Tasks, click on the Star icon to add a new task
2. Give the task a name
3. From Scan Target, select the target that was created in the previous section
4. For schedule, select `Once`
5. Click on the Create button to add the task
6. Click on the Play button to begin the scan

## Additional References

- [OpenVAS Tutorial and Tips](https://hackertarget.com/openvas-tutorial-tips/)
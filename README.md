## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![alt text](https://github.com/dsharma323/Bootcamp-work-/blob/main/Images/ELK%20Stack%20Network%20Diagram.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat. The following files have been used to create the deployment:

- elk-playbook.yml
- filebeat-playbook.yml
- metricbeat-playbook.yml
- my-playbook.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- Using the Playbook
- Test the system


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly efficient, in addition to restricting traffic to the network.
- Load balancers protect the webservers from being overloaded from traffic. This form of protection works in mitigating Distributed Denial of Service (DDoS) attacks. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system metrics.
- Filebeat collects log events data, centralises it and forwards it.  
- Metricbeat records the metrics of the machine such as CPU usage, memory usage, operating system metrics etc.

The configuration details of each machine may be found below.


| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Ubuntu 20.04     |
| Web-1    | Webserver| 10.0.0.5   | Ubuntu 20.04     |
| Web-2    | Webserver| 10.0.0.6   | Ubuntu 20.04     |
| Web-3    | Webserver| 10.0.0.7   | Ubuntu 20.04     |
| ELKStack | ELKserver| 10.1.0.5   | Ubuntu 20.04     |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP address: 
- 203.40.165.9, Kibana can also be accessed from this IP via URL 

Machines within the network can only be accessed by Jump-Box-Provisoner.
- Jump-Box-Provisioner is used by means of the cranky_gould container attached with Internal IP address 10.0.0.4

A summary of the access policies in place can be found in the table below.

| Name                | Publicly Accessible | Allowed IP Addresses |
|---------------------|---------------------|----------------------|
| Jump-Box-Provisoner | No                  | Home IP              |
| Web-1               | No                  | 10.0.0.4             |
| Web-2               | No                  | 10.0.0.4             |
| Web-3               | No                  | 10.0.0.4             |
| ELKStack            | No                  | Home IP, 10.0.0.4    |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because this allows users to deploy multiple servers in a single playbook.

The playbook implements the following tasks:
- Install docker.io
- Install python-pip
- Install docker container: elk
- Setup and launch elk
- Configure elk to start on boot

The following screenshot displays the result of running `sudo docker ps` after successfully configuring the ELK instance.

![alt text](https://github.com/dsharma323/Bootcamp-work-/blob/main/Images/Docker%20ps%20output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 10.0.0.5
- Web-2 10.0.0.6
- Web-3 10.0.0.7


We have installed the following Beats on these machines:
- Filebeat
- Metricbeat


These Beats allow us to collect the following information from each machine:
- Filebeat: This beat monitors log files from specified locations, collects log events and forwards it to Logstash or Elasticsearch for indexing. 
![alt text](https://github.com/dsharma323/Bootcamp-work-/blob/main/Images/Filebeat%20successful.png)
- Metricbeat: This beat monitors the metrics of the system such as CPU usage, memory usage and other services. The collected data is forwarded to the specified output e.g., Elasticsearch or Logstash.
![alt text](https://github.com/dsharma323/Bootcamp-work-/blob/main/Images/Metricbeat%20successful.png)


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook file to /etc/ansible.
- Update the hosts file to include the webservers and ELKStack server:
	-/etc/ansible/hosts should include the following:
-	[webservers]
-	10.0.0.5 ansible_pything_interpreter=/usr/bin/python3
-	10.0.0.6 ansible_pything_interpreter=/usr/bin/python3
-	10.0.0.7 ansible_pything_interpreter=/usr/bin/python3
-	[elk]
-	10.1.0.5 ansible_pything_interpreter=/usr/bin/python3

- Run the playbook, navigate to the ELKStackserver and run sudo docker ps to check that the installation worked as expected.
- Playbook: elk-playbook.yml Location: /etc/ansible/elk-playbook.yml
- The hosts file will specify which hosts are affected when running playbooks. Each playbook will have their own host outlined in the specific playbook which is linked to the hosts file. To configure the different machines, the host and the IP addresses must be specified. 
- Navigate to http://[ELKStackserver.externalIP]:5601/app/kibana to confirm that ELK and kibana are running.

The command to run the playbook is:
-	ansible-playbook elk-playbook.yml

Refer to the Ansible folder for the YAML playbooks. 

### Test the system

After ensuring that the beats are being received by the ELKStack server, test the system to see if Kibana can show that the tests were undertaken. 

The following tests are to be conducted:
-	SSH Barrage
-	Use of a for/while nested script to determine if Kibana shows the failed login entries. Refer to the Linux folder for the script.
![alt text](https://github.com/dsharma323/Bootcamp-work-/blob/main/Images/SSH%20login%20failure.png)
-	Stress test
-	Use the stress function to stress the system.
-	SSH into Web-1, Web-2 and Web-3.
-	Install stress:
-	Run ‘sudo apt install stress’.
-	Run ‘sudo stress --cpu 1 –timeout 180’ to stress the WebVM for 3minutes.
-	Record the result. Refer to the image below as an example.
![alt text](https://github.com/dsharma323/Bootcamp-work-/blob/main/Images/Stress%20test.png)
Wget-DoS
-	If necessary download the wget function with the following command, ‘sudo apt install wget’on the jumpbox. 
-	Run the command ‘wget IP.of.Web.VM’.
-	Notice wget creates an output.
-	Create a for/while nested loop to simulate a Denial of Service (DoS) attack. Refer to the Linux folder to find the script.
-	Ensure that the outputs from wget are sent to the /dev/null file for disposal.
-	You will find that the incoming traffic is significantly increased.



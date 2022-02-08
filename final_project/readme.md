# Autocreating Jenkins host and target hosts in Azure Cloud

This are files for crate and configure an infrastructure in AZURE cloud. It creates amount of virtual machines witch sets in  variable "node_count".
Every VM will have public ip and Azure domain name. The first of them will be Jenkins host, other - target hosts with nginx web server in docker conteiner.
As a result it be able to manually configure Jenkins job for update file index.php on all web servers.

Requirements on host witch executed creating: terraform, azure-cli and ansible have been installed, internet access, azure subscription.

Save files to working directory.
Change values in file variables.tf:
- my_tenant_id
- my_subscription_id
- and other if you need.

Login into your azure subscription. If host dosn't have brouser use "az login --use-device-code".
Do "terraform apply main.tf file".
After this, count of VM will be created.
Terraform will start ansible whith two playbooks:
- The First creates Jenkins host,  will copy private key to jenkins folder, will install ChuckNorris plugin
and  will change Jenkins initialAdminPassword to credentials set in vars in ansible playbook.
- The Second creates web servers will add docker image with nginx service and will copied index.php file into nginx home directory.

All tasks should be positive complete.

Outputs should include public IP addresses, fqdn for each VM and sensetive private key for ssh connections.

Open http web page port 8080 for jenkins host

Open http web pages port 80 for all other fqdn. You should see they ip addresses on pages content.

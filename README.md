# Terraform-Template
The terraform template is design to automate the process of deploying an AWS instance, running undertow server and deploying an application.

-- This terraform template has the following configuration
- 1 Application Load Balancer
- 5 m5.large AWS instances on which undertow server would run.

Please create a file named terraform.tfvars and update the values defined in the file variables.tf.

I have considered the region to be "us-east-1", and availability zones  to be "us-east-1a" and "us-east-1c". Please make sure to update the subnetIds  of these regions only. These are configurable based on your specifications.

Please specify the path where the java files are stored in your local machine. The script is designed to fetch them and copy in the required place of the instance as well as run the server with the required application.

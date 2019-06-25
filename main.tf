########################################################
# This terraform template has the following configuration
# - 1 Application Load Balancer
# 5 m5.large AWS instances on which undertow server would run.

# Please create a file named terraform.tfvars and update the values defined
# in the file variables.tf.

# We have considered the region to be "us-east-1", and availability zones
# to be "us-east-1a" and "us-east-1c". Please make sure to update the subnetIds
# of these regions only.

# Please specify the path where the submitted java files are stored. The script
# is designed to fetch them and copy in the required place of the instance. This
# is important to start the server correctly.

############################################################

############################
# FIRST SECTION BEGINS     #
# CREATING TAGS            #
############################

locals {
  common_tags = {
    Project = "phase1"
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

############################
# SECOND SECTION BEGINS    #
# CREATING SECURIY GROUPS  #
############################

resource "aws_security_group" "instance" {
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${local.common_tags}"
}

############################
# THIRD SECTION BEGINS     #
# CREATING AWS_VPC         #
############################

# Commment this if you would not like to use this vpc
# and instead have a default vpc.

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

#############################
# FOURTH SECTION BEGINS     #
# CREATING INSTANCE-1       #
#############################

# Creating the instance

resource "aws_instance" "region1" {
  count = "1"
  ami = "ami-0565af6e282977273"
  instance_type = "m5.large"
  key_name = "${var.key_name}"
  availability_zone = "us-east-1a"
  security_groups = ["${aws_security_group.instance.name}"]
  tags = "${local.common_tags}"

  # Establishing connection with the instance

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file(var.key_path)}"
  }

  # Installation of required software and files

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-8-jdk",
      "sudo apt-get install -y maven",
      "mvn archetype:generate -DgroupId=com.mastertheboss.undertow -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false -DartifactId=undertow-server"
    ]
  }

  # Copying the files to the respective folder in the instance

  provisioner "file" {
    source = "${var.input_file_path}"
    destination = "/home/ubuntu"
  }

  # Running the server

  provisioner "remote-exec" {
    inline = [
      "cd undertow-server",
      "nohup sudo mvn clean package exec:java &",
      "sleep 10",
      "ls"
    ]
  }
}

############################
# CREATING INSTANCE-2      #
############################

resource "aws_instance" "region1a" {
  count = "1"
  ami = "ami-0565af6e282977273"
  instance_type = "m5.large"
  key_name = "${var.key_name}"
  availability_zone = "us-east-1a"
  security_groups = ["${aws_security_group.instance.name}"]
  tags = "${local.common_tags}"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("/Users/admin/Desktop/TeamCloud15619.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-8-jdk",
      "sudo apt-get install -y maven",
      "mvn archetype:generate -DgroupId=com.mastertheboss.undertow -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false -DartifactId=undertow-server"
    ]
  }

  provisioner "file" {
    source = "${var.input_file_path}"
    destination = "/home/ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "cd undertow-server",
      "nohup sudo mvn clean package exec:java &",
      "sleep 10",
      "ls"
    ]
  }
}

############################
# CREATING INSTANCE-3      #
############################

resource "aws_instance" "region2" {
  count = "1"
  ami = "ami-0565af6e282977273"
  instance_type = "m5.large"
  key_name = "${var.key_name}"
  availability_zone = "us-east-1c"
  security_groups = ["${aws_security_group.instance.name}"]
  tags = "${local.common_tags}"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("/Users/admin/Desktop/TeamCloud15619.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-8-jdk",
      "sudo apt-get install -y maven",
      "mvn archetype:generate -DgroupId=com.mastertheboss.undertow -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false -DartifactId=undertow-server"
    ]
  }

  provisioner "file" {
    source = "${var.input_file_path}"
    destination = "/home/ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "cd undertow-server",
      "nohup sudo mvn clean package exec:java &",
      "sleep 10",
      "ls"
    ]
  }
}

############################
# CREATING INSTANCE-4      #
############################
resource "aws_instance" "region2a" {
  count = "1"
  ami = "ami-0565af6e282977273"
  instance_type = "m5.large"
  key_name = "${var.key_name}"
  availability_zone = "us-east-1c"
  security_groups = ["${aws_security_group.instance.name}"]
  tags = "${local.common_tags}"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("/Users/admin/Desktop/TeamCloud15619.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-8-jdk",
      "sudo apt-get install -y maven",
      "mvn archetype:generate -DgroupId=com.mastertheboss.undertow -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false -DartifactId=undertow-server"
    ]
  }

  provisioner "file" {
    source = "${var.input_file_path}"
    destination = "/home/ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "cd undertow-server",
      "nohup sudo mvn clean package exec:java &",
      "sleep 10",
      "ls"
    ]
  }
}

############################
# CREATING INSTANCE-5      #
############################

resource "aws_instance" "region2b" {
  count = "1"
  ami = "ami-0565af6e282977273"
  instance_type = "m5.large"
  key_name = "${var.key_name}"
  availability_zone = "us-east-1c"
  security_groups = ["${aws_security_group.instance.name}"]
  tags = "${local.common_tags}"

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("/Users/admin/Desktop/TeamCloud15619.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-8-jdk",
      "sudo apt-get install -y maven",
      "mvn archetype:generate -DgroupId=com.mastertheboss.undertow -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false -DartifactId=undertow-server"
    ]
  }

  provisioner "file" {
    source = "${var.input_file_path}"
    destination = "/home/ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "cd undertow-server",
      "nohup sudo mvn clean package exec:java &",
      "sleep 10",
      "ls"
    ]
  }
}
###########################################
# FIFTH SECTION BEGINS                    #
# CREATING AWS TARGET GROUP               #
# REGISTER INSTANCES WITH TARGET GROUP    #
###########################################

resource "aws_lb_target_group" "target" {
  name = "targetgroup"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_security_group.instance.vpc_id}"
}

resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = "${aws_lb_target_group.target.arn}"
  target_id = "${aws_instance.region1.id}"
  port = 80
}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = "${aws_lb_target_group.target.arn}"
  target_id = "${aws_instance.region1a.id}"
  port = 80
}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = "${aws_lb_target_group.target.arn}"
  target_id = "${aws_instance.region2.id}"
  port = 80
}

resource "aws_lb_target_group_attachment" "attach3" {
  target_group_arn = "${aws_lb_target_group.target.arn}"
  target_id = "${aws_instance.region2a.id}"
  port = 80
}

resource "aws_lb_target_group_attachment" "attach4" {
  target_group_arn = "${aws_lb_target_group.target.arn}"
  target_id = "${aws_instance.region2b.id}"
  port = 80
}
#####################################
# SIXTH SECTION BEGINS              #
# CREATING AWS LOAD BALANCER GROUP  #
#####################################

resource "aws_lb" "elb" {
  name = "elbphase1"
  internal  = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.instance.id}"]
  subnets    = "${var.subnet_id}"
  tags = "${local.common_tags}"
}

####################################
# SEVENTH SECTION BEGINS           #
# CREATING AWS LOAD BALANCER GROUP #
#####################################


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.elb.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.target.arn}"
  }
}

#######################################################
# Note: The servers are started as a background process.
# Hence, please make sure to do "terraform destroy" or
# kill them manually, else they would remain running!
#######################################################










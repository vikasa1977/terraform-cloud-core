#this data source block will query the ami as per the region you specified in provider file
data "aws_ami" "linux" {
  
  most_recent      = true
  
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values=["x86_64"]
  }
}

resource "aws_launch_template" "web" {
    name_prefix = "web"
    image_id = data.aws_ami.linux.id 
    instance_type = var.web_instance_type
    vpc_security_group_ids = [ var.web_sg]
    user_data = filebase64("install_apache.sh")
    tags = {
      Name = "web"
    }
  
}

resource "aws_autoscaling_group" "web" {
  name = "web"
  vpc_zone_identifier = tolist(var.public_subnet)
  min_size = 2
  max_size = 3
  desired_capacity = 2

  launch_template {
    id = aws_launch_template.web.id 
    version = "$Latest"
  }
}
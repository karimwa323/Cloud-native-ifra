# resource "aws_security_group" "jenkins_sg" {
#   name        = "${var.project_name}-jenkins-sg"
#   description = "Jenkins security group"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 50000
#     to_port     = 50000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   owners = ["099720109477"]

#   filter {
#     name = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }
# }

# resource "aws_instance" "jenkins" {

#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.instance_type
#   subnet_id     = var.subnet_id

#   iam_instance_profile = var.iam_instance_profile

#   vpc_security_group_ids = [
#     aws_security_group.jenkins_sg.id
#   ]

#   key_name = var.key_name

#   user_data = file("${path.module}/install_jenkins.sh")

#   tags = {
#     Name = "jenkins-master"
#   }
# }

# resource "aws_ebs_volume" "jenkins_data" {
#   availability_zone = "eu-central-1a"
#   size              = 20  
#   type              = "gp3"

#   tags = {
#     Name = "jenkins-data-disk"
#   }
# }

# resource "aws_volume_attachment" "jenkins_att" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.jenkins_data.id
#   instance_id = aws_instance.jenkins.id
# }
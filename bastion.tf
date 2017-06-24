resource "aws_instance" "bastion" {
    ami = "ami-a81402cc"
    instance_type = "t2.small"
    count = "1"
    associate_public_ip_address = "true"
    key_name = "terraform-eu-west-2"
    subnet_id = "${aws_subnet.a.id}"
    vpc_security_group_ids = [
      "${aws_security_group.bastion.id}"
    ]

    root_block_device = {
      volume_size = 10
    }

    connection {
      user = "ubuntu"
      private_key = "${file("~/.ssh/terraform-eu-west-2.pem")}"
      agent = false
    }

    tags {
      Name = "${var.vpc_key}-bastion"
      VPC = "${var.vpc_key}"
      Terraform = "Terraform"
    }
}

output "bastion_host" {
  value = "${aws_instance.bastion.public_dns}"
}

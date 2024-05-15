#creation provisioner to run once the resources are created
#creation provisioners will run only during resource creation
#provisioners are not allowed to directly refer resource block so we use self object to refer them 
#self object is used to refer resources block 
resource "aws_instance" "db" {
    ami = "ami-090252cbe067a9e58"
    vpc_security_group_ids = [ "sg-01f82b121228b3b22" ]
    instance_type = "t2.micro"
    tags = {
       Name = "db"
       environment = "dev"
    }

    provisioner "local-exec" {
        command = "echo ${self.private_ip} > private_ips.txt" 
    }

    #provisioner "local-exec" {
    #   command = "ansible-playbook -i private_ips.txt web.yaml"
      
    #}
    connection {
      type = "ssh"
      user = "ec2-user"
      password = "DevOps321"
      host = self.public_ip
    }

# terraform can also connect to the remote server using ssh and run the commands/playbooks/scripts using remote-exec provisioner
    provisioner "remote-exec" {
        inline = [ 
            "sudo dnf install ansible -y",
            "sudo dnf install nginx -y",
            "sudo systemctl start nginx"

        ]
      
    }

}

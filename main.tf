# A lot of group names use id or ids at the end.  No idea why.  Maybe to signal its joining two things together?

resource "aws_instance" "Morrowind_Server" {            # Creating a resource on AWS.  This resource is a EC2 instance that I have named Morrowind_Server.  This name only shows up in the code
  ami                         = "ami-0be4df43474a2f063" # Windows Server 2022 Base (eu-west-1)
  instance_type               = "t2.micro"              # T2.micro is the type of service.  T2.micro comes with 1 CPU core and 1 GB of ram
  key_name                    = var.key_pair_name       # Don't quite understand this yet.  I think I am declaring a variable now that is empty that will be filled by a EC2 key pair I create on AWS?
  associate_public_ip_address = true                    # Gives the instance a public IP Address

  tags = {
    Name = "MorrowindServer" # Names the instance MorrowindServer on EC2
  }

  vpc_security_group_ids = [aws_security_group.rdp_access.id] # This applies the secuirty group below to resource
}

resource "aws_security_group" "rdp_access" { # Creating a new security group called rdp_access in code
  name        = "rdp-access"                 # The new security group will be called rdp-access on AWS
  description = "Allow RDP from anywhere"    # A description of what the group does.  It is going to allow an RDP connection from anyone anywhere
  vpc_id      = data.aws_vpc.default.id      # My EC2 instance uses a VPC for its networking.  I am going to edit and use the VPC that is created by defailt when spinning up a new EC2 instance

  ingress {                     # Incoming traffic
    from_port   = 3389          # Allow incoming traffic through port 3389.  Port 3389 is used for RDP
    to_port     = 3389          # See above
    protocol    = "tcp"         # Protocol used
    cidr_blocks = ["0.0.0.0/0"] # Allow this port to be used by any IP on any subnet.  This is a security risk
  }

  ingress {                     # Incoming traffic.
    from_port   = 25565         # Allow incoming traffic through port 25565.  Port 25565 is used for the Morrowind Co Op server
    to_port     = 25565         # See above
    protocol    = "tcp"         # Protocol used
    cidr_blocks = ["0.0.0.0/0"] # Allow this port to be used by any IP on any subnet.  This is a security risk
  }

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {                      # Outbound traffic
    from_port   = 0             # Any port
    to_port     = 0             # Any port
    protocol    = "-1"          # Any protocol
    cidr_blocks = ["0.0.0.0/0"] # Allow this port to be used by any IP on any subnet.  This is a security risk
  }

}

data "aws_vpc" "default" { # Defining the VPC that is creating by default when spinning up a EC2 instance for this code
  default = true           # See above
}

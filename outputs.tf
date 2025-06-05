output "instance_id" {                  # The name of the output in code
  value = aws_instance.Morrowind_Server # Output the name of the EC2 instance (MorrowindServer)
}

output "public_ip" {                              # The name of the output in code
  value = aws_instance.Morrowind_Server.public_ip # Retreive and show the public IP of the EC2 instance
}
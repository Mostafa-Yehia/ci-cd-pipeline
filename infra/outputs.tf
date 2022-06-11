
output ec2pubip {
    value = aws_instance.ec2a.public_ip
}

output ec2prvip {
    value = aws_instance.ec2b.private_ip
}

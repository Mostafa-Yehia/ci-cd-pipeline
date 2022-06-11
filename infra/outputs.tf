output ec2pubip {
    value = aws_instance.ec2a.public_ip
}

output ec2prvip {
    value = aws_instance.ec2b.private_ip
}

output rdshost {
    value = aws_db_instance.my_rds.address
}

output rdsport {
    value = aws_db_instance.my_rds.port
}

output rdsusername {
    value = aws_db_instance.my_rds.username
}

output rdspassword {
    value = module.vars.my_secret
}

output redishost {
    value = aws_elasticache_cluster.my_redis.cluster_address
}


output redisport {
    value = aws_elasticache_cluster.my_redis.port
}

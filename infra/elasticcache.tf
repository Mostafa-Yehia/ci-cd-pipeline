resource "aws_elasticache_cluster" "my_redis" {
  cluster_id           = "my_redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  engine_version       = "3.2.10"
  port                 = 6379
  security_group_ids = [aws_security_group.my_elasticcache_secgrp.id]
  subnet_group_name    = aws_elasticache_subnet_group.my_elasticcache_subgrp.name
}

resource "aws_security_group" "my_elasticcache_secgrp" {
  name        = "my_elasticcache_secgrp"
  description = "my_elasticcache_secgrp"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "port 6379"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = [module.network.private_subnet_one.cidr_block,module.network.private_subnet_two.cidr_block]
  }
  depends_on = [
    module.network.private_subnet_one_id,
    module.network.private_subnet_two_id
  ]

  tags = {
    Name = "elasticcache"
  }
}

resource "aws_elasticache_subnet_group" "my_elasticcache_subgrp" {
  name       = "my_elasticcache_subgrp"
  subnet_ids = [module.network.private_subnet_one_id,module.network.private_subnet_two_id]
}

resource "aws_elasticache_user" "my_elasticcache_user" {
  user_id       = "admin"
  user_name     = "admin"
  access_string = "on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember"
  engine        = "REDIS"
  passwords     = [module.vars.my_secret]
}

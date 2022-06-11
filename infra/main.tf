module "network" {
    source = "./network"
    vpc_cidr = var.vpc_cidr
    name = var.name
    public_subnet_one_cidr = var.public_subnet_one_cidr
    public_subnet_two_cidr = var.public_subnet_two_cidr
    private_subnet_one_cidr = var.private_subnet_one_cidr
    private_subnet_two_cidr = var.private_subnet_two_cidr
    az1 = var.az1
    az2 = var.az2
    region = var.region
    public_subnet_one = var.public_subnet_one
    public_subnet_two = var.public_subnet_two
    private_subnet_one = var.private_subnet_one
    private_subnet_two = var.private_subnet_two
}

module "vars" {
    source = "./vars"
    bucket = 
    key    = 
}

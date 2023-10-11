
module "vpc"{
  source    = "./vpc"
  env_name  = "develop"
  zone      = "ru-central1-a"
  cidr      = ["10.0.1.0/24"]
}


module "remote" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "remote"
  network_id      = module.vpc.network_id
  subnet_zones    = [var.default_zone]
  subnet_ids      = [ module.vpc.subnet_id ]
  instance_name   = var.vm_web_name
  instance_count  = 1
  image_family    = var.image_family
  public_ip       = true
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
  }
}

data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
 vars ={
  ssh_public_key = file(var.ssh_public_key) //
 }
}

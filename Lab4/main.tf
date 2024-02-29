terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0" # 
    }
  }
}

provider "docker" {
  # Provider configuration can be placed here, if needed
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "nginx-container"
  ports {
    internal = 80
    external = 8080
  }
  volumes {
    container_path = "/usr/share/nginx/html"
    host_path      = "${abspath("${path.module}/nginx-data")}"
    read_only      = false
  }
}


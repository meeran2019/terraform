terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.31.0"
        }
    }
}

provider "aws"{

}

data "aws_efs_file_system" "by_tag"{
    tags = {
        env = "dev",
        name = "efs"
        Name = "test"
    }
}

output "efs-id" {
    value = data.aws_efs_file_system.by_tag.file_system_id
}

data "aws_efs_access_points" "ap" {
file_system_id = data.aws_efs_file_system.by_tag.file_system_id
# filter {
#     name   = "tag:Name"
#     values = ["access-point-1"]
#   }
}

output "efs-access-data" {
    value = data.aws_efs_access_points.ap
}


resource "null_resource" "sample"{
provisioner "local-exec" {
    command = "echo test"
}
}


provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      version = "~> 3.0"
    }
  }
  required_version = ">=0.13"
}


resource "aws_batch_job_definition" "diabatchjob" {
  name = "test-batch-job-definition-terraform"
  type = "container"

  container_properties = <<CONTAINER_PROPERTIES
{
    "image": "nginx",
    "memory": 1024,
    "vcpus": 1,
    "environment": [
        {"name": "env", "value": "dev"},
        {"name": "region", "value": "us-east-1"}
    ],
    "volumes": [
        {
            "host": {
                "sourcePath": "/opt/gbs_cloud_lz/c2c/dia"
            },
            "name": "efs1"
        },
        {
            "host": {
                "sourcePath": "/opt/claims/c2c/dia"
            },
            "name": "efs2"
        },
        {
            "host": {
                "sourcePath": "/opt/claims/c2c/cdp"
            },
            "name": "efs1"
        }                
    ],
    "mountPoints": [
        {
            "containerPath": "/data1",
            "sourceVolume": "efs1",
            "readOnly": false
        },
        {
            "containerPath": "/data2",
            "sourceVolume": "efs2",
            "readOnly": false
        },
        {
            "containerPath": "/data3",
            "sourceVolume": "efs3",
            "readOnly": false
        }                
    ]
    }
CONTAINER_PROPERTIES    
}
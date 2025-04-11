# Golang-ECS-Terraform

This is a sample project to demonstrate how a golang api can be dockerized and deployed on AWS ECS

## Instructions 

### Local 
#### Build Docker Image 
run `bash build-image.sh`

#### Run Docker Image 
run `bash run-image.sh`


### AWS ECS 
#### Terraform to Configure Infra ( un tested)
- `terraform init` to intiaize
- `terraform plan` to preview the resourecs that will be created when applied
- `terraform apply` to apply the resources, this will create the infra

once applied , terraform will output a link to your deployed application

##### Example http://datetime-api-lb-1234567890.us-east-1.elb.amazonaws.com/datetime


Note: Infra/ scripts  to upload or build images to AWS ECR are not part of this repo



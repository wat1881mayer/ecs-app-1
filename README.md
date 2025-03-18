# README for ECS Application

## Overview
This project is an AWS ECS application that serves a basic homepage using Nginx. It utilizes CloudFormation to define the necessary resources for deployment.

## Project Structure
- `cloudformation/ecs-cluster.yml`: Defines the ECS cluster resource.
- `cloudformation/ecs-service.yml`: Defines the ECS service resource.
- `cloudformation/task-definition.yml`: Defines the task definition for the ECS application.
- `Dockerfile`: Contains instructions to build the Docker image.
- `index.html`: Contains the HTML content for the homepage.
- `README.md`: Documentation for the project.

## Prerequisites
- AWS Account
- AWS CLI configured with appropriate permissions
- Docker installed on your local machine

## Deployment Instructions
1. **Build the Docker Image**
   Navigate to the project directory and build the Docker image using the following command:
   ```
   docker build -t ecs-app .
   ```

2. **Push the Docker Image to ECR**
   - Create an ECR repository in your AWS account.
   - Authenticate Docker to your ECR registry.
   - Tag and push the Docker image to ECR:
   ```
   docker tag ecs-app:latest <your-account-id>.dkr.ecr.<region>.amazonaws.com/ecs-app:latest
   docker push <your-account-id>.dkr.ecr.<region>.amazonaws.com/ecs-app:latest
   ```

3. **Deploy the CloudFormation Stack**
   Use the AWS CLI to deploy the CloudFormation stack:
   ```
   aws cloudformation create-stack --stack-name ecs-app-stack --template-body file://cloudformation/ecs-cluster.yml
   aws cloudformation create-stack --stack-name ecs-app-service-stack --template-body file://cloudformation/ecs-service.yml
   ```

4. **Access the Application**
   Once the stack is created, you can access the application using the public IP or DNS of the load balancer created by the ECS service.

## Cleanup
To delete the resources created by the CloudFormation stack, run:
```
aws cloudformation delete-stack --stack-name ecs-app-service-stack
aws cloudformation delete-stack --stack-name ecs-app-stack
```
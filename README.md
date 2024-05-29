# DevOps Take-Home Challenge

## Objective
To assess your skills in continuous integration, continuous deployment, and infrastructure as code, you will complete the following tasks.
You will deploy this small web application using a CI/CD pipeline, and manage the infrastructure using Terraform.

## Overview
You will use Docker to containerize the application, set up a CI/CD pipeline using GitHub Actions, and manage the infrastructure on AWS using Terraform.

## Tasks

1**Containerization**
    - Write a Dockerfile to containerize the application.
    - Ensure the application runs correctly inside the container.

2**Continuous Integration (CI)**
    - Set up a GitHub repository for your application.
    - Configure GitHub Actions to:
        - Automatically build the Docker image upon each commit.
        - Run a basic lint check or unit test.

3**Infrastructure as Code (IaC)**
    - Use Terraform to provision the necessary infrastructure on AWS:
        - An EC2 instance to host your application.
        - Security group to allow necessary traffic (e.g., port 80 for HTTP).
    - Ensure the Terraform scripts are modular and reusable.

4**Continuous Deployment (CD)**
    - Extend the GitHub Actions workflow to:
        - Push the Docker image to a container registry (e.g., Docker Hub).
        - Deploy the application to the EC2 instance using the Docker image.

## Deliverables

1. **Code Repository:**
    - A fork of this GitHub repository with:
        - The source code of application.
        - The Dockerfile.
        - GitHub Actions workflows.
        - Terraform scripts.

2. **Documentation:**
    - A README.md file explaining:
        - How to build and run the application locally.
        - How to set up the infrastructure using Terraform.
        - How to deploy the application using the CI/CD pipeline.

## Submission
Submit the link to your GitHub repository to vlad@qed.team.

## Live version can be found here
[http://comcast.raviramadoss.me](http://comcast.raviramadoss.me) Will redirect to https
[https://comcast.raviramadoss.me](https://comcast.raviramadoss.me)

# System Architecture README

## Overview

This document describes the architecture of a distributed web application system utilizing various Amazon Web Services (AWS) components, along with DNS services provided by Route 53, and automation facilitated by Ansible.

## Components

### Global Services

- **Route 53**: Manages DNS, directing traffic to the appropriate resources.

### VPC and Networking

- **VPC (Virtual Private Cloud)**: Establishes a private network for deploying AWS resources. It's segmented into two subnets:
  - **Subnet 1**: Reserved for specific resources, possibly public-facing services.
  - **Subnet 2**: Reserved for different resources, possibly for internal services or a different availability zone for high availability.

### Load Balancing and Content Distribution

- **Application Load Balancer (ALB)**: Distributes incoming application traffic across multiple targets, such as EC2 instances, in multiple Availability Zones, which increases the fault tolerance of the application.

### Security

- **Security Group**: Acts as a virtual firewall to control inbound and outbound traffic for resources.

### Auto Scaling

- **Auto Scaling Group**: Automatically adjusts the number of EC2 instances to maintain application performance and to scale the capacity up or down according to conditions defined.

### EC2 Instances

- **Amazon EC2 Instance**: Virtual servers in AWS's Elastic Compute Cloud for running applications.
  - Instances in **blue target group**: Belong to one scaling group or service.
  - Instances in **green target group**: Belong to another scaling group or service, potentially for staged deployments or blue/green deployments.

### Configuration Management

- **Ansible**: An open-source tool for software provisioning, configuration management, and application deployment. It's depicted at the bottom, implying it's used to configure and manage the infrastructure.

### Certificates

- **AWS Certificate Manager**: Handles SSL/TLS certificates for secure traffic.

### Database

- **RDS (Relational Database Service)**: Provides resizable capacity for a cloud-based relational database and manages common database administration tasks.

## Traffic Flow

1. User requests are directed to Route 53.
2. Route 53 routes the traffic to the Application Load Balancer based on DNS records.
3. The ALB distributes the traffic across the EC2 instances in the Auto Scaling Groups, utilizing the Security Groups' rules.
4. The EC2 instances process the requests and interact with RDS for data storage and retrieval.
5. AWS Certificate Manager ensures secure traffic between clients and the application.

## Automation and Management

- Ansible is used to automate the deployment, scaling, and management of the application infrastructure, ensuring that the environment is provisioned consistently and efficiently.

## High Availability and Fault Tolerance

- The use of multiple Availability Zones for EC2 instances and RDS ensures high availability and fault tolerance of the application.
- Auto Scaling Groups ensure that the application can handle the load by adjusting the number of instances automatically.

## Security

- Security Groups control the traffic to EC2 instances, ensuring that only authorized traffic can access the application.

---

This README provides a high-level overview of the system's architecture. For implementation details, each component's configuration should be further documented in separate sections.


## Issues faced
circular dependency
https://github.com/hashicorp/terraform-provider-aws/issues/12010
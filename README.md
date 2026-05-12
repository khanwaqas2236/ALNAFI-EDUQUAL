# Supply Chain Security & Industrial Cybersecurity Lab

## Overview

This project demonstrates a real-world Supply Chain Security and Container Vulnerability Management lab designed for cybersecurity learning, SOC training, and DevSecOps practice.

It simulates:
- Secure lab environment setup
- Software supply chain compromise scenarios
- Industrial (OT/ICS) cybersecurity risks
- Vulnerable application deployment
- Vulnerability scanning and detection

It is aligned with:
- NIST SP 800-161 (Supply Chain Risk Management)
- ISO 28000 (Supply Chain Security Management)

## Objectives

- Understand how vulnerabilities enter through third-party software
- Simulate supply chain attacks in a controlled environment
- Analyze container security risks
- Perform vulnerability scanning using industry tools
- Learn detection and response workflows

## Dependencies Installation

Before running the lab, install the required dependencies.

### System Packages
sudo apt update
sudo apt install docker.io docker-compose python3-pip curl git jq -y

### Enable Docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

Restart terminal after this step.

### Install Security Tools

Trivy:
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh

Grype:
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sudo sh

## What Each Script Does

### 1. setup.sh

This script prepares the full lab environment.

It installs:
- Docker and dependencies
- OSQuery for system monitoring
- Anchore Engine for container scanning
- Clair vulnerability scanner
- Vulnerable Docker images

Purpose: Builds the base DevSecOps + supply chain security lab.

### 2. real-case-scenario.sh

This script simulates a real-world industrial supply chain attack.

It models a SmartPump industrial system and demonstrates:
- Third-party dependency risks
- Malicious analytics agent simulation
- Insecure supply chain ingestion
- Industrial protocol exposure (Modbus concept)

Security actions:
- Risk assessment (NIST SR controls)
- Runtime monitoring using OSQuery
- Vulnerability scanning using Grype

Purpose: Demonstrates OT/ICS supply chain attack scenarios.

### 3. Equifax_Breach.sh

This script deploys a vulnerable web application using:
- Apache Struts 2.3.32
- Tomcat 8.5

It simulates a CVE scenario similar to the Equifax breach.

It demonstrates:
- CVE-based exploitation model
- Container-based vulnerable deployment
- Image scanning using Trivy

Purpose: Shows real-world vulnerability exploitation via insecure dependencies.

## Tools Used

- Docker
- Trivy (container vulnerability scanner)
- Grype (software composition analysis)
- Clair (CVE detection engine)
- OSQuery (system monitoring)

## Architecture

- Infrastructure Layer → Docker environment
- Supply Chain Layer → External dependencies
- Application Layer → Vulnerable services
- Monitoring Layer → Security tools

## Disclaimer

This project is for educational and research purposes only.

Do not use in production environments.

## Skills Demonstrated

- Supply Chain Risk Management
- DevSecOps security practices
- Container security analysis
- Vulnerability scanning (SCA)
- SOC monitoring and detection
- OT/ICS cybersecurity fundamentals

## Standards Referenced

- NIST SP 800-161
- ISO 28000
- CVE-based vulnerability modeling

## Author

Waqas Ahmed Tahir  
Cybersecurity / SOC / OT Security Enthusiast  
Focus: Supply Chain Security and Industrial Cybersecurity

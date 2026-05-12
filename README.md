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

---

## Objectives

- Understand how vulnerabilities enter through third-party software
- Simulate supply chain attacks in a controlled environment
- Analyze container security risks
- Perform vulnerability scanning using industry tools
- Learn detection and response workflows

---

## Lab Scenarios

### 1. Lab Environment Setup

This script prepares the cybersecurity lab environment:

- Installs Docker
- Configures OSQuery for monitoring
- Sets up Anchore Engine for scanning
- Deploys Clair for vulnerability analysis
- Downloads vulnerable container images for testing

---

### 2. Supply Chain Attack Simulation (Industrial OT Scenario)

This scenario simulates an industrial control system (SmartPump Inc.) compromise.

It demonstrates:
- Third-party dependency risks
- Malicious analytics agent simulation
- Insecure supply chain ingestion
- Industrial protocol exposure (Modbus concept)

Security activities included:
- Risk assessment (NIST SR controls)
- Runtime monitoring using OSQuery
- Vulnerability scanning using Grype

---

### 3. Vulnerable Application Deployment (Equifax Case Study)

This scenario deploys a vulnerable web application based on Apache Struts 2.3.32.

It demonstrates:
- Real-world CVE exploitation model (similar to Equifax breach)
- Containerized vulnerable application deployment
- Image scanning using Trivy

---

## Tools Used

- Docker
- Trivy (container vulnerability scanner)
- Grype (software composition analysis)
- Anchore Engine (policy-based image scanning)
- Clair (CVE detection engine)
- OSQuery (system and container monitoring)

---

## Architecture

The lab follows a layered model:

- Infrastructure layer (Docker environment)
- Supply chain layer (external dependencies)
- Application layer (vulnerable services)
- Monitoring layer (security tools)

---

## How to Run

Step 1: Clone the repository
git clone https://github.com/your-username/supply-chain-security-lab.git

Step 2: Move into scripts folder
cd supply-chain-security-lab/scripts

Step 3: Run lab setup
bash 01-lab-setup.sh

Step 4: Run supply chain simulation
bash 02-supply-chain-simulation.sh

Step 5: Deploy vulnerable application
bash 03-vulnerable-struts-demo.sh

---

## Disclaimer

This project is strictly for educational and research purposes only.

Do not run in production environments.

---

## Skills Demonstrated

- Supply Chain Risk Management
- DevSecOps security practices
- Container security analysis
- Vulnerability scanning and SCA
- SOC monitoring and detection
- OT/ICS cybersecurity fundamentals

---

## Standards Referenced

- NIST SP 800-161
- ISO 28000
- OWASP Container Security Guidelines
- CVE-based vulnerability modeling

---

## Author

Waqas Ahmed Tahir  
Cybersecurity / SOC / OT Security Enthusiast  
Focus: Supply Chain Security and Industrial Cybersecurity

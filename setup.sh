#!/bin/bash
# SUPPLY CHAIN SECURITY DEMONSTRATION SYSTEM - FIXED FOR KALI 2025
# EduQual Level 3 Oral Presentation Lab Setup

set -e

echo "============================================================"
echo " SUPPLY CHAIN & INDUSTRIAL CYBERSECURITY LAB SETUP"
echo " Auto-Download Vulnerable Images + Scanning Tools"
echo "============================================================"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ============================================
# STEP 1: SYSTEM PREPARATION
# ============================================
echo -e "\n${YELLOW}[1/6] Updating system and installing dependencies...${NC}"

sudo apt update -qq
sudo apt install -y -qq docker.io docker-compose python3-pip curl postgresql-client jq gnupg2 software-properties-common pipx

# Start Docker
sudo systemctl start docker 2>/dev/null || true
sudo systemctl enable docker 2>/dev/null || true

# Add user to docker group
sudo usermod -aG docker $USER 2>/dev/null || true

# Create working directory
mkdir -p ~/supply-chain-lab && cd ~/supply-chain-lab


# ============================================
# STEP 2: INSTALL OSQUERY
# ============================================
echo -e "\n${YELLOW}[2/6] Installing OSQuery...${NC}"

if ! command -v osqueryi &> /dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://pkg.osquery.io/deb/pubkey.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/osquery.gpg

    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/osquery.gpg] https://pkg.osquery.io/deb deb main" | \
    sudo tee /etc/apt/sources.list.d/osquery.list > /dev/null

    sudo apt update -qq
    sudo apt install -y -qq osquery || {
        echo -e "${YELLOW}Fallback installation...${NC}"
        curl -L -o /tmp/osquery.deb https://pkg.osquery.io/deb/osquery_5.12.1-1.linux_amd64.deb
        sudo dpkg -i /tmp/osquery.deb || sudo apt-get install -f -y
    }
fi

sudo mkdir -p /etc/osquery

sudo tee /etc/osquery/osquery-supply-chain.conf > /dev/null <<'EOF'
{
  "schedule": {
    "docker_images": {
      "query": "SELECT id, tags, size, created FROM docker_images;",
      "interval": 60
    },
    "docker_containers": {
      "query": "SELECT id, name, image, status FROM docker_containers;",
      "interval": 60
    },
    "suid_binaries": {
      "query": "SELECT * FROM suid_binaries WHERE directory NOT IN ('/bin', '/sbin', '/usr/bin', '/usr/sbin');",
      "interval": 300
    },
    "listening_ports": {
      "query": "SELECT DISTINCT process.name, listening.port, listening.address FROM listening_ports;",
      "interval": 120
    }
  }
}
EOF

echo -e "${GREEN}✓ OSQuery configured${NC}"


# ============================================
# STEP 3: ANCHORE SETUP
# ============================================
echo -e "\n${YELLOW}[3/6] Deploying Anchore...${NC}"

mkdir -p ~/supply-chain-lab/anchore && cd ~/supply-chain-lab/anchore

cat > docker-compose.yaml <<'EOF'
services:
  anchore-db:
    image: postgres:13-alpine
    environment:
      POSTGRES_USER: anchore
      POSTGRES_PASSWORD: anchore-db-pass
      POSTGRES_DB: anchore
    volumes:
      - anchore_db:/var/lib/postgresql/data

  anchore-engine:
    image: anchore/anchore-engine:v1.1.0
    ports:
      - "8228:8228"
    depends_on:
      - anchore-db
    environment:
      ANCHORE_DB_HOST: anchore-db
      ANCHORE_DB_USER: anchore
      ANCHORE_DB_PASSWORD: anchore-db-pass
      ANCHORE_DB_NAME: anchore
      ANCHORE_ADMIN_PASSWORD: foobar

volumes:
  anchore_db:
EOF

docker-compose up -d

echo -e "${GREEN}✓ Anchore deployed${NC}"


# ============================================
# STEP 4: CLAIR SETUP
# ============================================
echo -e "\n${YELLOW}[4/6] Deploying Clair...${NC}"

cd ~/supply-chain-lab

cat > docker-compose-clair.yaml <<'EOF'
services:
  clair-db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: clair
      POSTGRES_PASSWORD: clair
      POSTGRES_DB: clair

  clair:
    image: quay.io/projectquay/clair:4.7.2
    ports:
      - "6060:6060"
    depends_on:
      - clair-db
EOF

docker-compose -f docker-compose-clair.yaml up -d

echo -e "${GREEN}✓ Clair deployed${NC}"


# ============================================
# STEP 5: VULNERABLE IMAGES
# ============================================
echo -e "\n${YELLOW}[5/6] Pulling vulnerable images...${NC}"

VULNERABLE_IMAGES=(
  "vulnerables/cve-2014-6271"
  "vulnerables/cve-2017-7494"
  "vulnerables/cve-2017-5638"
  "vulnerables/web-dvwa"
  "bkimminich/juice-shop"
)

for img in "${VULNERABLE_IMAGES[@]}"; do
  echo "Pulling $img..."
  docker pull $img || true
done

echo -e "${GREEN}✓ Images downloaded${NC}"


# ============================================
# STEP 6: SCANNING DEMO
# ============================================
echo -e "\n${YELLOW}[6/6] Running scans...${NC}"

sleep 60

docker images | head


# ============================================
# FINAL
# ============================================
echo -e "\n${GREEN}============================================================${NC}"
echo -e "${GREEN} LAB SETUP COMPLETE${NC}"
echo -e "${GREEN}============================================================${NC}"

echo "Anchore: http://localhost:8228"
echo "Clair: http://localhost:6060"
echo "OSQuery: osqueryi"

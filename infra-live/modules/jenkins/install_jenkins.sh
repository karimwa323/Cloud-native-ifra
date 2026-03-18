#!/bin/bash

# 1. Mount External Volume for Jenkins Data
# التأكد إن الـ Volume موجود قبل العمليات
sudo mkfs -t xfs /dev/sdh || echo "Volume already has a filesystem"
sudo mkdir -p /var/lib/jenkins
sudo mount /dev/sdh /var/lib/jenkins
echo '/dev/sdh /var/lib/jenkins xfs defaults,nofail 0 2' | sudo tee -a /etc/fstab

# 2. Update and Basic Tools
sudo apt update -y
sudo apt install -y unzip curl apt-transport-https ca-certificates software-properties-common fontconfig

# 3. Install Java 17 (Required for Jenkins)
sudo apt install -y openjdk-17-jre

# 4. Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install -y jenkins

# 5. Performance Tuning (Avoid Service Timeout)
# زيادة الـ Timeout لـ 10 دقائق وزيادة الرامات لـ 2 جيجا
sudo sed -i '/\[Service\]/a TimeoutStartSec=600' /lib/systemd/system/jenkins.service
sudo sed -i 's/Environment="JAVA_OPTS=-Djava.awt.headless=true"/Environment="JAVA_OPTS=-Djava.awt.headless=true -Xms1g -Xmx2g"/' /lib/systemd/system/jenkins.service
sudo systemctl daemon-reload

# 6. Install Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 7. Permissions (Docker & Jenkins)
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins

# 8. Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

# 9. Install Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 10. Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# 11. Final Start and Enable
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl enable jenkins
sudo systemctl start jenkins

# 12. SSH Setup (Optional if already handled by AWS)
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
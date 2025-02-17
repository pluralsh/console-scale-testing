#!/bin/bash

set -e

# disable firewall, otherwise k3s has issues starting up
sudo ufw disable

# PLURAL_CONSOLE_URL and PLURAL_CONSOLE_TOKEN should already be set by the launch userscript
echo "Plural Console URL: ${PLURAL_CONSOLE_URL}"
echo "Plural Console Token: ${PLURAL_CONSOLE_TOKEN}"

# Configure Docker Hub credentials for K3s
sudo mkdir -p /var/lib/rancher/k3s/agent/images/
sudo curl -L -o /var/lib/rancher/k3s/agent/images/k3s-airgap-images-amd64.tar.zst "https://github.com/k3s-io/k3s/releases/download/v1.31.5%2Bk3s1/k3s-airgap-images-amd64.tar.zst"

# Download links for k3s and the plural deployment operator
# The user should NOT have to pass these in so we can keep them constant
export K3S_INSTALL_SCRIPT_URL=https://get.k3s.io/
export PLURAL_DEPLOYMENT_OPERATOR_URL=https://github.com/pluralsh/plural-cli/releases/download/v0.12.1/plural-cli_0.12.1_Linux_amd64.tar.gz
echo "K3S install script URL: ${K3S_INSTALL_SCRIPT_URL}"
echo "Plural deployment operator URL: ${PLURAL_DEPLOYMENT_OPERATOR_URL}"

# Install k3s
curl -s ${K3S_INSTALL_SCRIPT_URL} | INSTALL_K3S_SKIP_DOWNLOAD=true sh -

# Install the plural deployment operator
curl -L -s ${PLURAL_DEPLOYMENT_OPERATOR_URL} | tar xz
sudo mv plural /usr/bin
sudo chmod a+x /usr/bin/plural

# Login to plural console
plural cd login --url ${PLURAL_CONSOLE_URL} --token ${PLURAL_CONSOLE_TOKEN}

# k3s uses a different config file so make sure we have read/write access
sudo chmod 777 /etc/rancher/k3s/k3s.yaml

# set KUBECONFIG to point to the k3s config file
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

echo "KUBECONFIG: ${KUBECONFIG}"

# Get the instance ID so that we don't have dupes in console with same name
export EC2_INSTANCE_ID
EC2_INSTANCE_ID=$(ec2metadata --instance-id)

echo "EC2_INSTANCE_ID: ${EC2_INSTANCE_ID}"

sleep 10

# Deploy the plural deployment operator
plural cd clusters bootstrap --name ec2-test-cluster-"${EC2_INSTANCE_ID}"

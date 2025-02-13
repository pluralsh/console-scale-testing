#!/bin/bash

sudo ufw disable

set -e

# Load environment variables
source /etc/environment

# Verify environment variables are loaded
echo "PLURAL_CONSOLE_URL: $PLURAL_CONSOLE_URL"
echo "PLURAL_CONSOLE_TOKEN: $PLURAL_CONSOLE_TOKEN"

# Download links
export K3S_INSTALL_SCRIPT_URL=https://get.k3s.io/
export PLURAL_DEPLOYMENT_OPERATOR_URL=https://github.com/pluralsh/plural-cli/releases/download/v0.12.1/plural-cli_0.12.1_Linux_amd64.tar.gz

echo "Will download k3s from ${K3S_INSTALL_SCRIPT_URL}"
echo "Will download plural deployment operator from ${PLURAL_DEPLOYMENT_OPERATOR_URL}"

# Install k3s
curl -s ${K3S_INSTALL_SCRIPT_URL} | bash

# Install the plural deployment operator
curl -L -s ${PLURAL_DEPLOYMENT_OPERATOR_URL} | tar xz
sudo mv plural /usr/bin
sudo chmod a+x /usr/bin/plural

echo "Will login to ${PLURAL_CONSOLE_URL} with token ${PLURAL_CONSOLE_TOKEN}"

# Login to plural console
plural cd login --url ${PLURAL_CONSOLE_URL} --token ${PLURAL_CONSOLE_TOKEN}

# k3s uses a different config file so make sure we have read/write access
sudo chmod a+rw /etc/rancher/k3s/k3s.yaml

# set KUBECONFIG to point to the k3s config file
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Get the instance ID so that we don't have dupes in console with same name
export EC2_INSTANCE_ID
EC2_INSTANCE_ID=$(ec2-metadata -i | awk '{print $2}')

echo "EC2_INSTANCE_ID: ${EC2_INSTANCE_ID}"

# Deploy the plural deployment operator
plural cd clusters bootstrap --name ec2-test-cluster-"${EC2_INSTANCE_ID}"
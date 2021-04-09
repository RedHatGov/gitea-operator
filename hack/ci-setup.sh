#!/bin/bash -ex
# Installs dependencies needed to run the tests in CI environment


mkdir -p $HOME/.local/bin
export PATH="$HOME/.local/bin:$PATH"
export KUBECONFIG=$HOME/.kube/config

# Basic pip prereqs
pip3 install --user --upgrade setuptools wheel pip

# Dependencies for test environment
pip3 install --user -r requirements/test-requirements.txt

# Ansible dependencies
pip3 install --user --upgrade -r requirements/requirements.txt
ansible-galaxy collection install -r requirements/requirements.yml

# Helm CLI (for loading Ingress)
curl -Lo $HOME/helm.tgz https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
tar xvzf $HOME/helm.tgz -C $HOME/.local/bin --strip-components 1 linux-amd64/helm
helm repo add stable https://charts.helm.sh/stable

#!/bin/bash -ex
# Installs dependencies needed to run the tests in CI environment

function ll {
    ls -halF "${@}"
}

mkdir -p $HOME/.local/bin
export PATH="$HOME/.local/bin:$PATH"
export KUBECONFIG=${KUBECONFIG:-$HOME/.kube/config}
echo $KUBECONFIG
ll $HOME/.kube
kubectl config current-context
kind version
clusters=$(kind get clusters)
for cluster in $clusters; do
    kind get nodes --name $cluster
    kind get kubeconfig --name $cluster
done

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
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

#!/bin/bash
SDK_RELEASE=v0.12
MINOR_RELEASE=0

# Update latest Roles
rm -rf roles/*
git clone https://github.com/redhat-gpte-devopsautomation/ansible-operator-roles
cp -R ansible-operator-roles/roles/postgresql-ocp ./roles
cp -R ansible-operator-roles/roles/gitea-ocp ./roles
cp ansible-operator-roles/playbooks/gitea.yaml ./playbook.yml
rm -rf ansible-operator-roles

# Now build the Operator
operator-sdk build quay.io/gpte-devops-automation/gitea-operator:${SDK_RELEASE}.${MINOR_RELEASE}
docker tag quay.io/gpte-devops-automation/gitea-operator:${SDK_RELEASE}.${MINOR_RELEASE} quay.io/gpte-devops-automation/gitea-operator:latest
docker tag quay.io/gpte-devops-automation/gitea-operator:${SDK_RELEASE}.${MINOR_RELEASE} quay.io/gpte-devops-automation/gitea-operator:${SDK_RELEASE}
docker push quay.io/gpte-devops-automation/gitea-operator:${SDK_RELEASE}.${MINOR_RELEASE}
docker push quay.io/gpte-devops-automation/gitea-operator:${SDK_RELEASE}
docker push quay.io/gpte-devops-automation/gitea-operator:latest

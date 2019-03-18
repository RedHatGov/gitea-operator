#!/bin/bash
# Update latest Roles
rm -rf roles/*
git clone https://github.com/redhat-gpte-devopsautomation/ansible-operator-roles
cp -R ansible-operator-roles/roles/postgresql-ocp ./roles
cp -R ansible-operator-roles/roles/gitea-ocp ./roles
cp ansible-operator-roles/playbooks/gitea.yaml ./playbook.yml
rm -rf ansible-operator-roles

# Now build the Operator
operator-sdk build quay.io/wkulhanek/gitea-operator:v0.0.6
docker push quay.io/wkulhanek/gitea-operator:v0.0.6

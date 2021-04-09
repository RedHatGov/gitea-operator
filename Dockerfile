FROM quay.io/operator-framework/ansible-operator:v1.4.2

COPY requirements ${HOME}
RUN pip3 install --user --upgrade -r ${HOME}/requirements.txt \
 && ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
COPY LICENSE ${HOME}/LICENSE

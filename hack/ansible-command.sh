#!/usr/bin/env bash

export OC_TOKEN=
export OO_FIRST_MASTER=
export HTTPD_ROUTE=
export PROMETHEUS_ROUTE=
export ALERTS_ROUTE=

source ${HOME}/workspace/ansible/hacking/env-setup

#miq pods
ansible-playbook -i hosts-ansible-miq.ini -vvv ~/workspace/openshift-ansible/playbooks/byo/openshift-management/config.yml

#prometheus
ansible-playbook -i /home/ilackarms/workspace/manageiq/manageiq-pods/hack/hosts-ansible-miq.ini \
    -vvv --extra-vars "openshift_prometheus_namespace=prometheus     \
    openshift_prometheus_additional_rules_file=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/prometheus-alert-rules.yml" \
    /home/ilackarms/workspace/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.yml

#set up provider
ansible-playbook -i hosts-ansible-miq.ini -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=ocp-master01.10.35.48.94.nip.io \
    httpd_route=httpd-openshift-management.10.35.48.95.nip.io \
    prometheus_route=prometheus-cfme.10.35.48.95.nip.io \
    alerts_route=alerts-cfme.10.35.48.95.nip.io" \
    ./miqplaybook.yml

#add container_administrator and container_operator users
curl -k -u admin:smartvm https://httpd-openshift-management.10.35.48.75.nip.io/api/users -d '{"userid": "container_administrator_user", "password": "secret", "name": "Container Administrator User", "group": {"id": 17}}'
curl -k -u admin:smartvm https://httpd-openshift-management.10.35.48.75.nip.io/api/users -d '{"userid": "container_operator_user", "password": "secret", "name": "Container Operator User", "group": {"id": 18}}'

#stable
ansible-playbook -i hosts.ini -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=ocp-master01.10.35.48.74.nip.io \
    httpd_route=httpd-cfme.10.35.48.75.nip.io \
    prometheus_route=prometheus-cfme.10.35.48.75.nip.io \
    alerts_route=alerts-cfme.10.35.48.75.nip.io" \
    ./miqplaybook.yml

ansible-playbook -i hosts-stable.ini -vvv --extra-vars "openshift_prometheus_namespace=cfme \
    openshift_prometheus_additional_rules_file=${PWD}/prometheus-alert-rules.yml" \
    ~/workspace/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.yml

#unstable - old
ansible-playbook -i hosts.ini -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=ocp-master01.10.35.48.79.nip.io \
    httpd_route=httpd-cfme.10.35.48.80.nip.io \
    prometheus_route=prometheus-cfme.10.35.48.80.nip.io \
    alerts_route=alerts-cfme.10.35.48.80.nip.io" \
    ./miqplaybook.yml

#unstable - external db
ansible-playbook -i hosts.ini -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=ocp-master01.10.35.48.79.nip.io \
    httpd_route=httpd-openshift-management.10.35.48.80.nip.io \
    prometheus_route=prometheus-cfme.10.35.48.80.nip.io \
    alerts_route=alerts-cfme.10.35.48.80.nip.io" \
    ./miqplaybook.yml

ansible-playbook -i hosts-unstable.ini -vvv --extra-vars "openshift_prometheus_namespace=cfme \
    openshift_prometheus_additional_rules_file=${PWD}/prometheus-alert-rules.yml" \
    ~/workspace/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.yml

ansible-playbook -i hosts-ansible-miq.ini -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=ocp-master01.10.35.48.94.nip.io \
    httpd_route=httpd-openshift-management.10.35.48.95.nip.io \
    prometheus_route=prometheus-cfme.10.35.48.95.nip.io \
    alerts_route=alerts-cfme.10.35.48.95.nip.io" \
    ./miqplaybook.yml

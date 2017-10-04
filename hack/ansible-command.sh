#!/usr/bin/env bash

source ${HOME}/workspace/ansible/hacking/env-setup

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

#unstable
ansible-playbook -i hosts.ini -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=ocp-master01.10.35.48.79.nip.io \
    httpd_route=httpd-cfme.10.35.48.80.nip.io \
    prometheus_route=prometheus-cfme.10.35.48.80.nip.io \
    alerts_route=alerts-cfme.10.35.48.80.nip.io" \
    ./miqplaybook.yml

ansible-playbook -i hosts-unstable.ini -vvv --extra-vars "openshift_prometheus_namespace=cfme \
    openshift_prometheus_additional_rules_file=${PWD}/prometheus-alert-rules.yml" \
    ~/workspace/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.yml

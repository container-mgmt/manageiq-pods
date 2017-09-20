#!/usr/bin/env bash

source ${HOME}/workspace/ansible/hacking/env-setup

ansible-playbook -i hosts.ini -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=ocp-master01.10.8.29.24.nip.io \
    httpd_route=httpd-cfme.10.8.29.197.nip.io \
    prometheus_route=prometheus-cfme.10.8.29.197.nip.io \
    alerts_route=alerts-cfme.10.8.29.197.nip.io" \
    ./miqplaybook.yml

ansible-playbook -i hosts.ini -vvv --extra-vars "openshift_prometheus_namespace=${MIQPROJECT} \
    openshift_prometheus_additional_rules_file=${PWD}/prometheus-alert-rules.yml" \
    ~/workspace/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.yml

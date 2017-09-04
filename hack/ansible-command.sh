#!/usr/bin/env bash

source ${HOME}/workspace/ansible/hacking/env-setup

ansible-playbook -i hosts.ini -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=ocp-master01.10.35.48.199.nip.io \
    prometheus_route=prometheus-cfme.10.35.48.200.nip.io \
    httpd_route=httpd-cfme.10.35.48.200.nip.io \
    alerts_route=alerts-cfme.10.35.48.200.nip.io" \
    ./miqplaybook.yml

ansible-playbook -i hosts.ini -vvv --extra-vars "openshift_prometheus_namespace=${MIQPROJECT} \
    openshift_prometheus_additional_rules_file=${PWD}/prometheus-alert-rules.yml" \
    ~/workspace/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.yml

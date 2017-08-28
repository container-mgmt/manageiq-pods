#!/usr/bin/env bash
ansible-playbook -i hosts -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=[ocp-master01.10.35.48.208.nip.io] \
    prometheus_route=prometheus-cfme.10.35.48.209.nip.io \
    httpd_route=httpd-cfme.10.35.48.209.nip.io \
    alerts_route=alerts-cfme.10.35.48.209.nip.io" \
    ./miqplaybook.yml


ansible-playbook -i hosts -vvv --extra-vars "mgmt_infra_sa_token=${OC_TOKEN} \
    oo_first_master=[ocp-master01.10.35.48.199.nip.io] \
    prometheus_route=prometheus-cfme.10.35.48.200.nip.io \
    httpd_route=httpd-cfme.10.35.48.200.nip.io \
    alerts_route=alerts-cfme.10.35.48.200.nip.io" \
    ./miqplaybook.yml

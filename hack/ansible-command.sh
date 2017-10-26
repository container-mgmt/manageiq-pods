#!/usr/bin/env bash

export OC_TOKEN=
export OO_FIRST_MASTER=
export HTTPD_ROUTE=
export PROMETHEUS_ROUTE=
export ALERTS_ROUTE=

read -d '' CA_CRT << EOF
-----BEGIN CERTIFICATE-----
MIIC6jCCAdKgAwIBAgIBATANBgkqhkiG9w0BAQsFADAmMSQwIgYDVQQDDBtvcGVu
c2hpZnQtc2lnbmVyQDE1MDg3ODAwMTIwHhcNMTcxMDIzMTczMzMxWhcNMjIxMDIy
MTczMzMyWjAmMSQwIgYDVQQDDBtvcGVuc2hpZnQtc2lnbmVyQDE1MDg3ODAwMTIw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCn0jGnpj9ehL5P1V58eZVB
VjYAE/aslWjNySBNpXhnLGS0u4eqRD6YHyzHUAuHu1hbS1o2WjLa2YD4BQr9bpBB
41wGEak8IUuMvg77kw9OofQg+zlPKKIJyPhCNZnrjd6fYj7EX4OioNReUaxn0LpG
1c2v7Aunqo6qtPchXjHcDXETPyhVDS4avj2x601MZSMUpCvrTOq2DFCS0TRpFAzZ
Np3MXvfJX2+p791mGHFgf1zlRuqaxZ7oc6Jn09jw8BhJn/a+dJ9Q09EW4+pWiWrJ
qRhSWvxOLW/+sKeDgWFyM+lMNczves3UG/wKsSQZ/R6Scj940ZebDYZ0jZ9qSLpT
AgMBAAGjIzAhMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MA0GCSqG
SIb3DQEBCwUAA4IBAQBDCxngSkMYzvoaqd0KiFK2hGFWmxpsBT69U6uR4ITx0gZB
tG/WfY5RZ86SigMdrz9W9nR5pneZjZUQkTVGLRhSiX2mI5jkuJMq8Q87Vzo8vHo+
Dno+dXeQ60baB6NcCSd0TibvjozxnmziXk3qOW7Hgs0dOlaj0dpo1EtMYmkjWrcG
R4x63UJ4XbFV1IXhhFy7zTNd4fro41LkWixPY7JUkl9gqAesE/3f5kK6cgZTsN2z
0xRc5DK/BIrGtgbBmXYnARvRcdSuTiM+Y2jm6cF1SNQKAVE8fdhEHcoVCIBH38vP
nk6S1BbokKwZP57rMVoWVv3VQRasZELLKR/gLX/J
-----END CERTIFICATE-----
EOF

source ${HOME}/workspace/ansible/hacking/env-setup

#miq pods
ansible-playbook -i hosts-ansible-miq-2.ini -vvv ~/workspace/openshift-ansible/playbooks/byo/openshift-management/config.yml

#prometheus
ansible-playbook -i /home/ilackarms/workspace/manageiq/manageiq-pods/hack/hosts-ansible-miq-2.ini \
    -vvv --extra-vars "openshift_prometheus_namespace=prometheus     \
    openshift_prometheus_additional_rules_file=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/prometheus-alert-rules.yml" \
    /home/ilackarms/workspace/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.yml

#set up provider
ansible-playbook -i hosts-ansible-miq-2.ini -vvv --extra-vars \
    "mgmt_infra_sa_token=${OC_TOKEN} \
    ca_crt=\"${CA_CRT}\" \
    oo_first_master=ocp-master01.10.35.48.199.nip.io \
    httpd_route=httpd-openshift-management.10.35.48.120.nip.io \
    prometheus_route=prometheus-prometheus.10.35.48.120.nip.io \
    alerts_route=alerts-prometheus.10.35.48.120.nip.io" \
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

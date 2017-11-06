#!/usr/bin/env bash

export OC_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtYW5hZ2VtZW50LWluZnJhIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6Im1hbmFnZW1lbnQtYWRtaW4tdG9rZW4tOHRrMXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoibWFuYWdlbWVudC1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImZkZDAxYWY2LWMwYWMtMTFlNy1hY2FjLTAwMWE0YTE2MjYzMyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptYW5hZ2VtZW50LWluZnJhOm1hbmFnZW1lbnQtYWRtaW4ifQ.okRQydbkdvA8m5Xxa4l9GdF7yG5q_Ejs21zzMMn2l6xqg8HzpVB91U62j4Xyq16gdkR9K1-ePVF65pHA4ig3GfEUcinOy8As4QKzRGaxICbjLi3ci0iLFqdoCugtoTX2wz2DmXaN_fvy6_Ya3P22EPYRqCPONpGTwD17TPYN6hLcLjii4j3VLeSUiFt4XZ1sMYxmnmH-hvn8J5fARcoIUiZAUjIdffGsqHGXkEz8q4j_-8NV6tgOszJYs294fNpokCqIL5ouuabZv7sTbKvwT4heC2iOtLO5S1Yx7fUln9fUHAeOekKyLCNqjpKayYG1NM3e_TK-GktdKtEEfBbmNQ
export OO_FIRST_MASTER=ocp-master01.10.35.48.51.nip.io
export FIRST_INFRA_IP=10.35.48.57.nip.io

read -d '' CA_CRT << EOF
-----BEGIN CERTIFICATE-----
MIIC6jCCAdKgAwIBAgIBATANBgkqhkiG9w0BAQsFADAmMSQwIgYDVQQDDBtvcGVu
c2hpZnQtc2lnbmVyQDE1MDk3MjMyNjgwHhcNMTcxMTAzMTUzNDI3WhcNMjIxMTAy
MTUzNDI4WjAmMSQwIgYDVQQDDBtvcGVuc2hpZnQtc2lnbmVyQDE1MDk3MjMyNjgw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCbhEud3Ng4Ca+lUJnmeyd/
X/J2RCmuMh3FfPwLV5+8HVB91syijuJSYwLi68E0rVpCmQHJq4nnOa4hLG+gZ/EX
YNNsWUHln3fhsbdREN76ZynVC8rNbnbBH76Zr+/6bzUl+3RhKutsYWMPyyEt2l+a
GVOqrWBmi2ZOtu4bpZ0xYkLzwshicRcIx2F5Li2ON3/lKsMwSQJVNaymql8e/vhC
QvmCcIHCXRTvl9cdpnIvMKJjAcEz1oKACRlizqNU5aaFE2O8BsjlOvo8R7UVpYsq
r4NL2iBYBr398gizQLNw8nOUbVjqNEHVqXlqIyQTk0P9LiHVSi6t94A4VtlF7hmT
AgMBAAGjIzAhMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MA0GCSqG
SIb3DQEBCwUAA4IBAQAH0VZgbR/peZRRYzryVScaZus0qhA6ErllUbpQ27U8Zmww
eBxPokHpA0JqQ7tt8FTuTJbF2QdHaAWL6PqGVNmMUAAaJIfUNduyUW3pWS3teQF8
7WNtHNKMCMcMnvR7BHpqPraCqKg0t6jHg40OMT75gsnf0NHLSqjhy2CIG5DNm2aq
e7FfNOvbhnbyulH9j1uNZ6CT5NR76mw7/QG030C2rk5VbXAXo2flYhiEJKX/unTJ
bxOMFiykBRe3UzxRFzPjEejpAENSnp43hjoK+FMzAn1260dHFWCmfIiV+MMfZvUu
6HXXeONkWd/4gh7+XoUz3orJ0CtcmWfEBq/uJN6U
-----END CERTIFICATE-----
EOF


#!/usr/bin/env bash
while true; do
    for volume in $(ls -d /exports/* | grep prometheus); do
        SIZE=$(du -hs ${volume} | awk '{print $1}')
        if [[ ${SIZE} == [1-9]"G" ]] ; then
            echo "Size of ${volume} has grown over 1GB, cleaning up"
            rm -rf ${volume}
            oc delete pod -n prometheus $(oc get pods -n prometheus | grep prometheus | awk '{print $1}')
        fi
    done
    sleep 120
done

source ${HOME}/workspace/ansible/hacking/env-setup

# fix oci system hooks if not done already
for i in $(echo 51 57 58 59 69); do ssh root@10.35.48.${i} -- yum update -y oci-systemd-hook; done

# refresh db
dropdb -U postgres -h  10.35.48.109 miq-ansible-2 && createdb -U postgres -h  10.35.48.109 miq-ansible-2

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
    oo_first_master=${OO_FIRST_MASTER} \
    httpd_route=httpd-openshift-management.${FIRST_INFRA_IP} \
    prometheus_route=prometheus-prometheus.${FIRST_INFRA_IP} \
    alerts_route=alerts-prometheus.${FIRST_INFRA_IP}" \
    ./miqplaybook.yml

#add container_administrator and container_operator users
curl -k -u admin:smartvm https://httpd-openshift-management.${FIRST_INFRA_IP}/api/users -d '{"userid": "container_administrator_user", "password": "secret", "name": "Container Administrator User", "group": {"id": 17}}'
curl -k -u admin:smartvm https://httpd-openshift-management.${FIRST_INFRA_IP}/api/users -d '{"userid": "container_operator_user", "password": "secret", "name": "Container Operator User", "group": {"id": 18}}'

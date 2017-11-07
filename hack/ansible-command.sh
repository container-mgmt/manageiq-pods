#!/usr/bin/env bash

# main 5 node cluster
export HOSTS_FILE=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/hosts-ansible-miq-2.ini
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

# kube cluster 1
export HOSTS_FILE=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/hosts-kubedemo-cluster1.ini
export OC_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtYW5hZ2VtZW50LWluZnJhIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6Im1hbmFnZW1lbnQtYWRtaW4tdG9rZW4tdzZiZ2QiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoibWFuYWdlbWVudC1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImRkZmNlZDEyLWMzMDctMTFlNy04NzAzLTAwMWE0YTE2MjY2MCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptYW5hZ2VtZW50LWluZnJhOm1hbmFnZW1lbnQtYWRtaW4ifQ.YCS5xWMy3jG6vW0Q0hUc619LAO8joGay6IMSFzqRBjt0cvjZq3S2Moc0Tvkr2USAQ8mHjkhGD2DCTVpuWsvntZPOoW4f20bkbrQhJefu8U9IvPuyuRznMau5WNqK-3-YDsICwHjR-idu6aPGehjLgIxqaricB6Y2LMn7jxo8iyX1UQcufehC7wMCtbiBQFpZ4F1XreStDX-RBKnoycN9UoSILMKyJlvqQw1Yxw7wnO0xjP08JaQTtPIA_2UGG12xKOv5dQJVrsUQGVhk257zRKm_ZGMjdspvSqyNRTLSaarp0zN4A21KRzmyB2C29rT0FCIv6DVEkfPYZaahJPcghg
export OO_FIRST_MASTER=ocp-master01.10.35.48.96.nip.io
export FIRST_INFRA_IP=10.35.48.97.nip.io
read -d '' CA_CRT << EOF
-----BEGIN CERTIFICATE-----
MIIC6jCCAdKgAwIBAgIBATANBgkqhkiG9w0BAQsFADAmMSQwIgYDVQQDDBtvcGVu
c2hpZnQtc2lnbmVyQDE1MDk5ODIxOTQwHhcNMTcxMTA2MTUyOTUzWhcNMjIxMTA1
MTUyOTU0WjAmMSQwIgYDVQQDDBtvcGVuc2hpZnQtc2lnbmVyQDE1MDk5ODIxOTQw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/Z8XSJkfkM7WY0+2GVY3o
SOi6TjbouuTnSATL5ncs4XDM9UQIsXsv6jQ1oe68IKx8DZDHcq57cKd4ffhDVARv
zFzz1CqYfRJp8dgSXpj1pKHBdep3DTstpmX9uJeAc8mg+kBTGcidI3Sb9X/w8VrI
LJpEWv9k8LPqfAYqYb0dLvtUQi2T7bCYzODVxAH0eYV5kwylSJH1IePc5G60iJqQ
E2oyORHQpz/v5m7sUjY3JKnEJ2dEYE6XF5/Hj0rkDXHuxSk6SlwpL2UbBFgCZ6po
UrzSWrMWbgWSu6Y6nwGjjU9mgU7pIx2g2mccqQq2yx5Yu7MrROCtlCbD8DE7ayTN
AgMBAAGjIzAhMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MA0GCSqG
SIb3DQEBCwUAA4IBAQCr0PMX55mU+Gm81JmNg36YyY0zFaL0X4j+tNePNsJ6Pdk7
nU+5erNGo8YFGYJuOWNQW1o6SL/F39cGqtX5qGf82Rgut3hR/GOx3092AK5Zl3EG
QaaIYi6HjJhSlsWJvY2SjUKLShxjB6yKCMvXKrvd+Rj6zVdv861EtcKo6XXUAhm+
ScrcwQCZMhmMAwe/oJg7Zi8ikrYjA13HXEBaX+jT45PlzS1NZ+bi2Qj5nItiLY7F
XVH1c0nEDoOW0bdhvsVcQfc7kCt76aTvKgozX+vzwXq1eoy87rBFU/Ff/fGh/akW
o2i0Yo9lCfVPRC4k7eHBn3Z9cel/0fNX5bJmUQsc
-----END CERTIFICATE-----
EOF


# kube cluster 2
export HOSTS_FILE=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/hosts-kubedemo-cluster2.ini
export OC_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtYW5hZ2VtZW50LWluZnJhIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6Im1hbmFnZW1lbnQtYWRtaW4tdG9rZW4teDg0aHciLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoibWFuYWdlbWVudC1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImQ4NjUzMTRmLWMzMDctMTFlNy04MDExLTAwMWE0YTE2MjY0ZSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptYW5hZ2VtZW50LWluZnJhOm1hbmFnZW1lbnQtYWRtaW4ifQ.jCOx26WlUVCR5xSeEtnM7NYUOc4EsfjIURKu3kvf-te8Kf6Vdh-lkesKegY3PwhTYD43HDjVnLVjF_sJsxQ8BeBkerVqLdxSVQeMy59JETOXp8ZfzkGJaIY9A1XojppehTn1-MRIw6gfAsq4OGaH466UuzqDM1LTtUDzWkZ1jLwMByNx6pQROyo8OMOIHWjZv5_PVzIpUppVEh4s84sELzIQErYEDYn_O29Qbzlea3ZCnojd2av0dVCdlsVfHeDloRA-8DfV3Ce1_R7tY1CwgnG5bdRRHGH_1guZReFSp6Q7_2KrLKqMTNg7uWnDj9mn8pXV_92ZeeGz2oLY97fp_w
export OO_FIRST_MASTER=ocp-master01.10.35.48.78.nip.io
export FIRST_INFRA_IP=10.35.48.79.nip.io
read -d '' CA_CRT << EOF
-----BEGIN CERTIFICATE-----
MIIC6jCCAdKgAwIBAgIBATANBgkqhkiG9w0BAQsFADAmMSQwIgYDVQQDDBtvcGVu
c2hpZnQtc2lnbmVyQDE1MDk5ODIxNzMwHhcNMTcxMTA2MTUyOTMyWhcNMjIxMTA1
MTUyOTMzWjAmMSQwIgYDVQQDDBtvcGVuc2hpZnQtc2lnbmVyQDE1MDk5ODIxNzMw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/5uZwBmdmbaZf2Mxrq51P
R1LMSzGnLrpcvlj12zTKJ0kiRzng+e6KSS54PBJfBscaessPdcVQn6ajbWTb0OZJ
0jmDacK8Y636nB/sBOBO35jzBS3SeQ15K+Oz6thhMSk4K74kX1MnEUkJpJAqFARz
NDnC+FYgjwjuTkXV1hvlvF/yPJ5UllClv351R9dbEpRl9w01yBdEb4Gs79P9LsyJ
I5XFJcw+/SI0ohKsestcg9WTKRbesyON+vKYKu/JwRYYq1PFsyDbPHSG7rUtMO8K
4hY+PFPotrMNOoi6wFPB1T4QN1acge8l3b7/BZy14DtJkej45gdq/YuiJnO9jFWN
AgMBAAGjIzAhMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MA0GCSqG
SIb3DQEBCwUAA4IBAQC9pA2pcjvOVg55SxBMg1npCR/h2tZ19Vfds1b8baxLyMUi
bCqBggWnR/Ws3GE2bBDo0uF1oJAsM/2W+AV9L0IAnD5M78v4ElDx5VDAeFvXUE6E
zWO2NzrRiKpPlqhARZTTPIlH+E+mEicbCQS5Ao9CtW4bTAKmjmCLGnSSHXcmT8m1
XiAX3Bsuh8BtTvFjAqJH4eXxe6niWOfjr2iH1Ahe5B5GE0CdqRvOccEoxb3KlAq3
Wrqw8HfzE81cfad/MHE+LJXS1dEDSgix99muWaAC/eu++NqTexptj0x3FmFSmHVK
1TPurRVbgTbTwAiDO7X79u0rFPEHMPRvyCGKjQRw
-----END CERTIFICATE-----
EOF

# run this on each master
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
dropdb -U postgres -h 10.35.48.109 miq-ansible-2 && createdb -U postgres -h  10.35.48.109 miq-ansible-2

#miq pods
ansible-playbook -i ${HOSTS_FILE} -vvv ~/workspace/openshift-ansible/playbooks/byo/openshift-management/config.yml

#prometheus
ansible-playbook -i ${HOSTS_FILE} \
    -vvv --extra-vars "openshift_prometheus_namespace=prometheus     \
    openshift_prometheus_additional_rules_file=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/prometheus-alert-rules.yml" \
    /home/ilackarms/workspace/openshift-ansible/playbooks/byo/openshift-cluster/openshift-prometheus.yml

#set up provider
ansible-playbook -i ${HOSTS_FILE} -vvv --extra-vars \
    "provider_name=OCP_with_Prometheus \
    mgmt_infra_sa_token=${OC_TOKEN} \
    ca_crt=\"${CA_CRT}\" \
    oo_first_master=${OO_FIRST_MASTER} \
    httpd_route=httpd-openshift-management.${FIRST_INFRA_IP} \
    prometheus_route=prometheus-prometheus.${FIRST_INFRA_IP} \
    alerts_route=alerts-prometheus.${FIRST_INFRA_IP}" \
    ./miqplaybook.yml

ansible-playbook -i ${HOSTS_FILE} -vvv --extra-vars \
    "provider_name=OCP_with_Prometheus_2 \
    mgmt_infra_sa_token=${OC_TOKEN} \
    ca_crt=\"${CA_CRT}\" \
    oo_first_master=${OO_FIRST_MASTER} \
    httpd_route=httpd-openshift-management.10.35.48.97.nip.io \
    prometheus_route=prometheus-prometheus.${FIRST_INFRA_IP} \
    alerts_route=alerts-prometheus.${FIRST_INFRA_IP}" \
    ./miqplaybook.yml

#add container_administrator and container_operator users
curl -k -u admin:smartvm https://httpd-openshift-management.${FIRST_INFRA_IP}/api/users -d '{"userid": "container_administrator_user", "password": "secret", "name": "Container Administrator User", "group": {"id": 17}}'
curl -k -u admin:smartvm https://httpd-openshift-management.${FIRST_INFRA_IP}/api/users -d '{"userid": "container_operator_user", "password": "secret", "name": "Container Operator User", "group": {"id": 18}}'

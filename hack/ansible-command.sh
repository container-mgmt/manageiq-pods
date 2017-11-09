#!/usr/bin/env bash

# main 5 node cluster
export HOSTS_FILE=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/hosts-ansible-miq-2.ini
export OC_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtYW5hZ2VtZW50LWluZnJhIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6Im1hbmFnZW1lbnQtYWRtaW4tdG9rZW4tcTl6dnIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoibWFuYWdlbWVudC1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjlhZGQ0MDU1LWM0ZDAtMTFlNy04NzI1LTAwMWE0YTE2MjY4YSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptYW5hZ2VtZW50LWluZnJhOm1hbmFnZW1lbnQtYWRtaW4ifQ.QmZK3s_3vEU7dw_CqzNyW94YpcA-UHVZaLitO7WUPG-XzWFyDupTwutrB-8-vkIh_2QMsF_Cq37fDPQ-txtV1DPd4mb31EgOReRqKxKlTPxAITZxdvr4W7yl7PGapsR1mmW_Y2__1jFjnzWeVHtMP4xjcPyAfwglLyD0ucZIN-4-hliUIFvRxKWlXioiXy3frQxqlCfJoGalMIOuEG-9ecFXvr1iKKa0WHcr-0xmngLtCBbZ7tFPU8q0qXaD7T8bTcAGJf4ZWf6owNseKcR81IrY13E3EnOeNVzGgkjfWO5zRw_hG9tTYBPkNDJ1wJeFzUMSDZCFIVlhOwCLRqRO3w
export OO_FIRST_MASTER=ocp-master01.10.35.48.138.nip.io
export FIRST_INFRA_IP=10.35.48.139.nip.io
read -d '' CA_CRT << EOF
-----BEGIN CERTIFICATE-----
MIIC6jCCAdKgAwIBAgIBATANBgkqhkiG9w0BAQsFADAmMSQwIgYDVQQDDBtvcGVu
c2hpZnQtc2lnbmVyQDE1MTAxNzgyMTcwHhcNMTcxMTA4MjE1NjU2WhcNMjIxMTA3
MjE1NjU3WjAmMSQwIgYDVQQDDBtvcGVuc2hpZnQtc2lnbmVyQDE1MTAxNzgyMTcw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCpcyzm5RD27UElgi2SEk2C
BIrgHIN14KyDjhVci4ws+MSGHcp6M7oY0T+MZUH5lvkSDCxCua4EpdnlBYXFAeDG
H7KjUckRHYKy8lP6EuyTsCNeOq9mZVCz9JRmk81RiKRusErPaNfJZL5QrI5olUIb
iWEM2wahVJR0whC/MKEpEQk25JiSrwVKp0uUymt2pt0hrfVoxTmhqtFcfSwW/GbL
jbB5UOZIuC/HrNdPbCo+ULBZSLh7OmdcLegJqqOZfW3SK3jKodczYYW38GqcK/MX
Q8qaqyVEef+iJ803vHFaVPOvdmU5VTwt03gI8GxMbqqnDlY6njREiYpIe6ropi/V
AgMBAAGjIzAhMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MA0GCSqG
SIb3DQEBCwUAA4IBAQB6C1NuaYb5CvnenY3U8ih4uM9i0TMtZUZ8IaEww7J/zvwM
Uh2Jo6dqBva3WM2FU0+CvLloSclD49cXe3xMcDnFHRFYJNAS/jVLigQEPJ0wogL5
qFwxu0DUaW1TeddgIQ92zdytuDzFBN92KsSavd4fZMGUdpawSnaQDuIXts9+sUuJ
jjSWpp23K6VERNJBIUANRLUyeQG99bev8FqJVcXxwAtinRxuElSGhyir8QMbRFSE
agB1Bvn9GRoQe7WEEWPKbm4QXduuqXvcNsXG9VIj2MLi3S2jZpxdmIuPzzFsZkb9
nCk5MEp+OdBI/rFZBBRtHCGV/kVvqPjQQnusGPXE
-----END CERTIFICATE-----
EOF

# kube cluster 1
export HOSTS_FILE=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/hosts-kubedemo-cluster1.ini
export OC_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtYW5hZ2VtZW50LWluZnJhIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6Im1hbmFnZW1lbnQtYWRtaW4tdG9rZW4tMzlxc3YiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoibWFuYWdlbWVudC1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjE0MmM2YjJiLWM0Y2YtMTFlNy04OTZmLTAwMWE0YTE2MjY3OCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptYW5hZ2VtZW50LWluZnJhOm1hbmFnZW1lbnQtYWRtaW4ifQ.PnpfZUcn4cHnjnf8sueKd32QjnJYD7JLKA1tOpywSZuuB79oL2a0KF-e7f30BJb_DR947X8aghcUJ-bnVfLzCRvSuvVnKXHe5tBFDSOCzSx7svC5a5kW6fy3Yu3woOP-DN1PUPw-eX-dLa82ieWE6qRMQwZK-sXBl8gRg_L7w0aDxBllJOou2bIkKLFl_YKmvAtlv4kbWWkE-dEjcvS-lDPpnfC7xPkKfQCfOv3z7Zvb7ia1crKVKkCVGuYSbnLGTbA6YqtZ5MMTBFIqMdUwDgmpC6pag7E66_pdV_fOIL2nPK2yg5oM8pd-6IuHF3z6zWmVF8FjGFsvnQxhT4wzOg
export OO_FIRST_MASTER=ocp-master01.10.35.48.120.nip.io
export FIRST_INFRA_IP=10.35.48.121.nip.io
read -d '' CA_CRT << EOF
-----BEGIN CERTIFICATE-----
MIIC6jCCAdKgAwIBAgIBATANBgkqhkiG9w0BAQsFADAmMSQwIgYDVQQDDBtvcGVu
c2hpZnQtc2lnbmVyQDE1MTAxNzc0ODUwHhcNMTcxMTA4MjE0NDQ0WhcNMjIxMTA3
MjE0NDQ1WjAmMSQwIgYDVQQDDBtvcGVuc2hpZnQtc2lnbmVyQDE1MTAxNzc0ODUw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDnkusDqMT6NemmF/v4AKQl
bPnnxr/MJW/0yeczydgPdZHER1Pm4xKDajpIBLiXBN0JZ1v1rIkiWgP3M6xTYP8T
hxn31/bugAS3d0f+ZXarTAkw2S80xU7rlk0ue7yz3JoRm/tj+lWCEJhQK17g38DC
ayF5dQsFl93b/8uAOElC9wOAGQn7UZy4fz6FFKcdOwFtUsYzAxyGBfV5R8cVIt1+
bk6LZJUUM42lrelXMtSPjZg5z3/mSVkFEWWEh+vRZfx8++UbuxuVRkqKE4KWP3Pc
u2KPXmAj3LpTUM061xWXl303bo80WCX6DlMwGypoNfKzy949jYGYrAuhCspieTlR
AgMBAAGjIzAhMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MA0GCSqG
SIb3DQEBCwUAA4IBAQCSsYfD+7u7wLemJHHDazln2fbuwEuFVnjaVerPpNQglR4+
Sw/QoeT3/IjrEFBX+ousAcIQxOmQRl7kTT1pQ+/xXy0RoZOsXTWXq7+Qs0U0K6AJ
HaQe69GJ0Cdp09s7Zlxuz3N4kqQtgNbVqF3mzpCMpPv390jyp7W4FrucVwXTVBEK
D9eihy1MdQRPGbBr0QxPLWNjQDzjeNUPnUdfr38wvNzonItnTXQoCFukut00q0km
qMOvgl+HkjNYURI3CisF4LvXbBReU0rtjDZjFGs5eIwn6gUx9qQNo3Xh0UMJoWTd
X8vRrOLpDX+Gbqqc9GibJGPuWL2dNxikEcnqwgst
-----END CERTIFICATE-----
EOF


# kube cluster 2
export HOSTS_FILE=/home/ilackarms/workspace/manageiq/manageiq-pods/hack/hosts-kubedemo-cluster2.ini
export OC_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtYW5hZ2VtZW50LWluZnJhIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6Im1hbmFnZW1lbnQtYWRtaW4tdG9rZW4tOG01OTQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoibWFuYWdlbWVudC1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImM3N2YzMzk5LWM0ZDAtMTFlNy1iYzJjLTAwMWE0YTE2MjY5MiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptYW5hZ2VtZW50LWluZnJhOm1hbmFnZW1lbnQtYWRtaW4ifQ.QKz4ACpHsBlQo4OPbiI8FEH9pOsD9vz7_08D6s5FWOYuQdPB2zY5EHxFhLSEbdwgb4MSUso5ogQ_EhQTuKAlarsgH2QAlzvMGuC25wGg-nCjmBgfyzEO7OARaF3bpvVRYVzOylzE3ow6kCeew6JqzrrYlrrQOQG7ch7AViFMwQ1Yi7GHR9HXd0ssApn5wWdAuAcsT6FbLRJr-L5k3PNiXVQy9VTtGxu0E7-Hdgfavo6itkh3_BqgEDI3Q5kybQ240_nawcLqCuYsP_Uint8nEzNtila04pqdcQGtmUMHydrx0cUKWinikUauptW4cYPqxWkhx3Apxa6WL8WNWIE_hQ
export OO_FIRST_MASTER=ocp-master01.10.35.48.146.nip.io
export FIRST_INFRA_IP=10.35.48.147.nip.io
read -d '' CA_CRT << EOF
-----BEGIN CERTIFICATE-----
MIIC6jCCAdKgAwIBAgIBATANBgkqhkiG9w0BAQsFADAmMSQwIgYDVQQDDBtvcGVu
c2hpZnQtc2lnbmVyQDE1MTAxNzgyNzQwHhcNMTcxMTA4MjE1NzUzWhcNMjIxMTA3
MjE1NzU0WjAmMSQwIgYDVQQDDBtvcGVuc2hpZnQtc2lnbmVyQDE1MTAxNzgyNzQw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDXerr5WNNDEs4IqEyErg1A
pQMs5wNtcFSd9DR/j7GPyc/MCSSdI3FjKskekpDE70N2Dbrul4EpLqc0u3bPZYfU
Q7+nBI641DPVUo8es+UkQ2gGgsJBekCbdcBcb99gpVrk+j34G8gM7IN407YwT7wr
qOvcvdITqjNErOyeB9WMLKkUAGnGJ8c59bzKBoBkjAVZkDnPOIcya+fFd9uFcYCy
TqHBzAmKaTfmUtsjQd7aBVegfj78orUtrNq31ONImNcRe3P7SdqbaDZ4TwkzGxil
/YYtlJOqJ8E4gy8AQASMZdNaYg2IGZ6c615eQjMGTcY9JnS9yhGRNHPBEGXhSAZr
AgMBAAGjIzAhMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MA0GCSqG
SIb3DQEBCwUAA4IBAQBNgh9enzoVJP/ZWb+3o12zKtQJ927+lyB5f0sibkD874Rc
ihoeS14MuCEXj1WDyrlBmO4+VEszpqsBdGERz8stdk/kAlIaGZgJnhh8vtAn2JCV
H4Al/uWv+OkLvv4VupDr+nSlVF6bptF8Z87z7YBY5zYtbEbPOr5vTpQqJTTdoyIh
JkUPlq2N61LeEjN6OksjK8yEqgaCPXZjOk4b+aazPnDgdh13g5oxeUQ3Y+3/tbYg
Tpn431SrxqI3mTRtAUdY/CYAQodAq9AVPXiYJ6wl+lOBl6cLBHHBh6umNhaTslDQ
957p1UgyDzPptQPj8l8bChLJHIA9CErPWvWAp/GO
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

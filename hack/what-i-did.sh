#!/usr/bin/env bash

# Run this script on the master node after Origin has been deployed
set -e -x

rm -rf /exports/miq-pv0{1,2,3}
mkdir -p /exports/miq-pv0{1,2,3}
chgrp -R nfsnobody /exports/miq-pv0*
chown -R nfsnobody /exports/miq-pv0*
chmod -R 777 /exports/miq-pv0*

cat > /etc/exports <<EOF
/exports/miq-pv01 *(rw,root_squash,no_wdelay)
/exports/miq-pv02 *(rw,root_squash,no_wdelay)
/exports/miq-pv03 *(rw,root_squash,no_wdelay)
EOF
exportfs -ar

export MIQPROJECT="cfme"

export OC_USER=scweiss
export OC_ADMIN=system:admin
export PODS_PROJECT=https://github.com/ilackarms/manageiq-pods
export REF=all-merged
export GHORG=ilackarms

oadm policy add-cluster-role-to-user cluster-admin ${OC_USER}

oc login -u ${OC_USER}
oc new-project ${MIQPROJECT} --skip-config-write --display-name="CloudForms"

oc project ${MIQPROJECT}

oc login -u ${OC_ADMIN}
export MASTER_HOST=$(oc get nodes | grep master | awk '{print $1}')

oc adm policy add-scc-to-user anyuid system:serviceaccount:${MIQPROJECT}:miq-anyuid
oc adm policy add-scc-to-user anyuid system:serviceaccount:${MIQPROJECT}:miq-orchestrator
oc adm policy add-scc-to-user privileged system:serviceaccount:${MIQPROJECT}:miq-privileged

oc create -f templates/miq-sysadmin.yaml
oc adm policy add-scc-to-user miq-sysadmin system:serviceaccount:${MIQPROJECT}:miq-sysadmin -n ${MIQPROJECT}

oc login -u ${OC_USER}
oc policy add-role-to-user view system:serviceaccount:${MIQPROJECT}:miq-orchestrator -n ${MIQPROJECT}
oc policy add-role-to-user edit system:serviceaccount:${MIQPROJECT}:miq-orchestrator -n ${MIQPROJECT}

oc login -u ${OC_ADMIN}
oc process -f templates/miq-nfs-pvs-template.yaml NFS_HOST=${MASTER_HOST} | oc create -f -

oc login -u ${OC_USER}

#oc -n cfme new-build --name=miq-app --context-dir=images/miq-app --build-arg=REF=${REF} --build-arg=GHORG=${GHORG} ${PODS_PROJECT}
#oc -n cfme new-build --name=miq-app-frontend --context-dir=images/miq-app-frontend --build-arg=REF=${REF} --build-arg=GHORG=${GHORG} ${PODS_PROJECT}

oc process -n ${MIQPROJECT} -f templates/miq-template.yaml \
   APPLICATION_IMG_NAME="docker.io/ilackarms/miq-app-frontend" \
   FRONTEND_APPLICATION_IMG_TAG=latest \
   | oc create -n ${MIQPROJECT} -f -

#oc process -f templates/prometheus.yaml NAMESPACE=${MIQPROJECT} \
#   | oc create -n ${MIQPROJECT} -f -

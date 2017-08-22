#!/usr/bin/env bash

# Run this script on the master node after Origin has been deployed
set -e -x

echo "@@WARNING: Did you remember to change the NFS Server IP in the pv templates?@@"

mkdir -p /exports/miq-pv0{1,2,3}
chgrp -R nfsnobody /exports/miq-pv0*
chown -R nfsnobody /exports/miq-pv0*
chmod -R 777 /exports/miq-pv0*

cat > /etc/exports <<EOF
/exports/miq-pv01 *(rw,root_squash,no_wdelay)
/exports/miq-pv02 *(rw,root_squash,no_wdelay)
/exports/miq-pv03 *(rw,root_squash,no_wdelay)
EOF

# Currently this cannot be changed because hard-coded in the Dockerfile FROM of miq-app-frontend :-(
export MIQPROJECT="cfme"

export OC_USER=scweiss
export OC_ADMIN=system:admin
export PODS_PROJECT=https://github.com/ilackarms/manageiq-pods
export REF=all-merged
export GHORG=ilackarms

oc login -u ${OC_USER}
oc new-project ${MIQPROJECT} --skip-config-write --display-name="CloudForms"

oc project ${MIQPROJECT}

oc login -u ${OC_ADMIN}
oc adm policy add-scc-to-user anyuid system:serviceaccount:${MIQPROJECT}:miq-anyuid
oc adm policy add-scc-to-user anyuid system:serviceaccount:${MIQPROJECT}:miq-orchestrator
oc adm policy add-scc-to-user privileged system:serviceaccount:${MIQPROJECT}:miq-privileged

oc create -f templates/miq-sysadmin.yaml
oc adm policy add-scc-to-user miq-sysadmin system:serviceaccount:${MIQPROJECT}:miq-sysadmin -n ${MIQPROJECT}

oc login -u ${OC_USER}
oc policy add-role-to-user view system:serviceaccount:${MIQPROJECT}:miq-orchestrator -n ${MIQPROJECT}
oc policy add-role-to-user edit system:serviceaccount:${MIQPROJECT}:miq-orchestrator -n ${MIQPROJECT}

oc login -u ${OC_ADMIN}
oc create -f templates/miq-pv-db-example.yaml
oc create -f templates/miq-pv-server-example.yaml

oc login -u ${OC_USER}

oc -n cfme new-build --name=miq-app --context-dir=images/miq-app --build-arg=REF=${REF} --build-arg=GHORG=${GHORG} ${PODS_PROJECT}
oc -n cfme new-build --name=miq-app-frontend --context-dir=images/miq-app-frontend --build-arg=REF=${REF} --build-arg=GHORG=${GHORG} ${PODS_PROJECT}

ELAPSED=0
IMAGES_FINISHED=$(oc get pods | grep miq-app-frontend-*-build)
while [[ $IMAGES_FINISHED != *"Completed"* ]]; do
    echo "waiting for miq frontend container to finish \(${ELAPSED}s elapsed)"
    sleep 0.5
    ELAPSED=$(echo "$ELAPSED + 0.5" | bc)
    IMAGES_FINISHED=$(oc get pods | grep miq-app-frontend-*-build)
done

ELAPSED=0
IMAGES_FINISHED=$(oc get pods | grep miq-app-.*-build)
while [[ $IMAGES_FINISHED != *"Completed"* ]]; do
    echo 'waiting for miq container to finish'
    sleep 0.5
    ELAPSED=$(echo "$ELAPSED + 0.5" | bc)
    IMAGES_FINISHED=$(oc get pods | grep miq-app-.*-build)
done

oc process -n ${MIQPROJECT} -f templates/miq-template.yaml \
APPLICATION_IMG_NAME=docker-registry.default.svc:5000/cfme/miq-app-frontend \
FRONTEND_APPLICATION_IMG_TAG=latest \
| oc create -n ${MIQPROJECT} -f -

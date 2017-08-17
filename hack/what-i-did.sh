#!/usr/bin/env bash

# Run this script on the master node after Origin has been deployed
set -e -x

if [ $1 == "deploy" ]; then
    oc process -n ${MIQPROJECT} -f templates/miq-template.yaml \
    APPLICATION_IMG_NAME=docker-registry.default.svc:5000/cfme/miq-app-frontend \
    FRONTEND_APPLICATION_IMG_TAG=latest \
    | oc create -n ${MIQPROJECT} -f -
    exit
fi

# Currently this cannot be changed because hard-coded in the Dockerfile FROM of miq-app-frontend :-(
export MIQPROJECT="cfme"
export OC_USER=scweiss
export OC_ADMIN=system:admin
export PODS_PROJECT=https://github.com/ManageIQ/manageiq-pods

oc login -u ${OC_USER}
oc new-project ${MIQPROJECT} --skip-config-write --display-name="CloudForms"

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
oc -n cfme new-build --name=miq-app --context-dir=images/miq-app --build-arg=REF=master ${PODS_PROJECT}
oc -n cfme new-build --name=miq-app-frontend --context-dir=images/miq-app-frontend --build-arg=REF=master ${PODS_PROJECT}


#!/usr/bin/env bash

export BASE="local"
oc -n cfme new-build --name=miq-app-${BASE} --context-dir=images/miq-app --build-arg=REF=dedicated --build-arg=GHORG=simon3z .
oc logs -f bc/miq-app-${BASE}
oc delete bc miq-app-${BASE}
oc delete is miq-app-${BASE}
oc delete is ruby
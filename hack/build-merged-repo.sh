#!/usr/bin/env bash

PENDING_PRS=${PWD}/pending-prs.json
BASEDIR=${PWD}/manageiq-merged

mkdir ${BASEDIR}
cd ${BASEDIR}

set -x -e

for repo in $(cat ${PENDING_PRS} | jq "keys[]" -r); do
    set +e
    git clone https://github.com/ManageIQ/${repo}
    pushd ${repo}
    git remote add ilackarms https://github.com/ilackarms/${repo}
    git fetch ilackarms
    git co -b all-merged
    set -e
    if [[ ${repo} == "manageiq" ]]; then
        git pull --no-edit ilackarms use-my-gems
    fi
    repo=\"${repo}\"
    for pr in $(cat ${PENDING_PRS} | jq ".${repo}[]" -r); do
        git fetch origin pull/${pr}/head
        git merge --no-edit FETCH_HEAD
    done
    git push --set-upstream ilackarms all-merged --force
    popd
done

#
#cd manageiq
#git remote add ilackarms https://github.com/ilackarms/manageiq
#git fetch ilackarms
#git co -b all-merged
#git pull --no-edit ilackarms use-my-gems
#git pull --no-edit moolitayer new_providers
#git push --set-upstream ilackarms all-merged --force
#
#cd ${BASEDIR}/manageiq-providers-kubernetes
#for ghuser in $(echo "yaacov ilackarms moolitayer"); do
#    git remote add ${ghuser} https://github.com/${ghuser}/manageiq-providers-kubernetes
#    git fetch ${ghuser}
#done
#git co -b all-merged
#git pull --no-edit moolitayer prometheus_alerts
#git push --set-upstream ilackarms all-merged --force
#
#cd ${BASEDIR}/manageiq-providers-openshift
#for ghuser in $(echo "ilackarms moolitayer"); do
#    git remote add ${ghuser} https://github.com/${ghuser}/manageiq-providers-openshift
#    git fetch ${ghuser}
#done
#git co -b all-merged
#git pull --no-edit moolitayer prometheus_alerts
#git push --set-upstream ilackarms all-merged --force
#
#cd ${BASEDIR}/manageiq-ui-classic
#for ghuser in $(echo "ilackarms yaacov nimrodshn"); do
#    git remote add ${ghuser} https://github.com/${ghuser}/manageiq-ui-classic
#    git fetch ${ghuser}
#done
#git co -b all-merged
#git pull --no-edit nimrodshn add_alert_drop_down
#git push --set-upstream ilackarms all-merged --force

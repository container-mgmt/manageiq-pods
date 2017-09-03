#!/usr/bin/env bash

set -x -e

BASEDIR=${PWD}/manageiq-merged

mkdir ${BASEDIR}
cd ${BASEDIR}

#for miq_project in $(echo "providers-kubernetes"); do
#    git clone https://github.com/ManageIQ/manageiq-${miq_project}
#    cd ${BASEDIR}/manageiq-${miq_project}
#    for ghuser in $(echo "yaacov ilackarms moolitayer"); do
#        git remote add ${ghuser} https://github.com/${ghuser}/manageiq-${miq_project}
#        git fetch ${ghuser}
#    done
#done

git clone https://github.com/ManageIQ/manageiq
git clone https://github.com/ManageIQ/manageiq-providers-kubernetes
git clone https://github.com/ManageIQ/manageiq-providers-openshift
git clone https://github.com/ManageIQ/manageiq-ui-classic

cd manageiq
for ghuser in $(echo "yaacov ilackarms moolitayer"); do
    git remote add ${ghuser} https://github.com/${ghuser}/manageiq
    git fetch ${ghuser}
done
git co -b all-merged
git pull --no-edit ilackarms use-my-gems
git pull --no-edit moolitayer new_providers
git pull --no-edit moolitayer add_monitoring_menus
git push --set-upstream ilackarms all-merged --force

cd ../manageiq-providers-kubernetes
for ghuser in $(echo "yaacov ilackarms moolitayer"); do
    git remote add ${ghuser} https://github.com/${ghuser}/manageiq-providers-kubernetes
    git fetch ${ghuser}
done
git co -b all-merged
git pull --no-edit moolitayer prometheus_alerts
git push --set-upstream ilackarms all-merged --force

cd ../manageiq-providers-openshift
for ghuser in $(echo "ilackarms moolitayer"); do
    git remote add ${ghuser} https://github.com/${ghuser}/manageiq-providers-openshift
    git fetch ${ghuser}
done
git co -b all-merged
git pull --no-edit moolitayer prometheus_alerts
git push --set-upstream ilackarms all-merged --force

cd ../manageiq-ui-classic
for ghuser in $(echo "ilackarms yaacov nimrodshn"); do
    git remote add ${ghuser} https://github.com/${ghuser}/manageiq-ui-classic
    git fetch ${ghuser}
done
git co -b all-merged
git pull --no-edit nimrodshn add_alert_drop_down
git push --set-upstream ilackarms all-merged --force
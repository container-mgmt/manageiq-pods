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

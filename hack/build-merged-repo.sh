#!/usr/bin/env bash

PENDING_PRS=${PWD}/pending-prs.json
BASE_REFS=${PWD}/base-refs.json
BASEDIR=${PWD}/manageiq-merged
GIT_USER=${GIT_USER:-ilackarms}
CORE_REPO=manageiq

mkdir ${BASEDIR}
cd ${BASEDIR}

set -x -e

for repo in $(cat ${PENDING_PRS} | jq "keys[]" -r); do
    echo -e "\n\n\n** DOING REPO ${repo}**\n----------------------------------------------\n"
    git clone https://github.com/ManageIQ/${repo}
    pushd ${repo}
    git remote add ${GIT_USER} https://github.com/${GIT_USER}/${repo}
    git fetch ${GIT_USER}

    string_escaped_repo=\"${repo}\"
    base_ref=$(cat ${BASE_REFS} | jq ".${string_escaped_repo}" -r)
    git co ${base_ref}
    git co -b all-merged
    if [ ${repo} == ${CORE_REPO} ]; then
        git pull --no-edit ${GIT_USER} use-my-gems
    fi
    for pr in $(cat ${PENDING_PRS} | jq ".${string_escaped_repo}[]" -r); do
        git fetch origin pull/${pr}/head
        git merge --no-edit FETCH_HEAD
    done
    git push --set-upstream ${GIT_USER} all-merged --force
    echo -e "\n** FINISHED REPO ${repo} **\n---------------------------------------------- \n"
    popd
done

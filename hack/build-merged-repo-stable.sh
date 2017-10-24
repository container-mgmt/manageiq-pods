#!/usr/bin/env bash

PENDING_PRS=${PWD}/pending-prs-stable.json
BASE_REFS=${PWD}/base-refs.json
BASEDIR=${PWD}/manageiq-stable
GIT_USER=${GIT_USER:-ilackarms}
CORE_REPO=manageiq

mkdir ${BASEDIR}
cd ${BASEDIR}

set -x -e

if [[ $1 == "push" ]]; then
    for repo in $(cat ${PENDING_PRS} | jq "keys[]" -r); do
        echo -e "\n\n\n** PUSHING REPO ${repo}**\n----------------------------------------------\n"
        pushd ${repo}
        git push --set-upstream ${GIT_USER} image-stable --force
        echo -e "\n** PUSHED REPO ${repo} **\n---------------------------------------------- \n"
        popd
    done

    echo "Push Complete"
    exit 0
fi

if [ -z ${GIT_PASSWORD} ]; then
    echo "enter git password for ${GIT_USER}:"
    read -s GIT_PASSWORD
fi

for repo in $(cat ${PENDING_PRS} | jq "keys[]" -r); do
    echo -e "\n\n\n** DOING REPO ${repo}**\n----------------------------------------------\n"
    git clone https://github.com/ManageIQ/${repo}
    pushd ${repo}
    git remote add ${GIT_USER} https://github.com/${GIT_USER}/${repo}
    git fetch ${GIT_USER}

    string_escaped_repo=\"${repo}\"
    base_ref=$(cat ${BASE_REFS} | jq ".${string_escaped_repo}" -r)
    git checkout ${base_ref}
    git checkout -b image-stable
    if [ ${repo} == ${CORE_REPO} ]; then
        git pull --no-edit ${GIT_USER} use-my-gems-stable
    fi
    for pr in $(cat ${PENDING_PRS} | jq ".${string_escaped_repo}[]" -r); do
        git fetch origin pull/${pr}/head
#        git merge --no-edit FETCH_HEAD
        for sha in $(curl -u ${GIT_USER}:${GIT_PASSWORD} https://api.github.com/repos/ManageIQ/${repo}/pulls/${pr}/commits | jq .[].sha -r); do
            git cherry-pick ${sha}
        done
    done
    echo -e "\n** FINISHED REPO ${repo} **\n---------------------------------------------- \n"
    popd
done

#!/bin/bash

set -ex

HEAD=$(git rev-parse --abbrev-ref HEAD)
BRANCHES=$(git branch -l | egrep -v -e '(develop|master)' | sed 's/\s*//g')

for BRANCH in $BRANCHES; do
    git checkout $BRANCH
    git cherry-pick -m 1 $(git rev-parse master)
    git push
done

git checkout $HEAD

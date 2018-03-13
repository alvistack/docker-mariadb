#!/bin/bash

for BRANCH in 10.3.x 10.1.x 10.0.x 5.5.x; do
    git checkout $BRANCH
    git cherry-pick -m 1 $(git rev-parse master)
    git push
done

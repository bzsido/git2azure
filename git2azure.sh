#!/bin/bash

STARTDIR="~/repo-transfer"
PROJECT="repo-archive"
REPO=

cd "$STARTDIR"

git clone --bare "$REPO_URL"
cd $(echo "$REPO_URL" | cut -d'/')
az repos create --project "$PROJECT" --name "$REPO" # > AZ_URL
git push --mirror "$AZ_URL"

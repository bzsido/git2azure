#!/bin/bash

STARTDIR="$HOME/repo-transfer"
REPOLIST="repolist"
PROJECT="repo-archive"

if cd "$STARTDIR"; then

    while read REPO_URL; do
        
        REPO=$(echo "$REPO_URL" | cut -d'/' -f2 | cut -d'.' -f1)
        AZ_URL=$(az repos create --project "$PROJECT" --name "$REPO" | jq -r '.sshUrl')
        
        git clone --bare "$REPO_URL"
        cd "$REPO".git
        git push --mirror "$AZ_URL"
        cd ..
    
    done <"$REPOLIST"

else
    echo "Directory $STARTDIR doesn't exist!"
fi

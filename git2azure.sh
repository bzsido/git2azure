#!/bin/bash

STARTDIR="$HOME/repo-transfer"
REPOLIST="repolist"
PROJECT="repo-archive"

if cd "$STARTDIR"; then

    while read REPO_URL; do
        
        REPO=$(echo "$REPO_URL" | cut -d'/' -f2 | cut -d'.' -f1)
        if git clone --bare "$REPO_URL"; then
            
            cd "$REPO".git
            AZ_URL=$(az repos create --project "$PROJECT" --name "$REPO" | jq -r '.sshUrl')
            git push --mirror "$AZ_URL"
            cd "$STARTDIR"
        fi
    
    done <"$REPOLIST"

else
    echo "Directory $STARTDIR doesn't exist!"
fi

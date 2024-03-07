#!/bin/bash

# Exit script immediately if any command returns a non-zero exit status.
set -e

# Prompt for project name (default to local folder name)
DEFAULT_PACKAGE_NAME=`pwd | sed -e 's|^.*/||'`
read -p "Package Name [$DEFAULT_PACKAGE_NAME]: " PACKAGE_NAME
PACKAGE_NAME=${PACKAGE_NAME:-$DEFAULT_PACKAGE_NAME}
# echo Project Name is $PACKAGE_NAME

# Prompt to keep quickstart in new project git history (default to yes)
while true; do
    read -p "Keep quickstart-typescript-project in $PACKAGE_NAME git history? ([Y]/n): " yn
    case $yn in
        ""    ) KEEP_HISTORY=true;  break;;
        [Yy]* ) KEEP_HISTORY=true;  break;;
        [Nn]* ) KEEP_HISTORY=false; break;;
        * ) echo "Please answer yes or no.";;
    esac
done
# echo $KEEP_HISTORY

# Delete quickstart-typescript-project specific files and settings
rm README.md LICENSE init.sh
sed -e 's/"MIT"/""/' -i package.json
npm pkg delete repository
npm i --package-lock-only --audit=false
git commit -a -m "Delete quickstart-typescript-project specific files and settings"

# Update TypeScript and tsc-watch to latest version
npm i --save-dev typescript@latest tsc-watch@latest
npm audit fix
if [[ -n "$(git status --porcelain)" ]]; then
    git commit -a -m "Update TypeScript to latest version";
else
    echo "Typescript version is unchanged";
fi

# Initialize project
npm pkg set name=$PACKAGE_NAME
npm i --package-lock-only --audit=false
if [[ -n "$(git status --porcelain)" ]]; then
    git commit -a -m "$PACKAGE_NAME Initialized";
else
    echo "Package name is unchanged";
fi

# Create new git history (if that option was selected)
if [ "$KEEP_HISTORY" = false ]; then
    git branch -m quickstart-${PACKAGE_NAME}_archive
    git checkout --orphan main
    git reset
    git commit --allow-empty -m "Git Repo Initialized"
    git add -A .
    git commit -a -m "$PACKAGE_NAME Initial Commit"
fi

echo ""
echo "Application $PACKAGE_NAME Initialized!"

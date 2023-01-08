#!/bin/bash
export source=$(pwd)

# Clone website
git clone https://github.com/ariollex/ariollex.github.io -b main ~/public 2>/dev/null

# Build
hugo -d ../public

# Deploy changes
echo -e "\033[0;32mDeploying changes to GitHub...\033[0m"
cd ~/public

# Commit changes.
git add .
git commit -m "Push built site"

# Push source and build repos.
git push https://"$GH_PERSONAL_TOKEN"@github.com/Ariollex/ariollex.github.io.git main

if [[ $1 != "-k" ]]; then
  rm -rf ~/public
fi

echo -e "\033[0;32mSuccess!\033[0m"
# Back to source directory
cd $source

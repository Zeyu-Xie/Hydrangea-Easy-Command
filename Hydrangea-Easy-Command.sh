#!/bin/zsh
source ~/.zshrc
source ~/.zprofile

# The path of the config file
srcPath=$(realpath "commands.json")

if command -v jq &>/dev/null; then
    # Nothing happens lol
else
    echo "Start installing jq"
    brew install jq
fi

num=$(jq ". | length" $srcPath)

for ((i = 0; i < num; i++)); do
    if [ "$(jq ".[$i].alias" $srcPath)" = "\"$1\"" ]; then
        eval $(jq ".[$i].command" $srcPath)
    fi
done

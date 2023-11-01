#!/bin/zsh
source ~/.zshrc
source ~/.zprofile

# The path of the config file
# scriptPath="$(cd "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 && pwd)"

# 拼接 commands.json 文件的路径
filePath="$(readlink -f "$0")"
dirPath="$(dirname $filePath)"
srcPath="$dirPath/commands.json"

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
#!/bin/bash
langs=`echo "golang c rust cpp java kotlin" | tr ' ' '\n'`
cutils=`echo "xargs awk mv find tree ncdu sed" | tr ' ' '\n'`
picked=`printf "$langs\n$cutils" | fzf`
read -p "query: " query

if echo $langs | grep -qs $picked; then
    curl cht.sh/$picked/`echo $query | tr ' ' '+'` | less -R
else
    curl cht.sh/$picked~$query | less -R
fi

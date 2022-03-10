# alias lsg="ls $pwd | grep $1"
alias clsg="echo '$PWD+$1' echo yyy echo $2"
alias blah='function _blah(){ echo "First: $PWD/$1"; echo "Second: $2"; };_blah'
alias lsg='customizedListAndGrep' # in ~/.custom_fns
alias prettify="python3 -m json.tool"
alias gitdca="confirmation && git commit -a --amend --no-edit"
alias vdirs="dirs -v"
#prettifyResponse() { 
#    curl "$1" | python3 -m json.tool > "$2"
#}
# alias creatmr="!sh -c { git push \"$1\" -o merge_request.create -o merge_request.title=\"$2\" -o merge_request.description=\"$3\" -; };"


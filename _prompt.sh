section_hist=34
section_user=242
section_dir=237
section_end=16
nocol='\[\033[m\]'
if [[ -n ${SSH_CLIENT} ]]
then
    section_user=17
fi

prompt_git() {
    git branch &>/dev/null || return 1
    HEAD="$(git symbolic-ref HEAD 2>/dev/null)"
    BRANCH="${HEAD##*/}"
    [[ -n "$(git status 2>/dev/null | \
        grep -F 'working directory clean')" ]] || STATUS="!"
    printf ' ⭠ git:%s' "${BRANCH:-unknown}${STATUS}"
}
prompt_hg() {
    hg branch &>/dev/null || return 1
    BRANCH="$(hg branch 2>/dev/null)"
    [[ -n "$(hg status 2>/dev/null)" ]] && STATUS="!"
    printf ' ⭠ hg:%s' "${BRANCH:-unknown}${STATUS}"
}
prompt_svn() {
    svn info &>/dev/null || return 1
    URL="$(svn info 2>/dev/null | \
        awk -F': ' '$1 == "URL" {print $2}')"
    ROOT="$(svn info 2>/dev/null | \
        awk -F': ' '$1 == "Repository Root" {print $2}')"
    BRANCH=${URL/$ROOT}
    BRANCH=${BRANCH#/}
    BRANCH=${BRANCH#branches/}
    BRANCH=${BRANCH%%/*}
    [[ -n "$(svn status 2>/dev/null)" ]] && STATUS="!"
    printf ' ⭠ svn:%s' "${BRANCH:-unknown}${STATUS}"
}
prompt_vcs() {
    prompt_git || prompt_svn || prompt_hg
}

trans_color() {
    before_color=$1
    after_color=$2
    echo "\[\e[38;5;${before_color}m\]\[\e[48;5;${after_color}m\]⮀\[\e[m\]\[\e[48;5;${after_color}m\]"
}
export PROMPT_DIRTRIM=2
export PS1="\[\e[48;5;${section_hist}m\]"'\!'$(trans_color ${section_hist} ${section_user})'\u@\h'$(trans_color ${section_user} ${section_dir})'\w$(prompt_vcs)'$(trans_color ${section_dir} ${section_end})${nocol}


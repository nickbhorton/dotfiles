#
# ~/.bashrc
#

# colors
blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# adding potentially to short aliases
alias c='clear'
alias v='nvim'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gp='git pull'
alias cb='cd build && make && cd ..'
alias todo='nvim ~/.todo'

alias make='make -j15'

alias sound='alsamixer'

alias chk-bat='echo "power: " && cat /sys/class/power_supply/BAT1/charge_now && echo "full power:" && cat /sys/class/power_supply/BAT1/charge_full'

function render_tex() {
    latexmk -pdf ${1};
}
function clean_tex_quiet() {
    latexmk -c 1> /dev/null;
}
function view_pdf() {
    echo "$1 =>";
    echo "    $(echo $1 | sed 's/.tex/.pdf/')";
    mupdf -r 226 $(echo $1 | sed 's/.tex/.pdf/');
}
function render_and_view_tex() {
    render_tex $1;
    clean_tex_quiet $1;
    view_pdf $1;
}
function init_tex() {
    filename="$1.tex";
    echo "filename: " $filename;
    echo '\documentclass{article}' > $filename;
    echo '\usepackage[margin=1.0in]{geometry}' >> $filename;
    echo '\usepackage{amsfonts}' >> $filename;
    echo '\usepackage{amsmath}' >> $filename;
    echo '' >> $filename;
    name_string_with_spaces=${1//_/ } 
    echo "\title{${name_string_with_spaces^}}" >> $filename;
    echo "\begin{document}" >> $filename;
    echo "\maketitle" >> $filename;
    echo "\end{document}" >> $filename;
    
}

function init_cpp() {
    mkdir ./src;
    mkdir ./tests;
    mkdir ./include;
    cp /home/nick/.local/share/cpp_start_files/Makefile ./Makefile;
    cp /home/nick/.local/share/cpp_start_files/doctest.h ./include/doctest.h;
    cp /home/nick/.local/share/cpp_start_files/test.cpp ./tests/test.cc;
    cp /home/nick/.local/share/cpp_start_files/main.cpp ./src/main.cc;
}

alias mktex="render_and_view_tex $1"
alias pdfv='mupdf -r 226'${1}'.pdf'
alias texinit='init_tex '${1}
alias newcpp='init_cpp'

alias dotgit='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

PS1=${blu}'\u=>'${pur}'\w'${wht}'>= '

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# history optimizations
# command is 'history'
HISTTIMEFORMAT="%F %T"
HISTCONTROL=ignoredups

# setting up ocaml enviroment variables
eval $(opam env)

# something about transparency
term="$(cat /proc/$PPID/comm)"

if [[ $term = "st" ]]; then
	transset-df "0.8" --id "$WINDOWID" >/dev/null
fi

. "$HOME/.cargo/env"

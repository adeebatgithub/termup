#!/bin/bash

red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
noc="\033[0m"

BASE_DIR="$PREFIX/TermUp"

banner () {
    clear
    printf "${yellow}--------------------------------------------------------${noc}\n"
    printf "${red}                         TERMUP ${noc}\n"
    printf "${yellow}--------------------------------------------------------${noc}\n"
}

update_termux () {
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[*] upgrading....${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    apt update -y
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[*] updating....${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    apt upgrade -y
}

install_python () {
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[+] installing python${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    apt install python -y
}

install_git () {
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[+] installing git${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    apt install git -y
}

setup_git () {
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[+] setting local git${noc}\n"
    printf "${green}[+] user name : adeebatgithub${noc}\n"
    printf "${green}[+] email : adeebdanish063@gmail.com${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    git config --global user.name "adeebatgithub"
    git config --global user.email "adeebdanish063@gmail.com"
    git config --global credential.helper store
    printf "helper setted to store"
    printf "git will store credential permanently after one authentication"
}

motd () {
    printf "${yellow}----------------------------------${noc}\n"
    printf "${red}[*] changing motd${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    cp $BASE_DIR/etc/motd $PREFIX/etc/motd
    printf "${green}[*] Done ${noc}\n"
}

create_bin () {
    local name=$1
    local path=$2
cat <<EOL > $PREFIX/bin/$name
python $path
EOL
}

install_bot () {
    git clone https://github.com/adeebatgithub/Telebot.git $HOME/terminal/lib/bot
    create_bin "Bot" "$HOME/terminal/lib/Telebot/bot.py"
    chmod +x $PREFIX/bin/Bot
    printf "${green}[*] command creat : Bot ${noc}\n"
}

install_youtuber () {
    git clone https://github.com/adeebatgithub/youtuber.git $HOME/terminal/lib/youtuber
    create_bin "Youtuber" "$HOME/terminal/lib/youtuber/app_cli.py"
    chmod +x $PREFIX/bin/Youtuber
    printf "${green}[*] command created : Youtuber ${noc}\n"
}

set_cmd_cls () {
cat<<EOL > $PREFIX/bin/cls
clear
cat $PREFIX/etc/motd
EOL
    chmod +x $PREFIX/bin/cls
    printf "${green}[*] command created : cls ${noc}\n"
}

set_cmd_token () {
    echo ""
    printf "${green}[+] Token : ${noc}"
    read token
    cat <<EOL > $PREFIX/bin/Token
    echo ""
    echo "username: adeebatgithub"
    echo "token: ${token}"
    echo ""
EOL
    chmod +x $PREFIX/bin/Token
    printf "${green}[*] command created : Token ${noc}\n"
}

install_vim () {
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[+] installing vim${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    apt install vim -y
}

setup_vim () {
    install_vim
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[+] settingup vim${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    cat<<EOL > $HOME/.vimrc
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
EOL
}

err_gyp () {
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[+] resolving error: gyp${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
    cp $BASE_DIR/etc/.gyp $HOME
    pkg install binutils
}

change_ps1 () {
    cat <<EOL > $HOME/.bashrc
    PS1="\n┌──(adeeb@termux)-[\\w]\\n└─\\$ "
EOL
    printf "${yellow}---------------------------------${noc}\n"
    printf "${green}[+] promt changed to kali${noc}\n"
    printf "${yellow}---------------------------------${noc}\n"
}

basic () {
    update_termux
    install_python
    setup_vim
    install_git
    setup_git
    motd
    set_cmd_cls
    set_cmd_token
    change_ps1
}

check_folder_exista () {
    if [ -d "$BASE_DIR" ]; then
        :
    else 
        printf "${red}[?] TermUp folder not found ${noc}\n"
        printf "${red}[*] exiting........ ${noc}\n"
        exit 0
    fi
}

end_options () {
    echo ""
    printf "${green} [1] go back ${noc}\n" 
    printf "${green} [0] main menu ${noc}\n" 
    printf "${green} [x] exit ${noc}\n"
    printf "${red} [+] select:  ${noc}" 
    read inp
    if [ $inp = 0 ]; then
        main_menu
    elif [ $inp = 1 ]; then
        :
    elif [ $inp = "x" ]; then
        exit 0
    else
        printf "${red}[?] option not found ${noc}\n"
        end_options
    fi
}

set_cmd () {
    banner
    echo ""
    echo ""
    printf "${green} [1] cls ${noc}\n" 
    printf "${green} [2] Token ${noc}\n"
    printf "${green} [0] main menu ${noc}\n"
    printf "${green} [x] exit ${noc}\n"
    echo "" 
    printf "${red}[+] select : ${noc}"
    read inp
    if [ $inp = 1 ]; then
        set_cmd_cls
    elif [ $inp = 2 ]; then
        set_cmd_token
    elif [ $inp = 0 ]; then
        main_menu
    elif [ $inp = "x" ]; then
        exit 0
    else
        printf "${red}[?] option not found ${noc}\n"
        set_cmd
    fi
    end_options
    set_cmd
}

main_menu () {
    banner
    echo ""
    echo ""
    printf "${green} [1] basic ${noc}\n"
    printf "${green} [2] update and upgrade ${noc}\n"
    printf "${green} [3] install Bot ${noc}\n"
    printf "${green} [4] install Youtuber ${noc}\n"
    printf "${green} [5] setup git ${noc}\n"
    printf "${green} [6] change motd ${noc}\n"
    printf "${green} [7] set commands ${noc}\n"
    printf "${green} [8] setup vim ${noc}\n"
    printf "${green} [9] resolve gyp error ${noc}\n"
    printf "${green} [10] set kali promt ${noc}\n"
    printf "${green} [x] exit ${noc}\n"
    echo ""
    printf "${red}[+] select :  ${noc}"
    read inp
    if [ $inp = 1 ]; then
        basic
    elif [ $inp = 2 ]; then
        update_termux
    elif [ $inp = 3 ]; then
        install_bot
    elif [ $inp = 4 ]; then
        install_youtuber
    elif [ $inp = 5 ]; then
        setup_git
    elif [ $inp = 6 ]; then
        motd
    elif [ $inp = 7 ]; then
        set_cmd
    elif [ $inp = 8 ]; then
        setup_vim
    elif [ $inp = 9 ]; then
        err_gyp
    elif [ $inp = 10 ]; then
        change_ps1
    elif [ $inp = "x" ]; then
        exit 0
    else
        printf "${red}[?] option not found ${noc}\n"
        main_menu
    fi
    end_options
    main_menu
}

check_folder_exists
main_menu



exit 0

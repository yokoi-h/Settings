#!/bin/bash

NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

function red() {
    echo -e "$RED$*$NORMAL"
    }

    function green() {
        echo -e "$GREEN$*$NORMAL"
}

function yellow() {
    echo -e "$YELLOW$*$NORMAL"
    }

    # 成功
    green "Task has been completed"

    # エラー
    red "The configuration file does not exist"

    # 警告
    yellow "You have to use higher version."

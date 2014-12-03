#!/bin/bash

allFiles() {
    echo $1
    if [ $1 -eq "" ]; then
        echo "give me path"
        return
    fi

    for file in $1/*
        do
        if [ -d $file ]; then
            allFiles $file
        else
            echo $file
            touch r $file
        fi
        done
}

allFiles $1

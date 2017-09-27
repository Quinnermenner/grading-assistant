#!/usr/bin/env bash

declare -A VALGRIND=( ["whodunit"]="./whodunit clue.bmp ../verdict.bmp" )
problem="whodunit"
# ( cd 10718095/forensics && valgrind --tool=memcheck ./whodunit clue.bmp verdict.bmp )
( cd 10718095/forensics && valgrind --leak-check=full --error-exitcode=1 ${VALGRIND[$problem]} )
    if [[ $? == 0 ]]
    then
        echo "error"
        # ( cd 10718095/forensics && valgrind --leak-check=full ${VALGRIND[$problem]} 2> valgrind.txt )
    fi
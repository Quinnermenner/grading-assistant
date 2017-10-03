#! /bin/bash

# Usage: './checker50.sh "pset" "student_name"'

# student_name: This is the name of the folder that contains the files for the
#               specific student you're grading.
# pset:         The specific week of problem sets you'r grading. E.g. 'crypto'
#               Check cs50x.mprog.nl problem sets for all names.

pset=${1,,}
if [ -z "$pset" ]
then
    echo "Usage: './checker.sh \"pset\" \"student_name\"'"
    echo "No pset detected. Please provide a pset to check; e.g. 'crypto'."
    exit 1
fi

stud_name=$2
if [ -z "$stud_name" ]
then
    student_list=( $(cut -f2 students.csv ) )
else
    student_list=("$stud_name")
fi

if [ -z "$student_list" ]
then
    echo "No student list found. Please make sure there is a 'students.csv' file
          that contains the appropriate student numbers."
    exit 1
fi

case "$pset" in
    "c") CHECKLIST=("credit" "hello" "mario/more" "mario/less" "water" "greedy")
        ;;
    "crypto") CHECKLIST=("initials/less" "initials/more" "caesar" "vigenere" "crack")
        ;;
    "fifteen") CHECKLIST=("fifteen" "find/more" "find/less")
        ;;
    "forensics") CHECKLIST=("resize/less" "resize/more" "recover"); declare -A VALGRIND=( ["whodunit"]="./whodunit clue.bmp verdict.bmp" ["resize"]="./resize 4 small.bmp large.bmp" ["recover"]="./recover ../../files_forensics/card.raw")
        ;;
    "misspellings") CHECKLIST=("speller"); declare -A VALGRIND=( ["speller"]="./speller texts/ralph.txt" )
        ;;
    "sentimental") CHECKLIST=("not_implemented")
        ;;
    "finance") CHECKLIST=("not_implemented")
        ;;
    "mashup") CHECKLIST=("not_implemented")
        ;;
    *) echo "That's not a valid pset!"; exit 1;
        ;;
esac

main() {
    clear
    for student in ${student_list[@]}
    do
        ( cd $student/$pset/ && echo -e "Student: $student" > results.txt && echo -e "Student: $student" > valgrind.txt)
        for problem in ${CHECKLIST[@]}
        do
            printf "Checking: $student - $problem\n"
            ( cd $student/$pset/ &&
            echo -e "\nCheck50: $student - $problem" >> results.txt &&
            check50 cs50/2017/x/$problem >> results.txt )
        done

        for problem in "${!VALGRIND[@]}"
        do
            echo "Valgrinding: $problem"
            valgrinder $problem $student
            cleaner $pset $student
        done
    done
}

function valgrinder() {
    problem=$1
    student=$2
    ( cd $student/$pset && make $problem 1> /dev/null &&
    valgrind --leak-check=full --errors-for-leak-kinds=all --error-exitcode=1 ${VALGRIND[$problem]} > /dev/null 2>&1 )
    if [[ $? != 0 ]]
    then
        ( cd $student/$pset && valgrind --leak-check=full ${VALGRIND[$problem]} 2> valgrind.txt )
    fi
}

function cleaner() {

    pset=$1
    student=$2
    ( cd $student/$pset &&
    case "$pset" in
        "c")
            ;;
        "crypto")
            ;;
        "fifteen")
            ;;
        "forensics") rm -f *.jpg
            ;;
        "misspellings")
            ;;
        "sentimental")
            ;;
        "finance")
            ;;
        "mashup")
            ;;
        *) echo "That's not a valid pset!"; return;
            ;;
    esac )
}

main "$@"
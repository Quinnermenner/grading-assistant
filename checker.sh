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
    "c") CHECKLIST=("credit.c" "hello.c" "mario.c" "water.c" "greedy.c")
        ;;
    "crypto") CHECKLIST=("initials.c" "caesar.c" "vigenere.c" "crack.c")
        ;;
    "fifteen") CHECKLIST=("fifteen.c" "find.c")
        ;;
    "forensics") CHECKLIST=("resize.c" "recover.c"); declare -A VALGRIND=( ["whodunit"]="./whodunit clue.bmp verdict.bmp" ["resize"]="./resize 4 small.bmp large.bmp" ["recover"]="./recover ../../files_forensics/card.raw")
        ;;
    "mispell") CHECKLIST=("speller.c"); declare -A VALGRIND=( ["speller"]="./speller texts/ralph.txt" )
        ;;
    "sentimental") CHECKLIST=("mario.py" "caesar.py" "credit.py" "greedy.py" "vigenere.py" "crack.py" "smile" "tweets")
        ;;
    "finance") CHECKLIST=("not_implemented")
        ;;
    "mashup") CHECKLIST=("not_implemented")
        ;;
    *) echo "That's not a valid pset!"; exit 1;
        ;;
esac

case "$pset" in
    "sentimental") check_func="checkpyer"; source twitter_keys
        ;;
    *) check_func="check50er"
        ;;
esac

LESS_MORE=("mario" "initials" "find" "resize")
LM_FLAG=("less" "more")

main() {
    clear
    for student in ${student_list[@]}
    do
        ( cd $student/$pset/ && echo -e "Student: $student" > results.txt && echo -e "Student: $student" > valgrind.txt)
        for submit in `find $student/$pset/ -maxdepth 1 -type f`
        do
            submit_cleaned="$(cut -d'/' -f3<<<"$submit")"
            if array_contains CHECKLIST $submit_cleaned
            then
                problem="$(cut -d'.' -f1<<<"$submit_cleaned")"
                if array_contains LESS_MORE $problem && [[ "$check_func" == "check50er" ]]
                then
                    for flag in "${LM_FLAG[@]}"
                    do
                        echo "Checking: $student - $problem/$flag"
                        $check_func "$problem/$flag" $student
                    done
                else
                    echo "Checking: $student - $problem"
                    $check_func $problem $student
                fi
            fi
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
    local problem="$1"
    local student="$2"
    ( cd $student/$pset && make $problem 1> /dev/null &&
    valgrind --leak-check=full --errors-for-leak-kinds=all --error-exitcode=1 ${VALGRIND[$problem]} > /dev/null 2>&1 )
    if [[ $? != 0 ]]
    then
        ( cd $student/$pset && valgrind --leak-check=full ${VALGRIND[$problem]} 2>> valgrind.txt )
    fi
}

function check50er() {

    local problem="$1"
    local student="$2"
    ( cd $student/$pset && echo -e "\nCheck50: $student - $problem" >> results.txt &&
      check50 -l cs50/2017/x/$problem >> results.txt )
}

function checkpyer() {

    local problem="$1"
    local student="$2"
    ( cd $student/$pset && echo -e "\nCheck50: $student - $problem" >> results.txt)
    ./check50py.sh $problem $student $pset >> $student/$pset/results.txt 2>&1
}

function cleaner() {

    local pset="$1"
    local student="$2"
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
        "mispell")
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

array_contains () {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}

array_contains2 () {
    local e
    local array=("$@")
    for e in "${array[@]}"; do [[ "$e" == "$2" ]] && return 1; done
    return 0
}

main "$@"
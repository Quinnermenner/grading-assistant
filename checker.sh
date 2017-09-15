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
"forensics") CHECKLIST=("resize/less" "resize/more" "recover")
    ;;
"misspellings") CHECKLIST=("speller")
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

clear
for student in ${student_list[@]}
do
    read -p "Performing checks for $student. Y/N?" -n 1 -r
    clear
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        for problem in ${CHECKLIST[@]}
        do
        printf "\nChecking: $student - $problem\n"
        ( cd $student/$pset/ && check50 cs50/2017/x/$problem )
        done
    fi
done
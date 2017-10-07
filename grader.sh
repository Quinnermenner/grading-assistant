#! /bin/bash

pset=${1,,}
if [ -z "$pset" ]
then
    echo "Usage: './checker.sh \"pset\" \"student_name\"'"
    echo "No pset detected. Please provide a pset to check; e.g. 'crypto'."
    exit 1
fi

case "$pset" in
    "c") CHECKLIST=("credit.c" "hello.c" "mario.c" "water.c" "greedy.c")
        ;;
    "crypto") CHECKLIST=("initials.c" "caesar.c" "vigenere.c" "crack.c")
        ;;
    "fifteen") CHECKLIST=("fifteen.c" "find.c")
        ;;
    "forensics") CHECKLIST=("verdict.bmp" "whodunit.c" "resize.c" "recover.c")
        ;;
    "mispell") CHECKLIST=("speller.c" "dictionary.c" "dictionary.h")
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


main() {

    for student in ${student_list[@]}
        do
            read -p "Ready to grade $student. Y/N?" -n 1 -r
            clear
            if [[ $REPLY =~ ^[Yy]$ ]]
            then
                grade $student
                opener $student
            fi
        done

}

function grade() {

    student=$1
    ( cd $student/$pset/ &&
    cat results.txt &&
    (test -e valgrind.txt && cat valgrind.txt))

}

function opener() {

    student=$1
    for file in ${CHECKLIST[@]}
    do
        ( cd $student/$pset && ( test -e $file && c9 open "$file" || echo "$file was not submitted.") )
    done
}

main "$@"
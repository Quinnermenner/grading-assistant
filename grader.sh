#! /bin/bash

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


main() {

    for student in ${student_list[@]}
        do
            read -p "Ready to grade $student. Y/N?" -n 1 -r
            clear
            if [[ $REPLY =~ ^[Yy]$ ]]
            then
                cleanup $student
            fi
        done

}

function cleanup() {

    student=$1
    ( cd $student/$pset/ &&
    cat results.txt &&
    (test valgrind.txt && cat valgrind.txt))

}

main "$@"
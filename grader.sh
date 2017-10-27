#! /bin/bash

argcount=1
open_files=false
while getopts "o" opt; do
  case $opt in
    o)
      open_files=true
      ((argcount++))
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

pset=${!argcount,,}
((argcount++))
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
    "sentimental") CHECKLIST=("caesar.py" "credit.py" "mario.py" "crack.py" "greedy.py" "vigenere.py" "tweets" "smile" "analyzer.py" "application.py" "helpers.py")
        ;;
    "finance") CHECKLIST=("not_implemented")
        ;;
    "mashup") CHECKLIST=("not_implemented")
        ;;
    *) echo "That's not a valid pset!"; exit 1;
        ;;
esac

stud_name=${!argcount}
((argcount++))
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
            # read -p "Ready to grade $student. Y/N?" -n 1 -r
            read -p "Ready to grade $student? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || break
            clear
            # if [[ $REPLY =~ ^[Yy]$ ]]
            # then
                grade $student
                if [ "$open_files" = true ]; then opener $student; fi
            # fi
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
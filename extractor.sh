#! /bin/bash

# Instructions for linking dropbox to your IDE: https://c9.io/blog/dropbox-on-cloud9/
# Usage: './extractor.sh "pset" "student_name"'

# student_name: Optional: This is the student number of the student you whish to extract.
#               If omitted the student list will be extracted from the 'students.csv' file.
# pset:         The specific week of problem sets you'r grading. E.g. 'crypto'.
#               Check cs50x.mprog.nl problem sets for all names.

pset=$1
if [ -z "$pset" ]
then
    echo "Usage: './extractor.sh \"pset\" \"student_name\"'"
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
    echo "No student list found. Please make sure there is a 'students.csv' file that contains the appropriate student numbers."
    exit 1
fi

tag=$pset"__"

for student in ${student_list[@]}
do
    printf "Copying : $student\n"
    for submit in `find ~/workspace/Dropbox/Prog17/$student/$tag* -type d`
    do
        # echo $submit
        test -d $student/$1 || mkdir -p $student/$1 && cp $submit/* $student/$1
        chmod -R 755 $student/$1
    done
done
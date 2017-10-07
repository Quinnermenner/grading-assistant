#! /bin/bash

# Instructions for linking dropbox to your IDE: https://c9.io/blog/dropbox-on-cloud9/
# Usage: './extractor.sh "pset" "student_name"'

# student_name: Optional: This is the student number of the student you whish to extract.
#               If omitted the student list will be extracted from the 'students.csv' file.
# pset:         The specific week of problem sets you'r grading. E.g. 'crypto'.
#               Check cs50x.mprog.nl problem sets for all names.

pset=${1,,}
if [ -z "$pset" ]
then
    echo "Usage: './extractor.sh \"pset\" \"student_name\"'"
    echo "No pset detected. Please provide a pset to check; e.g. 'crypto'."
    exit 1
fi

valid_psets=("c" "crypto" "fifteen" "forensics" "mispellings" "sentimental" "mashup" "finance")
if [[ " ${valid_psets[*]} " != *" $pset "* ]]; then
    echo "Oops. '$pset' is not a valid problem set!"
    exit 1
fi

stud_name=$2
if [ -z "$stud_name" ]
then
    student_list=( $(cut -f2 students.csv ) )
else
    student_list=("$stud_name")
    ( cd ~/workspace/Dropbox && dropbox.py exclude remove Prog17/$stud_name )
    while [[ $(dropbox.py status) != "Up to date" ]]; do
        if [[ $(dropbox.py status) == "Dropbox isn't running!" ]]
        then
            echo "Either run 'dropbox.py start'  or './dropboxer.sh' to reconnect."
            exit
        fi
        dropbox.py status
        sleep 5
    done
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
    test -d $student/$pset || mkdir -p $student/$pset
    for submit in `find ~/workspace/Dropbox/Prog17/$student/$tag* -type d`
    do
        cp $submit/* $student/$pset
        chmod -R 755 $student/$pset
    done
done

./prepper.sh $pset $stud_name
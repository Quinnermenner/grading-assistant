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

valid_psets=("c" "crypto" "fifteen" "forensics" "misspellings" "sentimental" "mashup" "finance")
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
fi

if [ -z "$student_list" ]
then
    echo "No student list found. Please make sure there is a 'students.csv' file that contains the appropriate student numbers."
    exit 1
fi

main () {

    echo "Prepping "$pset""
    "$pset"_prep
}

function c_prep() {
    return
}

function crypto_prep() {
    return
}

function fifteen_prep() {
    wget "https://github.com/cs50/problems/archive/find.zip"
    unzip find.zip -d problems_find
    rm -f find.zip
    tar_dir=`find problems_find/* -type d`
    for student in ${student_list[@]}
    do
        printf "Copying : $student\n"
        echo "placeholder" > $student/$pset/questions.txt
        cp -nr $tar_dir/. $student/$pset
        ( cd $student/$pset && make )
        chmod -R 755 $student/$pset
    done
    rm -rf problems_find
    return
}

function forensics_prep() {

    wget "https://github.com/cs50/problems/archive/whodunit.zip"
    unzip whodunit.zip -d problems_whodunit
    rm -f whodunit.zip
    tar_dir=`find problems_whodunit/* -type d`
    for student in ${student_list[@]}
    do
        printf "Copying : $student\n"
        cp -nr $tar_dir/. $student/$pset
        make whodunit
        ./whodunit clue.bmp verdict.bmp
        chmod -R 755 $student/$pset
    done
    rm -rf problems_whodunit
    return
}

function misspellings_prep() {
    return
}

function sentimental_prep() {
    return
}

function finance_prep() {
    return
}

function mashup_prep() {
    return
}

main "$@"
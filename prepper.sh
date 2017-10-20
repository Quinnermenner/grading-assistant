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

valid_psets=("c" "crypto" "fifteen" "forensics" "mispell" "sentimental" "mashup" "finance")
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
    ( test -d /files_$pset || mkdir -p files_$pset &&
    wget -O files_$pset/card.raw "http://cdn.cs50.net/2016/fall/psets/4/pset4/card.raw" )

    unzip whodunit.zip -d problems_whodunit
    rm -f whodunit.zip
    tar_dir=`find problems_whodunit/* -type d`

    for student in ${student_list[@]}
    do
        printf "Copying : $student\n"
        cp -nr $tar_dir/. $student/$pset
        ( cd $student/$pset && make whodunit &&
        ./whodunit clue.bmp verdict.bmp )
        chmod -R 755 $student/$pset
    done

    rm -rf problems_whodunit
    return
}

function mispell_prep() {

    wget "https://github.com/cs50/problems/archive/speller.zip"
    unzip speller.zip -d problems_speller
    rm -f speller.zip
    tar_dir=`find problems_speller/* -type d | head -n 1`

    for student in ${student_list[@]}
    do
        printf "Copying : $student\n"
        cp -nr $tar_dir/. $student/$pset
        chmod -R 755 $student/$pset
    done

    rm -rf problems_speller
    return
}

function sentimental_prep() {

    for student in ${student_list[@]}
    do
        ( cd $student/$pset && unzip -o pset6.zip && rm -f pset6.zip )
        ( cd $student/$pset/pset6 && mv * ../ )
        ( cd $student/$pset && rm -rf pset6 &&
        mkdir -p templates &&
        cp *.html templates/ &&
        rm -f *.html && rm -rf sentiments)


    done

    read -p "Set twitter api keys? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || return

    read -p "What is your twitter api key?" api_key
    read -p "What is your twitter api secret?" api_secret
    echo -e "export API_KEY=$api_key\nexport API_SECRET=$api_secret" > twitter_keys

    return
}

function finance_prep() {

    for student in ${student_list[@]}
    do
        ( cd $student/$pset && mkdir -p templates && mkdir -p static &&
          mv *.html templates && mv styles.css static && rm -f pset7.zip )
    done
    return
}

function mashup_prep() {
    return
}

main "$@"

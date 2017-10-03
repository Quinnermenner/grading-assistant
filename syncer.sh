#! /bin/bash

( cd ~/workspace/Dropbox && dropbox.py exclude add * && dropbox.py exclude remove Prog17 )

while [[ $(dropbox.py status) != "Up to date" ]]; do
    sleep 5
done

( cd ~/workspace/Dropbox && dropbox.py exclude add Prog17/* )


student_list=( $(cut -f2 students.csv ) )
for student in ${student_list[@]}
do
    ( cd ~/workspace/Dropbox && dropbox.py exclude remove Prog17/$student )
done
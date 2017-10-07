#! /bin/bash

dir=$1

main() {
    if [ -z "$dir" ]
        then
            sync_all
        else
            sync_dir
    fi
}

sync_all() {

    ( cd ~/workspace/Dropbox && dropbox.py exclude add * && dropbox.py exclude remove Prog17 )

    while [[ $(dropbox.py status) != "Up to date" ]]; do
        echo "Waiting for dropbox to finish updating..."
        ( cd ~/workspace/Dropbox && dropbox.py exclude add Prog17/* > /dev/null)
        sleep 5
    done

    ( cd ~/workspace/Dropbox && dropbox.py exclude add Prog17/* )


    student_list=( $(cut -f2 students.csv ) )
    for student in ${student_list[@]}
    do
        ( cd ~/workspace/Dropbox && dropbox.py exclude remove Prog17/$student )
    done
}

sync_dir() {

    ( cd ~/workspace/Dropbox && dropbox.py exclude add $dir )
}

main "$@"
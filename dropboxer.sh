#! /bin/bash

main() {

    # check_for_link
    echo "Hey! Because of your workspace hibernating every now and then, sometimes dropbox will lose connection.
    It then gets stuck on 'starting' and will not update the dropbox files. To fix this you'll have to relink dropbox to your workspace."
    relink

}


function restart() {

    read -p "Do you wish to start dropbox now? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || echo "Did not start dropbox." return
    dropbox.py start
    return
}

function check_for_link() {

    if [[ $(dropbox.py status) == "Dropbox isn't running!" ]];
        then
            dropbox.py start
    fi
    if [[ $(dropbox.py status) != "Starting..." ]];
        then
            echo "Dropbox does not seem to be stuck on 'Starting...'"
            exit 0
    fi
}


function relink() {

    read -p "Do you wish to start dropbox now? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || echo "No scripts executed." return
    echo "Will now relink to dropbox! Click the link in the terminal to authorize. Then come back and use ctrl+c to continue."
    trap restart INT
    dropbox.py stop
    sleep 1
    ~/.dropbox-dist/dropboxd
    return
}

main "$@"
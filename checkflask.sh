#! /bin/bash

problem=$1
student=$2
pset=$3

tests=( 'register' 'login' 'quote' 'buy' 'sell' 'index' 'history' )

main() {

    check_$pset
}

check_finance() {

    rm -rf files_$pset/*
    cp -r $student/$pset/* files_finance/


}

check_mashup() {

    rm -rf files_$pset/*
    cp -r $student/$pset/* files_mashup/


}

prompt_test() {

    testing=$1
    echo "Testing '/$testing' functionality; "
    echo "Testing '/$testing':"
    return
}

prompt_input() {

    testing=$1
    case "$testing" in
        'register') input=("")
            ;;
        'login') input=("")
            ;;
        'quote') input=("")
            ;;
        'buy') input=("")
            ;;
        'sell') input=("")
            ;;
        'index') input=("")
            ;;
        'history') input=("")
            ;;
    esac


    return
}

main "$@"
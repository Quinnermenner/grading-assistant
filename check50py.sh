#! /bin/bash

problem=$1
student=$2
pset=$3

case "$problem" in
    "caesar") arguments=( "a/b/1" "barfoo/yxocll/23" "BARFOO/EDUIRR/3" "BaRFoo/FeVJss/4" "barfoo/onesbb/65" "null/Usage-error/")
    ;;
    "vigenere") arguments=("a/a/a" "barfoo/caqgon/baz" "BaRFoo/CaQGon/BaZ" "BARFOO/CAQGON/BAZ" "world!\$?/xoqmd!\$?/baz" "null/Usage-error/" "null/Error/Hax0r2")
    ;;
    "mario") arguments=("-1/Rejected" "0/Empty-pyramid" "1/Pyramid" "2/Pyramid" "23/Pyramid" "24/Rejection" "foo/Rejection" "/Rejection")
    ;;
    "greedy") arguments=("0.41/4" "0.01/1" "0.15/2" "1.6/7" "23/92" "4.2/18" "-0.1/Rejection" "foo/Rejection" "/Rejection")
    ;;
    "credit") arguments=("378282246310005/AMEX" "371449635398431/AMEX" "5555555555554444/MASTERCARD" "5105105105105100/MASTERCARD" "4111111111111111/VISA" "4012888888881881/VISA" "1234567890/INVALID" "foo/Rejection" "/Rejection")
    ;;
    "crack") arguments=("50fkUxYHbnXGw/rofl" "50i2t3sOSAZtk/lol" "50.jPgLzVirkc/hi")
    ;;
    "smile") arguments=("/:)/love" "/:(/hate" "/:|/bart")
    ;;
    "tweets") arguments=("/Error/@harko" "/SomeTweets/@cs50" "/SomeTweets/@davidjmalan")
esac

main() {

    check_$problem
}

check_tweets() {

    for args in ${arguments[@]}; do
        output="$(cut -d'/' -f2 <<<"$args")"
        argv="$(cut -d'/' -f3 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (./$problem $argv))
        echo
    done
}

check_smile() {

    for args in ${arguments[@]}; do
        output="$(cut -d'/' -f2 <<<"$args")"
        argv="$(cut -d'/' -f3 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (./$problem $argv))
        echo
    done
}

check_crack() {

    for args in ${arguments[@]}; do
        output="$(cut -d'/' -f2 <<<"$args")"
        argv="$(cut -d'/' -f3 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (python $problem.py $argv))
        echo
    done

    ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
    echo "Output should be: Usage-error" &&
    python $problem.py 10 20)

    echo

    ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
    echo "Output should be: Usage-error" &&
    python $problem.py)

    echo

}

check_credit() {

    for args in ${arguments[@]}; do
        input="$(cut -d'/' -f1 <<<"$args")"
        output="$(cut -d'/' -f2 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (echo "$input" | python $problem.py))
        echo
    done
}

check_greedy() {

    for args in ${arguments[@]}; do
        input="$(cut -d'/' -f1 <<<"$args")"
        output="$(cut -d'/' -f2 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (echo "$input" | python $problem.py))
        echo
    done
}

check_mario() {

    for args in ${arguments[@]}; do
        input="$(cut -d'/' -f1 <<<"$args")"
        output="$(cut -d'/' -f2 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (echo "$input" | python $problem.py))
        echo
    done
}

check_vigenere() {

    for args in ${arguments[@]}; do
        input="$(cut -d'/' -f1 <<<"$args")"
        output="$(cut -d'/' -f2 <<<"$args")"
        argv="$(cut -d'/' -f3 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (echo "$input" | python $problem.py $argv))
        echo
    done

    ( cd $student/$pset && echo "Testing input: null & argv: baz boo" &&
     echo "Output should be: Too many arguments" &&
     (echo "null" | python $problem.py "baz" "boo"))
}

check_caesar() {

    for args in ${arguments[@]}; do
        input="$(cut -d'/' -f1 <<<"$args")"
        output="$(cut -d'/' -f2 <<<"$args")"
        argv="$(cut -d'/' -f3 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (echo "$input" | python $problem.py $argv))
        echo
    done
}

main "$@"
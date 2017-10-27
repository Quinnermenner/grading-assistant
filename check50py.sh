#! /bin/bash

problem=$1
student=$2
pset=$3

case "$problem" in
    "caesar") ext=".py"; arguments=( "a/b/1" "barfoo/yxocll/23" "BARFOO/EDUIRR/3" "BaRFoo/FeVJss/4" "barfoo/onesbb/65" "null/Usage-error/")
    ;;
    "vigenere") ext=".py"; arguments=("a/a/a" "barfoo/caqgon/baz" "BaRFoo/CaQGon/BaZ" "BARFOO/CAQGON/BAZ" "world!\$?/xoqmd!\$?/baz" "null/Usage-error/" "null/Error/Hax0r2" "null/Usage-error/baz\nboo")
    ;;
    "mario") ext=".py"; arguments=("-1/Rejected" "0/Empty-pyramid" "1/Pyramid" "2/Pyramid" "23/Pyramid" "24\n2/Pyramid" "foo/Rejection" "/Rejection")
    ;;
    "greedy") ext=".py"; arguments=("0.41/4" "0.01/1" "0.15/2" "1.6/7" "23/92" "4.2/18" "-0.1/Rejection" "foo/Rejection" "/Rejection")
    ;;
    "credit") ext=".py"; arguments=("378282246310005/AMEX" "371449635398431/AMEX" "5555555555554444/MASTERCARD" "5105105105105100/MASTERCARD" "4111111111111111/VISA" "4012888888881881/VISA" "1234567890/INVALID" "foo/Rejection" "/Rejection")
    ;;
    "crack") ext=".py"; arguments=("50fkUxYHbnXGw/rofl/50fkUxYHbnXGw" "50i2t3sOSAZtk/lol/50i2t3sOSAZtk" "50.jPgLzVirkc/hi/50.jPgLzVirkc" "10\n20/Usage-error/10\n20" "/Usage-error/")
    ;;
    "smile") ext=""; arguments=("/:)/love" "/:(/hate" "/:|/bart")
    ;;
    "tweets") ext=""; arguments=("/Error/@harko" "/SomeTweets/@cs50" "/SomeTweets/@aa")
esac

main() {

    check
}

check() {

    for args in ${arguments[@]}; do
        input="$(cut -d'/' -f1 <<<"$args")"
        output="$(cut -d'/' -f2 <<<"$args")"
        argv="$(cut -d'/' -f3 <<<"$args")"
        ( cd $student/$pset && echo "Testing input: $input & argv: $argv" &&
          echo "Output should be: $output" &&
          (echo "$input" | python $problem$ext $argv))
        echo
    done
}

main "$@"
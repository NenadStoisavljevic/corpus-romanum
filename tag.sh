#!/bin/sh

# Requires Whitacker's Words (Latin dictionary), you can find it at https://github.com/mk270/whitakers-words

letters="ADJ:A
ADV:D
CONJ:C
INTERJ:I
NUM:M
PREP:P
PRON:O
SUFFIX:S
VPAR:R"

sub() {
    for x in $1; do
        tag=$(echo "$letters" | grep -w "$x" | cut -d ':' -f 2)
        [ -z "$tag" ] && labels="${labels}$x" || labels="${labels}$tag"
    done; printf "%s\n" "$labels"
}

main() {
    while read -r line; do
        last=${line##* }
        for word in $line; do
            pos=$(words "$word" | grep -Ev '(;|]|words)' | awk '{print $2}' | sort -u)
            letter=$(sub "$pos")
            [ "$word" = "$last" ] && printf "%s//%s\n" "$word" "$letter" >> "$output" || printf "%s//%s " "$word" "$letter" >> "$output"
        done
    done < "$1"
}

if [ $# -eq 0 ]
then
    echo "Provide file(s) to tag." && exit 1
else
    for name in "$@"; do
        file="$name"
        output="$file-tagged"
        echo "Tagging \"$file\"..."
        main "$file"
    done
fi

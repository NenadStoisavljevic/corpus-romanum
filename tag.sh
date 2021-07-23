#!/bin/sh

# Requires Whitacker's Words (Latin dictionary), you can find it at https://github.com/mk270/whitakers-words

subs="ADJ:A
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
        letter=$(echo "$subs" | grep -w "$x" | cut -d ':' -f 2)
        [ -z "$letter" ] && labels="${labels}$x" || labels="${labels}$letter"
    done; printf "%s\n" "$labels"
}

tag() {
    while read -r line; do
        last=${line##* }
        for word in $line; do
            pos=$(words "$word" | grep -Ev '(;|]|words)' | awk '{print $2}' | sort -u)
            letters=$(sub "$pos")
            [ "$word" = "$last" ] && printf "%s//%s\n" "$word" "$letters" >> "$output" || printf "%s//%s " "$word" "$letters" >> "$output"
        done
    done < "$1"
}

[ $# -eq 0 ] && echo "Provide file(s) to tag." && exit 1
for name in "$@"; do
    file="$name"
    output="$name-tagged"
    echo "Tagging \"$file\"..." && tag "$file"
done

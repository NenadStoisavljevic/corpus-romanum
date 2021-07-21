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
    for x in $@; do
        tag=$(echo "$letters" | grep -w "$x" | cut -d ':' -f 2)
        [ -z "$tag" ] && labels="${labels}$x" || labels="${labels}$tag"
    done; printf "%s\n" "$labels"
}

err() { echo "Usage :
    taglatin [OPTIONS] file(s)
You will be prompted to give file(s) as command-line arguments if you have not already." && exit 1 ;}

file="$1"
output="$file-tagged"

[ ! -f "$file" ] && echo "Provide a file to tag." && err

echo "Tagging \"$file\"..."

while read -r line; do
    last=${line##* }
    for word in $line; do
        pos=$(words "$word" | grep -Ev '(;|]|words)' | awk '{print $2}' | sort -u)
        letter=$(sub "$pos")
        [ "$word" = "$last" ] && printf "%s//%s\n" "$word" "$letter" >> "$output" || printf "%s//%s " "$word" "$letter" >> "$output"
    done
done < "$file"

#!/bin/sh

# Requires Whitacker's Words (Latin-English dictionary), you can
# find it at https://github.com/mk270/whitakers-words.

# A list of substitutes for the parts of speech.
subs="ADJ:A
ADV:D
CONJ:C
INTERJ:I
NUM:M
PREP:P
PRON:O
SUFFIX:S
SUPINE:N
TACKON:T
VPAR:R"

# Get and format text from The Latin Library.
getlatin() { curl -sf "$link" > "$esctitle" || exit 1
    sed -i 's/<[^>]*>//g
            s/&nbsp;//g
            s/\t//g
            /./,/^$/!d
            s/  \+/ /g' "$esctitle"
}

sub() { # Replace parts of speech with a letter.
    for x in $1; do
        letter=$(echo "$subs" | grep -w "$x" | cut -d ':' -f 2)
        [ -z "$letter" ] && labels="${labels}$x" || labels="${labels}$letter"
    done; printf "%s\n" "$labels"
}

tag() { # Tag file.
    output="$1-tagged"
    while read -r line; do
        [ -z "$line" ] && printf "\n" >> "$output" || last=${line##* } && total=$(echo "$line" | grep -ow "$last" | wc -l) && count=0
        for word in $line; do
            [ "$word" = "$last" ] && count=$((count+1))
            # Run the word in `words` and only select the possible
            # parts of speech.
            pos=$(words "$word" | grep -Ev '(;|])' | awk '$2~/[A-Z]/{print $2}' | sort -u)
            letters=$(sub "$pos")
            # Append each tagged word to the output file.
            # Print a newline when the last word of a sentence is
            # reached, otherwise print the word with a space.
            [ "$total" = "$count" ] && printf "%s//%s\n" "$word" "$letters" >> "$output" && unset word ||
                [ -z "$letters" ] && printf "%s " "$word" >> "$output" || printf "%s//%s " "$word" "$letters" >> "$output"
        done
    done < "$1"
}

# Check for number of files provided and tag each one
# accordingly, otherwise prompt user to provide a link.
if [ $# -eq 0 ]
then
    echo "Enter the full link of the text:"; read -r link
    echo "Enter the title of the text:"; read -r title
    esctitle="$(echo "$title" | iconv -cf UTF-8 -t ASCII//TRANSLIT | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed "s/-\+/-/g;s/\(^-\|-\$\)//g")"
    getlatin && echo "Tagging \"$esctitle\"..." && tag "$esctitle"
else
    for file in "$@"; do
        echo "Tagging \"$file\"..." && tag "$file"
    done
fi

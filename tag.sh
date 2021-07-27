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
VPAR:R"

# Get and format text from The Latin Library.
gettext() { curl -sf "$link" > "$title" && sed -i 's/<[^>]\+>/ /g' "$title" || exit 1 ;}

sub() { # Replace parts of speech with a letter.
    for x in $1; do
        letter=$(echo "$subs" | grep -w "$x" | cut -d ':' -f 2)
        [ -z "$letter" ] && labels="${labels}$x" || labels="${labels}$letter"
    done; printf "%s\n" "$labels"
}

tag() { # Tag file.
    while read -r line; do
        last=${line##* }
        for word in $line; do
            # Run the word in `words` and only select the possible
            # parts of speech.
            pos=$(words "$word" | grep -Ev '(;|]|words)' | awk '{print $2}' | sort -u)
            letters=$(sub "$pos")
            # Append each tagged word to the output file.
            # Print a newline when the last word of a sentence is
            # reached, otherwise print the word with a space.
            [ "$word" = "$last" ] && printf "%s//%s\n" "$word" "$letters" >> "$output" || printf "%s//%s " "$word" "$letters" >> "$output"
        done
    done < "$1"
}

# Check for number of files provided and tag each one
# accordingly, otherwise prompt user to provide a link.
if [ $# -eq 0 ]
then
    echo "Enter the full link of the text:"; read -r link
    echo "Enter the title of the text:"; read -r title
    gettext
    file="$title"
    output="$title-tagged"
    echo "Tagging \"$file\"..." && tag "$file"
else
    for name in "$@"; do
        file="$name"
        output="$name-tagged"
        echo "Tagging \"$file\"..." && tag "$file"
    done
fi

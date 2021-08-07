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

getlatin() { # Get and format text from The Latin Library.
	curl -sf "$link" > "$esctitle" || exit 1
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
		# If the line is empty then print a newline, otherwise
		# store the last word of the line and check for the
		# number of occurrences of that word in the line.
		[ -z "$line" ] && printf "\n" >> "$output" || last=${line##* } && total=$(echo "$line" | grep -ow "$last" | wc -w) && count=0
		for word in $line; do
			# Increment count to indicate when the last word
			# of a line is reached.
			[ "$word" = "$last" ] && count=$((count+1))

			# Run the word in `words` and only select the possible
			# parts of speech. Then use sub() to store parts of
			# speech as single letters.
			pos=$(words "$word" | grep -Ev '(;|])' | awk '$2~/[A-Z]/{print $2}' | sort -u)
			letters=$(sub "$pos")

			# Check if the end of a line is reached and whether
			# there are any parts of speech stored for that word.
			if [ "$total" = "$count" ] && [ -z "$letters" ]; then
				printf "%s\n" "$word" >> "$output"
			elif [ "$total" = "$count" ]; then
				printf "%s//%s\n" "$word" "$letters" >> "$output"
			elif [ -z "$letters" ]; then
				printf "%s " "$word" >> "$output"
			else
				printf "%s//%s " "$word" "$letters" >> "$output"
			fi
		done
	done < "$1"
}

# If no files are provided, then prompt the user to
# provide a link and tag that file, otherwise loop
# through all command-line arguments and run tag().
if [ $# -eq 0 ]; then
	echo "Enter the full link of the text:"; read -r link
	echo "Enter the title of the text:"; read -r title
	esctitle="$(echo "$title" | iconv -cf UTF-8 -t ASCII//TRANSLIT | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed "s/-\+/-/g;s/\(^-\|-\$\)//g")"
	getlatin && echo "Tagging \"$esctitle\"..." && tag "$esctitle"
else
	for file in "$@"; do
		echo "Tagging \"$file\"..." && tag "$file"
	done
fi

# Corpus Romanum

The main part of this script is the part-of-speech tagger which can be used to tag Latin text documents. Its purpose is to aid the Latin student in identifying adjectives, adverbs, etc., while reading any sort of Latin text. Beginner Latin students can particularly find this useful as they advance through their Latin readings while gaining a better understanding of being able to identify verbs, pronouns, etc., more easily.

A useful resource out there is [The Latin Library](https://www.thelatinlibrary.com/), which the script is still in the process of being made to be better able to format various texts across the site.

## Usage

The script runs via the command `corpus`. Several text document files can be passed onto the script and each one will be tagged. If no files are provided, the user is expected to paste a link to some Latin text from The Latin Library, from there it will properly format the text and then tag it.

The script will produce an output file `file-tagged`.

## Requirements

- `words` - William Whitaker's Words is a digital Latin-English dictionary with inflectional morphology support. This tool can be used to help in translations for any Latin student. Check out the repo [here](https://github.com/mk270/whitakers-words).

## Help the Project!

- Try feeding the script all kinds of Latin texts and report any errors.
- Optimizing the script in any way is always appreciated as tagging long Latin texts can take a while.

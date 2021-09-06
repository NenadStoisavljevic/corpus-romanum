# Corpus Romanum

Features included in the corpus:

- Part-of-speech tagger which can be used on texts stored locally
- Individual words can be marked up
- A searchable Latin corpus which:
    * automatically formats original text from [The Latin Library](http://thelatinlibrary.com/)
    * creates a tagged version of the text

The purpose of these tools is to aid the Latin student in identifying adjectives, adverbs, etc., while reading any sort of Latin text. Beginner Latin students can particularly find this useful as they advance through their Latin readings while gaining a better understanding of being able to identify verbs, pronouns, etc., more easily.

## Install

#### Dependencies

- `curl` - downloads the texts (required for adding texts to corpus).
- `fzf` - terminal fuzzy finder for searching the corpus.
- William Whitaker's `words` - digital Latin-English dictionary with inflectional morphology support. This tool can be used to help in translations for any Latin student. Check out the repo [here](https://github.com/mk270/whitakers-words).

```sh
git clone https://github.com/NenadStoisavljevic/corpus-romanum
cd corpus-romanum
sudo make install
```

## Usage

The corpus runs via the command `corpus`. When tagging a file not stored in the corpus, it will produce an output file `file-tagged`.

- `corpus -a link` -- add a text to the corpus
- `corpus -l` -- list all currently stored texts
- `corpus -t file` -- tag a file which is not to be stored in the corpus
- `corpus -T word` -- mark up a Latin word
- `corpus -s` -- search all texts which are stored in the corpus
- `corpus -d` -- choose a text to delete from the corpus

**Note**: When providing a link, it must come from [thelatinlibrary.com](http://thelatinlibrary.com/), otherwise the text will not be added to the corpus.

## Help the Project!

- Try feeding peculiar Latin texts, as well as any Latin words and report any errors.
- Optimizing the script in any way is always beneficial as tagging long Latin texts can take a while.

## License

This program is released under the GPLv3 license, you can find it [here](LICENSE).

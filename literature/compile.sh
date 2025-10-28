#!/bin/bash

rm -f library.bib
# cat *.bib > library.bib

# 1. Clear or create the output file to start fresh
> library.txt

# 2. Loop through all.bib files and append content with a separator
for bibfile in *.bib; do
    # Append the content of the current.bib file
    cat "$bibfile" >> library.txt
    # Insert a guaranteed newline for separation
    echo >> library.txt
done

mv library.txt library.bib
pdflatex report
bibtex report
pdflatex report
rm -f *.aux
rm -f *.log
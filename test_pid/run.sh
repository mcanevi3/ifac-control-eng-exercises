#!/bin/sh
file="digits.tex"
text1="";
text2="";

for x in {8..9}; 
do
	for y in {8..9}; 
	do
			text1=$text1"\def\xzero{"$x"}";
			text2=$text2"\def\xone{"$y"}";
			
			echo -e $text1"\n"$text2 > $file
			eval "pdflatex -output-directory='Files' \
			-jobname=$x$y main.tex "
			eval "rm Files/*.log"
			eval "rm Files/*.aux"
			eval "rm digits.tex"
done
done 
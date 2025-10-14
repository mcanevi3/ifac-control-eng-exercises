#!/bin/sh

file="digits.tex"

#\def\x{5}
#\def\y{2}
#\newcommand\showresults{}

#x=1
#y=2

text1="";
text2="";

for x in {0..1}; 
do
	for y in {0..1}; 
	do
			text1=$text1"\def\x{"$x"}";
			text2=$text2"\def\y{"$y"}";
			
			# echo -e $text1"\n"$text2 > $file
			echo $text1$text2"\\newcommand\\showresults{}" > $file
			eval "pdflatex -output-directory='Files' -jobname=$x$y main.tex "
			eval "rm Files/*.log"
			eval "rm Files/*.aux"
			eval "rm digits.tex"
done
done 
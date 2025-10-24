#!/bin/sh
#\newcommand\showresults{}
file="digits.tex"
text1="";
text2="";

for x in {8..9}; 
do
	for y in {8..9}; 
	do
			text1=$text1"\def\xzero{"$x"}";
			text2=$text2"\def\xone{"$y"}";
			
			echo $text1$text2"\printanswers" > $file
			eval "pdflatex -output-directory='FilesSol' -jobname=$x$y main.tex "
			eval "pdflatex -output-directory='FilesSol' -jobname=$x$y main.tex "
			eval "rm FilesSol/*.log"
			eval "rm FilesSol/*.aux"
			eval "rm digits.tex"
done
done 
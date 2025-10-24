#!/bin/sh
file="digits.tex"
text1="";
text2="";

for x in {0..0}; 
do
	for y in {0..0}; 
	do
			text1=$text1"\def\xzero{"$x"}";
			text2=$text2"\def\xone{"$y"}";
			
			echo $text1$text2"\printanswers" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=$x$y question2_1.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=$x$y question2_1.tex "
			eval "rm paper_img/*.log"
			eval "rm paper_img/*.aux"
			eval "rm digits.tex"
done
done 
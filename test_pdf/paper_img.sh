#!/bin/sh
file="digits.tex"

for x in {0..0}; 
do
	for y in {0..0}; 
	do
			
			echo "\def\xzero{"$x"}\def\xone{"$y"}" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=q2_1 paperq2_1.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=q2_1 paperq2_1.tex "

			echo "\def\xzero{"$x"}\def\xone{"$y"}" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=q2_2 paperq2_2.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=q2_2 paperq2_2.tex "

			eval "rm paper_img/*.log"
			eval "rm paper_img/*.aux"
			eval "rm digits.tex"
done
done 
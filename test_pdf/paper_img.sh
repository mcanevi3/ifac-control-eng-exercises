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

			echo "\def\xzero{"$x"}\def\xone{"$y"}" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=q3_q paperq3_q.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=q3_q paperq3_q.tex "

			echo "\def\xzero{"$x"}\def\xone{"$y"}" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=q3_correct paperq3_correct.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=q3_correct paperq3_correct.tex "

			echo "\def\xzero{"$x"}\def\xone{"$y"}" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=q3_f1 paperq3_f1.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=q3_f1 paperq3_f1.tex "

			echo "\def\xzero{"$x"}\def\xone{"$y"}" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=q3_f2 paperq3_f2.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=q3_f2 paperq3_f2.tex "

			echo "\def\xzero{"$x"}\def\xone{"$y"}" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=q3_f3 paperq3_f3.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=q3_f3 paperq3_f3.tex "

			echo "\def\xzero{"$x"}\def\xone{"$y"}" > $file
			eval "pdflatex -output-directory='paper_img' -jobname=q3_f4 paperq3_f4.tex "
			eval "pdflatex -output-directory='paper_img' -jobname=q3_f4 paperq3_f4.tex "

			eval "rm paper_img/*.log"
			eval "rm paper_img/*.aux"
			eval "rm digits.tex"
done
done 
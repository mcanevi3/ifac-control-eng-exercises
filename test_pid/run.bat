@echo OFF

set file="digits.tex"


for /l %%x in (0, 1, 9) do (
	for /l %%y in (0, 1, 9) do (

echo %%x%%y
echo \def\x{"%%x"}\def\y{"%%y"}>%file%

pdflatex.exe -output-directory=Files -jobname=%%x%%y main.tex 


)
)
cd Files
del *.log
del *.aux
cd ..
del student.tex
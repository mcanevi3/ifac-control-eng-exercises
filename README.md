# ifac-control-eng-exercises
A Student-Specific Problem Generation Framework for Control Engineering Courses - Code

# symbolic math impact
If symbolic expression can be used during the creation of parametric questions, then 
 - memory is preserved
 - latex floating-point errors are overcome (like 2.99999)
 - compilation-time is reduced 
If no such option than the parametric question creation needs lots of arrays to dump

- bode gain/phase
- step-response
- pole-zero map
- root-locus
- block-diagrams

When generating step-responses using symbolic math, inverse-Laplace transform pole-zero cancellations or Laplace transform boundary condition violations may occur!!!

# creating variables 
Choosing $x$ as a digit of student-id any parameter in interval [pmin,pmax] based on $x$ is created via
p=pmin+(pmax-pmin)*(x/9)

Choosing $xy$ as last two digits of student-id 
p=pmin+(pmax-pmin)*((10*x+y)/99)


# Thanks to
https://github.com/jesseopdenbrouw/exam-randomizechoices
from util import *
from report import *

# all students
file_list=studentfiles_list()
points={1:35,2:35,3:30}
LOs={1:"PI controller design",2:"Time-domain specifications",3:"Root-locus design"}

student_results=[]
for student_file in file_list:

    digits=get_digits_before_dot(student_file,2)

    student_ans=get_student_ans(student_file)
    correct_ans=get_keylist_ans(digits)

    res=compute_points(student=student_ans,correct=correct_ans,points=points)
    res['file']=student_file

    student_results.append(res)

generate_report(student_results,LOs)


import os
import re

def get_digits_before_dot(filename: str, n: int) -> list[int]:
    match = re.search(rf"(\d{{{n}}})\.\w+$", filename)
    if not match:
        return []  # no match found
    digits = match.group(1)
    return [int(d) for d in digits]

def get_keylist_ans(digits):
    num_str = ''.join(str(d) for d in digits)
    filename = f"keyfiles/{num_str}.keylist"
    if not os.path.exists(filename):
        raise FileNotFoundError(f"File not found: {filename}")
    with open(filename, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f if not line.strip().startswith("%")]

    # Parse the line \gdef\fi{1/E,2/A,3/A}
    mapping = {}
    for line in lines:
        if line.startswith(r"\gdef\fi"):
            # Extract the content between { and }
            inside = line.split("{", 1)[1].split("}", 1)[0]
            pairs = inside.split(",")
            for p in pairs:
                key, value = p.split("/")
                mapping[int(key)] = value
    return mapping

def studentfiles_list():
    files = [f for f in os.listdir("studentfiles") if os.path.isfile(os.path.join("studentfiles", f))]
    return files

def get_student_ans(filename):
    fname = "studentfiles/"+filename
    
    mapping = {}
    with open(fname, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("%"):
                continue  
            # split on any non-alphanumeric character(s)
            parts = re.split(r'\W+', line)
            
            if len(parts) >= 2:
                key = int(parts[0])
                value = parts[1]
                mapping[key] = value
    return mapping

def compute_points(correct: dict[int, str],
                   student: dict[int, str],
                   points: dict[int, int]) -> dict[int | str, int]:
    result = {}
    total = 0

    for key, correct_val in correct.items():
        student_val = student.get(key, '').strip().upper()
        if student_val=='':
            result[key] = ''
        else:
            point = 0
            if student_val == correct_val.upper():
                point = points.get(key, 0)
            result[key] = point
            total += point
    result['total'] = total
    return result

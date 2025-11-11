from typing import List, Dict
import statistics
import os
import csv
import matplotlib.pyplot as plt
import io
import base64

def generate_report(student_results: List[Dict], 
                                        LOs: Dict[int,str],
                                        csv_file="report.csv", 
                                        html_file="report.html"):
    """
    Generate a single CSV containing:
    - Per-student scores
    - Per-question statistics
    - Class statistics
    - Learning outcome performance (%)
    
    Also generates an HTML report with color-coded table and graphs.
    """
    if not student_results:
        print("No student results provided.")
        return
    
    question_keys = [k for k in student_results[0].keys() if k not in ['total','file']]
    
    # --- Compute statistics per question ---
    stats_per_question = {}
    per_question_counts = {}
    for q in question_keys:
        values_raw = [s[q] for s in student_results]
        # convert '' to 0
        values = [v if isinstance(v, (int,float)) else 0 for v in values_raw]

        correct_count = sum(1 for v in values if v>0)
        empty_count = sum(1 for s_ in student_results if str(s_.get(q,''))=='')
        false_count = len(student_results) - correct_count - empty_count
        per_question_counts[q] = {'correct': correct_count, 'false': false_count, 'empty': empty_count}
        deviation = round(statistics.stdev(values),2) if len(values)>1 else 0
        stats_per_question[q] = {
            'mean': round(statistics.mean(values),2),
            'deviation': deviation,
            'min': min(values),
            'max': max(values)
        }
    # --- Total scores statistics ---
    total_scores = [s['total'] for s in student_results]
    total_dev = round(statistics.stdev(total_scores),2) if len(total_scores)>1 else 0
    class_stats = {
        'mean': round(statistics.mean(total_scores),2),
        'deviation': total_dev,
        'min': min(total_scores),
        'max': max(total_scores)
    }
    
    # --- Learning outcomes performance ---
    LO_performance = {}
    for q, LO in LOs.items():
        if q in per_question_counts:
            total = sum(per_question_counts[q].values())
            correct_pct = round(100*per_question_counts[q]['correct']/total,1)
            false_pct = round(100*per_question_counts[q]['false']/total,1)
            empty_pct = round(100*per_question_counts[q]['empty']/total,1)
            LO_performance[q] = {'LO': LO, 'correct%': correct_pct, 'false%': false_pct, 'empty%': empty_pct}
    
    # --- Graph functions ---
    def plot_bar_counts(per_question_counts):
        labels = [f'Q{q}' for q in per_question_counts]
        correct = [per_question_counts[q]['correct'] for q in per_question_counts]
        false = [per_question_counts[q]['false'] for q in per_question_counts]
        empty = [per_question_counts[q]['empty'] for q in per_question_counts]
        x = range(len(labels))
        fig, ax = plt.subplots(figsize=(8,4))
        ax.bar(x, correct, label='Correct', color='green')
        ax.bar(x, false, bottom=correct, label='False', color='red')
        bottom2 = [c+f for c,f in zip(correct,false)]
        ax.bar(x, empty, bottom=bottom2, label='Empty', color='gray')
        ax.set_xticks(x)
        ax.set_xticklabels(labels)
        ax.set_ylabel('Number of students')
        ax.set_title('Question-wise performance')
        ax.legend()
        buf = io.BytesIO()
        plt.tight_layout()
        plt.savefig(buf, format='png')
        plt.close(fig)
        return base64.b64encode(buf.getvalue()).decode('utf-8')
    
    def plot_score_histogram(total_scores):
        fig, ax = plt.subplots(figsize=(6,4))
        ax.hist(total_scores, bins=10, color='skyblue', edgecolor='black')
        ax.set_xlabel('Total score')
        ax.set_ylabel('Number of students')
        ax.set_title('Score distribution')
        buf = io.BytesIO()
        plt.tight_layout()
        plt.savefig(buf, format='png')
        plt.close(fig)
        return base64.b64encode(buf.getvalue()).decode('utf-8')
    
    bar_chart_img = plot_bar_counts(per_question_counts)
    hist_img = plot_score_histogram(total_scores)
    
    # --- HTML output ---
    html = f"""
    <html>
    <head>
        <style>
            body {{ font-family: Arial, sans-serif; }}
            table {{ border-collapse: collapse; margin-bottom: 20px; }}
            th, td {{ border: 1px solid #333; padding: 5px 10px; text-align: center; }}
            th {{ background-color: #eee; }}
            .true {{ background-color: #c6efce; }}
            .false {{ background-color: #ffc7ce; }}
            .empty {{ background-color: #d9d9d9; }}
            .stats {{ background-color: #f9f9f9; font-weight: bold; }}
        </style>
    </head>
    <body>
        <h2>Student Grades Report</h2>
        <table>
            <tr><th>File</th>"""
    for q in question_keys:
        html += f"<th>Q{q}</th>"
    html += "<th>Total</th></tr>"
    
    for s in student_results:
        html += f"<tr><td>{s.get('file','')}</td>"
        for q in question_keys:
            val = s[q]
            if val=='':
                cls='empty'
            else:
                val_int=int(val)
                if val_int>0:
                    cls='true'
                elif val_int==0:
                    cls='false'
            html += f"<td class='{cls}'>{val}</td>"
        html += f"<td>{s['total']}</td></tr>"
    html += "</table>"
    
    html += "<h3>Per-Question Statistics</h3><table><tr><th>Question</th><th>Mean</th><th>Deviation</th><th>Min</th><th>Max</th></tr>"
    for q, stat in stats_per_question.items():
        html += f"<tr><td>Q{q}</td><td>{stat['mean']}</td><td>{stat['deviation']}</td><td>{stat['min']}</td><td>{stat['max']}</td></tr>"
    html += "</table>"
    
    html += f"<h3>Class Total Score Statistics</h3><table><tr><th>Mean</th><th>Deviation</th><th>Min</th><th>Max</th></tr>"
    html += f"<tr><td>{class_stats['mean']}</td><td>{class_stats['deviation']}</td><td>{class_stats['min']}</td><td>{class_stats['max']}</td></tr></table>"
    
    html += "<h3>Learning Outcomes Performance (%)</h3><table><tr><th>LO</th><th>Correct %</th><th>False %</th><th>Empty %</th></tr>"
    for q, perf in LO_performance.items():
        html += f"<tr><td>{perf['LO']}</td><td>{perf['correct%']}</td><td>{perf['false%']}</td><td>{perf['empty%']}</td></tr>"
    html += "</table>"
    
    html += f"<h3>Question-wise performance</h3><img src='data:image/png;base64,{bar_chart_img}'/>"
    html += f"<h3>Score distribution</h3><img src='data:image/png;base64,{hist_img}'/>"
    
    html += "</body></html>"
    
    with open(html_file,"w",encoding="utf-8") as f_html:
        f_html.write(html)
    
    # --- Single CSV containing everything ---
    with open(csv_file, 'w', newline='', encoding='utf-8') as f_csv:
        writer = csv.writer(f_csv)
        # Per-student section
        writer.writerow(["Per-student scores"])
        header = ['File'] + [f'Q{q}' for q in question_keys] + ['Total']
        writer.writerow(header)
        for s in student_results:
            row = [s.get('file','')] + [s[q] for q in question_keys] + [s['total']]
            writer.writerow(row)
        writer.writerow([])

        # Per-question stats
        writer.writerow(["Per-question statistics"])
        writer.writerow(["Question","Mean","Deviation","Min","Max"])
        for q, stat in stats_per_question.items():
            writer.writerow([f"Q{q}",stat['mean'],stat['deviation'],stat['min'],stat['max']])
        writer.writerow([])

        # Class stats
        writer.writerow(["Class total score statistics"])
        writer.writerow(["Mean","Deviation","Min","Max"])
        writer.writerow([class_stats['mean'],class_stats['deviation'],class_stats['min'],class_stats['max']])
        writer.writerow([])

        # LO performance
        writer.writerow(["Learning Outcomes Performance (%)"])
        writer.writerow(["LO","Correct %","False %","Empty %"])
        for q, perf in LO_performance.items():
            writer.writerow([perf['LO'],perf['correct%'],perf['false%'],perf['empty%']])

    print(f"All data CSV saved to {os.path.abspath(csv_file)}")
    print(f"HTML report saved to {os.path.abspath(html_file)}")

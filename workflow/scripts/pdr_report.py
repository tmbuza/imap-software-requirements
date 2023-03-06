# import sys
# !{sys.executable} -m pip install fpdf -q
# !{sys.executable} -m pip install pandas -q
# !{sys.executable} -m pip install plotly-express -q
# !{sys.executable} -m pip install kaleido -q


from datetime import date
from pathlib import Path
import sqlite3

import pandas as pd  # pip install pandas
import plotly.express as px  # pip install plotly-express kaleido
from fpdf import FPDF  # pip install fpdf

# Define the font color as RGB values (dark gray)
font_color = (64, 64, 64)

# Find all PNG files in the output folder
chart_filenames = [str(images) for chart_path in output_dir.glob("*.png")]

# Create a PDF document and set the page size
pdf = FPDF()
pdf.add_page()
pdf.set_font('Arial', 'B', 24)

# Add the overall page title
title = f"Getting started with microbiome data analysis {date.today().strftime('%m/%d/%Y')}"
pdf.set_text_color(*font_color)
pdf.cell(0, 20, title, align='C', ln=1)

# Add each chart to the PDF document
for chart_filename in chart_filenames:
    pdf.ln(10)  # Add padding at the top of the next chart
    pdf.image(chart_filename, x=None, y=None, w=pdf.w - 20, h=0)

# Save the PDF document to a file on disk
pdf.output(output_dir / "saldocs/imap_part_01.pdf", "F")
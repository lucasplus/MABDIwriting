SET STR=thesis

pdflatex "%STR%.tex"
bibtex "%STR%.aux"
pdflatex "%STR%.tex"
pdflatex "%STR%.tex"

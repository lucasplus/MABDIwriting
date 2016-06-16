all:
	while true; do for i in *.tex; do if test $$i -nt approach.pdf; then make approach; break; fi; done; sleep 1; done

approach: 
	pdflatex -halt-on-error approach
	bibtex approach.aux
	pdflatex -halt-on-error approach
	pdflatex -halt-on-error approach

bbl:
	pdflatex approach
	bibtex approach
	pdflatex approach
	pdflatex approach

clean:
	rm -f *.{aux,log} 

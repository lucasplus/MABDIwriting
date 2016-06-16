all:
	while true; do for i in *.tex; do if test $$i -nt proposal.pdf; then make proposal; break; fi; done; sleep 1; done

proposal: 
	pdflatex -halt-on-error proposal
	bibtex proposal.aux
	pdflatex -halt-on-error proposal
	pdflatex -halt-on-error proposal

bbl:
	pdflatex proposal
	bibtex proposal
	pdflatex proposal
	pdflatex proposal

clean:
	rm -f *.{aux,log} 

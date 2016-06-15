all:
	while true; do for i in *.tex; do if test $$i -nt AMfigure.pdf; then make AMfigure; break; fi; done; sleep 1; done

AMfigure: 
	pdflatex --jobname=tikzExt/AM1 AMfigure.tex
	pdflatex --jobname=tikzExt/AM2 AMfigure.tex
	pdflatex --jobname=tikzExt/AM3 AMfigure.tex
	pdflatex -halt-on-error AMfigure
	pdflatex -halt-on-error AMfigure

clean:
	rm -f *.{aux,log} 

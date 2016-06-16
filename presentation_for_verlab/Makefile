all:
	while true; do for i in *.tex; do if test $$i -nt presentation.pdf; then make presentation; break; fi; done; sleep 1; done

presentation: 
	pdflatex -halt-on-error presentation
	pdflatex -halt-on-error presentation

clean:
	rm -f *.{aux,log} 

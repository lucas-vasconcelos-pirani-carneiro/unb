PDFNAME = anotacoes
TEX     = main.tex
OUTDIR  = output

all:
	mkdir -p $(OUTDIR)
	pdflatex $(TEX)
	pdflatex $(TEX)
	mv main.pdf $(OUTDIR)/$(PDFNAME).pdf

clean:
	rm -f *.aux *.log *.out *.toc *.synctex.gz *.fls *.fdb_latexmk

cleanall: clean
	rm -f $(OUTDIR)/$(PDFNAME).pdf

.PHONY: all clean cleanall

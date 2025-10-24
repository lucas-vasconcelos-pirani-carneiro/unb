PDFNAME   = lista06
TEX       = main.tex
OUTDIR    = output

all: $(OUTDIR)/$(PDFNAME).pdf

$(OUTDIR)/$(PDFNAME).pdf: $(TEX)
	mkdir -p $(OUTDIR)
	pdflatex $(TEX)
	mv main.pdf $(OUTDIR)/$(PDFNAME).pdf

clean:
	rm -f *.aux *.log *.out *.toc *.synctex.gz *.fls *.fdb_latexmk *.bbl *.blg

cleanall: clean
	rm -f $(OUTDIR)/$(PDFNAME).pdf

.PHONY: all clean cleanall

all:
	mkdir -p $(OUTDIR)
	pdflatex $(TEX)
	mv main.pdf $(OUTDIR)/$(PDFNAME).pdf

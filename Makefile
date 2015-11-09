# Specify your latex/bibtex programs here. I Highly reccomend biber!
LATEX=pdflatex --shell-escape
BIBTEX=biber -q

all: buildthesis

buildthesis:
	$(LATEX) thesis
	$(BIBTEX) thesis
	makeindex thesis.nlo -s nomencl.ist -o thesis.nls
	$(LATEX) thesis

# Will look for TODO in your tex files and generate a list
todo:
	grep -nr TODO '*.tex' > TodoList

clean:
	rm -rf *.aux *.log *.lof *.bbl *.blg *.lot *.toc references.processed.bib *-blx.bib *run.xml *.bcf *.lol *.ilg *.ind *.nlo *.nls


# Partial builds. This will generate a PDF containing only the chapter/section
# specified. Add more here as you get more chapters!
title:
	echo "\includeonly{00-titlepage}" > temp
	cat thesis.tex >> temp
	$(LATEX) --jobname=title  temp
	$(BIBTEX) title 
	$(LATEX) --jobname=title  temp
	rm temp

abstract:
	echo "\includeonly{00-abstract}" > temp
	cat thesis.tex >> temp
	$(LATEX) --jobname=abstract temp
	$(BIBTEX) abstract 
	$(LATEX) --jobname=abstract  temp
	rm temp

acknowledgements:
	echo "\includeonly{00-acknowledgements}" > temp
	cat thesis.tex >> temp
	$(LATEX) --jobname=acknowledgements temp
	$(BIBTEX) acknowledgements 
	$(LATEX) --jobname=acknowledgements temp
	rm temp

bibliography: processbib
	echo "\includeonly{99-bibliography}" > temp
	cat thesis.tex >> temp
	$(LATEX) --jobname=bibliograpy temp
	$(BIBTEX) bibliograpy 
	$(LATEX) --jobname=bibliograpy temp
	rm temp

introduction:
	echo "\includeonly{chapter-introduction}" > temp
	cat thesis.tex >> temp
	$(LATEX) --jobname=introduction temp
	$(BIBTEX) introduction 
	$(LATEX) --jobname=introduction temp
	rm temp


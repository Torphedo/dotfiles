#!/bin/sh

base_doc_name=$(basename -- "$1" .tex)

mkdir -p out

aux_file="out/${base_doc_name}.aux"
if test ! -f $aux_file
then
    # Compile PDF & generate AUX file for bibtex.
    pdflatex -output-directory=out $1
fi

# Figure out references and compile for real.
bibtex "out/${base_doc_name}"
pdflatex -output-directory=out $1

# Compile again to fix references.
# pdflatex -output-directory=out $1


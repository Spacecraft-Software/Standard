# SPDX-FileCopyrightText: 2026 Mohamed Hammad <Mohamed.Hammad@SpacecraftSoftware.org>
# SPDX-License-Identifier: GPL-3.0-or-later

TEXI  = The_Steelbore_Standard.texi
INFO  = The_Steelbore_Standard.info
HTML  = The_Steelbore_Standard.html
MD    = The_Steelbore_Standard.md
PDF   = The_Steelbore_Standard.pdf
DOCX  = The_Steelbore_Standard.docx
CSS   = spacecraft.css

all: info html md

info: $(INFO)
$(INFO): $(TEXI)
	makeinfo --no-split $(TEXI)

html: $(HTML)
$(HTML): $(TEXI) $(CSS)
	texi2any --html --no-split --css-include=$(CSS) $(TEXI)

md: $(MD)
$(MD): $(TEXI)
	texi2any --docbook $(TEXI) -o /tmp/std_docbook.xml
	pandoc -f docbook -t gfm /tmp/std_docbook.xml -o $(MD)

pdf: $(PDF)
$(PDF): $(TEXI)
	texi2pdf --texinfo=@afourpaper $(TEXI)

docx: $(DOCX)
$(DOCX): $(TEXI)
	texi2any --docbook $(TEXI) -o /tmp/std_docbook.xml
	pandoc -f docbook -t docx /tmp/std_docbook.xml -o $(DOCX)

clean:
	rm -f $(INFO) $(HTML) $(PDF) *.aux *.log *.toc *.cp *.cps \
	      *.fn *.fns *.ky *.kys *.pg *.pgs *.tp *.tps *.vr *.vrs

.PHONY: all info html md pdf docx clean

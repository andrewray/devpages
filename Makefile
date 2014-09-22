all: js/oauth.js

dev/oauth.byte: dev/oauth.ml
	ocamlfind ocamlc -o dev/oauth.byte \
		-syntax camlp4o \
		-package js_of_ocaml,js_of_ocaml.syntax \
		-linkpkg \
		dev/oauth.ml

js/oauth.js: dev/oauth.byte
	js_of_ocaml dev/oauth.byte -o js/oauth.js

clean:
	rm -f dev/oauth.cm[io] dev/oauth.byte 
	find . -name "*~" | xargs rm -f

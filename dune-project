(lang dune 3.2)

(name lumiere)

(generate_opam_files true)

(source
 (github pmdias/lumiere))

(authors "Pedro Dias")

(maintainers "Pedro Dias")

(license LICENSE)

(package
 (name lumiere)
 (synopsis "Experimental ray tracing")
 (description "An experimental ray tracing library and application")
 (depends ocaml dune)
 (tags
  (raytracing)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project

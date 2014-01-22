(*
** FALCON project
*)

(* ****** ****** *)

staload "./falcon.sats"

(* ****** ****** *)

assume gene_type = symbol

(* ****** ****** *)

implement
fprint_gene
  (out, gn) = fprint_symbol (out, gn)
// end of [fprint_gene]

(* ****** ****** *)

implement
gene_make_symbol (x) = x

(* ****** ****** *)

(* end of [falcon_genes.dats] *)

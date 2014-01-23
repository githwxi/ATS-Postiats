(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./falcon.sats"

(* ****** ****** *)

local

assume gene_type = symbol

in (* in-of-local *)

implement
gene_make_symbol (x) = x

implement
fprint_gene
  (out, gn) = fprint_symbol (out, gn)
// end of [fprint_gene]

implement
compare_gene_gene (x1, x2) = symbol_compare (x1, x2)

end // end of [local]

(* ****** ****** *)
//
// HX: genes is based linear ordered lists
//
(* ****** ****** *)

staload
LS = "libats/ATS1/SATS/linset_listord.sats"
staload
_(*LS*) = "libats/ATS1/DATS/linset_listord.dats"

(* ****** ****** *)

assume
genes_vtype = $LS.set (gene)

(* ****** ****** *)

implement
$LS.compare_elt_elt<gene> (x1, x2, _) = compare (x1, x2)

(* ****** ****** *)

implement
genes_union
  (xs1, xs2) =
  $LS.linset_union<gene> (xs1, xs2, $UN.cast{$LS.cmp(gene)}(0))
// end of [genes_union]

(* ****** ****** *)

(* end of [falcon_genes.dats] *)

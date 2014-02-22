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
  (out, gn) = fprint_string (out, gn.name)
// end of [fprint_gene]

implement
gene_hash (x) = $UN.cast{ulint}(symbol_get_stamp(x))

implement
compare_gene_gene (x1, x2) = symbol_compare (x1, x2)

end // end of [local]

(* ****** ****** *)
//
implement
gene_make_name (name) =
  gene_make_symbol (symbol_make (name))
//
(* ****** ****** *)

implement
print_gene (gn) = fprint (stdout_ref, gn)

(* ****** ****** *)
//
// HX: genes is based on linear ordered lists
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
//
implement
genes_sing (gn) =
  $LS.linset_make_sing<gene> (gn)
//
(* ****** ****** *)

implement
genes_free (xs) = $LS.linset_free<gene> (xs)
implement
genes_copy (xs) = $LS.linset_copy<gene> (xs)

(* ****** ****** *)

implement
genes_union
  (xs1, xs2) =
  $LS.linset_union<gene> (xs1, xs2, $UN.cast{$LS.cmp(gene)}(0))
// end of [genes_union]

(* ****** ****** *)

implement
lte_genes_genes
  (gns1, gns2) =
  $LS.linset_is_subset (gns1, gns2, $UN.cast{$LS.cmp(gene)}(0))
implement
gte_genes_genes
  (gns1, gns2) =
  $LS.linset_is_supset (gns1, gns2, $UN.cast{$LS.cmp(gene)}(0))

(* ****** ****** *)

implement
genes_listize1 (xs) = $LS.linset_listize1<gene> (xs)

(* ****** ****** *)

local
//
implement
fprint_val<gene> = fprint_gene
//
in (*in-of-local*)

implement
fprint_genes (out, xs) =
{
  val xs = genes_listize1 (xs)
  val xs = list_vt_reverse (xs)
  val () = fprint_list_vt_sep (out, xs, ", ")
  val ((*void*)) = list_vt_free (xs)
}

end // end of [local]

(* ****** ****** *)
//
extern
fun geneslst_make_nil(): geneslst
//
implement geneslst_make_nil () = nil_vt
//
(* ****** ****** *)
//
implement
geneslst_free (xs) =
(
case+ xs of
| ~list_vt_nil () => ()
| ~list_vt_cons (x, xs) => let
    val () = genes_free (x) in geneslst_free (xs)
  end // end of [list_vt_cons]
)
//
(* ****** ****** *)

(* end of [falcon_genes.dats] *)

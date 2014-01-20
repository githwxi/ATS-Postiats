(*
** FALCON project
*)

(* ****** ****** *)

abstype gene_type = ptr
typedef gene = gene_type

(* ****** ****** *)

(*
** BB-2014: |genes| < 50
*)
absvtype genes_vtype = ptr
vtypedef genes = genes_vtype

(* ****** ****** *)

fun genes_union (xs: genes, ys: genes): genes

(* ****** ****** *)

absvtype GDMap_vtype = ptr
vtypedef GDMap = GDMap_vtype

fun gDMap_make_nil (): GDMap
fun gDMap_free (gdm: GDMap): void

fun gDMap_find (!GDMap, g: gene): double
fun gDMap_insert (mp: !GDMap, g: gene, dval: double): bool

(* ****** ****** *)

(* end of [falcon.sats] *)

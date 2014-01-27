(*
** FALCON project
*)

(* ****** ****** *)
//
typedef
print_type (a:t@ype) = (a) -> void
typedef
fprint_type (a:t@ype) = (FILEref, a) -> void
//
(* ****** ****** *)

abstype symbol_type = ptr
typedef symbol = symbol_type

(* ****** ****** *)
//
fun print_symbol : (symbol) -> void
fun fprint_symbol : fprint_type (symbol)
//
overload print with print_symbol
overload fprint with fprint_symbol
//
(* ****** ****** *)

fun the_symtbl_count ((*void*)): int

(* ****** ****** *)
//
fun symbol_make (string): symbol
fun symbol_get_name (symbol): string
fun symbol_get_stamp (sym: symbol): int
fun symbol_equal : (symbol, symbol) -<> bool
fun symbol_compare : (symbol, symbol) -<> int
//
symintr .name
overload .name with symbol_get_name
//
overload = with symbol_equal
overload compare with symbol_compare
//
(* ****** ****** *)

abstype position_type = ptr
typedef position = position_type

(* ****** ****** *)
//
fun
print_position : (position) -> void
fun
fprint_position : fprint_type (position)
//
overload print with print_position
overload fprint with fprint_position
//
(* ****** ****** *)

fun position_get_now (): position

(* ****** ****** *)
//
abstype gene_type = ptr
typedef gene = gene_type
typedef genelst = List0 (gene)
vtypedef genelst_vt = List0_vt (gene)
//
fun print_gene: print_type (gene)
fun fprint_gene: fprint_type (gene)
//
overload print with print_gene
overload fprint with fprint_gene
//
fun
compare_gene_gene (gene, gene):<> int
overload compare with compare_gene_gene
//
fun gene_hash (gene): ulint
fun gene_make_name (string): gene
fun gene_make_symbol (symbol): gene
//
(* ****** ****** *)

(*
** BB-2014: |genes| < 50
*)
absvtype genes_vtype = ptr
vtypedef genes = genes_vtype

(* ****** ****** *)

fun genes_sing (gene): genes

(* ****** ****** *)

fun genes_free (genes): void
fun genes_copy (!genes): genes

(* ****** ****** *)

fun genes_union (genes, genes): genes

(* ****** ****** *)

fun genes_listize1 (xs: !genes): genelst_vt

(* ****** ****** *)

fun fprint_genes (FILEref, !genes): void

(* ****** ****** *)
//
abstype GDMap_type = ptr
typedef GDMap = GDMap_type
//
fun GDMap_find
(
  map: GDMap, gn: gene, res: &double? >> opt (double, b)
) : #[b:bool] bool(b) // end of [GDMap_find]
//
fun GDMap_insert (map: GDMap, gn: gene, gval: double): void
//
(* ****** ****** *)

(* end of [falcon.sats] *)

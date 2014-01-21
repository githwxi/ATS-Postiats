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
fun symbol_equal : (symbol, symbol) -> bool
fun symbol_compare : (symbol, symbol) -> int
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
fun print_position : (position) -> void
fun fprint_position : fprint_type (position)
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
//
fun gene_make_symbol (symbol): gene
//
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

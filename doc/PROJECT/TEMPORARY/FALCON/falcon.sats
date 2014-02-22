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

fun fprint_the_position (FILEref): void

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
vtypedef geneslst = List0_vt (genes)

(* ****** ****** *)

fun genes_sing (gene): genes

(* ****** ****** *)

fun fprint_genes (FILEref, xs: !genes): void

(* ****** ****** *)

fun genes_free (genes): void
fun genes_copy (!genes): genes

(* ****** ****** *)

fun genes_union (genes, genes): genes

(* ****** ****** *)

fun lte_genes_genes (!genes, !genes): bool
fun gte_genes_genes (!genes, !genes): bool

(* ****** ****** *)

fun genes_listize1 (xs: !genes): genelst_vt

(* ****** ****** *)

fun geneslst_free (geneslst): void

(* ****** ****** *)

absvtype grcnf_vtype = ptr
vtypedef grcnf = grcnf_vtype
vtypedef grcnflst = List0_vt (grcnf)

(* ****** ****** *)

fun fprint_grcnf (FILEref, !grcnf): void 
fun fprint_grcnflst (FILEref, !grcnflst): void
//
overload fprint with fprint_grcnf
overload fprint with fprint_grcnflst
//
(* ****** ****** *)

datatype grexp =
  | GRgene of gene
  | GRconj of grexplst
  | GRdisj of grexplst
  | GRempty of ((*void*))
  | GRerror of ((*void*))
// end of [grexp]

where grexplst = List0 (grexp)

vtypedef grexplst_vt = List0_vt (grexp)

(* ****** ****** *)
//
fun fprint_grexp (FILEref, grexp): void
fun fprint_grexplst (FILEref, grexplst): void
//
overload fprint with fprint_grexp
overload fprint with fprint_grexplst of 10
//
(* ****** ****** *)

fun grexp_cnfize (gx: grexp): grcnf
fun grexplst_cnfize (gxs: grexplst): grcnflst

(* ****** ****** *)
//
abst@ype
expvar_type = @(double, double)
//
typedef expvar = expvar_type
typedef expvarlst = List0 (expvar)
vtypedef expvarlst_vt = List0_vt (expvar)
//
fun expvar_make (double, double): expvar
//
fun print_expvar : print_type (expvar)
fun fprint_expvar : fprint_type (expvar)
//
overload print with print_expvar
overload fprint with fprint_expvar
//
fun expvar_get_exp (expvar): double
fun expvar_get_var (expvar): double
//
symintr .gexp .gvar
overload .gexp with expvar_get_exp
overload .gvar with expvar_get_var
//
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

(*
This function is the primary interface for reading gene
expression data. It returns a pair of maps that can be used
to return the expression level and standard deviation of
expression for the gene under consideration.
*)

fun gmeanvar_initize (inp: FILEref): (GDMap(*mean*), GDMap(*stdev*))

(* ****** ****** *)
//
fun
grcnf_minmean_stdev
  (grcnf: !grcnf, emap: GDMap, smap: GDMap): expvar
//
fun
grcnflst_minmean_stdev
  (grcnfs: !grcnflst, emap: GDMap, smap: GDMap): expvarlst_vt
//
(* ****** ****** *)

(* end of [falcon.sats] *)

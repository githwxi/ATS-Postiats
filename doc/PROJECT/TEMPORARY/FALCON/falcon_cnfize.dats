(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./falcon.sats"
  
(* ****** ****** *)

staload "./falcon_genes.dats"
staload "./falcon_parser.dats"

(* ****** ****** *)

vtypedef grcnf = geneslst
vtypedef grcnflst = List0_vt (grcnf)

(* ****** ****** *)

extern
fun grcnf_free (grcnf): void
implement
grcnf_free (xs) =
(
case+ xs of
| ~list_vt_nil () => ()
| ~list_vt_cons (x, xs) => (genes_free (x); grcnf_free (xs))
) (* end of [grcnf_free] *)

(* ****** ****** *)

extern
fun
fprint_grcnf (FILEref, !grcnf): void  

extern
fun
fprint_grcnf_list_vt(FILEref, !grcnflst): void

local
//
implement
fprint_ref<genes>
  (out, xs) = fprint_genes (out, xs)
//
in(*in-of-local*)
//
implement
fprint_grcnf (out, cnf) =
  fprint_list_vt_sep<genes> (out, cnf, "; ")
//
implement
fprint_grcnf_list_vt (out, cnfs) = fprint_list_vt(out, cnfs)
//
end // end of [local]
  
(* ****** ****** *)

extern
fun
grexp_cnfize (grexp: grexp): grcnf

(* ****** ****** *)
extern
fun
grexplst_cnfize_list_vt {n:pos} (gxs: list(grexp, n)): grcnflst

(* ****** ****** *)

//
extern
fun
grcnf_conj
  (cnfs: grcnflst): geneslst
//
implement
grcnf_conj (cnfs) = let
//
fun loop
(
  cnfs: grcnflst, res: geneslst
) : geneslst = let
in
//
case+ cnfs of
| ~list_vt_nil () => res
| ~list_vt_cons
    (cnf, cnfs) => let
    val res = list_vt_append(cnf, res)
  in
    loop (cnfs, res)
  end (* end of [cons] *)
//
end // end of [loop]
//
val cnfs = list_vt_reverse (cnfs)
//
in
//
case+ cnfs of
| ~list_vt_nil () => list_vt_nil ()
| ~list_vt_cons (cnf, cnfs) => loop (cnfs, cnf)
//
end // end of [grcnf_conj]

(* ****** ****** *)
//
extern
fun
grcnf_disj
  (cnfs: grcnflst): geneslst
//
implement
grcnf_disj (cnfs) = let
//
fun aux
(
  x: !genes, ys: !geneslst
) : geneslst =
case+ ys of
| list_vt_cons
    (y, ys) => let
    val x2 = genes_copy (x)
    val y2 = genes_copy (y)
    val xy = genes_union (x2, y2)
    val xys = aux (x, ys)
  in
    list_vt_cons{genes}(xy, xys)
  end // end of [val]
| list_vt_nil () => list_vt_nil ()
//
fun auxlst
(
  xs: !geneslst, ys: !geneslst
) : geneslst = let
in
//
case+ xs of
| list_vt_nil () => list_vt_nil ()
| list_vt_cons
    (x, xs) =>
  (
    case+ xs of
    | list_vt_nil () => aux (x, ys)
    | list_vt_cons _ =>
        list_vt_append (aux (x, ys), auxlst (xs, ys))
      // end of [list_vt_cons]
  )
//
end // end of [auxlst]
//
in
//
case- cnfs of
| ~list_vt_cons
    (cnf, cnfs) => let
  in
    case+ cnfs of
    | ~list_vt_nil () => cnf
    |  list_vt_cons _ => let
        val xs = cnf
        val ys = grcnf_disj (cnfs)
        val xys = auxlst (xs, ys)
        val () = geneslst_free (xs)
        val () = geneslst_free (ys)
      in
        xys
      end // end of [cons]
  end // end of [list_cons]
//
end // end of [grcnf_disj]

(* ****** ****** *)

implement
grexp_cnfize
  (gx) = let
in
//
case+ gx of
| GRgene (gn) => let
    val xs = genes_sing (gn)
  in
    list_vt_cons{genes}(xs, list_vt_nil)
  end // end of [GRgene]
| GRconj (gxs) => let
    val cnfs =
      list_map_fun<grexp><grcnf> (gxs, grexp_cnfize)
    // end of [val]
  in
    grcnf_conj (cnfs)
  end // end of [GRconj]
| GRdisj (gxs) => let
    val cnfs =
      list_map_fun<grexp><grcnf> (gxs, grexp_cnfize)
    // end of [val]
  in
    grcnf_disj (cnfs)
  end // end of [GRdisj]
| GRerror () => let
    val () = assertloc (false) in list_vt_nil ()
  end // end of [GRerror]
//
end // end of [grexp_cnfize]

implement
grexplst_cnfize_list_vt
  {n} (gxs) = let
var cnfs = list_vt_nil()
//
fun loop {i:nat|i<n} 
(gxs: list(grexp, n), i: int i,
cnfs: &list_vt(INV(grcnf), i) >> list_vt(grcnf, i+1)
): void = case+ gxs of
| list_cons (gx, gxs1) => let
  val gx_cnf = grexp_cnfize(gx)
  val () = list_vt_insert_at(cnfs, i, gx_cnf)
in
  loop(gxs1, i+1, cnfs) 
end // end of [list_cons]
| list_nil () => () //shouldn't be reached
// end of [loop]
val () = loop(gxs, 0, cnfs)
in // in of let
  cnfs 
end //end of grexplst_cnfize_list_vt

(* ****** ****** *)

(* end of [falcon_cnfize.dats] *)

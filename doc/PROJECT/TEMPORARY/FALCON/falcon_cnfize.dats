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

staload "prelude/SATS/list_vt.sats"
staload _ = "prelude/DATS/list_vt.dats"
  
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
fun grcnf_free (grcnf):<!wrt> void
implement
grcnf_free (xs) =
(
case+ xs of
| ~list_vt_nil () => ()
| ~list_vt_cons (x, xs) => (genes_free (x); grcnf_free (xs))
) (* end of [grcnf_free] *)

(* ****** ****** *)

extern
fun grcnflst_free (grcnflst): void
local
//
implement
list_vt_freelin$clear<grcnf> (x) = grcnf_free(x)
in(*in-of-local*)
implement
grcnflst_free (x) = list_vt_freelin<grcnf> (x)
//
end // end of [local]

(* ****** ****** *)

extern
fun
fprint_grcnf (FILEref, !grcnf): void  
extern
fun
fprint_grcnflst (FILEref, !grcnflst): void  

(* ****** ****** *)

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
end // end of [local]
  
(* ****** ****** *)

implement
fprint_grcnflst
  (out, cnfs) =
(
case+ cnfs of
| list_vt_cons
    (cnf, cnfs) =>
  (
    fprint_grcnf (out, cnf);
    fprint_newline (out) ;
    fprint_grcnflst (out, cnfs);
  )
| list_vt_nil () => ()
) (* end of [fprint_grcnflst] *)

(* ****** ****** *)

extern
fun
grexp_cnfize (gx: grexp): grcnf

extern
fun
grexplst_cnfize (gxs: grexplst): grcnflst

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

(* ****** ****** *)
//
implement
grexplst_cnfize (gxs) =
  list_map_fun<grexp><grcnf> (gxs, grexp_cnfize)
//
(* ****** ****** *)

(* end of [falcon_cnfize.dats] *)

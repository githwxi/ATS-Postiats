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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload M = "libc/SATS/math.sats"

(* ****** ****** *)

assume grcnf_vtype = geneslst

(* ****** ****** *)

extern
fun grcnf_free (grcnf): void

(* ****** ****** *)

extern
fun grcnf_make_nil(): grcnf

(* ****** ****** *)

extern
fun grcnflst_free (grcnflst): void
//
implement
grcnflst_free (xs) =
(
case+ xs of
| ~list_vt_nil () => ()
| ~list_vt_cons (x, xs) => (grcnf_free (x); grcnflst_free (xs))
) (* end of [grcnflst_free] *)

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
//
extern
fun geneslst_cons
  (gn: genes, gns: geneslst): geneslst
//
extern
fun geneslst_append
  (gns1: geneslst, gns2: geneslst): geneslst
//
(* ****** ****** *)
//
extern
fun grcnf_conj (cnfs: grcnflst): geneslst
extern
fun grcnf_disj (cnfs: grcnflst): geneslst
//
(* ****** ****** *)

implement
grcnf_free (xs) =
(
case+ xs of
| ~list_vt_nil () => ()
| ~list_vt_cons (x, xs) => (genes_free (x); grcnf_free (xs))
) (* end of [grcnf_free] *)

implement
grcnf_make_nil() = nil_vt

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
    val res = geneslst_append (cnf, res)
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
implement
grcnf_disj (cnfs) = let
//
fun aux
(
  x: !genes, ys: !geneslst
) : geneslst =
(
case+ ys of
| list_vt_cons
    (y, ys) => let
    val x2 = genes_copy (x)
    val y2 = genes_copy (y)
    val xy = genes_union (x2, y2)
    val xys = aux (x, ys)
  in
    geneslst_cons (xy, xys)
  end // end of [val]
| list_vt_nil () => list_vt_nil ()
)
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
        geneslst_append (aux (x, ys), auxlst (xs, ys))
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

local

fun auxsup
(
  gn1: !genes, gns2: !geneslst
) : bool =
(
  case+ gns2 of
  | list_vt_nil () => false
  | list_vt_cons (gn2, gns2) =>
    (
      if gte_genes_genes (gn1, gn2)
        then true else auxsup (gn1, gns2)
      // end of [if]
    ) // end of [list_vt_cons]
) (* end of [auxsup] *)
//
fun auxsub
(
  gn1: !genes, gns2: &geneslst >> _
) : void =
(
  case+ gns2 of
  |  list_vt_nil () => ()
  | @list_vt_cons
      (gn2, gns21) => let
      val issub =
        lte_genes_genes (gn1, gn2)
      // end of [val]
    in
      if issub then let
        val () = genes_free (gn2)
        val gns21_ = gns21
        val ((*void*)) = free@{..}{0}(gns2)
        val ((*void*)) = gns2 := gns21_
      in
        auxsub (gn1, gns2)
      end else let
        val () = auxsub (gn1, gns21)
        prval ((*void*)) = fold@ (gns2)
      in
        // nothing
      end // end of [if]
    end (* end of [list_vt_cons] *)
) (* end of [auxsub] *)

in (* in-of-local (geneslst_cons)*)

implement
geneslst_cons
  (gn, gns) = let
//
val issup = auxsup (gn, gns)
//
in
//
if issup
  then (genes_free (gn); gns)
  else let
    var gns: geneslst = gns
    val () = auxsub (gn, gns)
  in
    list_vt_cons{genes}(gn, gns)
  end // end of [else]
// end of [if]
//
end // end of [geneslst_cons]

implement
geneslst_append
  (gns1, gns2) = let
//
fun auxlst
(
  gns1: &geneslst >> _, gns2: &geneslst >> _
) : void =
(
  case+ gns1 of
  |  list_vt_nil () => ()
  | @list_vt_cons
      (gn1, gns11) => let
      val issup = auxsup (gn1, gns2)
    in
      if issup then let
        val () = genes_free (gn1)
        val gns11_ = gns11
        val ((*void*)) = free@{..}{0} (gns1)
        val ((*void*)) = gns1 := gns11_
      in
        auxlst (gns1, gns2)
      end else let
        val () = auxsub (gn1, gns2)
        val () = auxlst (gns11, gns2)
        prval ((*void*)) = fold@ (gns1)
      in
        // nothing
      end // end of [if]
    end (* end of [list_vt_cons] *)
)
//
var gns1: geneslst = gns1
var gns2: geneslst = gns2
//
val () = auxlst (gns1, gns2)
//
in
  list_vt_append (gns1, gns2)
end // end of [geneslst_append]

end // end of [local]

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
| GRempty () => grcnf_make_nil ()
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

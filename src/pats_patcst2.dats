(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: February, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"
//
vtypedef charlst_vt = $UT.charlst_vt
//
macdef charset_add = $UT.charset_add
macdef charset_sing = $UT.charset_sing
macdef charset_is_member = $UT.charset_is_member
macdef charset_listize = $UT.charset_listize
//
macdef fprint_charset = $UT.fprint_charset
//
(* ****** ****** *)
//
staload INTINF = "./pats_intinf.sats"
//
vtypedef intinflst_vt = $INTINF.intinflst_vt
//
overload = with $INTINF.eq_intinf_intinf
//
macdef intinf_make_int = $INTINF.intinf_make_int
macdef intinf_make_string = $INTINF.intinf_make_string
//
macdef intinfset_add = $INTINF.intinfset_add
macdef intinfset_sing = $INTINF.intinfset_sing
macdef intinfset_is_member = $INTINF.intinfset_is_member
macdef intinfset_listize = $INTINF.intinfset_listize
//
macdef fprint_intinf = $INTINF.fprint_intinf
macdef fprint_intinfset = $INTINF.fprint_intinfset
//
(* ****** ****** *)

staload "./pats_basics.sats"
staload "./pats_lexing.sats" // for T_*

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_p2atcst"

(* ****** ****** *)

staload LAB = "./pats_label.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_stacst2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_patcst2.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
i0nt2intinf (tok) = let
//
val-T_INT(_, rep, sfx) = tok.token_node
//
in
//
if sfx > 0u
  then let
    val n = string_length (rep)
    val sfx = $UN.cast2size(sfx)
    val ln = $UN.cast{size_t}(n - sfx)
    val rep2 = 
    __make (rep, 0, ln) where
    {
      extern
      fun __make:
        (string,size_t,size_t)->Strptr1 = "atspre_string_make_substring"
      // end of [fun]
    } // end of [where] // end of [val]
    val intinf = $INTINF.intinf_make_string ($UN.castvwtp1{string}(rep2))
    val ((*freed*)) = strptr_free (rep2)
  in
    intinf
  end // end of [then]
  else $INTINF.intinf_make_string (rep)
// end of [if]
//
end // end of [i0nt2intinf]

(* ****** ****** *)

implement
p2atcst_lst
  (lin, xs) = let
//
(*
val () = println! ("p2atcst_lst: lin = ", lin)
*)
//
val isnonlin =
(
  if lin >= 0 then not(test_linkind(lin)) else true
) : bool // end of [val]
//
val s2c =
(
if isnonlin
  then s2cstref_get_cst (the_list_t0ype_int_type)
  else s2cstref_get_cst (the_list_vt0ype_int_vtype)
) : s2cst // end of [val]
//
val-Some xx = s2cst_get_islst (s2c)
val d2c_nil = xx.0 and d2c_cons = xx.1
//
fun
auxlst
(
  xs: p2atcstlst
) :<cloref1> p2atcst =
(
case+ xs of
| list_nil () =>
    P2TCcon (d2c_nil, list_nil())
| list_cons (x, xs) =>
    P2TCcon(d2c_cons, list_pair(x, auxlst(xs)))
) (* end of [auxlst] *)
//
in
  auxlst (xs)
end // end of [p2atcst_lst]

(* ****** ****** *)

implement
p2atcstlstlst_vt_free (xss) =
(
  case+ xss of
  | ~list_vt_cons (xs, xss) => let
      val () = list_vt_free (xs) in p2atcstlstlst_vt_free (xss)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
) // end of [p2atcstlstlst_vt_free]

implement
p2atcstlstlst_vt_copy (xss) =
(
  list_map_fun<p2atcstlst><p2atcstlst_vt>
    ($UN.castvwtp1{p2atcstlstlst}(xss), lam (xs) =<0> list_copy (xs))
) // end of [p2atcstlstlst_vt_copy]

(* ****** ****** *)
//
implement
fprint_p2atcst
  (out, p2tc) = let
//
macdef
prstr (s) = fprint_string (out, ,(s))  
//
in
//
case+ p2tc of
//
| P2TCany () => fprint_char (out, '_')
//
| P2TCcon
    (d2c, p2tcs) => {
    val () = fprint_d2con (out, d2c);
    val () = prstr "("
    val () = fprint_p2atcstlst (out, p2tcs)
    val () =  prstr ")"
  } // end of [P2TCcon]
//
| P2TCempty () => prstr "P2TCempty()"
//
| P2TCint (int) => {
    val () = fprint_intinf (out, int)
  }
| P2TCintc (ints) => {
    val () = prstr "[^"
    val () = fprint_intinfset (out, ints)
    val () = prstr "]"
  } // end of [P2TCintc]
//
| P2TCbool (b) => {
    val () = fprint_bool (out, b)
  }
| P2TCchar (c) => {
    val () = fprint_char (out, c)
  }
| P2TCcharc (cs) => {
    val () = prstr "[^"
    val () = fprint_charset (out, cs)
    val () = prstr "]"
  }
| P2TCfloat (rep) => {
    val () = fprint_string (out, rep)
  }
| P2TCstring (x) => {
    val () = fprintf (out, "\"%s\"", @(x))
  }
//
| P2TCrec
    (knd, lp2tcs) => {
    val () = if knd = 0 then fprint_char (out, '@')
    val () = if knd > 0 then fprint_char (out, '\'')
    val () = prstr "{"
    val () = fprint_labp2atcstlst (out, lp2tcs)
    val () = prstr "}"
  } // end of [P2TCrec]
//
end // end of [fprint_p2atcst]
//
implement
print_p2atcst (x) = fprint_p2atcst (stdout_ref, x)
implement
prerr_p2atcst (x) = fprint_p2atcst (stderr_ref, x)
//
(* ****** ****** *)

implement
fprint_p2atcstlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_p2atcst)
// end of [fprint_p2atcstlst]

(* ****** ****** *)

implement
print_p2atcstlst (xs) = fprint_p2atcstlst (stdout_ref, xs)
implement
prerr_p2atcstlst (xs) = fprint_p2atcstlst (stderr_ref, xs)

implement
print_p2atcstlst_vt (xs) =
  fprint_p2atcstlst (stdout_ref, $UN.castvwtp1{p2atcstlst}(xs))
// end of [print_p2atcstlst_vt]
implement
prerr_p2atcstlst_vt (xs) =
  fprint_p2atcstlst (stderr_ref, $UN.castvwtp1{p2atcstlst}(xs))
// end of [prerr_p2atcstlst_vt]

(* ****** ****** *)

fun fprint_labp2atcst (
  out: FILEref, lp2tc: labp2atcst
) : void = let
  val LABP2ATCST (l, p2tc) = lp2tc
in
  $LAB.fprint_label (out, l);
  fprint_string (out, "= ");
  fprint_p2atcst (out, p2tc)
end // end of [fprint_lab;2atcst]

implement
fprint_labp2atcstlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_labp2atcst)
// end of [fprint_labp2atcstlst]

implement
print_labp2atcstlst (xs) = fprint_labp2atcstlst (stdout_ref, xs)
implement
prerr_labp2atcstlst (xs) = fprint_labp2atcstlst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_p2atcstlstlst
  (out, xss) = let
  val () = $UT.fprintlst (out, xss, "\n", fprint_p2atcstlst)
in
  fprint_newline (out)
end // end of [fprint_p2atcstlst]

implement
print_p2atcstlstlst (xss) = fprint_p2atcstlstlst (stdout_ref, xss)
implement
prerr_p2atcstlstlst (xss) = fprint_p2atcstlstlst (stderr_ref, xss)

implement
print_p2atcstlstlst_vt (xss) =
  fprint_p2atcstlstlst (stdout_ref, $UN.castvwtp1{p2atcstlstlst}(xss))
// end of [print_p2atcstlstlst_vt]
implement
prerr_p2atcstlstlst_vt (xss) =
  fprint_p2atcstlstlst (stderr_ref, $UN.castvwtp1{p2atcstlstlst}(xss))
// end of [prerr_p2atcstlstlst_vt]

(* ****** ****** *)

fun
p2at2cstlst_vt (
  p2ts: p2atlst
) : p2atcstlst_vt = list_map_fun (p2ts, p2at2cst)
// end of [p2at2cstlst_vt]

implement p2at2cstlst (p2ts) = l2l (p2at2cstlst_vt (p2ts))

(* ****** ****** *)

fun labp2at2cstlst_vt
  (lp2ts: labp2atlst): labp2atcstlst_vt =
  case+ lp2ts of
  | list_cons
      (lp2t, lp2ts) => (
    case+ lp2t of
    | LABP2ATnorm
        (l0, p2t) => let
        val l = l0.l0ab_lab and p2tc = p2at2cst (p2t)
      in
        list_vt_cons (LABP2ATCST (l, p2tc), labp2at2cstlst_vt lp2ts)
      end // end of [LABP2ATnorm]
    | LABP2ATomit (loc) => labp2at2cstlst_vt (lp2ts)
    ) // end of [list_cons]
  | list_nil () => list_vt_nil ()
// end of [labp2at2cstlst_vt]

(* ****** ****** *)

implement
p2at2cst (p2t0) = let
//
in
//
case+ p2t0.p2at_node of
//
| P2Tvar _ => P2TCany ()
| P2Tany () => P2TCany ()
//
| P2Tcon
    (_, d2c, _, _, _, p2ts) =>
    P2TCcon (d2c, p2at2cstlst (p2ts))
  // end of [P2Tcon]
//
| P2Tempty () => P2TCempty ()
//
| P2Tint (i) => let
    val i = intinf_make_int (i) in P2TCint (i)
  end // end of [P2Tint]
| P2Tintrep (rep) => let
    val i = intinf_make_string (rep) in P2TCint (i)
  end // end of [P2Tint]
//
| P2Tbool (b) => P2TCbool (b)
| P2Tchar (c) => P2TCchar (c)
| P2Tfloat (rep) => P2TCfloat (rep)
| P2Tstring (str) => P2TCstring (str)
//
| P2Ti0nt (tok) => let
    val i0 = i0nt2intinf (tok) in P2TCint (i0)
  end // end of [P2Ti0nt]
| P2Tf0loat (tok) => let
    val-T_FLOAT(base, rep, sfx) = tok.token_node in P2TCfloat (rep)
  end // end of [P2Tf0loat]
//
| P2Tlst (lin, p2ts) =>
    p2atcst_lst (lin, p2at2cstlst (p2ts))
//
| P2Trec (
    recknd, npf, lp2ts
  ) => let
    var
    !p_clo =
    @lam (
      lx1: &labp2atcst
    , lx2: &labp2atcst
    ) : int =<0> let
      val LABP2ATCST (l1, _) = lx1
      and LABP2ATCST (l2, _) = lx2
    in
      $LAB.compare_label_label (l1, l2)
    end // end of [var]
    val lp2tcs = labp2at2cstlst_vt (lp2ts)
    val lp2tcs = list_vt_mergesort (lp2tcs, !p_clo)
  in
    P2TCrec (recknd, (l2l)lp2tcs)
  end // end of [P2Trec]
//
| P2Trefas (_(*d2v*), p2t) => p2at2cst (p2t)
//
| P2Texist (_(*s2vs*), p2t) => p2at2cst (p2t)
//
| P2Tvbox _ => P2TCany () // HX: only [vbox(d2v)] is allowed
//
| P2Tann (p2t, _) => p2at2cst (p2t)
//
| _ (* P2T-rest *) => let
    val () = prerr_interror_loc (p2t0.p2at_loc)
    val () = prerrln! (": p2at2cst: p2t0 = ", p2t0)
  in
    let val ((*exit*)) = assertloc(false) in P2TCany() end
  end // end of [P2T-rest]
//
end (* end of [p2at2cst] *)

(* ****** ****** *)

fun
p2atcst_comp_con
(
  d2c0: d2con
, d2cs: d2conlst, arg: p2atcstlst
) : p2atcstlst_vt = let
//
fun auxanys (
  n: int, res: p2atcstlst_vt
) : p2atcstlst_vt =
  if n > 0 then
    auxanys (n-1, list_vt_cons (P2TCany, res)) else res
  (* end of [if] *)
//
fun auxmain (
  d2c0, d2cs: d2conlst, arg: p2atcstlst
) : p2atcstlst_vt =
  case+ d2cs of
  | list_cons
      (d2c, d2cs) => (
      if d2c0 = d2c then let
        val carglst = p2atcstlst_comp (arg)
        val carglst = __cast (carglst) where {
          extern castfn __cast (xss: p2atcstlstlst_vt): List_vt (p2atcstlst)
        } // end of [val] // HX: this is a safe cast
        val res1 = list_map_cloptr (
          $UN.castvwtp1{p2atcstlstlst}(carglst), lam x =<0> P2TCcon (d2c, x)
        ) // end of [val]
        val () = list_vt_free (carglst)
        val res2 = auxmain (d2c0, d2cs, arg)
      in
        list_vt_append (res1, res2)
      end else let
        val anys =
          auxanys (d2con_get_arity_full d2c, list_vt_nil ())
        // end of [val]
        val p2tc = P2TCcon (d2c, (l2l)anys)
        val res = auxmain (d2c0, d2cs, arg)
      in
        list_vt_cons (p2tc, res)
      end // end of [if]
    ) // end of [list_cons]
  | list_nil () => list_vt_nil ()
// end of [auxmain]
in
  auxmain (d2c0, d2cs, arg)
end // end of [p2atcst_comp_con]

(* ****** ****** *)

implement
p2atcst_comp
  (p2tc0) = let
in
//
case+ p2tc0 of
| P2TCany () => list_vt_nil ()
//
| P2TCcon (d2c0, p2tcs) => let
    val tag = d2con_get_tag (d2c0)
  in
    if tag >= 0 then let
      val s2c0 = d2con_get_scst (d2c0)
      val-Some (d2cs) = s2cst_get_dconlst (s2c0)
    in
      p2atcst_comp_con (d2c0, d2cs, p2tcs)
    end else // HX: [d2c0] associated with an extensible sum
      list_vt_sing (P2TCany ())
    // end of [if]
  end // end of [P2TCcon]
//
| P2TCempty () => list_vt_nil ()
//
| P2TCint (x) => let
    val xs = intinfset_sing (x) in list_vt_sing (P2TCintc (xs))
  end // end of [P2TCint]
| P2TCintc (xs) => let
    fun aux
    (
      xs: intinflst_vt
    ) : p2atcstlst_vt =
    (
      case+ xs of
      | ~list_vt_nil () => list_vt_nil ()
      | ~list_vt_cons (x, xs) => list_vt_cons (P2TCint (x), aux (xs))
    ) (* end of [aux] *)
  in
    aux (intinfset_listize (xs))
  end // end of [P2TCintc]
//
| P2TCbool (b) => list_vt_sing (P2TCbool (~b))
//
| P2TCchar (c) => let
    val cs = charset_sing (c) in list_vt_sing (P2TCcharc (cs))
  end // end of [P2TCchar]
| P2TCcharc (cs) => let
    fun aux
    (
      cs: charlst_vt
    ) : p2atcstlst_vt =
    (
      case+ cs of
      | ~list_vt_nil () => list_vt_nil ()
      | ~list_vt_cons (x, cs) => list_vt_cons (P2TCchar (x), aux (cs))
    ) (* end of [aux] *)
  in
    aux (charset_listize (cs))
  end // end of [P2TCcharc]
//
(*
| P2TCchar _ => list_vt_sing (P2TCany ()) // conservative estimate
*)
//
| P2TCfloat _ => list_vt_sing (P2TCany ()) // conservative estimate
| P2TCstring _ => list_vt_sing (P2TCany ()) // conservative estimate
//
| P2TCrec
    (knd, arg) => res where
  {
    val carglst =
      labp2atcstlst_comp (arg)
    val carglst = __cast (carglst) where
    {
      extern
      castfn __cast (xss: labp2atcstlstlst_vt): List_vt (labp2atcstlst)
    } // end of [val] // HX: this is a safe cast
    val res =
    list_map_cloptr (
      $UN.castvwtp1{labp2atcstlstlst}(carglst), lam x =<0> P2TCrec (knd, x)
    ) (* end of [val] *)
    val () = list_vt_free (carglst)
  } (* end of [P2TCrec] *)
//
(*
| _ (*exhausted*) =>
    let val () = assertloc (false) in exit (1) end
  // end of [_]
*)
end // end of [p2atcst_comp]

(* ****** ****** *)

implement
p2atcstlst_comp
  (p2tcs0) = let
//
fun auxanys (
  xs: p2atcstlst, res: p2atcstlst_vt
) : p2atcstlst_vt =
  case+ xs of
  | list_cons (x, xs) =>
      auxanys (xs, list_vt_cons (P2TCany, res))
  | list_nil () => res
// end of [auxanys]
in
//
case+ p2tcs0 of
//
| list_nil () => list_vt_nil ()
//
| list_cons (p2tc1, p2tcs1) => let
//
    val res1 = let
      fun aux (
        xss: p2atcstlstlst_vt
      ) :<cloref1> p2atcstlstlst_vt =
      (
        case+ xss of
        | ~list_vt_cons
            (xs, xss) => let
            val ys =
              list_vt_cons (p2tc1, xs)
            // end of [val]
          in
            list_vt_cons (ys, aux (xss))
          end // end of [list_vt_cons]
        | ~list_vt_nil () => list_vt_nil ()
      ) (* end of [aux] *)
    in
      aux (p2atcstlst_comp (p2tcs1))
    end // end of [val]
//
    val res2 = let
      fun aux (
        xs: p2atcstlst_vt
      ) :<cloref1> p2atcstlstlst_vt =
        case+ xs of
        | ~list_vt_cons
            (x, xs) => let
            val ys =
              list_vt_cons (x, auxanys (p2tcs1, list_vt_nil))
            // end of [val]
          in
            list_vt_cons (ys, aux (xs))
          end // end of [list_vt_cons]
        | ~list_vt_nil () => list_vt_nil ()
      // end of [aux]
    in
      aux (p2atcst_comp (p2tc1))
    end // end of [val]
//
  in
    list_vt_append (res1, res2)
  end // end of [list_cons]
//
end // end of [p2atcstlst_comp]

(* ****** ****** *)

fun
labp2atcst_comp
(
  lp2tc: labp2atcst
) : labp2atcstlst_vt = let
  val LABP2ATCST (l, p2tc) = lp2tc
  val cp2tcs = p2atcst_comp (p2tc)
  val res = list_map_cloptr
    ($UN.castvwtp1{p2atcstlst}(cp2tcs), lam x =<0> LABP2ATCST (l, x))
  val () = list_vt_free (cp2tcs)
in
  res
end // end of [labp2atcst_comp]

(* ****** ****** *)

implement
labp2atcstlst_comp 
  (lp2tcs0) = let
in
//
case+ lp2tcs0 of
//
| list_nil () => list_vt_nil ()
//
| list_cons (lp2tc1, lp2tcs1) => let
    val res1 = let
      fun aux (
        xss: labp2atcstlstlst_vt
      ) :<cloref1> labp2atcstlstlst_vt =
        case+ xss of
        | ~list_vt_cons (xs, xss) => let
            val ys = list_vt_cons (lp2tc1, xs) in list_vt_cons (ys, aux xss)
          end // end of [list_vt_cons]
        | ~list_vt_nil () => list_vt_nil ()
      // end of [aux]
    in
      aux (labp2atcstlst_comp (lp2tcs1))
    end // end of [val]
    val res2 = let
      fun aux (
        xs: labp2atcstlst_vt
      ) :<cloref1> labp2atcstlstlst_vt =
        case+ xs of
        | ~list_vt_cons (x, xs) => let
            val ys = list_vt_sing (x) in list_vt_cons (ys, aux (xs))
          end // end of [list_vt_cons]
        | ~list_vt_nil () => list_vt_nil ()
      // end of [aux]
    in
      aux (labp2atcst_comp (lp2tc1))
    end // end of [val]
  in
    list_vt_append (res1, res2)
  end // end of [list_cons]
//
end // end of [labp2atcst_comp]

(* ****** ****** *)

implement
c2lau_pat_any
  (c2l) = let
//
val p2ts = c2l.c2lau_pat
//
in
  list_vt_sing(list_map_fun(p2ts, lam(_) =<fun1> P2TCany()))
end // end of [c2lau_pat_any]

(* ****** ****** *)

implement
c2lau_pat_comp
  (c2l) = let
//
val p2ts = c2l.c2lau_pat
(*
val () = fprintln! (
  stdout_ref, "c2lau_pat_comp: c2l.c2lau_pat = ", p2ts
) (* end of [val] *)
*)
//
in
//
case+ c2l.c2lau_gua of
| list_cons _ => let
(*
//
// HX: conservative estimate: [c2l] cannot be chosen
//
*)
    val anys = list_map_fun (p2ts, lam _ =<0> P2TCany ())
  in
    list_vt_sing (anys)
  end // end of [list_cons]
| list_nil () => let
    val p2tcs = list_map_fun (p2ts, p2at2cst)
    val cp2tcss = p2atcstlst_comp ($UN.castvwtp1{p2atcstlst}(p2tcs))
    val () = list_vt_free (p2tcs)
  in
    cp2tcss
  end // end of [list_nil]
end // end of [c2lau_pat_complement]

(* ****** ****** *)

implement
p2atcst_inter_test
  (p2tc1, p2tc2) = let
in
//
case+ (
  p2tc1, p2tc2
) of
| (P2TCany (), _) => true
| (_, P2TCany ()) => true
| (P2TCcon (d2c1, p2tcs1),
   P2TCcon (d2c2, p2tcs2)) => (
    if d2c1 = d2c2 then
      p2atcstlst_inter_test (p2tcs1, p2tcs2) else false
    // end of [if]
  ) // end of [P2TCcon, P2TCcon]
| (P2TCempty (), P2TCempty ()) => true
//
| (P2TCint i1, P2TCint i2) => (i1 = i2)
| (P2TCint x, P2TCintc xs) =>
    if intinfset_is_member (xs, x) then false else true
| (P2TCintc xs, P2TCint x) =>
    if intinfset_is_member (xs, x) then false else true
//
| (P2TCbool b1, P2TCbool b2) => (b1 = b2)
//
| (P2TCchar c1, P2TCchar c2) => (c1 = c2)
| (P2TCchar x, P2TCcharc xs) =>
    if charset_is_member (xs, x) then false else true
| (P2TCcharc xs, P2TCchar x) =>
    if charset_is_member (xs, x) then false else true
//
| (P2TCrec (_, lp2atcs1),
   P2TCrec (_, lp2atcs2)) =>
    labp2atcstlst_inter_test (lp2atcs1, lp2atcs2)
  // end of [P2TCrec, P2TCrec]
| (_, _) => true (* HX: being conservative *)
//
end (* end of [p2atcst_inter_test] *)

implement
p2atcstlst_inter_test
  (xs1, xs2) = let
in
//
case+ xs1 of
| list_cons (x1, xs1) => (
  case+ xs2 of
  | list_cons (x2, xs2) =>
      if p2atcst_inter_test (x1, x2)
        then p2atcstlst_inter_test (xs1, xs2) else false
      // end of [if]
  | list_nil () => false
  ) // end of [list_cons]
| list_nil () => (
  case+ xs2 of list_cons _ => false | list_nil () => true
  ) // end of [list_nil]
//
end // end of [p2atcstlst_inter_test]

implement
labp2atcstlst_inter_test
  (lxs10, lxs20) = let
in
//
case+ lxs10 of
| list_cons (lx1, lxs1) => (
  case+ lxs20 of
  | list_cons (lx2, lxs2) => let
      val LABP2ATCST (l1, x1) = lx1
      val LABP2ATCST (l2, x2) = lx2
      val sgn = $LAB.compare_label_label (l1, l2)
    in
      if sgn < 0 then
        labp2atcstlst_inter_test (lxs1, lxs20)
      else if sgn > 0 then
        labp2atcstlst_inter_test (lxs10, lxs2)
      else (
        if p2atcst_inter_test (x1, x2) then 
          labp2atcstlst_inter_test (lxs1, lxs2) else false
        // end of [if]
      ) // end of [if]
    end // end of [list_cons]
  | list_nil () => true
  ) // end of [list_cons]
| list_nil () => true
//
end // end of [labp2atcstlst_inter_test]

(* ****** ****** *)

implement
p2atcst_diff
  (p2tc1, p2tc2) = let
in
//
case+ (p2tc1, p2tc2) of
| (_, P2TCany ()) => list_vt_nil ()
| (P2TCany (), _) => p2atcst_comp (p2tc2)
//
| (P2TCint i1, P2TCint i2) =>
    if i1 = i2 then list_vt_nil else list_vt_sing (p2tc1)
  // end of [P2TCint, P2TCint]
| (P2TCintc xs, P2TCint x) => (
    if intinfset_is_member (xs, x)
      then list_vt_sing (p2tc1) else let
      val xs = intinfset_add (xs, x) in list_vt_sing (P2TCintc (xs))
    end // end of [if]
  ) // end of [P2TCintc, P2TCint]
| (P2TCint x, P2TCintc xs) =>
    if intinfset_is_member (xs, x) then list_vt_sing (p2tc1) else list_vt_nil
//
| (P2TCbool b1, P2TCbool b2) =>
    if b1 = b2 then list_vt_nil else list_vt_sing (p2tc1)
  // end of [P2TCbool, P2TCbool]
//
| (P2TCchar c1, P2TCchar c2) => begin
    if c1 = c2 then list_vt_nil else list_vt_sing (p2tc1)
    end // end of [P2TCchar, P2TCchar]
| (P2TCcharc xs, P2TCchar x) => (
    if charset_is_member (xs, x)
      then list_vt_sing (p2tc1) else let
      val xs = charset_add (xs, x) in list_vt_sing (P2TCcharc (xs))
    end // end of [if]
  ) // end of [P2TCcharc, P2TCchar]
| (P2TCchar x, P2TCcharc xs) =>
    if charset_is_member (xs, x) then list_vt_sing (p2tc1) else list_vt_nil
//
| (P2TCstring s1, P2TCstring s2) =>
    if s1 = s2 then list_vt_nil else list_vt_sing (p2tc1)
  // end of [P2TCstring, P2TCstring]
//
| (P2TCcon (d2c1, p2tcs1),
   P2TCcon (d2c2, p2tcs2)) => (
    if d2c1 = d2c2 then let
      val p2tcss = p2atcstlst_diff (p2tcs1, p2tcs2)
      val p2tcss = __cast (p2tcss) where {
        extern castfn __cast (xs: p2atcstlstlst_vt): List_vt (p2atcstlst)
      } // end of [val] // HX: this is a safe cast
      val res = list_map_cloptr
        ($UN.castvwtp1{p2atcstlstlst}(p2tcss), lam xs =<0> P2TCcon (d2c1, xs))
      val () = list_vt_free (p2tcss)
    in
      res
    end else
      list_vt_sing (p2tc1)
    // end of [if]
  ) // end of [P2TCcon, P2TCcon]
| (P2TCempty (), P2TCempty ()) => list_vt_nil ()
| (_, _) => list_vt_sing (p2tc1)
//
end // end of [p2atcst_diff]

(* ****** ****** *)

implement
p2atcstlst_diff
  (xs1, xs2) = let
in
//
case+ xs1 of
| list_cons (x1, xs1) => (
  case+ xs2 of
  | list_cons (x2, xs2) => let
      fun aux1 (
        x1: p2atcst, xss: p2atcstlstlst_vt
      ) : p2atcstlstlst_vt =
        case+ xss of
        | ~list_vt_cons (xs, xss) =>
            list_vt_cons (list_vt_cons (x1, xs), aux1 (x1, xss))
          // end of [list_vt_cons]
        | ~list_vt_nil () => list_vt_nil ()
      // end of [aux1]
      val p2tcss_res1 = let
        val xss = p2atcstlst_diff (xs1, xs2)
      in
        aux1 (x1, xss)
      end // end of [val]
      fun aux2 (
        xs: p2atcstlst_vt, xs1: p2atcstlst
      ) : p2atcstlstlst_vt =
        case+ xs of
        | ~list_vt_cons (x, xs) => let
            val xs1_ = list_copy (xs1) in
            list_vt_cons (list_vt_cons (x, xs1_), aux2 (xs, xs1))
          end // end of [list_vt_cons]
        | ~list_vt_nil () => list_vt_nil ()
      // end of [aux2]
      val p2tcss_res2 = aux2 (p2atcst_diff (x1, x2), xs1)
    in
      list_vt_append (p2tcss_res1, p2tcss_res2)
    end // end of [list_cons]
  | list_nil () => list_vt_nil ()
  ) // end of [list_cons]
| list_nil () => p2atcstlst_comp (xs2)
//
end (* end of [p2atcstlst_diff] *)

(* ****** ****** *)

(* end of [pats_patcst2.dats] *)

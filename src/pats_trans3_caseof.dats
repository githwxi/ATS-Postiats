(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_patcon"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_error.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_patcst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn
m2atch_trup (
  m2at: m2atch
) : m3atch = let
  val loc0 = m2at.m2atch_loc
  val d2e = m2at.m2atch_exp
  val d3e = d2exp_trup (d2e)
  val s2e = d3exp_get_type (d3e)
  val op2t = m2at.m2atch_pat 
  val op3t = (
    case+ op2t of
    | Some p2t => let
        val p3t = p2at_trdn (p2t, s2e)
      in
        Some (p3t)
      end // end of [Some]
    | None () => let
        val () = guard_trdn (loc0, true(*gval*), s2e)
      in
        None ()
      end // end of [None]
  ) : p3atopt // end of [val]
in
  m3atch_make (loc0, d3e, op3t)
end // end of [m2atch_tr_up]

fn
m2atchlst_trup (
  m2ats: m2atchlst
) : m3atchlst = let
  val m3ats = list_map_fun (m2ats, m2atch_trup)
in
  (l2l)m3ats
end // end of [m2atchlst_trup]

(* ****** ****** *)

extern
fun c2lau_trdn
  {n:nat} (
  casknd: caskind
, c2l: c2lau
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
, cp2tss: p2atcstlstlst_vt
) : c3lau (n) // end of [c2lau_trdn]
extern
fun c2laulst_trdn
  {n:nat} (
  loc0: location
, casknd: caskind
, c2ls: c2laulst
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
) : c3laulst n // end of [c2laulst_trdn]

(* ****** ****** *)

implement
c2lau_trdn (
  casknd, c2l, s2es_pat, s2e_res, cp2tcss
) = let
//
val loc0 = c2l.c2lau_loc
val p2ts = c2l.c2lau_pat
// (*
val () = begin
  print "c2lau_trdn: p2ts = "; print_p2atlst (p2ts); print_newline ();
  print "c2lau_trdn: s2es_pat = "; print_s2explst (s2es_pat); print_newline ();
  print "c2lau_trdn: s2e_res = "; print_s2exp (s2e_res); print_newline ();
end // end of [val]
// *)
val (pfpush | ()) = trans3_env_push ()
//
val seq = c2l.c2lau_seq
and neg = c2l.c2lau_neg
//
val () = if seq > 0 then let
  val cp2tcss = p2atcstlstlst_vt_copy (cp2tcss) in
  trans3_env_hypadd_patcstlstlst (loc0, cp2tcss, s2es_pat)
end // end of [val]
var serr: int = 0
val p3ts = p2atlst_trdn (loc0, p2ts, s2es_pat, serr)
val () = if (serr != 0) then {
  val () = the_trans3errlst_add (T3E_c2lau_trdn_arity (c2l, s2es_pat))
} // end of [val]
//
val gua = m2atchlst_trup (c2l.c2lau_gua)
//
val d3e_body = let
  val s2e_res = (
    if neg > 0 then s2exp_bottom_viewt0ype_exi () else s2e_res
  ) : s2exp // end of [val]
//
val () = p2atcstlstlst_vt_free (cp2tcss)
//
in
  d2exp_trdn (c2l.c2lau_body, s2e_res)
end // end of [val]
//
val () = trans3_env_pop_and_add_main (pfpush | loc0)
//
in
  c3lau_make (loc0, p3ts, gua, seq, neg, d3e_body)
end // end of [c2lau_trdn]

(* ****** ****** *)

fun
c2laulst0_trdn (
  loc0: location
, casknd: caskind
, s2es_pat: s2explst
, s2e_res: s2exp
) : void = let
in
//
case+ casknd of
| CK_case () => let
    val () = prerr_warning3_loc (loc0)
    val () = prerr ": a case-expression is expected to have at least one match clause."
    val () = prerr_newline ()
  in
    // nothing
  end // end of [CK_case]
| CK_case_pos () => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": a case+-expression is required to have at least one match clause."
    val () = prerr_newline ()
  in
    the_trans3errlst_add (T3E_c2laulst0_trdn_noclause (loc0))
  end // end of [CK_case_pos]
| CK_case_neg () => ()
//
end // end of [c2laulst0_trdn]

(* ****** ****** *)

extern
fun c2laulst2_trdn
  {n:nat} (
  loc0: location
, casknd: caskind
, c2l_fst: c2lau
, c2ls_rest: c2laulst
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
) : c3laulst n

and c2laulst2_trdn_rest
  {n:nat} (
  loc0: location
, casknd: caskind
, c3l_fst: c3lau n
, c2ls_rest: c2laulst
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
, cp2tcss: &p2atcstlstlst_vt
) : c3laulst n

(* ****** ****** *)

implement
c2laulst2_trdn {n} (
  loc0, casknd, c2l_fst, c2ls_rest, s2es_pat, s2e_res
) : c3laulst n = let
(*
val () = begin
  print "c2laulst2_trdn: s2es_pat = "; print s2es_pat; print_newline ();
end // end of [val]
*)
//
val cp2tcss = (
  case+ casknd of
  | CK_case () => c2lau_pat_comp (c2l_fst)
  | CK_case_pos () => c2lau_pat_comp (c2l_fst)
  | CK_case_neg () => list_vt_nil ()
) : p2atcstlstlst_vt // end of [val]
var cp2tcss : p2atcstlstlst_vt = cp2tcss
//
val c3l_fst = let
  val cp2tcss1 = p2atcstlstlst_vt_copy (cp2tcss)
in
  c2lau_trdn (casknd, c2l_fst, s2es_pat, s2e_res, cp2tcss1)
end // end of [val]
val c3ls_rest = c2laulst2_trdn_rest
  (loc0, casknd, c3l_fst, c2ls_rest, s2es_pat, s2e_res, cp2tcss)
val isexhaust = ( // HX: always true for [case-]
  if list_vt_is_nil (cp2tcss) then true else false
) : bool // end of [val]
val () = if ~isexhaust then let
  val cp2tcss = p2atcstlstlst_vt_copy (cp2tcss) in
  trans3_env_add_patcstlstlst_false (loc0, casknd, cp2tcss, s2es_pat)
end // end of [val]
val () = p2atcstlstlst_vt_free (cp2tcss)
//
in
  c3ls_rest
end (* end of [c2laulst2_trdn] *)

(* ****** ****** *)

implement
c2laulst2_trdn_rest
  {n} (
  loc0, casknd
, c3l_fst, c2ls_rest, s2es_pat, s2e_res
, cp2tcss // : &patcstlstlst_vt
) = let
//
fun auxred (
  casknd: caskind, c2l: c2lau, cp2tcss_inter: !p2atcstlstlst_vt
) :<cloref1> void = let
//
fun auxerr (
  xss: !p2atcstlstlst_vt
) :<cloref1> void = let
  val isnil = list_vt_is_nil (xss)
  val () = if isnil then {
    val () = prerr_error3_loc (c2l.c2lau_loc)
    val () = prerr ": this pattern match clause is redundant."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_c2laulst2_trdn_redundant (loc0, c2l))
  } // end of [val]
in
  // nothing
end // end of [auxerr]
//
in
//
case+ casknd of
| CK_case () => auxerr (cp2tcss_inter)
| CK_case_pos () => auxerr (cp2tcss_inter)
| CK_case_neg () => ()
//
end // end of [auxred]
//
fun auxmain (
  c2ls: c2laulst
, c3ls: c3laulst_vt (n)
, cp2tcss: &p2atcstlstlst_vt
) :<cloref1> c3laulst n = let
in
case+ c2ls of
| list_cons
    (c2l, c2ls) => let
    val p2tcs_c2l = p2at2cstlst (c2l.c2lau_pat)
(*
    val () = begin
      print "c2laulst2_trdn_rest: p2tcs = "; print p2tcs; print_newline ();
      print "c2laulst2_trdn_rest: cp2tcss =\n"; print cp2tcss; print_newline ();
    end (* end of [val] *)
*)
    val cp2tcss_inter = let
      fun aux (
        xss: !p2atcstlstlst_vt
      ) :<cloref1> p2atcstlstlst_vt =
        case+ xss of
        | list_vt_cons
            (!p1_xs, !p2_xss) => let
            val res = aux (!p2_xss)
            val test = p2atcstlst_inter_test
              ($UN.castvwtp1 {p2atcstlst}{p2atcstlst_vt} (!p1_xs), p2tcs_c2l)
            // end of [val]
          in
            if test then let
              val xs = list_vt_copy (!p1_xs)
              prval () = fold@ (xss)
            in
              list_vt_cons (xs, res)
            end else let
              prval () = fold@ (xss) in res
            end // end of [if]
          end // end of [list_vt_cons]
        | list_vt_nil () => (fold@ (xss); list_vt_nil)
      // end of [aux]
    in
      aux (cp2tcss)
    end // end of [val]
    val () = auxred (casknd, c2l, cp2tcss_inter) // HX: redundancy checking
// (*
    val () = begin
      print "c2laulst2_trdn_rest: auxmain";
      print ": cp2tcss_inter =\n"; print_p2atcstlstlst_vt (cp2tcss_inter); print_newline ()
    end // end of [val]
// *)
    val c3l = c2lau_trdn
      (casknd, c2l, s2es_pat, s2e_res, cp2tcss_inter)
    // end of [val]
    val () = let
      val gua = c2l.c2lau_gua
    in
      case+ gua of
      | list_nil () => let
          fun aux (
            xss: p2atcstlstlst_vt
          ) :<cloref1> p2atcstlstlst_vt =
            case+ xss of
            | ~list_vt_cons (xs, xss) => let
                val diff = p2atcstlst_diff
                  ($UN.castvwtp1 {p2atcstlst} (xs), p2tcs_c2l)
                val () = list_vt_free (xs)
              in
                list_vt_append (diff, aux (xss))
              end // end of [list_vt_cons]
            | ~list_vt_nil () => list_vt_nil ()
          // end of [aux]
        in
          cp2tcss := aux (cp2tcss)
        end // end of [list_cons]
      | list_cons _ => ()
    end // end of [val]
// (*
    val () = begin
      print "c2laulst2_trdn_rest: auxmain";
      print ": cp2tcss(aft) =\n"; print_p2atcstlstlst_vt (cp2tcss); print_newline ()
    end // end of [val]
// *)
  in
    auxmain (c2ls, list_vt_cons (c3l, c3ls), cp2tcss)
  end // end of [list_cons]
| list_nil () => let
    val c3ls = list_vt_reverse (c3ls) in (l2l)c3ls
  end // end of [list_nil]
end (* end of [aux_main] *)
val c3ls_rest  = auxmain (c2ls_rest, list_vt_nil (), cp2tcss)
// (*
val () = (
  print "c2laulst2_trdn_rest: cp2tcss =\n"; print_p2atcstlstlst_vt (cp2tcss); print_newline ()
) // end of [val]
// *)
in
  list_cons (c3l_fst, c3ls_rest)
end // end of [c2laulst2_trdn_rest]

(* ****** ****** *)

implement
c2laulst_trdn {n} (
  loc0, casknd, c2ls, s2es_pat, s2e_res
) = let
in
//
case+ c2ls of
| list_nil () => let
    val () = c2laulst0_trdn (loc0, casknd, s2es_pat, s2e_res)
  in
    list_nil ()
  end // end of [list_nil]
| list_cons (c2l, c2ls) =>
    c2laulst2_trdn (loc0, casknd, c2l, c2ls, s2es_pat, s2e_res)
  // end of [list_cons]
//
end // end of [c2laulst_trdn]

(* ****** ****** *)

implement
d2exp_trdn_casehead
  (d2e0, s2f0) = let
(*
val () = begin
  print "d2exp_caseof_trdn: s2f0 = ";
  print_s2hnf (s2f0); print_newline ()
end // end of [val]
*)
val loc0 = d2e0.d2exp_loc
val- D2Ecasehead (casknd, i2nvres, d2es, c2ls) = d2e0.d2exp_node
val s2e0 = s2hnf2exp (s2f0)
//
val d3es = d2explst_trup (d2es)
val () = d3explst_open_and_add (d3es)
val s2es_pat = list_map_fun (d3es, d3exp_get_type)
val c3ls = let
  val s2es1_pat =
    $UN.castvwtp1 {s2explst} (s2es_pat)
  // end of [val]
in
  c2laulst_trdn (loc0, casknd, c2ls, s2es1_pat, s2e0)
end // end of [val]
val () = list_vt_free (s2es_pat)
//
in
  d3exp_case (loc0, s2e0, casknd, d3es, c3ls)
end (* end of [d2exp_caseof_trdn] *)

(* ****** ****** *)

(* end of [pats_trans3_caseof.dats] *)

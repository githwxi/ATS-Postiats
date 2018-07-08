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
// Start Time: March, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<> () = prerr "pats_trans3_caseof"
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_staexp2_error.sats"

(* ****** ****** *)

staload "./pats_stacst2.sats"
staload "./pats_patcst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "./pats_staexp2_solve.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn
gm2at_trup
(
  gm2t: gm2at
) : gm3at = let
  val loc0 = gm2t.gm2at_loc
  val d2e = gm2t.gm2at_exp
  val d3e = d2exp_trup (d2e)
  val s2e = d3exp_get_type (d3e)
  val op2t = gm2t.gm2at_pat 
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
  gm3at_make (loc0, d3e, op3t)
end // end of [gm2at_tr_up]

fn
gm2atlst_trup (
  gm2ts: gm2atlst
) : gm3atlst = let
  val m3ats = list_map_fun (gm2ts, gm2at_trup)
in
  (l2l)m3ats
end // end of [gm2atlst_trup]

(* ****** ****** *)

extern
fun
c2lau_trdn
  {n:nat} (
  casknd: caskind
, c2l: c2lau
, ctr: c3nstroptref
, d3es: list (d3exp, n)
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
, cp2tss: p2atcstlstlst_vt
) : c3lau (n) // end of [c2lau_trdn]

(* ****** ****** *)

implement
c2lau_trdn (
  casknd, c2l, ctr, d3es, s2es_pat, s2e_res, cp2tcss
) = let
//
val loc0 = c2l.c2lau_loc
val p2ts = c2l.c2lau_pat
//
(*
val () = begin
  print "c2lau_trdn: p2ts = "; print_p2atlst (p2ts); print_newline ();
  print "c2lau_trdn: s2es_pat = "; print_s2explst (s2es_pat); print_newline ();
  print "c2lau_trdn: s2e_res = "; print_s2exp (s2e_res); print_newline ();
end // end of [val]
*)
//
val (pfpush | ()) = trans3_env_push ()
//
val seq = c2l.c2lau_seq
and neg = c2l.c2lau_neg
//
val () =
if seq > 0 then let
  val cp2tcss = p2atcstlstlst_vt_copy (cp2tcss)
in
  trans3_env_hypadd_patcstlstlst (loc0, cp2tcss, s2es_pat)
end // end of [val]
var serr: int = 0
val p3ts = p2atlst_trdn (loc0, p2ts, s2es_pat, serr)
val () =
if (serr != 0) then
{
  val () = the_trans3errlst_add (T3E_c2lau_trdn_arity (c2l, s2es_pat))
} (* end of [val] *)
//
(*
val () = (
  print "c2lau_trdn: p3ts = "; fprint_p3atlst (stdout_ref, p3ts); print_newline ()
) (* end of [val] *)
*)
//
val (pfd2v | ()) = the_d2varenv_push_let ()
val () = the_d2varenv_add_p3atlst (p3ts)
val (pfman | ()) = the_pfmanenv_push_let ()
val () = the_pfmanenv_add_p3atlst (p3ts)
//
val gua = gm2atlst_trup (c2l.c2lau_gua)
//
// HX-2012-05:
// if p3t is a PCKlincon, it is assumed read-only!
//
val () = d3lvalist_set_pat_type_left (d3es, p3ts)
val s2e_res = (
  if neg > 0 then s2exp_bottom_t0ype_exi () else s2e_res
) : s2exp // end of [val]
val d3e_body = d2exp_trdn (c2l.c2lau_body, s2e_res)
//
val () = the_d2varenv_check (loc0)
//
val () = p2atcstlstlst_vt_free (cp2tcss)
//
val () = the_d2varenv_pop (pfd2v | (*none*))
val () = the_pfmanenv_pop (pfman | (*none*))
//
val () = trans3_env_add_cnstr_ref (ctr)
val () = trans3_env_pop_and_add_main (pfpush | loc0)
//
in
  c3lau_make (loc0, p3ts, gua, seq, neg, d3e_body)
end // end of [c2lau_trdn]

(* ****** ****** *)

fun
c2laulst0_trdn
(
  loc0: loc_t
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
    val _(*err*) = the_effenv_check_exn (loc0) // HX: handling potential match failure
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

fun
c2laulst1_trdn
  {n:nat}
(
  loc0: loc_t
, casknd: caskind
, invres: i2nvresstate
, c2l: c2lau
, d3es: list (d3exp, n)
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
) : c3lau (n) = let
(*
val () =
println!
(
  "c2laulst1_trdn: s2es_pat = ", s2es_pat
) (* end of [val] *)
*)
//
val cp2tcss =
(
  case+ casknd of
  | CK_case () => c2lau_pat_comp (c2l)
  | CK_case_pos () => c2lau_pat_comp (c2l)
  | CK_case_neg () => list_vt_nil ()
) : p2atcstlstlst_vt // end of [val]
var cp2tcss : p2atcstlstlst_vt = cp2tcss
//
val lsbis =
  the_d2varenv_save_lstbefitmlst ()
var lsaft = lstaftc3nstr_initize (lsbis)
//
val ctr =
  c3nstroptref_make_none (c2l.c2lau_loc)
val c3l = let
  val cp2tcss1 = c2lau_pat_any (c2l) in
  c2lau_trdn (casknd, c2l, ctr, d3es, s2es_pat, s2e_res, cp2tcss1)
end // end of [val]
val () = lstaftc3nstr_update (lsaft, ctr)
//
val
isexhaust = (
//
// HX: true for [case-]
//
  if list_vt_is_nil (cp2tcss) then true else false
) : bool // end of [val]
val () =
if ~isexhaust then let
  val cp2tcss = p2atcstlstlst_vt_copy (cp2tcss) in
  trans3_env_add_patcstlstlst_false (loc0, casknd, cp2tcss, s2es_pat)
end // end of [if] // end of [val]
//
val () = p2atcstlstlst_vt_free (cp2tcss)
//
val () = lstaftc3nstr_process (lsaft, invres)
val () = lstaftc3nstr_finalize (lsaft) // HX: it must be processed
//
val () = if ~isexhaust then {
  val _(*err*) = the_effenv_caskind_check_exn (loc0, casknd)
} // end of [if] // end of [val]
//
in
  c3l (* single-clause expression *)
end // end of [c2laulst1_trdn]

(* ****** ****** *)
//
extern
fun
c2laulst2_trdn
  {n:nat} (
  loc0: loc_t
, casknd: caskind
, invres: i2nvresstate
, c2l_fst: c2lau
, c2ls_rest: c2laulst
, d3es: list (d3exp, n)
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
) : c3laulst (n)
//
and
c2laulst2_trdn_rest
  {n:nat} (
  loc0: loc_t
, casknd: caskind
, invres: i2nvresstate
, c3l_fst: c3lau n
, lsbis: lstbefitmlst
, lsaft: !lstaftc3nstr
, c2ls_rest: c2laulst
, d3es: list (d3exp, n)
, s2es_pat: list (s2exp, n)
, s2e_res: s2exp
, cp2tcss: &p2atcstlstlst_vt
) : c3laulst (n)
//
(* ****** ****** *)

implement
c2laulst2_trdn{n}
(
  loc0
, casknd, invres
, c2l_fst, c2ls_rest
, d3es, s2es_pat, s2e_res
) = let
(*
val () =
println!
(
  "c2laulst2_trdn: s2es_pat = ", s2es_pat
) (* end of [val] *)
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
val lsbis =
  the_d2varenv_save_lstbefitmlst ()
var lsaft = lstaftc3nstr_initize (lsbis)
//
val loc_fst = c2l_fst.c2lau_loc
val ctr = c3nstroptref_make_none (loc_fst)
val c3l_fst = let
  val cp2tcss1 = c2lau_pat_any (c2l_fst) in
  c2lau_trdn (casknd, c2l_fst, ctr, d3es, s2es_pat, s2e_res, cp2tcss1)
end // end of [val]
val () = lstaftc3nstr_update (lsaft, ctr)
//
val c3ls_all =
  c2laulst2_trdn_rest (
  loc0, casknd, invres, c3l_fst, lsbis, lsaft
, c2ls_rest, d3es, s2es_pat, s2e_res, cp2tcss
) (* end of [c3ls_all] *)
//
val isexhaust = ( // HX: always true for [case-]
  if list_vt_is_nil (cp2tcss) then true else false
) : bool // end of [val]
val () = if ~isexhaust then let
  val cp2tcss = p2atcstlstlst_vt_copy (cp2tcss) in
  trans3_env_add_patcstlstlst_false (loc0, casknd, cp2tcss, s2es_pat)
end // end of [if] // end of [val]
//
val () = p2atcstlstlst_vt_free (cp2tcss)
//
val () = lstaftc3nstr_process (lsaft, invres)
val () = lstaftc3nstr_finalize (lsaft) // HX: it must be processed
//
val () = if ~isexhaust then let
  val _(*err*) = the_effenv_caskind_check_exn (loc0, casknd)
in
  // nothing
end // end of [if] // end of [val]
//
in
  c3ls_all
end (* end of [c2laulst2_trdn] *)

(* ****** ****** *)

implement
c2laulst2_trdn_rest
  {n} (
  loc0
, casknd
, invres
, c3l_fst
, lsbis // : lstbefitmlst
, lsaft // : lstaftc3nstr // linear
, c2ls_rest
, d3es
, s2es_pat, s2e_res
, cp2tcss // : &patcstlstlst_vt
) = let
//
fun
auxred (
  casknd: caskind
, c2l: c2lau, cp2tcss_inter: !p2atcstlstlst_vt
) :<cloref1> void = let
//
fun
auxerr (
  xss: !p2atcstlstlst_vt
) :<cloref1> void = let
  val isnil = list_vt_is_nil (xss)
  val () =
  if isnil then {
    val () = prerr_error3_loc (c2l.c2lau_loc)
    val () = prerr ": this pattern match clause is redundant."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_c2laulst2_trdn_redundant (loc0, c2l))
  } (* end of [val] *)
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
fun
auxmain (
  c2ls: c2laulst
, lsbis: lstbefitmlst
, lsaft: !lstaftc3nstr
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
      print "c2laulst2_trdn_rest: p2tcs = ";
      print_p2atcstlst p2tcs_c2l; print_newline ();
      print "c2laulst2_trdn_rest: cp2tcss =\n";
      print_p2atcstlstlst_vt cp2tcss; print_newline ();
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
            val test =
            p2atcstlst_inter_test
              ($UN.castvwtp1{p2atcstlst}{p2atcstlst_vt}(!p1_xs), p2tcs_c2l)
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
        | list_vt_nil((*void*)) => (fold@ (xss); list_vt_nil())
      // end of [aux]
    in
      aux (cp2tcss)
    end // end of [let] // end of [val]
(*
    val () = (
      print "c2laulst2_trdn_rest;
      print ": auxmain: cp2tcss_inter =\n";
      print_p2atcstlstlst_vt (cp2tcss_inter); print_newline ()
    ) (* end of [val] *)
*)
    val () = auxred (casknd, c2l, cp2tcss_inter) // HX: redundancy checking
//
    val () = lstbefitmlst_restore_type (lsbis)
    val ctr = c3nstroptref_make_none (c2l.c2lau_loc)
    val c3l = c2lau_trdn (casknd, c2l, ctr, d3es, s2es_pat, s2e_res, cp2tcss_inter)
    val () = lstaftc3nstr_update (lsaft, ctr)
//
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
    val c3ls = list_vt_cons (c3l, c3ls)
(*
    val () = begin
      print "c2laulst2_trdn_rest: auxmain";
      print ": cp2tcss(aft) =\n"; print_p2atcstlstlst_vt (cp2tcss); print_newline ()
    end // end of [val]
*)
  in
    auxmain (c2ls, lsbis, lsaft, c3ls, cp2tcss)
  end // end of [list_cons]
| list_nil () => let
    val c3ls = list_vt_reverse (c3ls) in (l2l)c3ls
  end // end of [list_nil]
end (* end of [aux_main] *)
val c3ls_rest =
  auxmain (c2ls_rest, lsbis, lsaft, list_vt_nil (), cp2tcss)
// end of [val]
(*
val () = (
  print "c2laulst2_trdn_rest: cp2tcss =\n"; print_p2atcstlstlst_vt (cp2tcss); print_newline ()
) // end of [val]
*)
in
  list_cons (c3l_fst, c3ls_rest)
end // end of [c2laulst2_trdn_rest]

(* ****** ****** *)

implement
c2laulst_trdn{n}
(
  loc0, casknd, invres, c2ls, d3es, s2es_pat, s2e_res
) = let
in
//
case+ c2ls of
| list_nil () => let
    val () = c2laulst0_trdn (loc0, casknd, s2es_pat, s2e_res)
  in
    list_nil ()
  end // end of [list_nil]
| list_cons (c2l, c2ls) => (
    case+ c2ls of
    | list_nil () => let
        val c3l =
          c2laulst1_trdn (loc0, casknd, invres, c2l, d3es, s2es_pat, s2e_res)
        // end of [val]
      in
        list_sing (c3l)
      end // end of [list_nil]
    | list_cons _ =>
        c2laulst2_trdn (loc0, casknd, invres, c2l, c2ls, d3es, s2es_pat, s2e_res)
  ) // end of [list_cons]
//
end // end of [c2laulst_trdn]

(* ****** ****** *)

implement
d2exp_trdn_casehead
  (d2e0, s2f0) = let
(*
val () = (
  println! ("d2exp_trdn_casehead: s2f0 = ", s2f0)
) // end of [val]
*)
val loc0 = d2e0.d2exp_loc
val-D2Ecasehead (casknd, invres, d2es, c2ls) = d2e0.d2exp_node
val s2e0 = s2hnf2exp (s2f0)
//
val d3es = d2explst_trup (d2es)
val _(*void*) = d3explst_open_and_add (d3es)
val s2es_pat = list_map_fun (d3es, d3exp_get_type)
val c3ls = let
  val s2es1_pat =
  __cast (s2es_pat) where {
    extern
    castfn
    __cast {n:int}(xs: !list_vt(s2exp, n)): list(s2exp, n)
  } // end of [where] // end of [val]
in
  c2laulst_trdn (loc0, casknd, invres, c2ls, d3es, s2es1_pat, s2e0)
end // end of [val]
val () = list_vt_free (s2es_pat)
//
val () = i2nvresstate_update (loc0, invres)
//
in
  d3exp_case (loc0, s2e0, casknd, d3es, c3ls)
end (* end of [d2exp_trdn_casehead] *)

(* ****** ****** *)

implement
d2exp_trdn_scasehead
  (d2e0, s2f0) = let
(*
val () = (
  println! ("d2exp_trdn_scasehead: s2f0 = ", s2f0)
) // end of [val]
*)
//
val loc0 = d2e0.d2exp_loc
val-D2Escasehead (invres, s2e_val, sc2ls) = d2e0.d2exp_node
val s2e0 = s2hnf2exp (s2f0)
//
val lsbis =
  the_d2varenv_save_lstbefitmlst ()
var lsaft = lstaftc3nstr_initize (lsbis)
//
fun auxscl .<>. (
  sc2l: sc2lau
, s2e_val: s2exp
, s2e_res: s2exp
, isfst: bool
, lsbis: lstbefitmlst
, lsaft: !lstaftc3nstr
) : sc3lau = let
  val loc0 = sc2l.sc2lau_loc
  val () =
    if not(isfst) then lstbefitmlst_restore_type (lsbis)
  // end of [val]
  val ctr = c3nstroptref_make_none (loc0)
  val sp2t = sc2l.sc2lau_pat
  val d2e_body = sc2l.sc2lau_body
  val (pfpush | ()) = trans3_env_push ()
  val () = trans3_env_add_sp2at (sp2t)
  val () = $SOL.s2exp_hypequal_solve (sp2t.sp2at_loc, s2e_val, sp2t.sp2at_exp)
  val d3e_body = d2exp_trdn (d2e_body, s2e_res)
  val () = trans3_env_add_cnstr_ref (ctr)
  val () = trans3_env_pop_and_add_main (pfpush | loc0)
  val () = lstaftc3nstr_update (lsaft, ctr)
in
  sc3lau_make (loc0, sp2t, d3e_body)
end // end of [auxscl]
//
fun auxsclist (
  sc2ls: sc2laulst
, s2e_val: s2exp
, s2e_res: s2exp
, isfst: bool
, lsbis: lstbefitmlst
, lsaft: !lstaftc3nstr
) : sc3laulst =
  case+ sc2ls of
  | list_cons
      (sc2l, sc2ls) => let
      val sc3l = auxscl (
        sc2l, s2e_val, s2e_res, isfst, lsbis, lsaft
      ) // end of [val]
      val sc3ls = auxsclist (
        sc2ls, s2e_val, s2e_res, false(*isfst*), lsbis, lsaft
      ) // end of [val]
    in
      list_cons (sc3l, sc3ls)
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [auxsclist]
//
val sc3ls = auxsclist
  (sc2ls, s2e_val, s2e0, true(*isfst*), lsbis, lsaft)
//
val () = lstaftc3nstr_process (lsaft, invres)
val () = lstaftc3nstr_finalize (lsaft) // HX: it must be processed
//
val () = i2nvresstate_update (loc0, invres)
//
in
  d3exp_scase (loc0, s2e0, s2e_val, sc3ls)
end // end of [d2exp_trdn_scasehead]

(* ****** ****** *)

(* end of [pats_trans3_caseof.dats] *)

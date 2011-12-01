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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LAB = "pats_label.sats"
macdef eq_label_label = $LAB.eq_label_label
staload EFF = "pats_effect.sats"
macdef eq_effset_effset = $EFF.eq_effset_effset
staload INTINF = "pats_intinf.sats"
macdef eq_intinf_int = $INTINF.eq_intinf_int
macdef eq_intinf_intinf = $INTINF.eq_intinf_intinf

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef hnflst = s2hnflst_of_s2explst
macdef unhnf = s2exp_of_s2hnf
macdef unhnflst = s2explst_of_s2hnflst

(* ****** ****** *)

extern
fun s2exp_linkrem_flag (s2e: s2exp, flag: &int): s2exp

implement
s2exp_linkrem_flag (s2e0, flag) = let
  val () = begin
    print "s2exp_linkrem_flag: s2e0 = "; print_s2exp s2e0; print_newline ()
  end // end of [val]
in
//
case+ s2e0.s2exp_node of
| S2Ecst s2c => begin
    if s2cst_get_isrec s2c then s2e0
    else (
      case+ s2cst_get_def s2c of
      | Some s2e => let
          val () = flag := flag + 1 in s2exp_linkrem_flag (s2e, flag)
        end // end of [Some]
      | None () => s2e0
    ) // end of [if]
  end // end of [S2Ecst]
//
// HX: the link of s2V should not be updated!!!
//
| S2EVar s2V => (
  case+ s2Var_get_link (s2V) of
  | Some s2e => let
      val () = flag := flag + 1 in s2exp_linkrem_flag ((unhnf)s2e, flag)
    end // end of [Some]
  | None () => s2e0
  ) // end of [S2EVar]
| _ => s2e0 // end of [_]
end (* end of [s2exp_linkrem_flag] *)

implement
s2exp_linkrem (s2e0) = let
  var flag: int = 0 in s2exp_linkrem_flag (s2e0, flag)
end // end of [s2exp_linkrem]

(* ****** ****** *)

extern
fun s2exp_hnfize_flag (s2e: s2exp, flag: &int): s2exp
extern
fun s2explst_hnfize_flag (s2es: s2explst, flag: &int): s2explst
extern
fun labs2explst_hnfize_flag (ls2es: labs2explst, flag: &int): labs2explst

extern
fun s2exp_hnfize_app (
  s2e0: s2exp, s2e_fun: s2exp, s2es_arg: s2explst, flag: &int
) : s2exp // [s2exp_hnfize_app]

(* ****** ****** *)

implement
s2exp_hnfize_app (
  s2e0, s2e_fun, s2es_arg, flag
) = let
  val flag0 = flag
  val s2e_fun = s2exp_hnfize_flag (s2e_fun, flag)
in
  case+ s2e_fun.s2exp_node of
  | S2Elam (s2vs_arg, s2e_body) => let
      #define :: list_cons
      val () = flag := flag + 1
      var sub = stasub_make_nil ()
      fun aux (
        s2vs: s2varlst, s2es: s2hnflst, sub: &stasub
      ) : void =
        case+ (s2vs, s2es) of
        | (s2v :: s2vs, s2e :: s2es) => let
            val () = stasub_add (sub, s2v, s2e) in aux (s2vs, s2es, sub)
          end // end of [::, ::]
        | (_, _) => ()
      // end of [aux]
      val s2fs_arg =
        s2explst_hnfize (s2es_arg)
      // end of [val]
      val () = aux (s2vs_arg, s2fs_arg, sub)
      val s2e0 = s2exp_subst (sub, s2e_body)
      val () = stasub_free (sub)
    in
      s2exp_hnfize_flag (s2e0, flag)
    end // end of [S2Elam]
  | _ =>
      if flag > flag0 then
        s2exp_app_srt (s2e0.s2exp_srt, s2e_fun, s2es_arg)
      else s2e0 (* there is no change *)
    // end of [_]
end // end of [s2exp_hnfize_flag_app]

(* ****** ****** *)

implement
s2exp_hnfize_flag
  (s2e0, flag) = let
(*
  val () = (
    print "s2exp_hnfize_flag: s2e0 = "; print_s2exp (s2e0); print_newline ()
  ) // end of [val]
*)
  val s2t0 = s2e0.s2exp_srt
in
//
case+ s2e0.s2exp_node of
| S2Ecst _ => s2e0
//
| S2Eapp (s2e_fun, s2es_arg) =>
    s2exp_hnfize_app (s2e0, s2e_fun, s2es_arg, flag)
  // end of [S2Eapp]
| S2Elam (s2vs_arg, s2e_body) => let
    val flag0 = flag
    val s2e_body = s2exp_hnfize_flag (s2e_body, flag)
  in
    if flag > flag0
      then s2exp_lam_srt (s2t0, s2vs_arg, s2e_body) else s2e0
    // end of [if]
  end // end of [S2Elam]
| S2Efun _ => s2e0
//
| S2Eexi (s2vs, s2ps, s2e) => let
    val flag0 = flag
    val s2ps = s2explst_hnfize_flag (s2ps, flag)
    val s2e = s2exp_hnfize_flag (s2e, flag)
  in
    if flag > flag0 then s2exp_exi (s2vs, s2ps, s2e) else s2e0
  end // end of [S2Euni]
| S2Euni (s2vs, s2ps, s2e) => let
    val flag0 = flag
    val s2ps = s2explst_hnfize_flag (s2ps, flag)
    val s2e = s2exp_hnfize_flag (s2e, flag)
  in
    if flag > flag0 then s2exp_uni (s2vs, s2ps, s2e) else s2e0
  end // end of [S2Euni]
//
| _ => let
    val () = (
      print "s2exp_hnfize_flag: s2e0 = "; print_s2exp (s2e0); print_newline ()
    ) // end of [val]
    val () = assertloc (false)
  in
    s2e0
  end // end of [_]
//
end // end of [s2exp_hnfize_flag]


(* ****** ****** *)

implement
s2explst_hnfize_flag
  (s2es0, flag) =
  case+ s2es0 of
  | list_cons (s2e, s2es) => let
      val flag0 = flag
      val s2e = s2exp_hnfize_flag (s2e, flag)
      val s2es = s2explst_hnfize_flag (s2es, flag)
    in
      if flag > flag0 then
        list_cons (s2e, s2es) else s2es0
      // end of [if]
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [s2explst_hnfize_flag]

(* ****** ****** *)

implement
labs2explst_hnfize_flag
  (ls2es0, flag) =
  case+ ls2es0 of
  | list_cons (ls2e, ls2es) => let
      val flag0 = flag
      val SLABELED (l, name, s2e) = ls2e
      val s2e = s2exp_hnfize_flag (s2e, flag)
      val ls2es = labs2explst_hnfize_flag (ls2es, flag)
    in
      if flag > flag0 then
        list_cons (SLABELED (l, name, s2e), ls2es) else ls2es0
      // end of [if]
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [labs2explst_hnfize_flag]

(* ****** ****** *)

implement
s2exp_hnfize (s2e) = let
  var flag: int = 0
  val s2e = s2exp_hnfize_flag (s2e, flag)
in
  s2hnf_of_s2exp (s2e)
end // end of [s2exp_hnfsize]

implement
s2explst_hnfize (s2es) = let
  var flag: int = 0
  val s2es = s2explst_hnfize_flag (s2es, flag)
in
  s2hnflst_of_s2explst (s2es)
end // end of [s2explst_hnfsize]

implement
s2expopt_hnfize (opt) = let
  var flag: int = 0
in
  case+ opt of
  | Some s2e => let
      val s2e = s2exp_hnfize_flag (s2e, flag)
    in
      if flag > 0 then
        Some (s2hnf_of_s2exp s2e) else s2hnfopt_of_s2expopt (opt)
      // end of [if]
    end // end of [Some]
  | None () => None ()
end // end of [s2expopt_hnfsize]

(* ****** ****** *)

exception SYNEQexn

extern
fun s2hnf_syneq_exn (s2f1: s2hnf, s2f2: s2hnf): void
extern
fun s2exp_syneq_exn (s2e1: s2exp, s2e2: s2exp): void
extern
fun s2hnflst_syneq_exn (xs1: s2hnflst, xs2: s2hnflst): void
extern
fun s2explst_syneq_exn (xs1: s2explst, xs2: s2explst): void
extern
fun s2explstlst_syneq_exn
  (xss1: s2explstlst, xss2: s2explstlst): void
// end of [s2explstlst_syneq_exn]

(* ****** ****** *)

implement
s2hnf_syneq
  (s2e1, s2e2) = try let
  val () = s2hnf_syneq_exn (s2e1, s2e2) in true
end with
  | ~SYNEQexn () => false
// end of [s2hnf_syneq]

implement
s2exp_syneq
  (s2e1, s2e2) = try let
  val () = s2exp_syneq_exn (s2e1, s2e2) in true
end with
  | ~SYNEQexn () => false
// end of [s2exp_syneq]

(* ****** ****** *)

implement
s2exp_syneq_exn
  (s2e10, s2e20) = let
  val s2f10 = s2exp_hnfize (s2e10)
  and s2f20 = s2exp_hnfize (s2e20)
in
  s2hnf_syneq_exn (s2f10, s2f20)
end // end of [s2exp_syneq_exn]

implement
s2hnflst_syneq_exn
  (xs1, xs2) =
  case+ (xs1, xs2) of
  | (list_cons (x1, xs1), list_cons (x2, xs2)) => let
      val () = s2hnf_syneq_exn (x1, x2) in s2hnflst_syneq_exn (xs1, xs2)
    end // end of [cons, cons]
  | (list_nil (), list_nil ()) => ()
  | (_, _) => $raise (SYNEQexn)
// end of [s2hnflst_syneq_exn]

implement
s2explst_syneq_exn
  (xs1, xs2) =
  case+ (xs1, xs2) of
  | (list_cons (x1, xs1), list_cons (x2, xs2)) => let
      val () = s2exp_syneq_exn (x1, x2) in s2explst_syneq_exn (xs1, xs2)
    end // end of [cons, cons]
  | (list_nil (), list_nil ()) => ()
  | (_, _) => $raise (SYNEQexn)
// end of [s2explst_syneq_exn]

implement
s2explstlst_syneq_exn
  (xss1, xss2) =
  case+ (xss1, xss2) of
  | (list_cons (xs1, xss1), list_cons (xs2, xss2)) => let
      val () = s2explst_syneq_exn (xs1, xs2) in s2explstlst_syneq_exn (xss1, xss2)
    end // end of [cons, cons]
  | (list_nil (), list_nil ()) => ()
  | (_, _) => $raise (SYNEQexn)
// end of [s2explstlst_syneq_exn]

(* ****** ****** *)

fun s2eff_syneq_exn (
  s2fe1: s2eff, s2fe2: s2eff
) : void = begin
  case+ (s2fe1, s2fe2) of
  | (S2EFFall (), S2EFFall ()) => ()
  | (S2EFFnil (), S2EFFnil ()) => ()
  | (S2EFFset (efs1, s2es1),
     S2EFFset (efs2, s2es2)) => (
      if eq_effset_effset (efs1, efs2)
        then s2hnflst_syneq_exn (s2es1, s2es2) else $raise (SYNEQexn)
      // end of [if]
    ) // end of [S2EFFset, S2EFFset]
  | (_, _) => $raise (SYNEQexn)
end // end of [s2eff]

fun labs2explst_syneq_exn (
  ls2es1: labs2explst, ls2es2: labs2explst
) : void =
  case+ (ls2es1, ls2es2) of
  | (list_cons (ls2e1, ls2es1),
     list_cons (ls2e2, ls2es2)) => let
      val SLABELED (l1, _(*opt*), s2e1) = ls2e1
      val SLABELED (l2, _(*opt*), s2e2) = ls2e2
    in
      if eq_label_label (l1, l2) then let
        val () = s2exp_syneq_exn (s2e1, s2e2)
      in
        labs2explst_syneq_exn (ls2es1, ls2es2)
      end else $raise (SYNEQexn)
    end // end of [cons, cons]
  | (list_nil (), list_nil ()) => ()
  | (_, _) => $raise (SYNEQexn)
// end of [labs2explst_syneq]

(* ****** ****** *)

implement
s2hnf_syneq_exn
  (s2f10, s2f20) = let
  val s2e10 = unhnf (s2f10) and s2e20 = unhnf (s2f20)
  val s2en10 = s2e10.s2exp_node and s2en20 = s2e20.s2exp_node
in
//
case s2en10 of
| _ when $UT.eqref_type (s2e10, s2e20) => ()
//
| S2Eint i1 => (
  case+ s2en20 of
  | S2Eint i2 =>
      if eq_int_int (i1, i2) then () else $raise (SYNEQexn)
  | S2Eintinf i2 =>
      if eq_intinf_int (i2, i1) then () else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Eint]
| S2Eintinf i1 => (
  case+ s2en20 of
  | S2Eint i2 =>
      if eq_intinf_int (i1, i2) then () else $raise (SYNEQexn)
  | S2Eintinf i2 =>
      if eq_intinf_intinf (i1, i2) then () else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Eintinf]
| S2Echar c1 => (
  case+ s2en20 of
  | S2Echar c2 =>
      if eq_char_char (c1, c2) then () else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Echar]
//
| S2Ecst s2c1 => (
  case+ s2en20 of
  | S2Ecst s2c2 =>
      if eq_s2cst_s2cst (s2c1, s2c2) then () else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Ecst]
//
| S2Eextype (name1, s2ess1) => (
  case+ s2en20 of
  | S2Eextype (name2, s2ess2) =>
      if name1 = name2 then
        s2explstlst_syneq_exn (s2ess1, s2ess2) else $raise (SYNEQexn)
      // end of [if]
  | _ => $raise (SYNEQexn)
  ) // end of [S2Eextype]
//
| S2Evar (s2v1) => (
  case+ s2en20 of
  | S2Evar s2v2 =>
      if eq_s2var_s2var (s2v1, s2v2) then () else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Evar]
| S2EVar (s2V1) => (
  case+ s2en20 of
  | S2EVar s2V2 =>
      if eq_s2Var_s2Var (s2V1, s2V2) then () else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2EVar]
//
| S2Edatconptr (d2c1, s2es1) => (
  case+ s2en20 of
  | S2Edatconptr (d2c2, s2es2) =>
      if eq_d2con_d2con (d2c1, d2c2)
        then s2explst_syneq_exn (s2es1, s2es2) else $raise (SYNEQexn)
      // end of [if]
  | _ => $raise (SYNEQexn)
  ) // end of [S2Edatconptr]
| S2Edatcontyp (d2c1, s2es1) => (
  case+ s2en20 of
  | S2Edatcontyp (d2c2, s2es2) =>
      if eq_d2con_d2con (d2c1, d2c2)
        then s2explst_syneq_exn (s2es1, s2es2) else $raise (SYNEQexn)
      // end of [if]
  | _ => $raise (SYNEQexn)
  ) // end of [S2Edatcontyp]
//
| S2Eapp (s2e11, s2es12) => (
  case+ s2en20 of
  | S2Eapp (s2e21, s2es22) => {
      val () = s2exp_syneq_exn (s2e11, s2e21)
      val () = s2explst_syneq_exn (s2es12, s2es22)
    } // end of [S2Eapp]
  | _ => $raise (SYNEQexn)
  ) // end of [S2Eapp]
| S2Efun (
    fc1, lin1, s2fe1, npf1, s2es1_arg, s2e1_res
  ) => (case+ s2en20 of
  | S2Efun (
      fc2, lin2, s2fe2, npf2, s2es2_arg, s2e2_res
    ) => {
      val ()= if fc1 != fc2 then $raise (SYNEQexn)
      val () = if lin1 != lin2 then $raise (SYNEQexn)
      val () = s2eff_syneq_exn (s2fe1, s2fe2)
      val () = if npf1 != npf2 then $raise (SYNEQexn)
      val () = s2explst_syneq_exn (s2es1_arg, s2es2_arg)
      val () = s2exp_syneq_exn (s2e1_res, s2e2_res)
    } // end of [S2Efun]
  | _ => $raise (SYNEQexn)
  ) // end of [S2Efun]
//
| S2Etop (knd1, s2e1) => (
  case+ s2en20 of
  | S2Etop (knd2, s2e2) =>
      if knd1 = knd2 then s2exp_syneq_exn (s2e1, s2e2) else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Etop]
//
| S2Etyarr (s2e1_elt, s2es1_int) => (
  case+ s2en20 of
  | S2Etyarr (s2e2_elt, s2es2_int) => {
      val () = s2exp_syneq_exn (s2e1_elt, s2e2_elt)
      val () = s2explst_syneq_exn (s2es1_int, s2es2_int)
    } // end of [S2Etyarr]
  | _ => $raise (SYNEQexn)
  ) // end of [S2Etyarr]
| S2Etyrec (knd1, npf1, ls2es1) => (
  case+ s2en20 of
  | S2Etyrec (knd2, npf2, ls2es2) => {
      val () = if knd1 != knd2 then $raise (SYNEQexn)
      val () = if npf1 != npf2 then $raise (SYNEQexn)
      val () = labs2explst_syneq_exn (ls2es1, ls2es2)
    } // end of [S2Etyrec]
  | _ => $raise (SYNEQexn)
  ) // end of [S2Etyrec]
//
| S2Etyvarknd (knd1, s2e1) => (
  case+ s2en20 of
  | S2Etyvarknd (knd2, s2e2) =>
      if knd1 = knd2 then s2exp_syneq_exn (s2e1, s2e2) else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Etyvarknd]
//
| S2Erefarg (knd1, s2e1) => (
  case+ s2en20 of
  | S2Erefarg (knd2, s2e2) =>
      if knd1 = knd2 then s2exp_syneq_exn (s2e1, s2e2) else $raise (SYNEQexn)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Erefarg]
//
| S2Evararg (s2e1) => (
  case+ s2en20 of
  | S2Evararg (s2e2) => s2exp_syneq_exn (s2e1, s2e2)
  | _ => $raise (SYNEQexn)
  ) // end of [S2Evararg]
//
| _ => $raise (SYNEQexn)
//
end // end of [s2hnf_syneq]

(* ****** ****** *)

(* end of [pats_staexp2_util2.dats] *)

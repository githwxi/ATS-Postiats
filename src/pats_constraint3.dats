
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: February, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/option_vt.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_constraint3"

(* ****** ****** *)

staload "pats_intinf.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

staload "pats_constraint3.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
s3exp_syneq
  (x1, x2) = let
in
//
case+ x1 of
| S3Evar s2v1 => (
  case+ x2 of S3Evar s2v2 => s2v1 = s2v2 | _ => false
  ) // end of [S3Evar]
| S3Ecst s2c1 => (
  case+ x2 of S3Ecst s2c2 => s2c1 = s2c2 | _ => false
  ) // end of [S3Ecst]
| S3Eapp (x1, xs1) => (case+ x2 of
  | S3Eapp (x2, xs2) =>
      if s3exp_syneq (x1, x2) then s3explst_syneq (xs1, xs2) else false
  | _ => false // end of [_]
  ) // end of [S3Eapp]
| S3Eexp s2e1 => (case+ x2 of
  | S3Eexp s2e2 => s2exp_syneq (s2e1, s2e2) | _ => false
  ) // end of [S3Eexp]
//
| S3Enull () => (
  case+ x2 of S3Enull () => true | _ => false
  )
| S3Epadd (x11, x12) => (case+ x2 of
  | S3Epadd (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Epadd]
//
| S3Ebool b1 => (
  case+ x2 of S3Ebool b2 => b1 = b2 | _ => false
  ) // end of [S3Ebool]
| S3Ebneg (x1) => (
  case+ x2 of S3Ebneg (x2) => s3exp_syneq (x1, x2) | _ => false
  ) // end of [S3Ebneg]
| S3Ebadd (x11, x12) => (case+ x2 of
  | S3Ebadd (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Ebadd]
| S3Ebmul (x11, x12) => (case+ x2 of
  | S3Ebmul (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Ebmul]
| S3Ebeq (x11, x12) => (case+ x2 of
  | S3Ebeq (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Ebeq]
| S3Ebneq (x11, x12) => (case+ x2 of
  | S3Ebneq (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Ebneq]
| S3Ebineq (knd1, x1) => (case+ x2 of
  | S3Ebineq (knd2, x2) =>
      if knd1 = knd2 then s3exp_syneq (x1, x2) else false
  | _ => false // end of [_]
  ) // end of [S3Ebineq]
//
| S3Eint (int1) => (
  case+ x2 of S3Eint (int2) => int1 = int2 | _ => false
  ) // end of [S3Eint]
| S3Eiatm (vs1) => (case+ x2 of
  | S3Eiatm (vs2) => s2varmset_is_equal (vs1, vs2) | _ => false
  ) // end of [S3Eiatm]
| S3Eicff (c1, x1) => (case+ x2 of
  | S3Eicff (c2, x2) =>
      if c1 = c2 then s3exp_syneq (x1, x2) else false
  | _ => false // end of [_]
  ) // end of [S3Eicff]
| S3Eiadd (x11, x12) => (case+ x2 of
  | S3Eiadd (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Eiadd]
| S3Eisub (x11, x12) => (case+ x2 of
  | S3Eisub (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Eisub]
| S3Eimul (x11, x12) => (case+ x2 of
  | S3Eimul (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Eimul]
| S3Epdiff (x11, x12) => (case+ x2 of
  | S3Epdiff (x21, x22) =>
      if s3exp_syneq (x11, x21) then s3exp_syneq (x12, x22) else false
  | _ => false // end of [_]
  ) // end of [S3Epdiff]
//
| S3Eerr () => false
//
end // end of [s3exp_syneq]

implement
s3explst_syneq
  (xs1, xs2) = (
  case+ xs1 of
  | list_cons (x1, xs1) => (
    case+ xs2 of
    | list_cons (x2, xs2) =>
        if s3exp_syneq (x1, x2) then s3explst_syneq (xs1, xs2) else false
    | list_nil () => false
    ) // end of [list_cons]
  | list_nil () => (
    case+ xs2 of
    | list_cons _ => false | list_nil () => true
    ) // end of [list_nil]
) // end of [s3explst_syneq]

(* ****** ****** *)

implement s3exp_err () = S3Eerr ()
implement s3exp_var (s2v) = S3Evar (s2v)
implement s3exp_cst (s2c) = S3Ecst (s2c)

(* ****** ****** *)

implement s3exp_null = S3Enull ()

implement
s3exp_padd
  (s3e1, s3e2) = (
  case+ s3e1 of
  | S3Epadd (s3e11, s3e12) =>
      s3exp_padd (s3e11, s3exp_iadd (s3e12, s3e2))
    // end of [S3Epadd]
  | _ => S3Epadd (s3e1, s3e2)
) // end of [s3exp_padd]

implement
s3exp_psub
  (s3e1, s3e2) = (
  case+ s3e1 of
  | S3Epadd (s3e11, s3e12) =>
      s3exp_padd (s3e11, s3exp_isub (s3e12, s3e2))
    // end of [S3Epadd]
  | _ => S3Epadd (s3e1, s3exp_ineg s3e2)
) // end of [s3exp_psub]

implement s3exp_psucc (s3e) = s3exp_padd (s3e, s3exp_1)
implement s3exp_ppred (s3e) = s3exp_padd (s3e, s3exp_neg_1)

(* ****** ****** *)

implement s3exp_true = S3Ebool (true)
implement s3exp_false = S3Ebool (false)

(* ****** ****** *)

implement
s3exp_bneg (s3e0) = (
  case+ s3e0 of
  | S3Ebool b => S3Ebool (not b)
  | S3Ebneg (s3e) => s3e
  | S3Ebadd (s3e1, s3e2) => S3Ebmul (S3Ebneg s3e1, S3Ebneg s3e2)
  | S3Ebmul (s3e1, s3e2) => S3Ebadd (S3Ebneg s3e1, S3Ebneg s3e2)
  | S3Ebeq (s3e1, s3e2) => S3Ebneq (s3e1, s3e2)
  | S3Ebneq (s3e1, s3e2) => S3Ebeq (s3e1, s3e2)
  | S3Ebineq (knd, s3e) => S3Ebineq (~knd, s3e)
  | _ => S3Ebneg (s3e0)
) // end of [s3exp_bneg]

(* ****** ****** *)

implement
s3exp_badd
  (s3e1, s3e2) = (
  case+ s3e1 of
  | S3Ebool b1 => if b1 then s3exp_true else s3e2
  | _ => begin case+ s3e2 of
    | S3Ebool b2 => if b2 then s3exp_true else s3e1
    | _ => S3Ebadd (s3e1, s3e2)
    end // end of [_]
) // end of [s3exp_badd]

implement
s3exp_bmul
  (s3e1, s3e2) = (
  case+ s3e1 of
  | S3Ebool b1 => if b1 then s3e2 else s3exp_false
  | _ => begin case+ s3e2 of
    | S3Ebool b2 => if b2 then s3e1 else s3exp_false
    | _ => S3Ebmul (s3e1, s3e2)
    end // end of [_]
) // end of [s3exp_bmul]

(* ****** ****** *)

implement
s3exp_beq
  (s3e1, s3e2) = (
  case+ s3e1 of
  | S3Ebool b1 =>
      if b1 then s3e2 else s3exp_bneg (s3e2)
  | _ => (case+ s3e2 of
    | S3Ebool b2 =>
        if b2 then s3e1 else s3exp_bneg (s3e1)
    | _ => S3Ebeq (s3e1, s3e2)
    ) // end of [_]
) // end of [s3exp_beq]

implement
s3exp_bneq (s3e1, s3e2) = (
  case+ s3e1 of
  | S3Ebool b1 =>
      if b1 then s3exp_bneg (s3e2) else s3e2
  | _ => (case+ s3e2 of
    | S3Ebool b2 =>
        if b2 then s3exp_bneg (s3e1) else s3e1
    | _ => S3Ebneq (s3e1, s3e2)
    ) // end of [_]
) // end of [s3exp_bneq]

(* ****** ****** *)

implement
s3exp_bineq (knd, s3e) = let
(*
  val () = (
    print "s3exp_bineq: knd = "; print knd; print_newline ()
  ) // end of [val]
*)
//
in
//
case+ s3e of
| S3Eint i => (case+ knd of
  | ~2(*lt*) => if i < 0 then s3exp_true else s3exp_false
  |  2(*gte*) => if i >= 0 then s3exp_true else s3exp_false
  |  1(*eq*) => if i = 0 then s3exp_true else s3exp_false
  | ~1(*neq*) => if i != 0 then s3exp_true else s3exp_false
  | _ => let
      val () = prerr_interror ()
      val () = (
        prerr ": s3exp_bineq: knd = "; prerr_int knd; prerr_newline ()
      ) // end of [val]
    in
      s3exp_false
    end // end of [_]
  ) // end of [S3Eint]
| _ => S3Ebineq (knd, s3e)
end // end of [s3exp_bineq]

(* ****** ****** *)

implement
s3exp_igt (s3e1, s3e2) =
  s3exp_bineq (~2(*lt*), s3exp_isub (s3e2, s3e1))
// end of [s3exp_igt]

implement
s3exp_igte (s3e1, s3e2) =
  s3exp_bineq (2(*gte*), s3exp_isub (s3e1, s3e2))
// end of [s3exp_igte]

implement
s3exp_ilt (s3e1, s3e2) =
  s3exp_bineq (~2(*lt*), s3exp_isub (s3e1, s3e2))
// end of [s3exp_ilt]

implement
s3exp_ilte (s3e1, s3e2) =
  s3exp_bineq (2(*gte*), s3exp_isub (s3e2, s3e1))
// end of [s3exp_ilte]

implement
s3exp_ieq (s3e1, s3e2) =
  s3exp_bineq (1(*eq*), s3exp_isub (s3e1, s3e2))
// end of [s3exp_ieq]

implement
s3exp_ineq (s3e1, s3e2) =
  s3exp_bineq (~1(*neq*), s3exp_isub (s3e1, s3e2))
// end of [s3exp_ineq]

(* ****** ****** *)

implement
s3exp_pgt (s3e1, s3e2) =
  s3exp_bineq (~2(*lt*), s3exp_pdiff (s3e2, s3e1))
// end of [s3exp_pgt]

implement
s3exp_pgte (s3e1, s3e2) =
  s3exp_bineq (2(*gte*), s3exp_pdiff (s3e1, s3e2))
// end of [s3exp_pgte]

implement
s3exp_plt (s3e1, s3e2) =
  s3exp_bineq (~2(*lt*), s3exp_pdiff (s3e1, s3e2))
// end of [s3exp_plt]

implement
s3exp_plte (s3e1, s3e2) =
  s3exp_bineq (2(*gte*), s3exp_pdiff (s3e2, s3e1))
// end of [s3exp_plte]

implement
s3exp_peq (s3e1, s3e2) =
  s3exp_bineq (1(*eq*), s3exp_pdiff (s3e1, s3e2))
// end of [s3exp_peq]

implement
s3exp_pneq (s3e1, s3e2) =
  s3exp_bineq (~1(*neq*), s3exp_pdiff (s3e1, s3e2))
// end of [s3exp_pneq]

(* ****** ****** *)
//
implement intinf_0 = intinf_make_int (0)
implement intinf_1 = intinf_make_int (1)
implement intinf_neg_1 = intinf_make_int (~1)
//
implement s3exp_0 = S3Eint (intinf_0)
implement s3exp_1 = S3Eint (intinf_1)
implement s3exp_neg_1 = S3Eint (intinf_neg_1)
//
(* ****** ****** *)

implement
s3exp_int (i) =
  S3Eint (intinf_make_int (i))
implement
s3exp_intinf (int) = S3Eint (int)

(* ****** ****** *)

implement
s3exp_icff (c, x) = let
(*
  val () = print "s3exp_icff"
*)
in
case+ 0 of
| _ when c = 1 => x
| _ when c = 0 => s3exp_0
| _ => (
  case+ x of
  | S3Eint i => S3Eint (c * i)
  | S3Eicff (c1, x) => s3exp_icff (c * c1, x)
  | S3Eiadd (x1, x2) =>
      s3exp_iadd (s3exp_icff (c, x1), s3exp_icff (c, x2))
  | S3Eisub (x1, x2) =>
      s3exp_isub (s3exp_icff (c, x1), s3exp_icff (c, x2))
  | _ => S3Eicff (c, x)
  ) // end of [_]
end // end of [s3exp_icff]

implement
s3exp_ineg (x) = s3exp_icff (intinf_neg_1, x)

(* ****** ****** *)

implement
s3exp_iadd
  (x1, x2) = (
  case+ (x1, x2) of
  | (S3Eint i, _) when i = 0 => x2
  | (_, S3Eint i) when i = 0 => x1
  | (S3Eint i1, S3Eint i2) => S3Eint (i1 + i2)
  | (_, _) => S3Eiadd (x1, x2)
) // end of [s3exp_iadd]

(* ****** ****** *)

implement
s3exp_isub
  (x1, x2) = (
  case+ (x1, x2) of
  | (_, S3Eint i) when i = 0 => x1
  | (S3Eint i, _) when i = 0 => s3exp_ineg (x2)
  | (S3Eint i1, S3Eint i2) => S3Eint (i1 - i2)
  | (_, _) => S3Eisub (x1, x2)
) // end of [s3exp_isub]

(* ****** ****** *)

implement
s3exp_isucc (s3e) = s3exp_iadd (s3e, s3exp_1)

implement
s3exp_ipred (s3e) = s3exp_isub (s3e, s3exp_1)

(* ****** ****** *)

implement
s3exp_imul
  (x1, x2) = let
in
//
case+ (x1, x2) of
| (S3Eint i, _) => s3exp_icff (i, x2)
| (_, S3Eint i) => s3exp_icff (i, x1)
| (S3Eicff (c, x1), x2) => s3exp_icff (c, s3exp_imul (x1, x2))
| (x1, S3Eicff (c, x2)) => s3exp_icff (c, s3exp_imul (x1, x2))
//
  | (S3Evar (s2v1), S3Evar (s2v2)) =>
      S3Eiatm (s2varmset_pair (s2v1, s2v2))
  | (S3Eiatm (s2vs1), S3Evar (s2v2)) =>
      S3Eiatm (s2varmset_add (s2vs1, s2v2))
  | (S3Evar (s2v1), S3Eiatm (s2vs2)) =>
      S3Eiatm (s2varmset_add (s2vs2, s2v1))
  | (S3Eiatm (s2vs1), S3Eiatm (s2vs2)) =>
      S3Eiatm (s2varmset_union (s2vs1, s2vs2))
//
  | (S3Eiadd (x11, x12), _) =>
      s3exp_iadd (s3exp_imul (x11, x2), s3exp_imul (x12, x2))
    // end of [S3Eiadd, _]
  | (_, S3Eiadd (x21, x22)) =>
      s3exp_iadd (s3exp_imul (x1, x21), s3exp_imul (x1, x22))
    // end of [_, S3Eiadd]
  | (S3Eisub (x11, x12), _) =>
      s3exp_isub (s3exp_imul (x11, x2), s3exp_imul (x12, x2))
    // end of [S3Eisub, _]
  | (_, S3Eisub (x21, x22)) =>
      s3exp_isub (s3exp_imul (x1, x21), s3exp_imul (x1, x22))
    // end of [_, S3Eisub]
//
  | (_, _) => S3Eimul (x1, x2)
//
end // end of [s3exp_imul]

(* ****** ****** *)

implement
s3exp_pdiff (s3e1, s3e2) = S3Epdiff (s3e1, s3e2)

(* ****** ****** *)

local

fun synlt_s2hnf_s2hnf (
  s2f1: s2hnf, s2f2: s2hnf
) : bool = let
  val s2e2 = s2hnf2exp s2f2
// (*
  val () = begin
    print "synlt_s2hnf_s2hnf: s2f1 = "; print_s2hnf (s2f1); print_newline ();
    print "synlt_synlt_s2hnf: s2f2 = "; print_s2hnf (s2f2); print_newline ();
  end // end of [val]
// *)
in
  case+ s2e2.s2exp_node of
  | S2Eapp (_, s2es2) => synlte_s2hnf_s2explst (s2f1, s2es2)
  | _ => false
end // end pf [s2exp_synlt]

and synlte_s2hnf_s2hnf
  (s2f1: s2hnf, s2f2: s2hnf): bool =
  s2hnf_syneq (s2f1, s2f2) orelse synlt_s2hnf_s2hnf (s2f1, s2f2)
(* end of [synlte_s2hnf_s2hnf] *)

//
// HX-2012-02:
// [s2f1] <= at least one of [s2es2]
//
and synlte_s2hnf_s2explst
  (s2f1: s2hnf, s2es2: s2explst): bool =
  case+ s2es2 of
  | list_cons
      (s2e2, s2es2) => let
      val s2f2 = s2exp2hnf (s2e2)
    in
      if synlte_s2hnf_s2hnf (s2f1, s2f2)
        then true else synlte_s2hnf_s2explst (s2f1, s2es2)
      // end of [if]
    end // end of [list_cons]
  | list_nil () => false
// end of [synlte_s2hnf_s2explst]

in // in of [local]

fun s2exp_synlt (
  s2e1: s2exp, s2e2: s2exp
) : bool = let
  val s2f1 = s2exp2hnf (s2e1) and s2f2 = s2exp2hnf (s2e2)
in
  synlt_s2hnf_s2hnf (s2f1, s2f2)
end // end of [s2exp_synlt]

fun s2exp_synlte (
  s2e1: s2exp, s2e2: s2exp
) : bool = let
  val s2f1 = s2exp2hnf (s2e1) and s2f2 = s2exp2hnf (s2e2)
in
  synlte_s2hnf_s2hnf (s2f1, s2f2)
end // end of [s2exp_synlt]

end // end of [local]

(* ****** ****** *)

local

fun auxlt (
  isint: bool
, s2e1: s2exp, s2e2: s2exp
, lt: &int(0) >> int
) : s2exp =
  if isint then
    s2exp_intlt (s2e1, s2e2)
  else let
    val islt = s2exp_synlt (s2e1, s2e2)
    val () = (if islt then lt := 1 else lt := ~1): void
  in
    s2exp_bool (islt)
  end // end of [if]
// end of [auxlt]
//
fun auxlte (
  isint: bool
, s2e1: s2exp, s2e2: s2exp
, lte: &int(0) >> int
) : s2exp =
  if isint then
    s2exp_intlte (s2e1, s2e2)
  else let
    val islte = s2exp_synlte (s2e1, s2e2)
    val () = (if islte then lte := 1 else lte := ~1): void
  in
    s2exp_bool (islte)
  end // end of [if]
//
fun auxlst (
  s2es1: s2explst, s2es2: s2explst
) : s2exp = let
(*
  val () = (
    print "s2exp_metlt_reduce: auxlst"; print_newline ()
  ) // end of [val]
*)
in
//
case+ s2es1 of
| list_cons
    (s2e1, s2es1) => let
    var lt: int = 0 and lte: int = 0
  in
    case+ s2es2 of
    | list_cons
        (s2e2, s2es2) => let
        val isint = s2rt_is_int (s2e1.s2exp_srt)
        val s2p_lt = auxlt (isint, s2e1, s2e2, lt)
      in
        case+ lt of
        | _ when lt > 0 => s2p_lt (*true*)
        | _ (* lt <= 0 *) => let
            val s2p_lte = auxlte (isint, s2e1, s2e2, lte)
          in
            if lt = 0 then let
              val s2p_rest = auxlst (s2es1, s2es2)
            in
              s2exp_badd (s2p_lt, s2exp_bmul (s2p_lte, s2p_rest))
            end else ( // lt < 0 // HX: lte != 0
              if lte >= 0 then auxlst (s2es1, s2es2) else s2p_lte (*false*)
            ) // end of [if]
          end // end of [lt <= 0]
        // end of [case]
      end // end of [list_cons]
    | list_nil () => s2exp_bool (true)
  end (* end of [list_cons] *)
| list_nil () => s2exp_bool (false)
end // end of [auxlst]

in // in of [local]

fun s2exp_metlt_reduce (
  met: s2explst, met_bound: s2explst
) : s2exp = (
  auxlst (met, met_bound)
) // end of [s2exp_metlt_reduce]

end // end of [local]

(* ****** ****** *)

local

fun auxeq (
  fds: &s2vbcfenv, s2e1: s2exp, s2e2: s2exp
) : s3exp = let
  val s2t1 = s2e1.s2exp_srt
in
//
case+ 0 of
| _ => (
    if s2exp_syneq (s2e1, s2e2) then s3exp_true else s3exp_err ()
  ) // end of [_]
//
end // end of [auxeq]

fun auxbind (
  loc0: location
, fds: &s2vbcfenv, s2v1: s2var, s2e2: s2exp
) : s3exp = let
(*
  val () = begin
    print "auxbind: s2v1 = "; print_s2var (s2v1); print_newline ();
    print "auxbind: s2e2 = "; print_s2exp (s2e2); print_newline ();
  end // end of [val]
*)
  val s2e1 = s2exp_var (s2v1)
  val () = trans3_env_hypadd_bind (loc0, s2v1, s2e2)
in
  auxeq (fds, s2e1, s2e2)
end // end of [aux_bind]

in // in of [local]

implement
s3exp_make
  (env, s2e0) = let
  val s2f0 = s2exp2hnf (s2e0)
  val s2e0 = s2hnf2exp (s2f0)
(*
  val () = begin
    print "s3exp_make_s2exp: s2e0 = "; print_s2exp (s2e0); print_newline ()
  end // end of [val]
*)
in
//
case+ s2e0.s2exp_node of
//
| S2Evar s2v => s3exp_var (s2v)
//
| S2Eint i => s3exp_int (i)
| S2Eintinf (int) => s3exp_intinf (int)
| S2Echar c => let
    val i = int_of_uint (uint_of_char (c)) in s3exp_int (i)
  end // end of [S2Echar]
//
| S2Ecst s2c => (case+ s2c of
  | _ when
      s2cstref_equ_cst (the_null_addr, s2c) => s3exp_null
  | _ when
      s2cstref_equ_cst (the_true_bool, s2c) => s3exp_true
  | _ when
      s2cstref_equ_cst (the_false_bool, s2c) => s3exp_false
  | _ => let
      val () = s2vbcfenv_add_scst (env, s2c) in s3exp_cst (s2c)
    end (* end of [_] *)
  ) // end of [S2Ecst]
//
| S2Eapp
    (s2e1, s2es2) => (
  case+ s2e1.s2exp_node of
  | S2Ecst s2c1 =>
      s3exp_make_s2cst_s2explst (env, s2c1, s2es2)
    // end of [S2Ecst]
  | _ => let
      val s3e1 = s3exp_make (env, s2e1)
      val s3es2 = s3explst_make (env, s2es2)
    in
      S3Eapp (s3e1, s3es2)
    end
  ) // end of [S2Eapp]
| S2Eeqeq (s2e1, s2e2) => auxeq (env, s2e1, s2e2)
| S2Emetlt
    (met, met_bound) => let
    val s2e_met =
      s2exp_metlt_reduce (met, met_bound)
    // end of [val]
  in
    s3exp_make (env, s2e_met)
  end // end of [S3Emetlt]
| _ => let // an expression that cannot be handled
    val () = begin
      prerr "warning(3): s3exp_make_s2exp: s2e0 = "; prerr_s2exp (s2e0); prerr_newline ();
    end // end of [val]
  in
    s3exp_err ()
  end // end of [_]
//
end // end of [s3exp_make]

implement
s3exp_make_h3ypo
  (env, h3p) = (
  case+ h3p.h3ypo_node of
  | H3YPOprop s2p => s3exp_make (env, s2p)
  | H3YPObind (s2v1, s2e2) => auxbind (h3p.h3ypo_loc, env, s2v1, s2e2)
  | H3YPOeqeq (s2e1, s2e2) => auxeq (env, s2e1, s2e2)
) // end of [s3exp_make_h3ypo]

end // end of [local]

(* ****** ****** *)

implement
s3explst_make
  (env, s2es) = let
  macdef f (x) = s3exp_make (env, ,(x))
in
//
case+ s2es of
| list_cons (s2e, s2es) =>
    list_cons (f (s2e), s3explst_make (env, s2es))
| list_nil () => list_nil ()
//
end // end of [s3explst_make]

(* ****** ****** *)

local
//
viewtypedef s3expopt_vt = Option_vt (s3exp)
//
dataviewtype
s2vbclst =
  | S2VBCFLSTsvar of (s2var, s2vbclst)
  | S2VBCFLSTsbexp of (s3exp, s2vbclst)
  | S2VBCFLSTscst of (s2cst, s2vbclst)
  | S2VBCFLSTcons of (
      s2cst(*scf*), s3explst(*arg*), s2var(*res*), s3expopt_vt(*rel*), s2vbclst
    ) // end of [S2VBCFLSTcons]
  | S2VBCFLSTmark of s2vbclst
  | S2VBCFLSTnil of ()
// end of [s2vbclst]

assume
s2vbcfenv_viewtype = s2vbclst
assume s2vbcfenv_push_v = unit_v

in // in of [local]

implement
s2vbcfenv_nil () = S2VBCFLSTnil ()

implement
s2vbcfenv_free (env) = (
  case+ env of
  | ~S2VBCFLSTsvar (_, env) => s2vbcfenv_free (env)
  | ~S2VBCFLSTsbexp (_, env) => s2vbcfenv_free (env)
  | ~S2VBCFLSTscst (_, env) => s2vbcfenv_free (env)
  | ~S2VBCFLSTcons (_, _, _, opt, env) => let
      val () = option_vt_free (opt) in s2vbcfenv_free (env)
    end // end of [S2VBCFLSTcons]
  | ~S2VBCFLSTmark (env) => s2vbcfenv_free (env)
  | ~S2VBCFLSTnil () => ()
) // end of [s2vbcfenv_free]

implement
s2vbcfenv_pop (pf | env) = let
  fun aux (
    env: s2vbclst
  ) : s2vbclst = case+ env of
    | ~S2VBCFLSTsvar (_, env) => aux (env)
    | ~S2VBCFLSTsbexp (_, env) => aux (env)
    | ~S2VBCFLSTscst (_, env) => aux (env)
    | ~S2VBCFLSTcons
        (_, _, _, opt, env) => let
        val () = option_vt_free (opt) in aux (env)
      end (* end of [S2VBCFLSTcons] *)
    | ~S2VBCFLSTmark (env) => env // HX: pop is done
    | ~S2VBCFLSTnil () => S2VBCFLSTnil ()
  // end of [aux]
  prval unit_v () = pf
in
  env := aux (env)
end (* end of [s2vbcflst_pop] *)

implement
s2vbcfenv_push (env) = let
  val () = env := S2VBCFLSTmark (env) in (unit_v () | ())
end // end of [s2vbcfenv_push]

(* ****** ****** *)

implement
s2vbcfenv_find
  (env0, s2c0, s3es0) = let
in
//
case+ env0 of
//
| S2VBCFLSTsvar
    (_, !p_env) => let
    val ans = s2vbcfenv_find (!p_env, s2c0, s3es0)
  in
    fold@ env0; ans
  end // end of [S2VBCFLSTsvar]
| S2VBCFLSTsbexp
    (_, !p_env) => let
    val ans = s2vbcfenv_find (!p_env, s2c0, s3es0)
  in
    fold@ env0; ans
  end // end of [S2VBCFLSTsbexp]
//
| S2VBCFLSTcons
    (s2c, s3es, s2v, _, !p_env) => let
    val test = (
      if eq_s2cst_s2cst (s2c0, s2c)
        then s3explst_syneq (s3es0, s3es) else false
      // end of [val]
    ) : bool // end of [val]
  in
    if test then let
      prval () = fold@ env0 in Some_vt (s2v)
    end else let
      val ans = s2vbcfenv_find (!p_env, s2c0, s3es0)
    in
      fold@ env0; ans
    end (* end of [if] *)
  end // end of [S2VBCFLSTcons]
//
| S2VBCFLSTscst
    (_, !p_env) => let
    val ans = s2vbcfenv_find (!p_env, s2c0, s3es0)
  in
    fold@ env0; ans
  end // end of [S2VBCFLSTscst]
//
| S2VBCFLSTmark (!p_env) => let
    val ans = s2vbcfenv_find (!p_env, s2c0, s3es0)
  in
    fold@ env0; ans
  end // end of [S2VBCFLSTmark]
| S2VBCFLSTnil () => let
    prval () = fold@ (env0) in None_vt ()
  end // end of [S2VBCFLSTnil]
//
end // end of [s2vbcfenv_find]

(* ****** ****** *)

implement
s2vbcfenv_extract (env) = let
//
fun loop (
  env: !s2vbcfenv
, s2vs: &s2varlst_vt, s3bes: &s3explst_vt, s2cs: &s2cstset_vt
) : void = let
in
//
case+ env of
| S2VBCFLSTsvar
    (s2v, !p_env) => let
    val () = s2vs := list_vt_cons (s2v, s2vs)
    val () = loop (!p_env, s2vs, s3bes, s2cs)
  in
    fold@ (env)
  end // end of [S2VBCFLSTsbexp]
| S2VBCFLSTsbexp
    (s3be, !p_env) => let
    val () = s3bes := list_vt_cons (s3be, s3bes)
    val () = loop (!p_env, s2vs, s3bes, s2cs)
  in
    fold@ (env)
  end // end of [S2VBCFLSTsbexp]
| S2VBCFLSTscst
    (s2c, !p_env) => let
    val () = s2cs := s2cstset_vt_add (s2cs, s2c)
    val () = loop (!p_env, s2vs, s3bes, s2cs)
  in
    fold@ (env)
  end // end of [S2VBCFLSTsbexp]
| S2VBCFLSTcons (
    s2c, arg, res, !p_rel, !p_env
  ) => let
    val () = (
      case+ !p_rel of
      | Some_vt (s3be) => let
          prval () = fold@ (!p_rel) in s3bes := list_vt_cons (s3be, s3bes)
        end // end of [Some_vt]
      | None_vt () => fold@ (!p_rel)
    ) : void // end of [val]
    val () = loop (!p_env, s2vs, s3bes, s2cs)
  in
    fold@ (env)
  end // end of [S2VBCFLSTcons]
| S2VBCFLSTmark (!p_env) => let
    val () = loop (!p_env, s2vs, s3bes, s2cs) in fold@ (env)
  end // end of [S2VBCFLSTmark]
| S2VBCFLSTnil () => fold@ (env)
//
end // [end of loop]
//
var s2vs: s2varlst_vt = list_vt_nil ()
var s3bes: s3explst_vt = list_vt_nil ()
var s2cs: s2cstset_vt = s2cstset_vt_nil ()
val () = loop (env, s2vs, s3bes, s2cs)
//
in
  @(s2vs, s3bes, s2cs)
end // end of [s2vbcfenv_extract]

(* ****** ****** *)

fun s2vbcfenv_add2 (
  env: &s2vbcfenv
, s2c: s2cst, arg1: s2explst, arg2: s3explst, s2v: s2var
) : void = let
//
  val s2e_cst = s2exp_cst (s2c)
  val s2e_var = s2exp_var (s2v)
  val s2es1 = list_extend (arg1, s2e_var)
  val s2e_rel = s2exp_app_srt (s2rt_bool, s2e_cst, (l2l)s2es1)
  val s3be = s3exp_make (env, s2e_rel)
//
in
  env := S2VBCFLSTcons (s2c, arg2, s2v, Some_vt (s3be), env)
end // end of [s2vbcfenv_add2]

fun s2vbcfenv_add2_none (
  env: &s2vbcfenv
, s2c: s2cst, arg1: s2explst, arg2: s3explst, s2v: s2var
) : void = let
in
  env := S2VBCFLSTcons (s2c, arg2, s2v, None_vt (), env)
end // end of [s2vbcfenv_add2_none]

(* ****** ****** *)

implement
s2vbcfenv_add_svar
  (env, s2v) = (env := S2VBCFLSTsvar (s2v, env))
// end of [s2vbcfenv_add_svar]

implement
s2vbcfenv_add_sexp
  (env, s3be) = (env := S2VBCFLSTsbexp (s3be, env))
// end of [s2vbcfenv_add_sexp]

implement
s2vbcfenv_add_scst
  (env, s2c) = (env := S2VBCFLSTscst (s2c, env))
// end of [s2vbcfenv_add_scst]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
s2vbcfenv_add
  (env, s2c, s2es_arg, s2v) = let
//
  val () = begin
    print "s2vbcfenv_add: s2c = ";
    print_s2cst (s2c); print_newline ();
    print "s2vbcfenv_add: s2es_arg = ";
    print_s2explst (s2es_arg); print_newline ();
    print "s2vbcfenv_add: s2v = ";
    print_s2var (s2v); print_newline ();
  end // end of [val]
//
  val s3es_arg = s3explst_make (env, s2es_arg)
in
  s2vbcfenv_add2 (env, s2c, s2es_arg, s3es_arg, s2v)
end // end of [s2vbcfenv_add]

implement
s2vbcfenv_replace
  (env, s2t, s2c, s2es_arg) = let
//
val s3es_arg =
  s3explst_make (env, s2es_arg)
// end of [val]
val ans = s2vbcfenv_find (env, s2c, s3es_arg)
//
in
//
case+ ans of
| ~Some_vt (s2v) => s2v
| ~None_vt () => s2v where {
    val s2v = s2var_make_srt (s2t)
    val () = s2vbcfenv_add2 (env, s2c, s2es_arg, s3es_arg, s2v)
  } // end of [None_vt]
//
end // end of [s2vbcfenv_replace]

(* ****** ****** *)

implement
s2vbcfenv_add_none
  (env, s2c, s2es_arg, s2v) = let
//
  val () = begin
    print "s2vbcfenv_add: s2c = ";
    print_s2cst (s2c); print_newline ();
    print "s2vbcfenv_add: s2es_arg = ";
    print_s2explst (s2es_arg); print_newline ();
    print "s2vbcfenv_add: s2v = ";
    print_s2var (s2v); print_newline ();
  end // end of [val]
//
  val s3es_arg = s3explst_make (env, s2es_arg)
in
  s2vbcfenv_add2_none (env, s2c, s2es_arg, s3es_arg, s2v)
end // end of [s2vbcfenv_add_none]

implement
s2vbcfenv_replace_none
  (env, s2t, s2c, s2es_arg) = let
//
val s3es_arg =
  s3explst_make (env, s2es_arg)
val ans = s2vbcfenv_find (env, s2c, s3es_arg)
//
in
//
case+ ans of
| ~Some_vt (s2v) => s2v
| ~None_vt () => s2v where {
    val s2v = s2var_make_srt (s2t)
    val () = s2vbcfenv_add2_none (env, s2c, s2es_arg, s3es_arg, s2v)
  } // end of [None_vt]
//
end // end of [s2vbcfenv_replace_none]

(* ****** ****** *)

local

stadef env = s2vbcfenv
typedef tfun = (&env, s2explst) -<fun1> s3exp

assume
s2cfunmap = s2cstmap (tfun)
var the_s2cfunmap: s2cfunmap = s2cstmap_nil ()
val (pf_the_s2cfunmap | ()) =
  vbox_make_view_ptr {s2cfunmap} (view@ (the_s2cfunmap) | &the_s2cfunmap)
// end of [val]

in // in of [local]

implement
s3exp_make_s2cst_s2explst
  (env, s2c, s2es) = let
  val opt = let
    prval vbox (pf) = pf_the_s2cfunmap in s2cstmap_find  (the_s2cfunmap, s2c)
  end // end of [val]
in
//
case+ opt of
| ~Some_vt f => f (env, s2es)
| ~None_vt _ => let
    val () = begin
      print "s3exp_make_s2cst_s2explst: s2c = "; print_s2cst (s2c); print_newline ();
    end // end of [val]
  in
    s3exp_err ()
  end // end of [None_vt]
//  
end // end of [s3exp_make_s2cst_s2explst]

(* ****** ****** *)

implement
constraint3_initialize () = let
  prval vbox (pf) = pf_the_s2cfunmap in
  $effmask_ref (constraint3_initialize_map (the_s2cfunmap))
end // end of [constraint3_initialize]

end // end of [local]

(* ****** ****** *)

(* end of [pats_constraint3.dats] *)


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

staload "pats_intinf.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

staload "pats_constraint3.sats"

(* ****** ****** *)

implement s3aexp_null = S3AEnull ()

implement s3aexp_var (s2v) = S3AEvar (s2v)
implement s3aexp_cst (s2c) = S3AEcst (s2c)

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
s3aexp_padd
  (s3ae1, s3ie2) = (
  case+ s3ae1 of
  | S3AEpadd (s3ae11, s3ie12) =>
      s3aexp_padd (s3ae11, s3iexp_iadd (s3ie12, s3ie2))
    // end of [S3AEpadd]
  | _ => S3AEpadd (s3ae1, s3ie2)
) // end of [s3aexp_padd]

implement
s3aexp_psub
  (s3ae1, s3ie2) = (
  case+ s3ae1 of
  | S3AEpadd (s3ae11, s3ie12) =>
      s3aexp_padd (s3ae11, s3iexp_isub (s3ie12, s3ie2))
    // end of [S3AEpadd]
  | _ => S3AEpadd (s3ae1, s3iexp_neg s3ie2)
) // end of [s3aexp_psub]

implement s3aexp_psucc (s3ae) = s3aexp_padd (s3ae, s3iexp_1)
implement s3aexp_ppred (s3ae) = s3aexp_padd (s3ae, s3iexp_neg_1)

(* ****** ****** *)

implement s3bexp_true = S3BEbool (true)
implement s3bexp_false = S3BEbool (false)

implement s3bexp_var (s2v) = S3BEvar (s2v)
implement s3bexp_cst (s2c) = S3BEcst (s2c)

(* ****** ****** *)

implement
s3bexp_bneg (s3be0) = (
  case+ s3be0 of
  | S3BEbool b => S3BEbool (not b)
  | S3BEbadd (s3be1, s3be2) => S3BEbmul (S3BEbneg s3be1, S3BEbneg s3be2)
  | S3BEbmul (s3be1, s3be2) => S3BEbadd (S3BEbneg s3be1, S3BEbneg s3be2)
  | S3BEbneg s3be => s3be
  | S3BEiexp (knd, s3ie) => S3BEiexp (~knd, s3ie)
  | _ => S3BEbneg (s3be0)
) // end of [s3bexp_bneg]

(* ****** ****** *)

implement
s3bexp_beq (s3be1, s3be2) = (
  case+ s3be1 of
  | S3BEbool b1 => if b1 then s3be2 else s3bexp_bneg s3be2
  | _ => (case+ s3be2 of
    | S3BEbool b2 => if b2 then s3be1 else s3bexp_bneg s3be1
    | _ => let
        val s3be1_neg = s3bexp_bneg (s3be1)
        and s3be2_neg = s3bexp_bneg (s3be2)
      in
        S3BEbadd (S3BEbmul (s3be1, s3be2), S3BEbmul (s3be1_neg, s3be2_neg))
      end // end of [_]
    ) // end of [_]
) // end of [s3bexp_beq]

implement
s3bexp_bneq (s3be1, s3be2) = (
  case+ s3be1 of
  | S3BEbool b1 => if b1 then s3bexp_bneg s3be2 else s3be2
  | _ => (case+ s3be2 of
    | S3BEbool b2 => if b2 then s3bexp_bneg s3be1 else s3be1
    | _ => let
        val s3be1_neg = s3bexp_bneg (s3be1)
        and s3be2_neg = s3bexp_bneg (s3be2)
      in
        S3BEbadd (S3BEbmul (s3be1, s3be2_neg), S3BEbmul (s3be1_neg, s3be2))
      end // end of [_]
    ) // end of [_]
) // end of [s3bexp_bneq]

(* ****** ****** *)

implement
s3bexp_badd
  (s3be1, s3be2) = (
  case+ s3be1 of
  | S3BEbool b1 => if b1 then s3bexp_true else s3be2
  | _ => begin case+ s3be2 of
    | S3BEbool b2 => if b2 then s3bexp_true else s3be1
    | _ => S3BEbadd (s3be1, s3be2)
    end // end of [_]
) // end of [s3bexp_badd]

implement
s3bexp_bmul
  (s3be1, s3be2) = (
  case+ s3be1 of
  | S3BEbool b1 => if b1 then s3be2 else s3bexp_false
  | _ => begin case+ s3be2 of
    | S3BEbool b2 => if b2 then s3be1 else s3bexp_false
    | _ => S3BEbmul (s3be1, s3be2)
    end // end of [_]
) // end of [s3bexp_bmul]

(* ****** ****** *)
//
implement intinf_0 = intinf_make_int (0)
implement intinf_1 = intinf_make_int (1)
implement intinf_neg_1 = intinf_make_int (~1)
//
implement s3iexp_0 = S3IEint (intinf_0)
implement s3iexp_1 = S3IEint (intinf_1)
implement s3iexp_neg_1 = S3IEint (intinf_neg_1)
//
(* ****** ****** *)

implement
s3iexp_int (i) = S3IEint (intinf_make_int (i))

(* ****** ****** *)

implement
s3iexp_cff (c, x) = let
(*
  val () = print "s3iexp_cff"
*)
in
case+ 0 of
| _ when c = 1 => x
| _ when c = 0 => s3iexp_0
| _ => (
  case+ x of
  | S3IEint i => S3IEint (c * i)
  | S3IEcff (c1, x) => s3iexp_cff (c * c1, x)
  | S3IEiadd (x1, x2) =>
      s3iexp_iadd (s3iexp_cff (c, x1), s3iexp_cff (c, x2))
  | S3IEisub (x1, x2) =>
      s3iexp_isub (s3iexp_cff (c, x1), s3iexp_cff (c, x2))
  | _ => S3IEcff (c, x)
  ) // end of [_]
end // end of [s3iexp_cff]

implement
s3iexp_neg (x) = s3iexp_cff (intinf_neg_1, x)

(* ****** ****** *)

implement
s3iexp_iadd
  (x1, x2) = (
  case+ (x1, x2) of
  | (S3IEint i, _) when i = 0 => x2
  | (_, S3IEint i) when i = 0 => x1
  | (S3IEint i1, S3IEint i2) => S3IEint (i1 + i2)
  | (_, _) => S3IEiadd (x1, x2)
) // end of [s3iexp_iadd]

(* ****** ****** *)

implement
s3iexp_isub
  (x1, x2) = (
  case+ (x1, x2) of
  | (S3IEint i, _) when i = 0 => x2
  | (_, S3IEint i) when i = 0 => x1
  | (S3IEint i1, S3IEint i2) => S3IEint (i1 - i2)
  | (_, _) => S3IEisub (x1, x2)
) // end of [s3iexp_isub]

(* ****** ****** *)

implement
s3iexp_isucc
  (x: s3iexp): s3iexp = s3iexp_iadd (x, s3iexp_1)
// end of [s3iexp_isucc]

implement
s3iexp_ipred
  (x: s3iexp): s3iexp = s3iexp_isub (x, s3iexp_1)
// end of [s3iexp_ipred]

(* ****** ****** *)

implement
s3iexp_imul
  (x1, x2) = (
  case+ (x1, x2) of
  | (S3IEint i, _) => s3iexp_cff (i, x2)
  | (_, S3IEint i) => s3iexp_cff (i, x1)
  | (S3IEcff (c, x1), x2) => s3iexp_cff (c, s3iexp_imul (x1, x2))
  | (x1, S3IEcff (c, x2)) => s3iexp_cff (c, s3iexp_imul (x1, x2))
//
  | (S3IEvar (s2v1), S3IEvar (s2v2)) =>
      S3IEatm (s2varmset_pair (s2v1, s2v2))
  | (S3IEatm (s2vs1), S3IEvar (s2v2)) =>
      S3IEatm (s2varmset_add (s2vs1, s2v2))
  | (S3IEvar (s2v1), S3IEatm (s2vs2)) =>
      S3IEatm (s2varmset_add (s2vs2, s2v1))
  | (S3IEatm (s2vs1), S3IEatm (s2vs2)) =>
      S3IEatm (s2varmset_union (s2vs1, s2vs2))
//
  | (S3IEiadd (x11, x12), _) =>
      s3iexp_iadd (s3iexp_imul (x11, x2), s3iexp_imul (x12, x2))
    // end of [S3IEiadd, _]
  | (_, S3IEiadd (x21, x22)) =>
      s3iexp_iadd (s3iexp_imul (x1, x21), s3iexp_imul (x1, x22))
    // end of [_, S3IEiadd]
  | (S3IEisub (x11, x12), _) =>
      s3iexp_isub (s3iexp_imul (x11, x2), s3iexp_imul (x12, x2))
    // end of [S3IEisub, _]
  | (_, S3IEisub (x21, x22)) =>
      s3iexp_isub (s3iexp_imul (x1, x21), s3iexp_imul (x1, x22))
    // end of [_, S3IEisub]
//
  | (_, _) => S3IEimul (x1, x2)
//
) // end of [s3iexp_imul]

(* ****** ****** *)

implement
s3iexp_pdiff (s3ae1, s3ae2) = S3IEpdiff (s3ae1, s3ae2)

(* ****** ****** *)

local

dataviewtype
s2cfdeflst_vt =
  | S2CFDEFLSTcons of (
      s2cst(*scf*), s2explst(*arg*), s2var(*res*), s3bexpopt_vt(*rel*), s2cfdeflst_vt
    ) // end of [S2CFDEFLSTcons]
  | S2CFDEFLSTmark of s2cfdeflst_vt
  | S2CFDEFLSTnil of ()
// end of [s2cfdeflst_vt]

assume s2cfdefmap_viewtype = s2cfdeflst_vt

in

implement
s2cfdefmap_free (fds) = (
  case+ fds of
  | ~S2CFDEFLSTcons
      (_, _, _, opt, fds) => let
      val () = option_vt_free (opt) in s2cfdefmap_free (fds)
    end // end of [S2CFDEFLSTcons]
  | ~S2CFDEFLSTmark (fds) => s2cfdefmap_free (fds)
  | ~S2CFDEFLSTnil () => ()
) // end of [s2cfdefmap_free]

implement
s2cfdefmap_pop (fds) = let
  fun aux (
    fds: s2cfdeflst_vt
  ) : s2cfdeflst_vt = case+ fds of
    | ~S2CFDEFLSTcons
        (_, _, _, opt, fds) => let
        val () = option_vt_free (opt) in aux (fds)
      end (* end of [S2CFDEFLSTcons] *)
    | ~S2CFDEFLSTmark (fds) => fds
    | ~S2CFDEFLSTnil () => S2CFDEFLSTnil ()
  // end of [aux]  
in
  fds := aux (fds)
end (* end of [s2cfdeflst_pop] *)

implement
s2cfdefmap_push (fds) = (fds := S2CFDEFLSTmark (fds))

(* ****** ****** *)

implement
s2cfdefmap_find
  (fds0, s2c0, s2es0) = let
in
//
case+ fds0 of
| S2CFDEFLSTcons
    (s2c, s2es, s2v, _, !p_fds) => let
    val test = (
      if eq_s2cst_s2cst (s2c0, s2c)
        then s2explst_syneq (s2es0, s2es) else false
      // end of [val]
    ) : bool // end of [val]
  in
    if test then let
      prval () = fold@ fds0 in Some_vt (s2v)
    end else let
      val ans = s2cfdefmap_find (!p_fds, s2c0, s2es0)
    in
      fold@ fds0; ans
    end (* end of [if] *)
  end // end of [S2CFDEFLSTcons]
| S2CFDEFLSTmark (!fds) => let
    val ans = s2cfdefmap_find (!fds, s2c0, s2es0)
  in
    fold@ fds0; ans
  end // end of [S2CFDEFLSTmark]
| S2CFDEFLSTnil () => let
    prval () = fold@ (fds0) in None_vt ()
  end // end of [S2CFDEFLSTnil]
//
end // end of [s2cfdefmap_find]

(* ****** ****** *)

implement
s2cfdefmap_add
  (fds, s2c, s2es, s2v, s2cs) = let
(*
  val () = begin
    print "s2cfdefmap_add: s2c = "; print s2c; print_newline ();
    print "s2cfdefmap_add: s2es = "; print s2es; print_newline ();
    print "s2cfdefmap_add: s2v = "; print s2v; print_newline ();
  end // end of [val]
*)
  val s2e_cst = s2exp_cst (s2c)
  val s2e_var = s2exp_var (s2v)
  val s2es1 = list_extend (s2es, s2e_var)
  val s2e_rel = s2exp_app_srt (s2rt_bool, s2e_cst, (l2l)s2es1)
  val os3be = s3bexp_make_s2exp (s2e_rel, s2cs, fds)
in
  fds := S2CFDEFLSTcons (s2c, s2es, s2v, os3be, fds)
end // end of [s2cfdefmap_add]

implement
s2cfdefmap_add_none
  (fds, s2c, s2es, s2v, s2cs) = let
(*
  val () = begin
    print "s2cfdefmap_add: s2c = "; print s2c; print_newline ();
    print "s2cfdefmap_add: s2es = "; print s2es; print_newline ();
    print "s2cfdefmap_add: s2v = "; print s2v; print_newline ();
  end // end of [val]
*)
in
  fds := S2CFDEFLSTcons (s2c, s2es, s2v, None_vt (), fds)
end // end of [s2cfdefmap_add_none]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_constraint3.dats] *)

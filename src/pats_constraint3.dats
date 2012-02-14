
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

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_constraint3.sats"

(* ****** ****** *)

implement s3aexp_null = S3AEnull ()

implement s3aexp_var (s2v) = S3AEvar (s2v)
implement s3aexp_cst (s2c) = S3AEcst (s2c)

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
  | _ => S3AEpadd (s3ae1, s3iexp_ineg s3ie2)
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

(* end of [pats_constraint3.dats] *)

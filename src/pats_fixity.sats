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
// Start Time: April, 2011
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

datatype assoc = ASSOCnon | ASSOClft | ASSOCrgt

fun fprint_assoc (out: FILEref, x: assoc): void
overload fprint with fprint_assoc

(* ****** ****** *)

abst@ype prec_t0ype = int (* precedence type *)
typedef prec = prec_t0ype

(* ****** ****** *)

val neginf_prec : prec // lowest legal precedence value
val posinf_prec : prec // highest legal precedence value

(* ****** ****** *)

val app_prec : prec // the precedence value for application

(* ****** ****** *)

val select_prec : prec // the precedence value for selection

(* ****** ****** *)

val backslash_prec : prec
val infixtemp_prec : prec // for temp infix status

(* ****** ****** *)

val exi_prec_sta : prec
and uni_prec_sta : prec

(* ****** ****** *)

val delay_prec_dyn : prec

val exist_prec_dyn : prec

(* ****** ****** *)

val ptrof_prec_dyn : prec
val addrat_prec_dyn : prec

val foldat_prec_dyn : prec
val freeat_prec_dyn : prec
val viewat_prec_dyn : prec

(* ****** ****** *)

val invar_prec_sta : prec

val qmark_prec_sta : prec

val qmarkbang_prec_sta : prec

val trans_prec_sta : prec // for >>

val deref_prec_dyn : prec

(* ****** ****** *)

fun int_of_prec (p: prec): int
fun prec_make_int (i: int): prec

fun precedence_inc (p: prec, i: int): prec
fun precedence_dec (p: prec, i: int): prec

(* ****** ****** *)

fun compare_prec_prec (p1: prec, p2: prec): Sgn
overload compare with compare_prec_prec

(* ****** ****** *)

(*
// HX: it is exported mainly for pretty printing
*)
datatype fxty =
  | FXTYnon
  | FXTYinf of (prec, assoc)
  | FXTYpre of prec
  | FXTYpos of prec
// end of [fxty]

(* ****** ****** *)

fun fprint_fxty
  (out: FILEref, fxty: fxty): void
// end of [fprint_fxty]

fun prerr_fxty (fxty: fxty): void
fun print_fxty (fxty: fxty): void

(* ****** ****** *)

val fxty_non : fxty
fun fxty_inf (p: prec, a: assoc): fxty
fun fxty_pre (p: prec): fxty
fun fxty_pos (p: prec): fxty

(* ****** ****** *)

val deref_fxty_dyn : fxty // for dereference
val selptr_fxty_dyn : fxty // for lab/ind selection

(* ****** ****** *)

fun fxty_get_prec (fxty: fxty): Option_vt (prec)

(* ****** ****** *)

datatype
fxopr (a:type) = 
  | FXOPRinf(a) of (
      prec, assoc, (a, a) -<cloref1> fxitm a
    ) (* end of [FXOPRinf] *)
  | FXOPRpre(a) of (prec, a -<cloref1> fxitm a)
  | FXOPRpos(a) of (prec, a -<cloref1> fxitm a)
// end of [fxopr]
        
and fxitm (a:type) =
  FXITMatm(a) of a | FXITMopr(a) of (location, fxopr(a))
// end of [fxitm]

fun fxopr_precedence {a:type} (opr: fxopr a): prec
fun fxopr_associativity {a:type} (opr: fxopr a): assoc

(* ****** ****** *)

fun
fxitm_app
  {a:type}
(
  loc: location, app: (a, a) -<cloref1> fxitm a
) : fxitm a // end of [fxitm_app]

(* ****** ****** *)

fun
fxopr_make
  {a:type}
(
  locf: a -> location
, appf: (location, a, location, List a) -<cloref1> a
, oper: a, fxty: fxty
) : fxitm a // end of [fxopr_make]

fun
fxopr_make_backslash
  {a:type}
( // HX: for handling temp infix status
  locf: a -> location
, appf: (location, a, location, List a) -<cloref1> a
, loc0: location (* loc of [backslash] *)
) : fxitm a // end of [fxopr_make_backslash]

(* ****** ****** *)

fun
fixity_resolve
  {a:type}
(
  loc: location
, locf: a -> location, app: fxitm (a), xs: List (fxitm a)
) : (a) // end of [fixity_resolve]

(* ****** ****** *)

(* end of [pats_fixity.sats] *)

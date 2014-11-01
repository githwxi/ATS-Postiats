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

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_syntax.sats"
staload "./pats_staexp1.sats"

(* ****** ****** *)
//
fun
v1al_is_true (v: v1al): bool
fun
v1al_is_false (v: v1al): bool
//
fun v1al_is_err (v: v1al): bool // HX: V1ALerr or not
//
(* ****** ****** *)

datatype valerr =
  | VE_valize of (e1xp)
  | VE_valize_defined of (e1xp)
  | VE_valize_undefined of (e1xp)
  | VE_maxlevel of (int, e1xp)
  | VE_opr_arglst of (e1xp, symbol) // opertor cannot handle its arguments
  | VE_E1XPide_unbound of (e1xp)
  | VE_E1XPundef of (e1xp)
  | VE_E1XPlist of (e1xp) // tuple value is not supported
  | VE_E1XPapp_fun of (e1xp) // the [fun] part is not an identifier
  | VE_E1XPappid_fun of (e1xp, symbol) // the [fun] part is not an function
  | VE_E1XPappid_opr of (e1xp, symbol) // the [fun] part is some unrecognized opr
  | VE_E1XPappid_arity of (e1xp, symbol) // arity mismatch
  | VE_E1XPfun of (e1xp) // function value is not supported
  | VE_E1XPerr of (e1xp)
// end of [valerr]

(* ****** ****** *)
//
fun fprint_valerr : fprint_type (valerr)
//
fun the_valerrlst_add (x: valerr): void
fun fprint_the_valerrlst (out: FILEref): void
//
(* ****** ****** *)

fun e1xp_valize (e: e1xp): v1al
fun e1xp_valize_if (knd: srpifkind, e: e1xp): v1al

(* ****** ****** *)

fun e1xp_normalize (e: e1xp): e1xp

(* ****** ****** *)

(* end of [pats_e1xpval.sats] *)

(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: March, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

typedef
fprint_type (a: t@ype) = (FILEref, a) -> void

(* ****** ****** *)

fun test_boxkind (knd: int): bool
fun test_linkind (knd: int): bool
fun test_prfkind (knd: int): bool

(* ****** ****** *)

datatype
fxtykind =
  | FXK_infix
  | FXK_infixl
  | FXK_infixr
  | FXK_prefix
  | FXK_postfix
// end of [fxtykind]

datatype
caskind =
  | CK_case // case
  | CK_case_pos // case+
  | CK_case_neg // case-
// end of [caskind]

datatype
funkind =
  | FK_fun // recursive fun
  | FK_prfun // recursive proof fun
  | FK_praxi // proof axion
  | FK_castfn // casting fun
  | FK_fn // nonrec fun
  | FK_fnstar // tailrec fun
  | FK_prfn // nonrec proof fun
// end of [funkind]

fun funkind_is_proof (x: funkind): bool
fun funkind_is_recursive (x: funkind): bool
fun funkind_is_tailrecur (x: funkind): bool

datatype
valkind =
  | VK_val // val
  | VK_prval // prval
  | VK_val_pos // val+
  | VK_val_neg // val-
// end of [valkind]

fun valkind_is_proof (vk: valkind):<> bool

(* ****** ****** *)

datatype
dcstkind =
  | DCKfun of ()
  | DCKval of ()
  | DCKpraxi of ()
  | DCKprfun of ()
  | DCKprval of ()
  | DCKcastfn of ()
// end of [dcstkind]

fun dcstkind_is_fun (dck: dcstkind):<> bool
fun dcstkind_is_val (dck: dcstkind):<> bool
fun dcstkind_is_praxi (dck: dcstkind):<> bool
fun dcstkind_is_prfun (dck: dcstkind):<> bool
fun dcstkind_is_prval (dck: dcstkind):<> bool
fun dcstkind_is_proof (dck: dcstkind):<> bool
fun dcstkind_is_castfn (dck: dcstkind):<> bool

fun fprint_dcstkind : fprint_type (dcstkind)
overload fprint with fprint_dcstkind

(* ****** ****** *)

datatype
funclo = (* function or closure *)
  | FUNCLOclo of int(*knd*) (* closure: knd=1/0/~1: ptr/clo/ref *)
  | FUNCLOfun (* function *)
typedef funcloopt = Option funclo

#define CLOPTR ( 1)
#define CLOREF (~1)
macdef FUNCLOcloptr = FUNCLOclo (CLOPTR)
macdef FUNCLOcloref = FUNCLOclo (CLOREF)

fun fprint_funclo : fprint_type (funclo)
overload fprint with fprint_funclo

fun print_funclo (x: funclo): void
fun prerr_funclo (x: funclo): void

fun eq_funclo_funclo (fc1: funclo, fc2: funclo): bool 
overload = with eq_funclo_funclo

(* ****** ****** *)

(* end of [pats_basics.sats] *)

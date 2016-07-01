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
// Start Time: March, 2011
//
(* ****** ****** *)

typedef
fprint_type (a: t@ype) = (FILEref, a) -> void
typedef
fprint_vtype (a: viewt@ype) = (FILEref, !a) -> void

(* ****** ****** *)

val VIEWT0YPE_knd : int // = VIEWT0YPE_int

(* ****** ****** *)

fun test_fltkind (knd: int): bool // is flat?
fun test_boxkind (knd: int): bool // is boxed?
fun test_linkind (knd: int): bool // is linear?
fun test_prfkind (knd: int): bool // is proof?
fun test_prgmkind (knd: int): bool // is program?
fun test_polkind (knd: int): int // 0/1/-1

(* ****** ****** *)

fun impkind_linearize (knd: int): int
fun impkind_neutralize (knd: int): int

(* ****** ****** *)

fun lte_impkind_impkind (k1: int, k1: int): bool

(* ****** ****** *)

datatype
fxtykind =
  | FXK_infix
  | FXK_infixl
  | FXK_infixr
  | FXK_prefix
  | FXK_postfix
// end of [fxtykind]

(* ****** ****** *)

datatype
caskind =
  | CK_case // case
  | CK_case_pos // case+
  | CK_case_neg // case-
// end of [caskind]

fun fprint_caskind : fprint_type (caskind)

(* ****** ****** *)

datatype
funkind =
//
  | FK_fn // nonrec fun
  | FK_fnx // tailrec fun
  | FK_fun // recursive fun
//
  | FK_prfn // nonrec proof fun
  | FK_prfun // recursive proof fun
//
  | FK_praxi // proof axion
//
  | FK_castfn // casting fun
// end of [funkind]

fun funkind_is_proof (x: funkind): bool
fun funkind_is_recursive (x: funkind): bool
fun funkind_is_mutailrec (x: funkind): bool

fun fprint_funkind : fprint_type (funkind)

datatype
valkind =
  | VK_val // val
  | VK_val_pos // val+
  | VK_val_neg // val-
(*
  | VK_mcval // mcval: for model-checking
*)
  | VK_prval // prval: for theorem-proving
// end of [valkind]

(* ****** ****** *)

fun
valkind_is_model (vk: valkind):<> bool
fun
valkind_is_proof (vk: valkind):<> bool

fun fprint_valkind : fprint_type (valkind)

fun valkind2caskind (knd: valkind): caskind

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

(* ****** ****** *)

datatype
funclo =
//
// function or closure
//
  | FUNCLOfun (* function *)
  | FUNCLOclo of int (*knd*) // closure: knd=1/0/~1: ptr/clo/ref
//
(* ****** ****** *)
//
typedef fcopt = Option (funclo)
vtypedef fcopt_vt = Option_vt (funclo)
//
(* ****** ****** *)

#define CLOPTR ( 1)
#define CLOREF (~1)
macdef FUNCLOcloptr = FUNCLOclo (CLOPTR)
macdef FUNCLOcloref = FUNCLOclo (CLOREF)

(* ****** ****** *)

fun funclo_is_clo (fc: funclo): bool
fun funclo_is_ptr (fc: funclo): bool
fun funclo_is_cloptr (fc: funclo): bool

fun print_funclo (x: funclo): void
fun prerr_funclo (x: funclo): void
fun fprint_funclo : fprint_type (funclo)

fun eq_funclo_funclo (fc1: funclo, fc2: funclo): bool 
overload = with eq_funclo_funclo
fun neq_funclo_funclo (fc1: funclo, fc2: funclo): bool 
overload != with neq_funclo_funclo

(* ****** ****** *)
//
// HX: implemented in pats_basics.dats
//
fun
debug_flag_get
  ((*void*)): int = "patsopt_debug_flag_get"
fun
debug_flag_set
  (flag: int): void = "patsopt_debug_flag_set"
//
fun
prerrf_ifdebug
  {ts:types}
(
  fmt: printf_c ts, arg: ts
) : void = "patsopt_prerrf_ifdebug"
//
macdef
filprerr_ifdebug (x) =
  prerrf_ifdebug (": [%s]: %s", @(#FILENAME, ,(x)))
//
(* ****** ****** *)
//
#define
PATS_MAJOR_VERSION 0
#define
PATS_MINOR_VERSION 2
#define
PATS_MICRO_VERSION 9
//
// HX-2011-04-27: this is supported in Postiats:
//
macdef
PATS_fVER(MAJOR, MINOR, MICRO) =
  (1000 * (1000 * ,(MAJOR) + ,(MINOR)) + ,(MICRO))
//
macdef
PATS_VERSION() =
  PATS_fVER(PATS_MAJOR_VERSION, PATS_MINOR_VERSION, PATS_MICRO_VERSION)
//
(* ****** ****** *)

(* end of [pats_basics.sats] *)

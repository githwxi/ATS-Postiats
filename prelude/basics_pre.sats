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

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_pre.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)
//
// HX:
// some built-in static boolean constants
//
stacst true_bool : bool and false_bool : bool
stadef true = true_bool and false = false_bool
//
stacst neg_bool
  : bool -> bool (* boolean negation *)
stadef ~ = neg_bool // overloaded
//
stacst add_bool_bool
  : (bool, bool) -> bool (* disjunction *)
stacst mul_bool_bool
  : (bool, bool) -> bool (* conjunction *)
stadef || = add_bool_bool
stadef && = mul_bool_bool
//
stacst lt_bool_bool : (bool, bool) -> bool
stacst lte_bool_bool : (bool, bool) -> bool
stacst gt_bool_bool : (bool, bool) -> bool
stacst gte_bool_bool : (bool, bool) -> bool
stadef < = lt_bool_bool
stadef <= = lte_bool_bool
stadef > = gt_bool_bool
stadef >= = gte_bool_bool
//
stacst eq_bool_bool : (bool, bool) -> bool
stacst neq_bool_bool : (bool, bool) -> bool
stadef == = eq_bool_bool
stadef != = neq_bool_bool
stadef <> = neq_bool_bool // backward compatibility
//
(* ****** ****** *)

stacst neg_int : (int) -> int
stadef ~ = neg_int // overloaded

stacst add_int_int : (int, int) -> int
stacst sub_int_int : (int, int) -> int
stacst mul_int_int : (int, int) -> int
stacst div_int_int : (int, int) -> int
stadef + = add_int_int
stadef - = sub_int_int
stadef * = sub_int_int
stadef / = sub_int_int

stacst lt_int_int : (int, int) -> bool
stacst lte_int_int : (int, int) -> bool
stacst gt_int_int : (int, int) -> bool
stacst gte_int_int : (int, int) -> bool
stadef < = lt_int_int and <= = lte_int_int
stadef > = gt_int_int and >= = gte_int_int

stacst eq_int_int : (int, int) -> bool
stacst neq_int_int : (int, int) -> bool
stadef == = eq_int_int
stadef != = neq_int_int
stadef <> = neq_int_int // backward compatibility

(* ****** ****** *)

stacst null_addr : addr
stadef null = null_addr
stadef NULL = null_addr

stacst add_addr_int : (addr, int) -> addr
stacst sub_addr_int : (addr, int) -> addr
stadef + = add_addr_int
stadef - = sub_addr_int

stacst lt_addr_addr : (addr, addr) -> bool
stacst lte_addr_addr : (addr, addr) -> bool
stadef < = lt_addr_addr
stadef <= = lte_addr_addr

stacst gt_addr_addr : (addr, addr) -> bool
stacst gte_addr_addr : (addr, addr) -> bool
stadef > = gt_addr_addr
stadef >= = gte_addr_addr

stacst eq_addr_addr : (addr, addr) -> bool
stacst neq_addr_addr : (addr, addr) -> bool
stadef == = eq_addr_addr
stadef != = neq_addr_addr and <> = neq_addr_addr

(* ****** ****** *)

stacst // HX: this is a special constant!
sizeof_viewt0ype_int : (viewt@ype) -> int
stadef sizeof = sizeof_viewt0ype_int

(* ****** ****** *)

sortdef nat = { i: int | i >= 0 } // natural numbers
sortdef pos = { i: int | i > 0 }
sortdef neg = { i: int | i < 0 }
sortdef npos = { i: int | i <= 0 } // non-positive integers

sortdef nat1 = { n: nat | n < 1 } // for 0
sortdef nat2 = { n: nat | n < 2 } // for 0, 1
sortdef nat3 = { n: nat | n < 3 } // for 0, 1, 2
sortdef nat4 = { n: nat | n < 4 } // for 0, 1, 2, 3

sortdef sgn = { i:int | ~1 <= i; i <= 1 }

sortdef agz = { l: addr | l > null }
sortdef agez = { l: addr | l >= null }

(* ****** ****** *)

#define CHAR_MAX 127
#define CHAR_MIN ~128
#define UCHAR_MAX 0xFF

(* ****** ****** *)
//
// HX: some overloaded symbols
//
symintr ~ not
symintr && || << >> land lor lxor
symintr + - * / mod gcd
symintr < <= > >= = <> !=
symintr succ pred
symintr abs square sqrt cube cbrt
symintr compare max min pow
symintr foreach // foreach without index
symintr iforeach (* foreach with index *)
symintr fprint print prerr
symintr length (* array_length, list_length, string_length, etc. *)
symintr ofstring ofstrptr
symintr tostring tostrptr
symintr encode decode
//
(* ****** ****** *)

absview // S2Eat
at_viewt0ype_addr_view (viewt@ype+, addr)
stadef @ = at_viewt0ype_addr_view // HX: @ is infix

(* ****** ****** *)

absviewt@ype
clo_viewt0ype_viewt0ype (a: viewt@ype) = a
absviewtype
cloptr_viewt0ype_viewtype (a: viewt@ype) // = ptr
absviewtype cloref_t0ype_type (a: t@ype) // = ptr

(* ****** ****** *)

absviewt@ype
READ_viewt0ype_int_viewt0ype
  (a: viewt@ype+, stamp:int) = a
stadef READ = READ_viewt0ype_int_viewt0ype
viewtypedef READ (a:viewt@ype) = [s:int] READ (a, s)

(* ****** ****** *)

viewtypedef SHARED (a:viewt@ype) = a // HX: used as a comment

(* ****** ****** *)

(*
absviewt@ype // S2Etyvarknd
tyvarknd (a:viewt@ype, knd: int) = a
viewtypedef IN (a:viewt@ype) = tyvarknd (a, 1) // both CO and CONTRA
viewtypedef CO (a:viewt@ype) = tyvarknd (a, 2) // T <= X => T = X
viewtypedef CONTRA (a:viewt@ype) = tyvarknd (a, 3) // X <= T => T = X
*)

absviewt@ype // S2Einvar
invar_viewt0ype_viewt0ype (a:viewt@ype) = a
viewtypedef IN (a:viewt@ype) = invar_viewt0ype_viewt0ype (a)

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_pre.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_pre.sats] *)

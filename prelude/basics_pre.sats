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
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2011
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
stadef + = add_bool_bool and * = mul_bool_bool
stadef || = add_bool_bool and && = mul_bool_bool
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
stadef <> = neq_bool_bool // backward compatibility // deprecated
//
(* ****** ****** *)

(*
//
// HX-2012-06-12: removed
//
stacst eq_char_char : (char, char) -> bool
stacst neq_char_char : (char, char) -> bool
stadef == = eq_char_char
stadef != = neq_char_char
stadef <> = neq_char_char // backward compatibility // deprecated
*)

(* ****** ****** *)

stacst neg_int : (int) -> int
stadef ~ = neg_int // overloaded

stacst add_int_int : (int, int) -> int
stacst sub_int_int : (int, int) -> int
stacst mul_int_int : (int, int) -> int
stacst div_int_int : (int, int) -> int
stadef + = add_int_int
stadef - = sub_int_int
stadef * = mul_int_int
stadef / = div_int_int

stacst ndiv_int_int : (int, int) -> int
stadef ndiv = ndiv_int_int
stacst idiv_int_int : (int, int) -> int // HX: alias for div_int_int
stadef idiv = idiv_int_int

stadef mod_int_int
  (x:int, y:int) = x - y * (x \ndiv_int_int y)
stadef mod = mod_int_int
stadef % (*adopted from C*) = mod_int_int

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
//
stacst abs_int : (int) -> int
stadef abs = abs_int
stadef absrel_int_int
  (x: int, v: int): bool =
  (x >= 0 && x == v) || (x <= 0 && ~x == v)
stadef absrel = absrel_int_int
//
stacst sgn_int : (int) -> int
stadef sgn = sgn_int
stadef sgnrel_int_int
  (x: int, v: int): bool =
  (x > 0 && v==1) || (x==0 && v==0) || (x < 0 && v==(~1))
stadef sgnrel = sgnrel_int_int
//
stacst max_int_int : (int, int) -> int
stadef max = max_int_int
stacst min_int_int : (int, int) -> int
stadef min = min_int_int
stadef maxrel_int_int_int
  (x: int, y: int, v: int): bool =
  (x >= y && x == v) || (x <= y && y == v)
stadef maxrel = maxrel_int_int_int
stadef minrel_int_int_int
  (x: int, y: int, v: int): bool =
  (x >= y && y == v) || (x <= y && x == v)
stadef minrel = minrel_int_int_int
//
stadef nsub (x:int, y:int) = max (x-y, 0)
//
stadef
ndivrel_int_int_int // HX: y > 0
  (x: int, y: int, q: int): bool =
  (q * y <= x) && (x < q * y + y)
stadef ndivrel = ndivrel_int_int_int
//
stadef
idivrel_int_int_int
  (x: int, y: int, q: int) = ( // HX: y != 0
  x >= 0 && y > 0 && ndivrel_int_int_int ( x,  y,  q)
) || (
  x >= 0 && y < 0 && ndivrel_int_int_int ( x, ~y, ~q)
) || (
  x <  0 && y > 0 && ndivrel_int_int_int (~x,  y, ~q)
) || (
  x <  0 && y < 0 && ndivrel_int_int_int (~x, ~y,  q)
) // end of [idivrel_int_int_int]
//
stadef idivrel = idivrel_int_int_int
//
stadef
divmodrel_int_int_int_int
  (x: int, y: int, q: int, r: int) : bool =
  (0 <= r && r < y && x == q*y + r)
stadef divmodrel = divmodrel_int_int_int_int
//
(* ****** ****** *)

stacst
ifint_bool_int_int
  : (bool, int, int) -> int
stadef ifint = ifint_bool_int_int
stadef
ifintrel_bool_int_int_int
  (b:bool, x:int, y:int, r:int): bool =
  (b && r==x) || (~b && r==y)
// end of [ifintrel]

(* ****** ****** *)

stadef
bool2int (b: bool): int = ifint (b, 1, 0)
stadef int2bool (i: int): bool = (i != 0)
stadef b2i = bool2int and i2b = int2bool

(*
** HX: [char] = [int8]
** HX-2012-06-12: removed
//
stacst int_of_char: char -> int
stadef c2i = int_of_char
stacst char_of_int : int -> char
stadef i2c = char_of_int
//
*)

stacst int_of_addr : addr -> int
stacst addr_of_int : int -> addr
stadef a2i = int_of_addr
stadef i2a = addr_of_int

(* ****** ****** *)

stadef pow2_7 = 128
stadef pow2_8 = 256
stadef i2u_int8 (i:int) = ifint (i >= 0, i, i+pow2_8)
stadef i2u8 = i2u_int8
stadef u2i_int8 (u:int) = ifint (u < pow2_7, u, u-pow2_8)
stadef u2i8 = u2i_int8
//
stadef pow2_15 = 32768
stadef pow2_16 = 65536
stadef i2u_int16 (i:int) = ifint (i >= 0, i, i+pow2_16)
stadef i2u8 = i2u_int16
stadef u2i_int16 (u:int) = ifint (u < pow2_15, u, u-pow2_16)
stadef u2i8 = u2i_int16

(* ****** ****** *)

stacst null_addr : addr
stadef null = null_addr
stadef NULL = null_addr

stacst add_addr_int : (addr, int) -> addr
stacst sub_addr_int : (addr, int) -> addr
stacst sub_addr_addr : (addr, addr) -> int
stadef + = add_addr_int
stadef - = sub_addr_int
stadef - = sub_addr_addr

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
//
// HX-2013-09:
// for supporting inheritance in OOP
//
stacst lte_cls_cls : (cls, cls) -> bool
stacst gte_cls_cls : (cls, cls) -> bool
stadef lterel_cls_cls (c1: cls, c2: cls, v: bool): bool = v
stadef gterel_cls_cls (c1: cls, c2: cls, v: bool): bool = v
stadef <= = lte_cls_cls
stadef >= = gte_cls_cls

(* ****** ****** *)
//
// HX: this is a special constant!
//
stacst
sizeof_t0ype_int : t@ype -> int
stadef
sizeof (a:viewt@ype): int = sizeof_t0ype_int (a?)
//
(* ****** ****** *)

sortdef nat = { i:int | i >= 0 } // natural numbers
sortdef pos = { i:int | i > 0 }
sortdef neg = { i:int | i < 0 }
sortdef npos = { i:int | i <= 0 } // non-positive integers

sortdef nat1 = { n:nat | n < 1 } // for 0
sortdef nat2 = { n:nat | n < 2 } // for 0, 1
sortdef nat3 = { n:nat | n < 3 } // for 0, 1, 2
sortdef nat4 = { n:nat | n < 4 } // for 0, 1, 2, 3

sortdef sgn = { i:int | ~1 <= i; i <= 1 }

sortdef agz = { l:addr | l > null }
sortdef agez = { l:addr | l >= null }
sortdef alez = { l:addr | l <= null }

(* ****** ****** *)

#define CHAR_MAX 127
#define CHAR_MIN ~128
#define UCHAR_MAX 0xFF

(* ****** ****** *)
//
stacst effnil : eff // nothing
stacst effall : eff // everything
//
stacst effntm : eff // nonterm
stacst effexn : eff // exception
stacst effref : eff // reference
stacst effwrt : eff // writeover
//
stacst add_eff_eff : (eff, eff) -> eff
stadef + = add_eff_eff // union of effsets
stacst sub_eff_eff : (eff, eff) -> eff
stadef - = add_eff_eff // difference of effsets
//
(* ****** ****** *)
//
// HX: some overloaded symbols
//
symintr ~ not
symintr && || << >>
symintr lor lxor land
symintr + - * / mod ndiv nmod
symintr < <= > >= = != <> compare
symintr isltz isltez isgtz isgtez iseqz isneqz
symintr neg abs max min
symintr succ pred half double
symintr square sqrt cube cbrt pow
//
symintr [] // for subscripting
//
symintr inc dec
symintr ++ -- // inc and dec
symintr get set exch
symintr getinc setinc exchinc
symintr decget decset decexch
symintr !++ --! // getinc and decget
symintr =++ --= // setinc and decset
//
symintr assert
//
symintr encode decode
//
symintr g0ofg1 g1ofg0 // casting: dpt <-> ndpt
symintr ptrcast (* for functions taking the address of a boxed val *)
//
symintr copylin
symintr freelin (* strptr_free, strnptr_free, list_vt_freelin, ... *)
//
symintr fprint print prerr
symintr length (* array_length, list_length, string_length, etc. *)
(*
symintr foreach iforeach rforeach
*)
//
symintr ofstring ofstrptr
symintr tostring tostrptr
//
(* ****** ****** *)
//
// HX-2012-05-23: for template args
//
abstype atstkind_type (tk: tkind)
abst@ype atstkind_t0ype (tk: tkind)
//
typedef
tkind_type (tk:tkind) = atstkind_type (tk)
typedef
tkind_t0ype (tk:tkind) = atstkind_t0ype (tk)
//
(* ****** ****** *)

absview // S2Eat
at_vt0ype_addr_view (vt@ype+, addr)
stadef @ = at_vt0ype_addr_view // HX: @ is infix

(* ****** ****** *)
//
absvt@ype
clo_t0ype_t0ype (a: t@ype) = a
absvt@ype
clo_vt0ype_vt0ype (a: vt@ype) = a
//
(* ****** ****** *)

(*
absview
read_view_int_int_view
  (v:view, stamp:int, n:int)
stadef READ = read_view_int_int_view
viewdef READ (v:view) = [s,n:int] READ (v, s, n)
stadef RD = READ
//
absview
readout_view_int_view (v:view, stamp:int)
stadef READOUT = readout_view_int_view
viewdef READOUT (v:view) = [s:int] READOUT (v, s)
//
absvt@ype
read_vt0ype_int_int_vt0ype
  (a:vt@ype, stamp:int, n:int) = a
stadef READ = read_vt0ype_int_int_vt0ype
vtypedef READ (a:vt@ype) = [s,n:int] READ (a, s, n)
stadef RD = READ
//
absvt@ype
readout_vt0ype_int_vt0ype (a:vt@ype, stamp: int) = a
stadef READOUT = readout_vt0ype_int_vt0ype
vtypedef READOUT (a:vt@ype) = [s:int] READOUT (a, s)
*)

(* ****** ****** *)

(*
absvt@ype
write_vt0ype_vt0ype (a: vt@ype) = a
vtypedef
WRITE (a:vt@ype) = write_vt0ype_vt0ype (a)
stadef WRT = WRITE
*)

(* ****** ****** *)
//
vtypedef READ (a:vt@ype) = a // HX: used as a comment
vtypedef WRITE (a:vt@ype) = a // HX: used as a comment (rarely)
//
(*
vtypedef SHARED (a:vt@ype) = a // HX: used as a comment
vtypedef NSHARED (a:vt@ype) = a // HX: used as a comment (rarely)
*)
//
(* ****** ****** *)
//
absprop invar_prop_prop (a:prop)
absview invar_view_view (a:view)
//
abst@ype // S2Einvar
invar_t0ype_t0ype (a:t@ype) = a
absvt@ype // S2Einvar
invar_vt0ype_vt0ype (a:vt@ype) = a
//
// HX: this order is significant
// 
viewdef INV (a:view) = invar_view_view (a)
propdef INV (a:prop) = invar_prop_prop (a)
vtypedef INV
  (a:vt@ype) = invar_vt0ype_vt0ype (a)
vtypedef INV (a:t@ype) = invar_t0ype_t0ype (a)
//
(* ****** ****** *)
(*
//
absprop optarg_prop_prop (a:prop)
absview optarg_view_view (a:view)
//
abst@ype
optarg_t0ype_t0ype (a:t@ype) = a
absvt@ype
optarg_vt0ype_vt0ype (a:vt@ype) = a
//
// HX: this order is significant
// 
viewdef OPT (a:view) = optarg_view_view (a)
propdef OPT (a:prop) = optarg_prop_prop (a)
vtypedef OPT
  (a:vt@ype) = optarg_vt0ype_vt0ype (a)
vtypedef OPT (a:t@ype) = optarg_t0ype_t0ype (a)
//
*)
(* ****** ****** *)
//
abst@ype
stamped_t0ype (a:t@ype, int) = a
stadef stamped_t = stamped_t0ype
//
absvt@ype
stamped_vt0ype (a:vt@ype, int) = a
stadef stamped_vt = stamped_vt0ype
//
(* ****** ****** *)
//
absview
vcopyenv_view_view (v:view)
stadef vcopyenv_v = vcopyenv_view_view
absvt@ype
vcopyenv_vt0ype_vt0ype (vt: vt0ype) = vt
stadef vcopyenv_vt = vcopyenv_vt0ype_vt0ype
//
(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_pre.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_pre.sats] *)

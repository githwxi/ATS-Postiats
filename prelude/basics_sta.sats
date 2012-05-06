(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
#print "Loading [basics_sta.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

abst@ype
bool_t0ype = $extype "atstype_bool"
stadef bool = bool_t0ype
abst@ype
bool_bool_t0ype (b: bool) = bool_t0ype
stadef bool = bool_bool_t0ype
//
typedef Bool = [b:bool] bool (b)
//
(* ****** ****** *)

abst@ype
byte_t0ype = $extype "atstype_byte"
stadef byte = byte_t0ype

(* ****** ****** *)
//
// char is signed
//
sortdef int8 = {
  i:int | ~128 <= i; i < 128
} // end of [int8]
sortdef uint8 =
  {i:int | 0 <= i; i < 256}
// end of [uint8]
abst@ype char_t0ype = $extype"atstype_char"
abst@ype char_int_t0ype (c:int) = char_t0ype
stadef char = char_t0ype
stadef char = char_int_t0ype
typedef Char = [c:int8] char (c)
//
// signed characters
//
abst@ype schar_t0ype = $extype"atstype_schar"
abst@ype schar_int_t0ype (c:int) = schar_t0ype
stadef schar = schar_t0ype
stadef schar = schar_int_t0ype
typedef sChar = [c:int8] schar (c)
//
// unsigned characters
//
abst@ype uchar_t0ype = $extype"atstype_uchar"
abst@ype uchar_int_t0ype (c:int) = uchar_t0ype
stadef uchar = uchar_t0ype
stadef uchar = uchar_int_t0ype
typedef uChar = [c:uint8] uchar (c)
//
(* ****** ****** *)

abst@ype
g0int_t0ype (a:t@ype) = a
stadef g0int = g0int_t0ype
abst@ype
g1int_int_t0ype (a:t@ype, int) = g0int (a)
stadef g1int = g1int_int_t0ype
typedef g1int (a:t@ype) = [i:int] g1int (a, i)

typedef g1intLt
  (knd:t@ype, n:int) = [i:int | i < n] g1int (knd, i)
typedef g1intLte
  (knd:t@ype, n:int) = [i:int | i <= n] g1int (knd, i)
typedef g1intGt
  (knd:t@ype, n:int) = [i:int | i > n] g1int (knd, i)
typedef g1intGte
  (knd:t@ype, n:int) = [i:int | i >= n] g1int (knd, i)
typedef g1intBtw
  (knd:t@ype, lb:int, ub:int) = [i: int | lb <= i; i < ub] g1int (knd, i)
typedef g1intBtwe
  (knd: t@ype, lb:int, ub:int) = [i: int | lb <= i; i <= ub] g1int (knd, i)

(* ****** ****** *)

abst@ype
g0uint_t0ype (a:t@ype) = a
stadef g0uint = g0uint_t0ype
abst@ype
g1uint_int_t0ype (a:t@ype, int) = g0uint (a)
stadef g1uint = g1uint_int_t0ype
typedef g1uint (a:t@ype) = [i:nat] g1uint (a, i)

typedef g1uintLt
  (knd:t@ype, n:int) = [i:nat | i < n] g1uint (knd, i)
typedef g1uintLte
  (knd:t@ype, n:int) = [i:nat | i <= n] g1uint (knd, i)
typedef g1uintGt
  (knd:t@ype, n:int) = [i:int | i > n] g1uint (knd, i)
typedef g1uintGte
  (knd:t@ype, n:int) = [i:int | i >= n] g1uint (knd, i)
typedef g1uintBtw
  (knd:t@ype, lb:int, ub:int) = [i: int | lb <= i; i < ub] g1uint (knd, i)
typedef g1uintBtwe
  (knd: t@ype, lb:int, ub:int) = [i: int | lb <= i; i <= ub] g1uint (knd, i)

(* ****** ****** *)
//
abst@ype
int_kind = $extype"atstype_int"
//
typedef int0 = g0int (int_kind)
typedef int1 (i:int) = g1int (int_kind, i)
stadef int = int0
stadef int = int1
//
typedef Int = [i:int] int1 (i)
typedef Nat = [i:int | i >= 0] int1 (i)
//
typedef intLt (n:int) = g1intLt (int_kind, n)
typedef intLte (n:int) = g1intLte (int_kind, n)
typedef intGt (n:int) = g1intGt (int_kind, n)
typedef intGte (n:int) = g1intGte (int_kind, n)
typedef intBtw (lb:int, ub:int) = g1intBtw (int_kind, lb, ub)
typedef intBtwe (lb:int, ub:int) = g1intBtwe (int_kind, lb, ub)
//
typedef Two = intBtw (0, 2)
typedef Sgn = intBtwe (~1, 1)
//
typedef natLt (n:int) = intBtw (0, n)
typedef natLte (n:int) = intBtwe (0, n)
//
typedef uint0 = g0uint (int_kind)
typedef uint1 (n:int) = g1uint (int_kind, n)
stadef uint = uint0
stadef uint = uint1
stadef uInt = [n:int] uint1 (n)
//
typedef uintLt (n:int) = g1uintLt (int_kind, n)
typedef uintLte (n:int) = g1uintLte (int_kind, n)
typedef uintGt (n:int) = g1uintGt (int_kind, n)
typedef uintGte (n:int) = g1uintGte (int_kind, n)
typedef uintBtw (lb:int, ub:int) = g1uintBtw (int_kind, lb, ub)
typedef uintBtwe (lb:int, ub:int) = g1uintBtwe (int_kind, lb, ub)
//
(* ****** ****** *)

abst@ype
lint_kind = $extype"atstype_lint"
typedef lint0 = g0int (lint_kind)
typedef lint1 (i:int) = g1int (lint_kind, i)
stadef lint = lint0
stadef lint = lint1
typedef ulint0 = g0uint (lint_kind)
typedef ulint1 (i:int) = g1uint (lint_kind, i)
stadef ulint = ulint0
stadef ulint = ulint1

abst@ype
llint_kind = $extype"atstype_llint"
typedef llint0 = g0int (llint_kind)
typedef llint1 (i:int) = g1int (llint_kind, i)
stadef llint = llint0
stadef llint = llint1
typedef ullint0 = g0uint (llint_kind)
typedef ullint1 (i:int) = g1uint (llint_kind, i)
stadef ullint = ullint0
stadef ullint = ullint1

abst@ype
sint_kind = $extype"atstype_sint"
typedef sint0 = g0int (sint_kind)
typedef sint1 (i:int) = g1int (sint_kind, i)
stadef sint = sint0
stadef sint = sint1
typedef usint0 = g0uint (sint_kind)
typedef usint1 (i:int) = g1uint (sint_kind, i)
stadef usint = usint0
stadef usint = usint1

abst@ype
ssint_kind = $extype"atstype_ssint"
typedef ssint0 = g0int (ssint_kind)
typedef ssint1 (i:int) = g1int (ssint_kind, i)
stadef ssint = ssint0
stadef ssint = ssint1
typedef ussint0 = g0uint (ssint_kind)
typedef ussint1 (i:int) = g1uint (ssint_kind, i)
stadef ussint = ussint0
stadef ussint = ussint1

(* ****** ****** *)

abst@ype
size_kind = $extype"atstype_size"
//
typedef size0_t = g0uint (size_kind)
stadef size_t = size0_t
typedef size1_t (i:int) = g1uint (size_kind, i)
stadef size_t = size1_t
//
typedef Size =
  [i:int | i >= 0] g1uint (size_kind, i)
typedef sizeLt
  (n: int) = [i:int | 0 <= i; i < n] g1uint (size_kind, i)
typedef sizeLte
  (n: int) = [i:int | 0 <= i; i <= n] g1uint (size_kind, i)
typedef sizeGt
  (n: int) = [i:int | i > n] g1uint (size_kind, i)
typedef sizeGte
  (n: int) = [i:int | i >= n] g1uint (size_kind, i)
typedef sizeBtw
  (lb:int, ub:int) = [i: int | lb <= i; i < ub] g1uint (size_kind, i)
typedef sizeBtwe
  (lb:int, ub:int) = [i: int | lb <= i; i <= ub] g1uint (size_kind, i)
//
typedef ssize0_t = g0int (size_kind)
stadef ssize_t = ssize0_t
typedef ssize1_t (i:int) = g1int (size_kind , i) 
stadef ssize_t = ssize1_t

typedef
sizeof_t (a:viewt@ype) = size_t (sizeof(a?))

(* ****** ****** *)

abst@ype
int8_kind = $extype"atstype_int8"
//
typedef int8_0 = g0int (int_kind)
typedef int8_1 (i:int) = g1int (int8_kind, i)
stadef int8 = int8_0
stadef int8 = int8_1
stadef Int8 = [i:int] int8_1 (i)
//
typedef uint8_0 = g0uint (int_kind)
typedef uint8_1 (i:int) = g1uint (int8_kind, i)
stadef uint8 = uint8_0
stadef uint8 = uint8_1
stadef uInt8 = [i:nat] uint8_1 (i)

(* ****** ****** *)

abst@ype
int16_kind = $extype"atstype_int16"
//
typedef int16_0 = g0int (int16_kind)
typedef int16_1 (i:int) = g1int (int16_kind, i)
stadef int16 = int16_0
stadef int16 = int16_1
stadef Int16 = [i:int] int16_1 (i)
//
typedef uint16_0 = g0uint (int16_kind)
typedef uint16_1 (i:int) = g1uint (int16_kind, i)
stadef uint16 = uint16_0
stadef uint16 = uint16_1
stadef uInt16 = [i:nat] uint16_1 (i)

(* ****** ****** *)

abst@ype
int32_kind = $extype"atstype_int32"
//
typedef int32_0 = g0int (int32_kind)
typedef int32_1 (i:int) = g1int (int32_kind, i)
stadef int32 = int32_0
stadef int32 = int32_1
stadef Int32 = [i:int] int32_1 (i)
//
typedef uint32_0 = g0uint (int32_kind)
typedef uint32_1 (i:int) = g1uint (int32_kind, i)
stadef uint32 = uint32_0
stadef uint32 = uint32_1
stadef uInt32 = [i:nat] uint32_1 (i)

(* ****** ****** *)

abst@ype
int64_kind = $extype"atstype_int64"
//
typedef int64_0 = g0int (int64_kind)
typedef int64_1 (i:int) = g1int (int64_kind, i)
stadef int64 = int64_0
stadef int64 = int64_1
stadef Int64 = [i:int] int64_1 (i)
//
typedef uint64_0 = g0uint (int64_kind)
typedef uint64_1 (i:int) = g1uint (int64_kind, i)
stadef uint64 = uint64_0
stadef uint64 = uint64_1
stadef uInt64 = [i:nat] uint64_1 (i)

(* ****** ****** *)
//
abst@ype
g0float_t0ype (a:t@ype) = a
stadef g0float = g0float_t0ype
//
abst@ype
float_kind = $extype"atstype_float"
typedef float = g0float (float_kind)
//
abst@ype
double_kind = $extype"atstype_double"
typedef double = g0float (double_kind)
//
abst@ype
ldouble_kind = $extype"atstype_ldouble"
typedef ldouble = g0float (ldouble_kind)
//
(* ****** ****** *)
//
// HX: unindexed type for pointers
//
abstype
ptr_type = $extype"atstype_ptr"
stadef ptr = ptr_type
abstype
ptr_addr_type (l:addr) = ptr_type
stadef ptr = ptr_addr_type
typedef Ptr0 = [l:addr] ptr (l)
typedef Ptr1 = [l:addr | l > null] ptr (l)
//
// HX-2012-02-14: it is an expriment for now:
//
stadef ptr (n:int) = ptr_addr_type (addr_of_int(n))
//
(* ****** ****** *)

(*
** HX: persistent read-only strings
*)
abstype string_type
stadef string = string_type
abstype string_int_type (n: int)
stadef string = string_int_type

abstype
stropt_int_type (n:int)
stadef stropt = stropt_int_type
abstype stropt_type = [n:int] stropt (n)

(*
** HX: linear strings that are modifiable 
*)
absviewtype
strptr_addr_viewtype (l:addr)
stadef strptr = strptr_addr_viewtype
viewtypedef strptr0 = [l:addr] strptr (l)
viewtypedef strptr1 = [l:addr | l > null] strptr (l)
absviewtype
strnptr_addr_int_viewtype (l:addr, n:int)
stadef strnptr = strnptr_addr_int_viewtype
viewtypedef strnptr (n:int) = [l:addr] strnptr (l, n)

(* ****** ****** *)

abst@ype void_t0ype
stadef void = void_t0ype

(* ****** ****** *)

absviewtype exception_viewtype
viewtypedef exn = exception_viewtype

(* ****** ****** *)

absviewt@ype
opt_viewt0ype_bool_viewt0ype
  (a:viewt@ype+, opt:bool) = a
stadef opt = opt_viewt0ype_bool_viewt0ype

(* ****** ****** *)

typedef bytes (n:int) = @[byte][n]
typedef b0ytes (n:int) = @[byte?][n]

(* ****** ****** *)

abst@ype strbuf (m:int, n:int) // [m] bytesz

(* ****** ****** *)

absviewt@ype
arrsz_viewt0ype_int_viewt0ype
  (a:viewt@ype+, n:int) = (ptr, size_t)
// end of [arrsz_viewt0ype_int_viewt0ype]
stadef arrsz = arrsz_viewt0ype_int_viewt0ype

(* ****** ****** *)

absprop
vbox_view_prop
  (v:view) // [vbox] is invariant!
stadef vbox = vbox_view_prop

abstype
ref_viewt0ype_type
  (a:viewt@ype) // [ref] is invariant!
stadef ref = ref_viewt0ype_type

(* ****** ****** *)

viewtypedef
bottom_viewt0ype_uni = {a:viewt@ype} a
viewtypedef
bottom_viewt0ype_exi = [a:viewt@ype | false] a

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_sta.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_sta.sats] *)

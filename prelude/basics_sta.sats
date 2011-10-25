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
#print "Loading [basics_sta.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

abst@ype
bool_t0ype = $extype "atstype_bool"
stadef bool = bool_t0ype
abst@ype
bool_bool_t0ype (b: bool) = bool_t0ype
stadef bool = bool_bool_t0ype

(* ****** ****** *)

abst@ype
byte_t0ype = $extype "atstype_byte"
stadef byte = byte_t0ype

(* ****** ****** *)

abst@ype
g0char_t0ype (a:t@ype) = a
stadef g0char = g0char_t0ype

abst@ype
g1char_t0ype_int (a:t@ype, int) = g0char (a)
stadef g1char = g1char_t0ype_int
typedef g1char (a:t@ype) = [i:int] g1char (a, i)

abst@ype
g0uchar_t0ype (a:t@ype) = a
stadef g0uchar = g0uchar_t0ype

abst@ype
g1uchar_t0ype_int (a:t@ype, int) = g0uchar (a)
stadef g1uchar = g1uchar_t0ype_int
typedef g1uchar (a:t@ype) = [i:nat] g1uchar (a, i)

(* ****** ****** *)

abst@ype
charknd = $extype"atstype_char"
typedef char0 = g0char (charknd)
typedef char1 (i:int) = g1char (charknd, i)
stadef char = char0 and char = char1

abst@ype
ucharknd = $extype"atstype_uchar"
typedef uchar0 = g0uchar (ucharknd)
typedef uchar1 (i:int) = g1uchar (ucharknd, i)
stadef uchar = uchar0 and uchar = uchar1

(* ****** ****** *)

abst@ype
g0int_t0ype (a:t@ype) = a
stadef g0int = g0int_t0ype
abst@ype
g1int_t0ype_int (a:t@ype, int) = g0int (a)
stadef g1int = g1int_t0ype_int
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
g1uint_t0ype_int (a:t@ype, int) = g0uint (a)
stadef g1uint = g1uint_t0ype_int
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
intknd = $extype"atstype_int"
//
typedef int0 = g0int (intknd)
typedef int1 (i:int) = g1int (intknd, i)
stadef int = int0 and int = int1
typedef intLt (n:int) = g1intLt (intknd, n)
typedef intLte (n:int) = g1intLte (intknd, n)
typedef intGt (n:int) = g1intGt (intknd, n)
typedef intGte (n:int) = g1intGte (intknd, n)
typedef intBtw (lb:int, ub:int) = g1intBtw (intknd, lb, ub)
typedef intBtwe (lb:int, ub:int) = g1intBtwe (intknd, lb, ub)
//
typedef natLt (n:int) = intBtw (0, n)
typedef natLte (n:int) = intBtwe (0, n)
//
typedef uint0 = g0uint (intknd)
typedef uint1 (i:int) = g1uint (intknd, i)
stadef uint = uint0 and uint = uint1
typedef uintLt (n:int) = g1uintLt (intknd, n)
typedef uintLte (n:int) = g1uintLte (intknd, n)
typedef uintGt (n:int) = g1uintGt (intknd, n)
typedef uintGte (n:int) = g1uintGte (intknd, n)
typedef uintBtw (lb:int, ub:int) = g1uintBtw (intknd, lb, ub)
typedef uintBtwe (lb:int, ub:int) = g1uintBtwe (intknd, lb, ub)
//
(* ****** ****** *)

abst@ype
lintknd = $extype"atstype_lint"
typedef lint0 = g0int (lintknd)
typedef lint1 (i:int) = g1int (lintknd, i)
stadef lint = lint0 and lint = lint1
typedef ulint0 = g0uint (lintknd)
typedef ulint1 (i:int) = g1uint (lintknd, i)
stadef ulint = ulint0 and ulint = ulint1

abst@ype
llintknd = $extype"atstype_llint"
typedef llint0 = g0int (llintknd)
typedef llint1 (i:int) = g1int (llintknd, i)
stadef llint = llint0 and llint = llint1
typedef ullint0 = g0uint (llintknd)
typedef ullint1 (i:int) = g1uint (llintknd, i)
stadef ullint = ullint0 and ullint = ullint1

abst@ype
sintknd = $extype"atstype_sint"
typedef sint0 = g0int (sintknd)
typedef sint1 (i:int) = g1int (sintknd, i)
stadef sint = sint0 and sint = sint1
typedef usint0 = g0uint (sintknd)
typedef usint1 (i:int) = g1uint (sintknd, i)
stadef usint = usint0 and usint = usint1

abst@ype
ssintknd = $extype"atstype_ssint"
typedef ssint0 = g0int (ssintknd)
typedef ssint1 (i:int) = g1int (ssintknd, i)
stadef ssint = ssint0 and ssint = ssint1
typedef ussint0 = g0uint (ssintknd)
typedef ussint1 (i:int) = g1uint (ssintknd, i)
stadef ussint = ussint0 and ussint = ussint1

(* ****** ****** *)

abst@ype
sizeknd = $extype"atstype_size"
//
typedef size0_t = g0uint (sizeknd)
stadef size_t = size0_t
typedef size1_t (i:int) = g1uint (sizeknd, i)
stadef size_t = size1_t
//
typedef Size =
  [i:int | i >= 0] g1uint (sizeknd, i)
typedef sizeLt
  (n: int) = [i:int | 0 <= i; i < n] g1uint (sizeknd, i)
typedef sizeLte
  (n: int) = [i:int | 0 <= i; i <= n] g1uint (sizeknd, i)
typedef sizeGt
  (n: int) = [i:int | i > n] g1uint (sizeknd, i)
typedef sizeGte
  (n: int) = [i:int | i >= n] g1uint (sizeknd, i)
typedef sizeBtw
  (lb:int, ub:int) = [i: int | lb <= i; i < ub] g1uint (sizeknd, i)
typedef sizeBtwe
  (lb:int, ub:int) = [i: int | lb <= i; i <= ub] g1uint (sizeknd, i)
//
typedef ssize0_t = g0int (sizeknd)
stadef ssize_t = ssize0_t
typedef ssize1_t (i:int) = g1int (sizeknd , i) 
stadef ssize_t = ssize1_t

(* ****** ****** *)

abst@ype
int8knd = $extype"atstype_int8"
//
typedef int8_0 = g0int (intknd)
typedef int8_1 (i:int) = g1int (int8knd, i)
stadef int8 = int8_0
stadef int8 = int8_1
stadef Int8 = [i:int] int8_1 (i)
//
typedef uint8_0 = g0uint (intknd)
typedef uint8_1 (i:int) = g1uint (int8knd, i)
stadef uint8 = uint8_0
stadef uint8 = uint8_1
stadef uInt8 = [i:nat] uint8_1 (i)

(* ****** ****** *)

abst@ype
int16knd = $extype"atstype_int16"
//
typedef int16_0 = g0int (intknd)
typedef int16_1 (i:int) = g1int (int16knd, i)
stadef int16 = int16_1
stadef Int16 = [i:int] int16_1 (i)
stadef int16 = int16_0
//
typedef uint16_0 = g0uint (intknd)
typedef uint16_1 (i:int) = g1uint (int16knd, i)
stadef uint16 = uint16_0
stadef uint16 = uint16_1
stadef uInt16 = [i:nat] uint16_1 (i)

(* ****** ****** *)

abst@ype
int32knd = $extype"atstype_int32"
//
typedef int32_0 = g0int (intknd)
typedef int32_1 (i:int) = g1int (int32knd, i)
stadef int32 = int32_0
stadef int32 = int32_1
stadef Int32 = [i:int] int32_1 (i)
//
typedef uint32_0 = g0uint (intknd)
typedef uint32_1 (i:int) = g1uint (int32knd, i)
stadef uint32 = uint32_0
stadef uint32 = uint32_1
stadef uInt32 = [i:nat] uint32_1 (i)

(* ****** ****** *)

abst@ype
int64knd = $extype"atstype_int64"
//
typedef int64_0 = g0int (intknd)
typedef int64_1 (i:int) = g1int (int64knd, i)
stadef int64 = int64_0
stadef int64 = int64_1
stadef Int64 = [i:int] int64_1 (i)
//
typedef uint64_0 = g0uint (intknd)
typedef uint64_1 (i:int) = g1uint (int64knd, i)
stadef uint64 = uint64_0
stadef uint64 = uint64_1
stadef uInt64 = [i:nat] uint64_1 (i)

(* ****** ****** *)

abst@ype
g0float_t0ype (a:t@ype) = a
stadef g0float = g0float_t0ype

abst@ype
fltknd = $extype"atstype_float"
typedef float = g0float (fltknd)
//
abst@ype
dblknd = $extype"atstype_double"
typedef double = g0float (dblknd)
//
abst@ype
ldblknd = $extype"atstype_ldouble"
typedef ldouble = g0float (ldblknd)

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

(* ****** ****** *)

(*
** HX: persistent read-only strings
*)
abstype string_type
stadef string = string_type
abstype string_int_type (n: int)
stadef string = string_int_type

(* ****** ****** *)

abst@ype void_t0ype
stadef void = void_t0ype

(* ****** ****** *)

absviewtype exception_viewtype
viewtypedef exn = exception_viewtype

(* ****** ****** *)

absviewt@ype
READ_viewt0ype_viewt0ype
  (a: viewt@ype+, int) = a
stadef READ = READ_viewt0ype_viewt0ype

(* ****** ****** *)

absviewt@ype
opt_viewt0ype_bool_viewt0ype
  (a:viewt@ype+, opt:bool) = a
stadef opt = opt_viewt0ype_bool_viewt0ype

(* ****** ****** *)

typedef bytes (n:int) = @[byte][n]
typedef b0ytes (n:int) = @[byte?][n]

(* ****** ****** *)

abst@ype strbuf (m:int, n:int) // [m] bytesx

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_sta.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_sta.sats] *)

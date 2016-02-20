(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author of the file:
// Hongwei Xi (gmhwxiATgmailDOTcom)
// Start Time: September, 2011
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_sta.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

#define RD(x) x // for commenting: read-only

(* ****** ****** *)
(*
//
// HX-2012-05-24:
// the following two styles are equivalent:
//
stadef
bool_kind = $extkind"atstype_bool"
tkindef bool_kind = "atstype_bool"
*)
(* ****** ****** *)
//
tkindef bool_kind = "atstype_bool"
//
abst@ype
bool_t0ype = tkind_t0ype (bool_kind)
stadef bool = bool_t0ype // shorthand
abst@ype
bool_bool_t0ype (b: bool) = bool_t0ype
stadef bool = bool_bool_t0ype // shorthand
//
typedef Bool = [b:bool] bool (b)
typedef boolLte
  (b1:bool) = [b2:bool] bool (b2 <= b1) // b2 -> b1
typedef boolGte
  (b1:bool) = [b2:bool] bool (b2 >= b1) // b1 -> b2
//
abst@ype atstype_bool // HX-2013-09: for internal use
//
(* ****** ****** *)

tkindef
byte_kind = "atstype_byte"
abst@ype
byte_t0ype = tkind_t0ype (byte_kind)
stadef byte = byte_t0ype

(* ****** ****** *)
//
// char is signed
//
sortdef int8 = {
  i:int | ~128 <= i; i < 128
} // end of [int8]
sortdef uint8 =
  { i:int | 0 <= i; i < 256 }
// end of [uint8]
//
tkindef char_kind = "atstype_char"
//
abst@ype
char_t0ype = tkind_t0ype (char_kind)
stadef char = char_t0ype // shorthand
abst@ype
char_int_t0ype (c:int) = char_t0ype
stadef char = char_int_t0ype // shorthand
typedef Char = [c:int8] char (c)
typedef charNZ = [c:int8 | c != 0] char (c)
//
// signed characters
//
tkindef schar_kind = "atstype_schar"
//
abst@ype
schar_t0ype = tkind_t0ype (schar_kind)
stadef schar = schar_t0ype // shorthand
abst@ype
schar_int_t0ype (c:int) = schar_t0ype
stadef schar = schar_int_t0ype // shorthand
typedef sChar = [c:int8] schar (c)
//
// unsigned characters
//
tkindef uchar_kind = "atstype_uchar"
//
abst@ype
uchar_t0ype = tkind_t0ype (uchar_kind)
stadef uchar = uchar_t0ype // shorthand
abst@ype
uchar_int_t0ype (c:int) = uchar_t0ype
stadef uchar = uchar_int_t0ype // shorthand
typedef uChar = [c:uint8] uchar (c)
//
(* ****** ****** *)

sortdef tk = tkind

(* ****** ****** *)
//
abst@ype
g0int_t0ype (tk:tk) = tkind_t0ype (tk)
stadef g0int = g0int_t0ype // shorthand
abst@ype
g1int_int_t0ype (tk:tkind, int) = g0int (tk)
stadef g1int = g1int_int_t0ype // shorthand
//
typedef g1int (tk:tkind) = [i:int] g1int (tk, i)
typedef g1int0 (tk:tkind) = [i:int | i >= 0] g1int (tk, i)
typedef g1int1 (tk:tkind) = [i:int | i >= 1] g1int (tk, i)
//
(* ****** ****** *)
//
typedef g1intLt
  (tk:tk, n:int) = [i:int | i < n] g1int (tk, i)
typedef g1intLte
  (tk:tk, n:int) = [i:int | i <= n] g1int (tk, i)
typedef g1intGt
  (tk:tk, n:int) = [i:int | i > n] g1int (tk, i)
typedef g1intGte
  (tk:tk, n:int) = [i:int | i >= n] g1int (tk, i)
typedef g1intBtw
  (tk:tk, lb:int, ub:int) = [i: int | lb <= i; i < ub] g1int (tk, i)
typedef g1intBtwe
  (tk:tk, lb:int, ub:int) = [i: int | lb <= i; i <= ub] g1int (tk, i)
//
(* ****** ****** *)
//
abst@ype
g0uint_t0ype (tk:tkind) = tkind_t0ype (tk)
stadef g0uint = g0uint_t0ype // shorthand
abst@ype
g1uint_int_t0ype (tk:tkind, int) = g0uint (tk)
stadef g1uint = g1uint_int_t0ype // shorthand
//
typedef g1uint (tk:tk) = [i:int] g1uint (tk, i)
typedef g1uint0 (tk:tk) = [i:int | i >= 0] g1uint (tk, i)
typedef g1uint1 (tk:tk) = [i:int | i >= 1] g1uint (tk, i)
//
(* ****** ****** *)
//
typedef g1uintLt
  (tk:tk, n:int) = [i:nat | i < n] g1uint (tk, i)
typedef g1uintLte
  (tk:tk, n:int) = [i:nat | i <= n] g1uint (tk, i)
typedef g1uintGt
  (tk:tk, n:int) = [i:int | i > n] g1uint (tk, i)
typedef g1uintGte
  (tk:tk, n:int) = [i:int | i >= n] g1uint (tk, i)
typedef g1uintBtw
  (tk:tk, lb:int, ub:int) = [i: int | lb <= i; i < ub] g1uint (tk, i)
typedef g1uintBtwe
  (tk:tk, lb:int, ub:int) = [i: int | lb <= i; i <= ub] g1uint (tk, i)
//
(* ****** ****** *)
//
tkindef int_kind = "atstype_int"
//
typedef int0 = g0int (int_kind)
typedef int1 (i:int) = g1int (int_kind, i)
//
stadef int = int1 // 2nd-select
stadef int = int0 // 1st-select
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
tkindef uint_kind = "atstype_uint"
//
typedef uint0 = g0uint (uint_kind)
typedef uint1 (n:int) = g1uint (uint_kind, n)
//
stadef uint = uint1 // 2nd-select
stadef uint = uint0 // 1st-select
//
stadef uInt = [n:int] uint1 (n)
//
typedef uintLt (n:int) = g1uintLt (uint_kind, n)
typedef uintLte (n:int) = g1uintLte (uint_kind, n)
typedef uintGt (n:int) = g1uintGt (uint_kind, n)
typedef uintGte (n:int) = g1uintGte (uint_kind, n)
typedef uintBtw (lb:int, ub:int) = g1uintBtw (uint_kind, lb, ub)
typedef uintBtwe (lb:int, ub:int) = g1uintBtwe (uint_kind, lb, ub)
//
abst@ype atstype_int // HX-2013-09: for internal use
abst@ype atstype_uint // HX-2013-09: for internal use
//
(* ****** ****** *)
//
tkindef
lint_kind = "atstype_lint"
typedef
lint0 = g0int (lint_kind)
typedef
lint1 (i:int) = g1int (lint_kind, i)
stadef lint = lint1 // 2nd-select
stadef lint = lint0 // 1st-select
//
tkindef
ulint_kind = "atstype_ulint"
typedef
ulint0 = g0uint (ulint_kind)
typedef
ulint1 (i:int) = g1uint (ulint_kind, i)
stadef ulint = ulint1 // 2nd-select
stadef ulint = ulint0 // 1st-select
//
tkindef
llint_kind = "atstype_llint"
typedef llint0 = g0int (llint_kind)
typedef llint1 (i:int) = g1int (llint_kind, i)
stadef llint = llint1 // 2nd-select
stadef llint = llint0 // 1st-select
//
tkindef
ullint_kind = "atstype_ullint"
typedef
ullint0 = g0uint (ullint_kind)
typedef
ullint1 (i:int) = g1uint (ullint_kind, i)
stadef ullint = ullint1 // 2nd-select
stadef ullint = ullint0 // 1st-select
//
(* ****** ****** *)
//
tkindef
intptr_kind = "atstype_intptr"
typedef
intptr0 = g0int (intptr_kind)
typedef
intptr1 (i:int) = g1int (intptr_kind, i)
stadef intptr = intptr1 // 2nd-select
stadef intptr = intptr0 // 1st-select
//
tkindef
uintptr_kind = "atstype_uintptr"
typedef
uintptr0 = g0uint (uintptr_kind)
typedef
uintptr1 (i:int) = g1uint (uintptr_kind, i)
stadef uintptr = uintptr1 // 2nd-select
stadef uintptr = uintptr0 // 1st-select
//
(* ****** ****** *)
//
tkindef
sint_kind = "atstype_sint"
typedef
sint0 = g0int (sint_kind)
typedef
sint1 (i:int) = g1int (sint_kind, i)
stadef sint = sint1 // 2nd-select
stadef sint = sint0 // 1st-select
//
tkindef
usint_kind = "atstype_usint"
typedef
usint0 = g0uint (usint_kind)
typedef
usint1 (i:int) = g1uint (usint_kind, i)
stadef usint = usint1 // 2nd-select
stadef usint = usint0 // 1st-select
//
(* ****** ****** *)
//
tkindef
size_kind = "atstype_size"
typedef size0_t = g0uint (size_kind)
typedef size1_t (i:int) = g1uint (size_kind, i)
//
stadef size_t = size1_t // 2nd-select
stadef size_t = size0_t // 1st-select
//
typedef Size =
  [i:int | i >= 0] g1uint (size_kind, i)
typedef Size_t = Size
//
typedef sizeLt (n:int) = g1uintLt (size_kind, n)
typedef sizeLte (n:int) = g1uintLte (size_kind, n)
typedef sizeGt (n:int) = g1uintGt (size_kind, n)
typedef sizeGte (n:int) = g1uintGte (size_kind, n)
typedef sizeBtw (lb:int, ub:int) = g1uintBtw (size_kind, lb, ub)
typedef sizeBtwe (lb:int, ub:int) = g1uintBtwe (size_kind, lb, ub)
//
tkindef
ssize_kind = "atstype_ssize"
typedef ssize0_t = g0int (ssize_kind)
typedef ssize1_t (i:int) = g1int (ssize_kind , i) 
//
stadef ssize_t = ssize1_t // 2nd-select
stadef ssize_t = ssize0_t // 1st-select
//
typedef SSize =
  [i:int] g1int (ssize_kind, i)
typedef SSize_t = SSize
//
typedef ssizeLt (n:int) = g1intLt (ssize_kind, n)
typedef ssizeLte (n:int) = g1intLte (ssize_kind, n)
typedef ssizeGt (n:int) = g1intGt (ssize_kind, n)
typedef ssizeGte (n:int) = g1intGte (ssize_kind, n)
typedef ssizeBtw (lb:int, ub:int) = g1intBtw (ssize_kind, lb, ub)
typedef ssizeBtwe (lb:int, ub:int) = g1intBtwe (ssize_kind, lb, ub)
//
abst@ype atstype_size // HX-2013-09: for internal use
abst@ype atstype_ssize // HX-2013-09: for internal use
//
(* ****** ****** *)

typedef sizeof_t (a:vt@ype) = size_t (sizeof(a?))

(* ****** ****** *)
//
tkindef
int8_kind = "atstype_int8"
typedef
int8_0 = g0int (int8_kind)
typedef
int8_1
  (i:int) = g1int (int8_kind, i)
//
stadef int8 = int8_1 // 2nd-select
stadef int8 = int8_0 // 1st-select
stadef Int8 = [i:int] int8_1 (i)
//
tkindef
uint8_kind = "atstype_uint8"
typedef
uint8_0 = g0uint (uint8_kind)
typedef
uint8_1
  (i:int) = g1uint (uint8_kind, i)
//
stadef uint8 = uint8_1 // 2nd-select
stadef uint8 = uint8_0 // 1st-select
stadef uInt8 = [i:nat] uint8_1 (i)
//
(* ****** ****** *)
//
tkindef
int16_kind = "atstype_int16"
typedef
int16_0 = g0int (int16_kind)
typedef
int16_1
  (i:int) = g1int (int16_kind, i)
//
stadef int16 = int16_1 // 2nd-select
stadef int16 = int16_0 // 1st-select
stadef Int16 = [i:int] int16_1 (i)
//
tkindef
uint16_kind = "atstype_uint16"
typedef
uint16_0 = g0uint (uint16_kind)
typedef
uint16_1
  (i:int) = g1uint (uint16_kind, i)
//
stadef uint16 = uint16_1 // 2nd-select
stadef uint16 = uint16_0 // 1st-select
stadef uInt16 = [i:nat] uint16_1 (i)
//
(* ****** ****** *)
//
tkindef
int32_kind = "atstype_int32"
typedef
int32_0 = g0int (int32_kind)
typedef
int32_1
  (i:int) = g1int (int32_kind, i)
//
stadef int32 = int32_1 // 2nd-select
stadef int32 = int32_0 // 1st-select
stadef Int32 = [i:int] int32_1 (i)
//
tkindef
uint32_kind = "atstype_uint32"
typedef
uint32_0 = g0uint (uint32_kind)
typedef
uint32_1
  (i:int) = g1uint (uint32_kind, i)
//
stadef uint32 = uint32_1 // 2nd-select
stadef uint32 = uint32_0 // 1st-select
stadef uInt32 = [i:nat] uint32_1 (i)
//
(* ****** ****** *)
//
tkindef
int64_kind = "atstype_int64"
typedef
int64_0 = g0int (int64_kind)
typedef
int64_1
  (i:int) = g1int (int64_kind, i)
//
stadef int64 = int64_1 // 2nd-select
stadef int64 = int64_0 // 1st-select
stadef Int64 = [i:int] int64_1 (i)
//
tkindef
uint64_kind = "atstype_uint64"
typedef
uint64_0 = g0uint (uint64_kind)
typedef
uint64_1
  (i:int) = g1uint (uint64_kind, i)
//
stadef uint64 = uint64_1 // 2nd-select
stadef uint64 = uint64_0 // 1st-select
stadef uInt64 = [i:nat] uint64_1 (i)
//
(* ****** ****** *)
//
abst@ype
g0float_t0ype (tk:tk) = tkind_t0ype (tk)
stadef g0float = g0float_t0ype // shorthand
//
tkindef float_kind = "atstype_float"
typedef float = g0float (float_kind)
//
tkindef double_kind = "atstype_double"
typedef double = g0float (double_kind)
//
tkindef ldouble_kind = "atstype_ldouble"
typedef ldouble = g0float (ldouble_kind)
//
(* ****** ****** *)
//
// HX: unindexed type for pointers
//
tkindef ptr_kind = "atstype_ptrk"
abstype ptr_type = tkind_type (ptr_kind)
stadef ptr = ptr_type // a shorthand
abstype ptr_addr_type (l:addr) = ptr_type
stadef ptr = ptr_addr_type // a shorthand
typedef Ptr = [l:addr] ptr (l)
typedef Ptr0 = [l:addr | l >= null] ptr (l)
typedef Ptr1 = [l:addr | l >  null] ptr (l)
typedef
Ptrnull (l:addr) =
  [l1:addr | l1 == null || l1 == l] ptr (l1)
// end of [Ptrnull]
//
// HX-2012-02-14: it is an expriment for now:
//
stadef ptr (n:int) = ptr_addr_type (addr_of_int(n))
//
(* ****** ****** *)

(*
** HX: persistent read-only strings
*)
(*
//
// HX-2013-04: this confuses type-erasure
//
abstype
string_type = $extype"atstype_string"
*)
abstype
string_type = ptr // = char* in C
abstype
string_int_type (n: int) = string_type
//
stadef string0 = string_type
stadef string1 = string_int_type
stadef string = string1 // 2nd-select
stadef string = string0 // 1st-select
typedef String = [n:int] string_int_type (n)
typedef String0 = [n:int | n >= 0] string_int_type (n)
typedef String1 = [n:int | n >= 1] string_int_type (n)
//
(* ****** ****** *)

abstype
stropt_int_type (n:int) = ptr
stadef stropt = stropt_int_type
typedef Stropt = [n:int] stropt_int_type (n)
typedef Stropt0 = [n:int] stropt_int_type (n)
typedef Stropt1 = [n:int | n >= 0] stropt_int_type (n)
stadef stropt = Stropt // HX: this may be a bit confusing :)

(* ****** ****** *)

(*
** HX: linear mutable strings
*)
absvtype
strptr_addr_vtype (l:addr) = ptr
stadef strptr = strptr_addr_vtype
vtypedef Strptr0 = [l:addr] strptr (l)
vtypedef Strptr1 = [l:addr | l > null] strptr (l)
stadef strptr = Strptr0

absvtype
strnptr_addr_int_vtype (l:addr, n:int) = ptr
stadef strnptr = strnptr_addr_int_vtype
vtypedef strnptr (n:int) = [l:addr] strnptr (l, n)
vtypedef Strnptr0 = [l:addr;n:int] strnptr (l, n)
vtypedef Strnptr1 = [l:addr;n:int | n >= 0] strnptr (l, n)

(* ****** ****** *)

(*
** HX: persistent mutable strings
*)
abstype
strref_addr_type (l:addr) = ptr
stadef strref = strref_addr_type
typedef Strref0 = [l:addr] strref (l)
typedef Strref1 = [l:addr | l > null] strref (l)

(* ****** ****** *)

abst@ype
atsvoid_t0ype
(*
= $extype"atsvoid_t0ype"
*)
typedef void = atsvoid_t0ype // = C-void

(* ****** ****** *)
//
absvtype
exception_vtype = $extype"atstype_exnconptr"
//
vtypedef exn = exception_vtype // boxed vtype
//
(* ****** ****** *)

absvt@ype // covariance
opt_vt0ype_bool_vt0ype (a:vt@ype+, opt:bool) = a
stadef opt = opt_vt0ype_bool_vt0ype

(* ****** ****** *)

typedef bytes (n:int) = @[byte][n]
viewdef bytes_v (l:addr, n:int) = bytes (n) @ l
typedef b0ytes (n:int) = @[byte?][n]
viewdef b0ytes_v (l:addr, n:int) = b0ytes (n) @ l

(* ****** ****** *)
//
abstype
cloref_t0ype_type (a:t@ype) = ptr
stadef cloref = cloref_t0ype_type
//
absvtype
cloptr_vt0ype_vtype (a:t@ype) = ptr
stadef cloptr = cloptr_vt0ype_vtype
vtypedef cloptr0 = cloptr_vt0ype_vtype (void)
//
(* ****** ****** *)
//
typedef
stamped_t(a:t@ype) = [x:int] stamped_t(a, x)
vtypedef
stamped_vt(a:vt@ype) = [x:int] stamped_vt(a, x)
//
(* ****** ****** *)
//
// HX: for memory deallocation (with/without GC)
//
absview
mfree_gc_addr_view (addr)
stadef mfree_gc_v = mfree_gc_addr_view
absview
mfree_ngc_addr_view (addr)
stadef mfree_ngc_v = mfree_ngc_addr_view
//
absview
mfree_libc_addr_view (addr) // libc-mfree
stadef mfree_libc_v = mfree_libc_addr_view
//
(* ****** ****** *)

absvt@ype
arrpsz_vt0ype_int_vt0ype
  (a:vt@ype+, n:int) = $extype"atstype_arrpsz"
stadef arrpsz = arrpsz_vt0ype_int_vt0ype

(* ****** ****** *)

absprop // invariance
vbox_view_prop (v:view)
propdef vbox (v:view) = vbox_view_prop (v)

abstype // invariance
ref_vt0ype_type (a:vt@ype) = ptr
typedef ref (a:vt@ype) = ref_vt0ype_type (a)

(* ****** ****** *)
//
viewdef vtakeout
  (v1: view, v2: view) = (v2, v2 -<lin,prf> v1)
viewdef vtakeout0 (v:view) = vtakeout (void, v)
//
vtypedef vttakeout
  (vt1: vt@ype, vt2: vt@ype) = (vt2 -<lin,prf> vt1 | vt2)
viewdef vttakeout0 (vt:vt@ype) = vttakeout (void, vt)
//
(* ****** ****** *)
//
vtypedef
vtakeoutptr
  (a:vt@ype) = [l:addr] (a@l, a@l -<lin,prf> void | ptr l)
//
(* ****** ****** *)
//
vtypedef
vstrptr (l:addr) = vttakeout0 (strptr l)
//
vtypedef vStrptr0 = [l:addr] vstrptr (l)
vtypedef vStrptr1 = [l:addr | l > null] vstrptr (l)
//
(* ****** ****** *)

typedef
bottom_t0ype_uni = {a:t@ype} (a)
typedef
bottom_t0ype_exi = [a:t@ype | false] (a)

vtypedef
bottom_vt0ype_uni = {a:vt@ype} (a)
vtypedef
bottom_vt0ype_exi = [a:vt@ype | false] (a)

(* ****** ****** *)

typedef
cmpval_fun
  (a: t@ype) = (a, a) -<fun> int
typedef
cmpval_funenv
  (a: t@ype, vt: t@ype) = (a, a, !vt) -<fun> int
stadef cmpval = cmpval_fun
stadef cmpval = cmpval_funenv

(* ****** ****** *)

typedef
cmpref_fun
  (a: vt@ype) = (&RD(a), &RD(a)) -<fun> int
typedef
cmpref_funenv
  (a: vt@ype, vt: vt@ype) = (&RD(a), &RD(a), !vt) -<fun> int
stadef cmpref = cmpref_fun
stadef cmpref = cmpref_funenv

(* ****** ****** *)
//
// HX: [lazy(T)] :
// suspended evaluation of type T
//
abstype
lazy_t0ype_type (t@ype+) = ptr
typedef lazy (a:t@ype) = lazy_t0ype_type (a)
//
(* ****** ****** *)
//
// HX: [lazy_vt(VT)] :
// suspended computation of viewtype VT
//
absvtype
lazy_vt0ype_vtype (vt@ype+) = ptr
vtypedef lazy_vt (a: vt@ype)= lazy_vt0ype_vtype (a)
//
(* ****** ****** *)
//
(*
//
// HX-2016-02-21:
// these are renamed/relocated elsewhere
//
abst0ype
literal_int(intlit) = $extype"atsliteral_int"
abst0ype
literal_float(float) = $extype"atsliteral_float"
abst1ype
literal_string(string) = $extype"atsliteral_string"
*)
//
(* ****** ****** *)
//
abst@ype
undefined_t0ype = $extype"atstype_undefined"
absvt@ype
undefined_vt0ype = $extype"atstype_undefined"
//
(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_sta.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_sta.sats] *)

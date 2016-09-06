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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: October, 2013 *)

(* ****** ****** *)
  
#define ATS_PACKNAME "ATSLIB.libats.stringbuf"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names
  
(* ****** ****** *)
//
staload
_ = "prelude/DATS/integer.dats"
staload
_ = "prelude/DATS/integer_size.dats"
//
(* ****** ****** *)
//
staload
_ = "prelude/DATS/array.dats"
staload
_ = "prelude/DATS/arrayptr.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
STDIO = "libats/libc/SATS/stdio.sats"

(* ****** ****** *)

staload "libats/SATS/stringbuf.sats"

(* ****** ****** *)

extern
fun
memcpy (ptr, ptr, size_t):<!wrt> ptr = "mac#atslib_stringbuf_memcpy"
extern
fun
memmove (ptr, ptr, size_t):<!wrt> ptr = "mac#atslib_stringbuf_memmove"

(* ****** ****** *)
//
// HX:
// recapacitizing policy
// 0: manual
// 1: automatic doubling
//
implement
{}(*tmp*)
stringbuf$recapacitize () = 1 // default policy
//
(* ****** ****** *)
//
datavtype
stringbuf =
{m:pos}
STRINGBUF of (arrayptr(char, m+1), ptr(*cur*), size_t(m))
//
(* ****** ****** *)

assume stringbuf_vtype = stringbuf

(* ****** ****** *)
//
implement
{}(*tmp*)
stringbuf_make_nil_int
  (cap) =
  stringbuf_make_nil_size(i2sz(cap))
//
implement
{}(*tmp*)
stringbuf_make_nil_size
  (cap) = (sbf) where
{
//
prval
[m:int]
EQINT() = g1uint_get_index(cap)
//
val A = arrayptr_make_uninitized<char>(succ(cap))
//
val p_A = ptrcast(A)
//
val sbf = STRINGBUF($UN.castvwtp0{arrayptr(char,m+1)}(A), p_A, cap)
//
} (* end of [stringbuf_make_cap] *)
//
(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_free (sbf) =
  let val+~STRINGBUF (A, _, _) = sbf in arrayptr_free (A) end
// end of [stringbuf_free]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_getfree_strptr
  (sbf) = let
//
val+~STRINGBUF(A, p, _) = sbf
val () = $UN.ptr0_set<char>(p, '\000')
//
in
  $UN.castvwtp0{Strptr1}(A)
end // end of [stringbuf_getfree_strptr]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_getfree_strnptr
  (sbf, n0) = let
//
val+~STRINGBUF(A, p, _) = sbf
val () = $UN.ptr0_set<char>(p, '\000')
val [n:int] n = $UN.cast{sizeGte(0)}(p - ptrcast(A))
val ((*void*)) = n0 := n
//
in
  $UN.castvwtp0{strnptr(n)}(A)
end // end of [stringbuf_getfree_strnptr]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_get_size
  (sbf) = let
//
val+STRINGBUF(A, p, _) = sbf
//
in
  $UN.cast{size_t}(p - ptrcast(A))
end // end of [stringbuf_get_size]

implement
{}(*tmp*)
stringbuf_get_capacity
  (sbf) =
  let val+STRINGBUF (_, _, cap) = sbf in cap end
// end of [stringbuf_get_capacity]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_get_bufptr
  (sbf) = let
  val+STRINGBUF (A, _, _) = sbf in $UN.castvwtp1{Ptr1}(A)
end // end of [stringbuf_get_bufptr]

implement
{}(*tmp*)
stringbuf_get_strptr
  (sbf) = let
  val+STRINGBUF (A, p, _) = sbf
  val () = $UN.ptr0_set<char> (p, '\000') in $UN.castvwtp1{vStrptr1}(A)
end // end of [stringbuf_get_strptr]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_takeout_strbuf
  (sbf, n0) = let
//
val+STRINGBUF(A, p1, _) = sbf
//
val p0 = ptrcast (A)
val n = $UN.cast{size_t}(p1 - p0)
val [n:int] n = g1ofg0_uint (n)
val ((*void*)) = n0 := n
//
prval (pf, fpf) = __assert (p0) where
{
  extern praxi __assert {l:addr} (ptr(l)): vtakeout0(bytes_v (l, n))
} (* end of [prval] *)
//
in
  (pf, fpf | p0)
end // end of [stringbuf_takeout_strbuf]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_reset_capacity
  (sbf, m2) = let
//
val n = stringbuf_get_size (sbf)
//
prval [m2:int] EQINT () = g1uint_get_index (m2)
//
in
//
if m2 >= n then let
//
val+@STRINGBUF(A, p, m) = sbf
//
val A2 =
  arrayptr_make_uninitized<char> (succ(m2))
val p_A2 = ptrcast(A2)
val _(*ptr*) = memcpy (p_A2, ptrcast(A), n)
//
val () = arrayptr_free (A)
//
val () = m := m2
val () = p := add_ptr_bsz (p_A2, n)
val () = A := $UN.castvwtp0{arrayptr(char,m2+1)}(A2)
prval () = fold@ (sbf)
//
in
  true
end else
  false
// end of [if]
//
end // end of [stringbuf_reset_capacity]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_get_at
  (sbf, i) = let
//
var n: size_t
val (pf, fpf | p) = stringbuf_takeout_strbuf (sbf, n)
//
val i = g1ofg0(i)
val res = (if i < n then $UN.cast2int(p->[i]) else ~1): int
prval () = fpf (pf)
//
in
  res
end // end of [strigbuf_get_at]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_rget_at
  (sbf, i) = let
//
var n: size_t
val (pf, fpf | p) = stringbuf_takeout_strbuf (sbf, n)
//
val res = (if i <= n then $UN.cast2int(p->[n-i]) else ~1): int
//
prval () = fpf (pf)
//
in
  res
end // end of [strigbuf_rget_at]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_insert_char
  (sbf, x) = let
//
val+@STRINGBUF(A, p, m) = sbf
//
val m = m
val n = $UN.cast{size_t}(p - ptrcast(A))
//
in
//
case+ 0 of
| _ when n < m => let
    val () = $UN.ptr0_set<char> (p, x)
    val () = p := ptr_succ<char> (p)
    prval () = fold@ (sbf)
  in
    1
  end // end of [n < m]
| _ (*n >= m*) => let
    val recap = stringbuf$recapacitize ()
    prval () = fold@ (sbf)
  in
    if recap >= 1 then let
      val _ = stringbuf_reset_capacity (sbf, m+m) in stringbuf_insert_char (sbf, x)
    end else 0(*~inserted*) // end of [if]
  end // end of [n >= m]
//
end // end of [stringbuf_insert_char]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_insert_string
  (sbf, x) = let
  val x = g1ofg0(x)
in
  stringbuf_insert_strlen (sbf, x, string_length(x))
end // end of [stringbuf_insert_string]

(* ****** ****** *)
//
extern
fun _stringbuf_pow2min
  (s1: sizeGte(1), s2: size_t): sizeGte(1) = "mac#%"
(*
//
// HX-2015-11-19: It has been moved to CATS
//
implement
_stringbuf_pow2min (s1, s2) =
   if s1 >= s2 then s1 else _stringbuf_pow2min (s1+s1, s2)
*)
//
(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_insert_strlen
  (sbf, x, nx) = let
//
val+@STRINGBUF(A, p, m) = sbf
//
val m = m
val n = $UN.cast{size_t}(p - ptrcast(A))
val n2 = n + nx
//
in
//
case+ 0 of
| _ when n2 <= m => let
    val _(*ptr*) =
      memcpy (p, string2ptr(x), nx)
    val () = p := ptr_add<char> (p, nx)
    prval () = fold@ (sbf)
  in
    sz2i(nx)
  end // end of [n2 <= m]
| _ (*n2 >= m*) => let
    val recap = stringbuf$recapacitize ()
    prval () = fold@ (sbf)
  in
    if recap >= 1 then let
      val m2 = _stringbuf_pow2min (m, n2)
      val _ = stringbuf_reset_capacity (sbf, m2) in stringbuf_insert_strlen (sbf, x, nx)
    end else 0(*~inserted*) // end of [if]
  end // end of [n2 >= m]
//
end // end of [stringbuf_insert_char]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_insert_bool
  (sbf, x) = let
in
//
if x
  then stringbuf_insert_strlen (sbf, "true", i2sz(4))
  else stringbuf_insert_strlen (sbf, "false", i2sz(5))
// end of [if]
//
end // end of [stringbuf_insert_bool]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_insert_int
  (sbf, x) = let
  val sbf = $UN.castvwtp1{ptr}(sbf)
  val recap = stringbuf$recapacitize ()
in
  $extfcall(int, "atslib_stringbuf_insert_snprintf", sbf, recap, "%i", x)
end // end of [stringbuf_insert_int]
implement
{}(*tmp*)
stringbuf_insert_uint
  (sbf, x) = let
  val sbf = $UN.castvwtp1{ptr}(sbf)
  val recap = stringbuf$recapacitize ()
in
  $extfcall(int, "atslib_stringbuf_insert_snprintf", sbf, recap, "%u", x)
end // end of [stringbuf_insert_uint]
implement
{}(*tmp*)
stringbuf_insert_lint
  (sbf, x) = let
  val sbf = $UN.castvwtp1{ptr}(sbf)
  val recap = stringbuf$recapacitize ()
in
  $extfcall(int, "atslib_stringbuf_insert_snprintf", sbf, recap, "%li", x)
end // end of [stringbuf_insert_lint]
implement
{}(*tmp*)
stringbuf_insert_ulint
  (sbf, x) = let
  val sbf = $UN.castvwtp1{ptr}(sbf)
  val recap = stringbuf$recapacitize ()
in
  $extfcall(int, "atslib_stringbuf_insert_snprintf", sbf, recap, "%lu", x)
end // end of [stringbuf_insert_ulint]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_insert_fread
  (sbf, inp, nb) = let
//
val+@STRINGBUF(A, p, m) = sbf
//
val n = $UN.cast{size_t}(p - ptrcast(A))
//
val nb = g1ofg0 (nb)
val nb = (
  if nb > 0 then min (i2sz(nb), m - n) else (m - n)
) : size_t
val [nb:int] nb = g1ofg0(nb)
//
val (
  pf, fpf | p1
) = $UN.ptr0_vtake{bytes(nb)}(p)
val nread = $STDIO.fread (!p1, i2sz(1), nb, inp)
val ((*void*)) = p := ptr_add<char> (p, nread)
//
prval () = fpf (pf)
prval () = fold@ (sbf)
//
in
  sz2i(nread)
end // end of [stringbuf_insert_fread]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_insert_fgets
  (sbf, inp, last) = let
//
val+@STRINGBUF(A, p, m) = sbf
//
val n =
$UN.cast{size_t}(p-ptrcast(A))
val [nb:int] nb = g1ofg0(m - n)
//
val (
  pf, fpf | p1
) = $UN.ptr0_vtake{bytes(nb+1)}(p)
val p2 = $STDIO.fgets0 (!p1, sz2i(nb)+1, inp)
//
prval pf2 =
assert (view@last) where
{ 
  extern praxi assert{l:addr}(char(0)@l): char@l
}
//
val n2 =
(
if p2 > 0 
  then let
    val n2 =
      length($UN.cast{string}(p2))
    val n2 = g1ofg0(n2)
    val () = p := ptr_add<char> (p, n2)
    val () = if n2 > 0 then last := $UN.ptr0_get<char> (ptr_pred<char> (p))
  in
    sz2i (n2)
  end // end of [then]
  else (~1) // HX: failure
// end of [if]
) : int // end of [val]
//
prval () = view@last := pf2
//
prval () = fpf (pf)
prval () = fold@ (sbf)
//
in
  n2
end // end of [stringbuf_insert_fgets]

(* ****** ****** *)
//
implement
stringbuf_insert_val<int> = stringbuf_insert_int
//
implement
stringbuf_insert_val<bool> = stringbuf_insert_bool
//
implement
stringbuf_insert_val<uint> = stringbuf_insert_uint
implement
stringbuf_insert_val<lint> = stringbuf_insert_lint
implement
stringbuf_insert_val<ulint> = stringbuf_insert_ulint
//
implement
stringbuf_insert_val<string> = stringbuf_insert_string
//
(* ****** ****** *)

implement
{a}(*tmp*)
stringbuf_insert_list
  (sbf, xs) = let
//
fun loop
(
  sbf: !stringbuf, xs: List(a), res: int
) : int = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val n = stringbuf_insert_val<a> (sbf, x)
  in
    loop (sbf, xs, res + n)
  end (* end of [list_cons] *)
| list_nil () => res
//
end // end of [loop]
//
in
  loop (sbf, xs, 0)
end // end of [stringbuf_insert_list]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_takeout
  (sbf, i) = let
//
val+@STRINGBUF(A, p1, _) = sbf
//
val p0 = ptrcast (A)
val n = $UN.cast{size_t}(p1 - p0)
val [n:int] n = g1ofg0_uint (n)
val [i:int] i = g1ofg0_uint (i)
//
val i = min(i, n)
val str = string_make_substring ($UN.cast{string(n)}(p0), i2sz(0), i)
//
val ni = (n - i)
val p0 = memmove (p0, ptr_add<char> (p0, i), ni)
val () = p1 := ptr_add<char> (p0, ni)
//
prval () = fold@ (sbf)
prval () = lemma_strnptr_param (str)
//
in
  strnptr2strptr(str)
end // end of [stringbuf_takeout]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_takeout_all
  (sbf) = let
//
val+@STRINGBUF(A, p1, _) = sbf
//
val p0 = ptrcast (A)
val n = $UN.cast{size_t}(p1 - p0)
val [n:int] n = g1ofg0_uint (n)
//
val str = string_make_substring ($UN.cast{string(n)}(p0), i2sz(0), n)
//
val () = p1 := p0
//
prval () = fold@ (sbf)
prval () = lemma_strnptr_param (str)
//
in
  strnptr2strptr(str)
end // end of [stringbuf_takeout_all]

(* ****** ****** *)
  
implement
{}(*tmp*)
stringbuf_remove
  (sbf, i) = () where
{
//
val+@STRINGBUF(A, p1, _) = sbf
//
val p0 = ptrcast (A)
val n = $UN.cast{size_t}(p1 - p0)
val [n:int] n = g1ofg0_uint (n)
val [i:int] i = g1ofg0_uint (i)
//
val i = min(i, n)
val ni = n - min(i, n)
val p0 = memmove (p0, ptr_add<char> (p0, i), ni)
val () = p1 := ptr_add<char> (p0, ni)
//
prval () = fold@ (sbf)
//
} (* end of [stringbuf_remove] *)
  
(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_remove_all
  (sbf) = () where
{
//
val+@STRINGBUF(A, p1, _) = sbf
val ((*void*)) = p1 := ptrcast(A)
prval ((*void*)) = fold@ (sbf)
//
} (* end of [stringbuf_remove_all] *)

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_truncate
  (sbf, n2) = let
//
val+@STRINGBUF(A, p1, _) = sbf
//
val p0 = ptrcast(A)
val n1 = $UN.cast{size_t}(p1 - p0)
//
in
//
if n2 < n1
  then let
    val p2 =
      ptr_add<char> (p0, n2)
    val ((*void*)) = (p1 := p2)
    prval () = fold@ (sbf)
  in
    true
  end // end of [then]
  else let
    prval () = fold@ (sbf) in false
  end // end of [else]
// end of [if]
//
end // end of [stringbuf_truncate]

(* ****** ****** *)

implement
{}(*tmp*)
stringbuf_truncout
  (sbf, n2) = let
//
fun aux .<>.
(
  p: ptr, n: size_t
) :<!wrt> Strptr1 = let
  val [n0:int]
    str = $UN.cast{String}(p)
  val n = $UN.cast{sizeLte(n0)}(n)
  val str2 =
    string_make_substring (str, i2sz(0), n)
  // end of [val]
  prval () = lemma_strnptr_param (str2)
in
  strnptr2strptr (str2)
end // end of [aux]
//
val+@STRINGBUF(A, p1, _) = sbf
//
val p0 = ptrcast(A)
val n1 = $UN.cast{size_t}(p1 - p0)
//
in
//
if (
  n1 >= n2
) then let
    val p2 =
      ptr_add<char> (p0, n2)
    val res = aux (p2, n1-n2)
    val ((*void*)) = (p1 := p2)
    prval () = fold@ (sbf)
  in
    res
  end // end of [then]
  else let
    prval () = fold@ (sbf) in strptr_null ()
  end // end of [else]
// end of [if]
//
end // end of [stringbuf_truncout]

(* ****** ****** *)
//
implement
{}(*tmp*)
stringbuf_truncout_all (sbf) =
  $UN.castvwtp0{Strptr1}(stringbuf_truncout (sbf, i2sz(0)))
//  
(* ****** ****** *)
//
extern
fun _stringbuf_get_size (!stringbuf): size_t = "ext#%"
extern
fun _stringbuf_get_capacity (!stringbuf): size_t = "ext#%"
//
extern
fun _stringbuf_get_ptrcur (sbf: !stringbuf): ptr = "ext#%"
extern
fun _stringbuf_set_ptrcur (sbf: !stringbuf, p2: ptr): void = "ext#%"
//
extern
fun _stringbuf_reset_capacity (sbf: !stringbuf, m2: sizeGte(1)): bool = "ext#%"
//
(* ****** ****** *)
//
implement
_stringbuf_get_size (sbf) = stringbuf_get_size<> (sbf)
implement
_stringbuf_get_capacity (sbf) = stringbuf_get_capacity<> (sbf)
//
implement
_stringbuf_get_ptrcur
  (sbf) =
  let val+STRINGBUF(_, p, _) = sbf in p end
implement
_stringbuf_set_ptrcur
  (sbf, p2) =
  let val+@STRINGBUF(_, p, _) = sbf in p := p2; fold@(sbf) end
// end of [_stringbuf_set_ptrcur]
//
implement
_stringbuf_reset_capacity (sbf, m2) = stringbuf_reset_capacity<> (sbf, m2)
//
(* ****** ****** *)

%{$
//
atstype_int
atslib_stringbuf_insert_snprintf
(
  atstype_ptr sbf, atstype_int recap, atstype_string fmt, ...
) {
  int ntot ;
  va_list ap0 ;
  va_start(ap0, fmt) ;
  ntot = atslib_stringbuf_insert_vsnprintf (sbf, recap, fmt, ap0) ;
  va_end(ap0) ;
  return (ntot) ;
} // end of [atslib_stringbuf_insert_snprintf]
//
atstype_int
atslib_stringbuf_insert_vsnprintf
(
  atstype_ptr sbf, atstype_int recap, atstype_string fmt, va_list ap0
) {
  size_t m ;
  size_t n ;
  void *p_cur ;
  int ntot ;
  va_list ap1 ;
//
  m = atslib__stringbuf_get_capacity (sbf) ;
  n = atslib__stringbuf_get_size (sbf) ;
  p_cur = atslib__stringbuf_get_ptrcur (sbf) ;
//
  va_copy(ap1, ap0) ;
  ntot = vsnprintf ((char*)p_cur, m-n+1, (char*)fmt, ap1) ;
  va_end(ap1) ;
//
  if (ntot > m-n && recap >= 1)
  { 
    m = atslib__stringbuf_pow2min (m, n+ntot) ;
    atslib__stringbuf_reset_capacity (sbf, m) ;
    p_cur = atslib__stringbuf_get_ptrcur (sbf) ;
    ntot = vsnprintf ((char*)p_cur, ntot+1, (char*)fmt, ap0) ;
  }
//
  if (ntot >= 0) {
    atslib__stringbuf_set_ptrcur (sbf, (char*)p_cur+ntot) ;
  } // end of [if]
//
  return (ntot) ;
//
} // end of [atslib_stringbuf_insert_snprintf]
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [stringbuf.dats] *)

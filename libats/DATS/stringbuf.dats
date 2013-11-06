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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/stringbuf.sats"

(* ****** ****** *)

extern
fun
memcpy (ptr, ptr, size_t):<!wrt> ptr = "mac#atslib_stringbuf_memcpy"

(* ****** ****** *)
//
// HX:
// recapacitizing policy
// 0: manual
// 1: automatic doubling
//
implement{}
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

implement{
} stringbuf_make_nil
  (cap) = (sbf) where
{
//
prval [m:int] EQINT() = g1uint_get_index (cap)
//
val A = arrayptr_make_uninitized<char> (succ(cap))
//
val p_A = ptrcast (A)
//
val sbf = STRINGBUF ($UN.castvwtp0{arrayptr(char,m+1)}(A), p_A, cap)
//
} // end of [stringbuf_make_cap]

(* ****** ****** *)

implement{
} stringbuf_free (sbf) =
  let val+~STRINGBUF (A, _, _) = sbf in arrayptr_free (A) end
// end of [stringbuf_free]

(* ****** ****** *)

implement{
} stringbuf_getfree_strnptr
  (sbf, n0) = let
  val+~STRINGBUF (A, p, _) = sbf
  val () = $UN.ptr0_set<char>(p, '\000')
  val [n:int] n = $UN.cast{sizeGte(0)}(p - ptrcast(A))
  val ((*void*)) = n0 := n
in
  $UN.castvwtp0{strnptr(n)}(A)
end // end of [stringbuf_getfree_strnptr]

(* ****** ****** *)

implement{
} stringbuf_get_size
  (sbf) = let
  val+STRINGBUF (A, p, _) = sbf
in
  $UN.cast{size_t}(p - ptrcast(A))
end // end of [stringbuf_get_size]

implement{
} stringbuf_get_capacity
  (sbf) =
  let val+STRINGBUF (_, _, cap) = sbf in cap end
// end of [stringbuf_get_capacity]

(* ****** ****** *)

implement{
} stringbuf_reset_capacity
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
val+@STRINGBUF (A, p, m) = sbf
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

implement{
} stringbuf_insert_char
  (sbf, x) = let
//
val+@STRINGBUF (A, p, m) = sbf
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

implement{
} stringbuf_insert_string
  (sbf, x) = let
  val x = g1ofg0(x)
in
  stringbuf_insert_strlen (sbf, x, string_length(x))
end // end of [stringbuf_insert_string]

(* ****** ****** *)
//
extern
fun{}
pow2min
  (s1: sizeGte(1), s2: size_t): sizeGte(1)
//
implement{
} pow2min (s1, s2) =
(
  if s1 >= s2 then s1 else pow2min (s1+s1, s2)
) (* end of [pow2min] *)
//
(* ****** ****** *)

implement{
} stringbuf_insert_strlen
  (sbf, x, nx) = let
//
val+@STRINGBUF (A, p, m) = sbf
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
      val m2 = pow2min (m, n2)
      val _ = stringbuf_reset_capacity (sbf, m2) in stringbuf_insert_strlen (sbf, x, nx)
    end else 0(*~inserted*) // end of [if]
  end // end of [n2 >= m]
//
end // end of [stringbuf_insert_char]

(* ****** ****** *)

implement{
} stringbuf_insert_bool
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

(* end of [stringbuf.dats] *)

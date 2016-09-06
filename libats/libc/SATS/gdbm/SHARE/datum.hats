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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: July, 2013
//
(* ****** ****** *)

absvtype
dptr_addr_int_vtype (addr, int)
//
vtypedef dptr
  (l:addr, n:int) = dptr_addr_int_vtype (l, n)
//
(* ****** ****** *)
//
viewdef
dptrout
  (l:addr, n:int) = dptr (l, n) -<lin,prf> void
//
(* ****** ****** *)
//
castfn
dptr2ptr{l:addr}{n:int}(x: !dptr(l, n)):<> ptr(l)
//
overload ptrcast with dptr2ptr
//
(* ****** ****** *)

vtypedef
datum_vtype
(
l:addr, n:int
) = (* datum *)
$extype_struct
"atslib_libc_datum_type" of
{ dptr= dptr(l, n), dsize= int(n) }
// end of [datum]
//
stadef datum = datum_vtype
//
(* ****** ****** *)
//
vtypedef
datum =
[l:addr;n:int] datum(l, n)
vtypedef
datum0 =
[l:agez;n:int] datum(l, n)
vtypedef // for valid data
datum1 =
[l:addr;n:int | l > null; n >= 0] datum(l, n)
//
(* ****** ****** *)

fun
datum_is_valid
  {l:addr}{n:int}
(
x0: datum(l, n)
) : bool (l > null)
  = "mac#atslib_libc_gdbm_datum_is_valid"
// end of [datum_is_valid]

fun
datum_takeout_ptr
  {l:addr}{n:int}
(
x0: datum(l, n)
) :<> dptr (l, n)
  = "mac#atslib_libc_gdbm_datum_takeout_ptr"
// end of [datum_takeout_ptr]

(* ****** ****** *)
//
// HX: implemented in [gdbm.cats]
//
fun
datum_make0_string
  (string)
: [l:agz;n:nat]
(
  dptrout (l, n) | datum (l, n)
) = "mac#atslib_libc_gdbm_datum_make0_string"
//
fun
datum_make1_string
  (string): datum1
  = "mac#atslib_libc_gdbm_datum_make1_string"
//
(* ****** ****** *)

fun
datum_free(datum0): void = "mac#atslib_libc_gdbm_datum_free"

(* ****** ****** *)

(* end of [datum.hats] *)

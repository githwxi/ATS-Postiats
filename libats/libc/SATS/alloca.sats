(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: February, 2014
//
(* ****** ****** *)

%{#
#include \
"libats/libc/CATS/alloca.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.libc"
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "atslib_libc_"
//
(* ****** ****** *)

#define NSH(x) x // for commenting: no sharing
#define SHR(x) x // for commenting: it is shared

(* ****** ****** *)

fun alloca
  {dummy:addr}{n:int}
(
  pf: void@dummy | n: size_t (n)
) : [l:addr]
(
  bytes(n) @ l, bytes(n) @ l -> void@dummy | ptr(l)
) = "mac#%" // end of [alloca]

(* ****** ****** *)

(*
fun{
a:vt0p
} ptr_alloca
  {dummy:addr} (
  pf: void@dummy | (*void*)
) : [l:addr] (a? @ l, a? @ l -> void@dummy | ptr(l))
*)
fun
ptr_alloca_tsz
  {a:vt0p}{dummy:addr}
  (pf: void@dummy | tsz: sizeof_t(a))
: [l:addr] (a? @ l, a? @ l -> void@dummy | ptr(l)) = "mac#%"

(* ****** ****** *)

(*
fun{
a:vt0p
} array_ptr_alloca
  {dummy:addr}{n:int}
(
  pf: void@dummy | asz: size_t(n)
) : [l:addr] (array(a?,n)@l, array(a?,n)@l -> void@dummy | ptr(l))
*)
fun
array_ptr_alloca_tsz
  {a:vt0p}{dummy:addr}{n:int}
(
  pf: void@dummy | asz: size_t(n), tsz: sizeof_t(a)
) : [l:addr] (array(a?,n)@l, array(a?,n)@l -> void@dummy | ptr(l)) = "mac#%"

(* ****** ****** *)

(* end of [alloca.sats] *)

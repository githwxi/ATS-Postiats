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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2011
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [strptr.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

castfn
strnptr_of_strptr
  {l:addr} (x: strptr l): [n:int] strnptr (n, l)
// end of [strnptr_of_strptr]
castfn
strptr_of_strnptr
  {n:int}{l:addr} (x: strnptr (n, l)): strptr (l)
// end of [strptr_of_strnptr]

(* ****** ****** *)

viewtypedef
rstrptr = READ(strptr0)
viewtypedef
rstrnptr (n:int) = READ(strnptr(n))

(* ****** ****** *)

fun strptr_length (x: !rstrptr): ssize_t
fun strnptr_length {n:int} (x: !rstrnptr n): ssize_t (n)

(* ****** ****** *)

fun strptr_append (
  x1: !rstrptr, x2: !rstrptr
) : strptr0 = "atspre_strptr_append"

fun strnptr_append
  {n1,n2:nat} (
  x1: !rstrnptr n1, x2: !rstrnptr n2
) : strnptr (n1+n2) = "atspre_strnptr_append"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [strptr.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [strptr.sats] *)

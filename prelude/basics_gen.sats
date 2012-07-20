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
// Start Time: July, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_gen.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

fun{a:vt0p}
ginit_ref (x: &a? >> a):<!wrt> void
fun{a:vt0p}
gclear_ref (x: &a >> a?):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
gequal_val (x: !INV(a), y: !a):<> bool
fun{a:vt0p}
gequal_ref (x: &INV(a), y: &a):<> bool

(* ****** ****** *)

fun{a:vt0p}
glt_val (x: !INV(a), y: !a):<> bool
fun{a:vt0p}
glte_val (x: !INV(a), y: !a):<> bool
fun{a:vt0p}
ggt_val (x: !INV(a), y: !a):<> bool
fun{a:vt0p}
ggte_val (x: !INV(a), y: !a):<> bool
fun{a:vt0p}
geq_val (x: !INV(a), y: !a):<> bool
fun{a:vt0p}
gneq_val (x: !INV(a), y: !a):<> bool
fun{a:vt0p}
gcompare_val (x: !INV(a), y: !a):<> int

fun{a:vt0p}
glt_ref (x: &INV(a), y: &a):<> bool
fun{a:vt0p}
glte_ref (x: &INV(a), y: &a):<> bool
fun{a:vt0p}
ggt_ref (x: &INV(a), y: &a):<> bool
fun{a:vt0p}
ggte_ref (x: &INV(a), y: &a):<> bool
fun{a:vt0p}
geq_ref (x: &INV(a), y: &a):<> bool
fun{a:vt0p}
gneq_ref (x: &INV(a), y: &a):<> bool
fun{a:vt0p}
gcompare_ref (x: &INV(a), y: &a):<> int

(* ****** ****** *)
//
// generic number operations
//
fun{a:vt0p}
gadd_val (x: !INV(a), y: !a):<> a
fun{a:vt0p}
gsub_val (x: !INV(a), y: !a):<> a
fun{a:vt0p}
gmul_val (x: !INV(a), y: !a):<> a
fun{a:vt0p}
gdiv_val (x: !INV(a), y: !a):<> a
fun{a:vt0p}
gmod_val (x: !INV(a), y: !a):<> a

(* ****** ****** *)

fun{a:vt0p} tostring_val (x: !INV(a)):<> string
fun{a:vt0p} tostring_ref (x: &INV(a)):<> string

fun{a:vt0p} tostrptr_val (x: !INV(a)):<> Strptr1
fun{a:vt0p} tostrptr_ref (x: &INV(a)):<> Strptr1

(* ****** ****** *)

fun{a:vt0p}
fprint_val (out: FILEref, x: !INV(a)): void
fun{a:vt0p}
print_val (x: !INV(a)): void // = fprint_val (stdout_ref, x)
fun{a:vt0p}
prerr_val (x: !INV(a)): void // = fprint_val (stderr_ref, x)

fun{a:vt0p}
fprint_ref (out: FILEref, x: &INV(a)): void
fun{a:vt0p}
print_ref (x: &INV(a)): void // = fprint_ref (stdout_ref, x)
fun{a:vt0p}
prerr_ref (x: &INV(a)): void // = fprint_ref (stderr_ref, x)

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [basics_gen.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [basics_gen.sats] *)

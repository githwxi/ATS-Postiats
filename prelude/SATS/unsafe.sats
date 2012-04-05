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

(* author: Hongwei Xi (hwxi AT cs DOT bu DOT edu) *)

(* ****** ****** *)
//
// HX: only if you know what you are doing ...
//
fun{a:viewt@ype} ptr_get (p: ptr):<> a
fun{a:viewt@ype} ptr_set (p: ptr, x: a):<> void
fun{a:viewt@ype} ptr_exch (p: ptr, x: &a >> a):<> void
//
(* ****** ****** *)
//
// HX: only if you know what you are doing ...
//
castfn
ptr2cptr {a:viewt@ype}{l:addr} (p: ptr l): cptr (a, l)
//
fun{a:viewt@ype} cptr_get (p: cptr (INV(a))):<> a
fun{a:viewt@ype} cptr_set (p: cptr (a), x: a):<> void
fun{a:viewt@ype} cptr_exch (p: cptr (a), x: &a >> a):<> void
//
(* ****** ****** *)

(* end of [unsafe.sats] *)

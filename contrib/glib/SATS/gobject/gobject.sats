(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
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
// Authoremail: hwxiATcsDOTbuDOTedu
// Start Time: April, 2010
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: September, 2013
//
(* ****** ****** *)

fun g_object_is_floating
  {c:cls | c <= GObject} (!gobjref1 (c)): bool = "mac#%"

(* ****** ****** *)

fun g_object_ref_count
  {c:cls | c <= GObject} (x: !gobjref1 (c)): int = "mac#%"

(* ****** ****** *)

fun g_object_ref
  {c:cls | c <= GObject}
  {l:agz} (x: !gobjref (c, l)): gobjref (c, l) = "mac#%"
// end of [g_object_ref]

fun g_object_unref
  {c:cls | c <= GObject}{l:agz} (x: gobjref (c, l)): void = "mac#%"

(* ****** ****** *)

(* end of [gobject.sats] *)

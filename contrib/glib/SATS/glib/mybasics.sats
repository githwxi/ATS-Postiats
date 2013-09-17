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
// Start Time: February, 2010
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: September, 2013
//
(* ****** ****** *)

macdef GTRUE = $extval (gboolean, "TRUE")
macdef GFALSE = $extval (gboolean, "FALSE")

(* ****** ****** *)
//
symintr gint
symintr guint
//
castfn gint_of_int (int):<> gint
castfn guint_of_int (int):<> guint
castfn guint_of_uint (uint):<> guint
//
overload gint with gint_of_int
//
overload guint with guint_of_int
overload guint with guint_of_uint
//
(* ****** ****** *)

castfn gint2int (gint):<> int
castfn guint2uint (guint):<> uint

(* ****** ****** *)
//
symintr gpointer
//
castfn
gpointer_of_ptr (p: ptr): gpointer
overload gpointer with gpointer_of_ptr
//
(* ****** ****** *)
//
symintr gstring
//
castfn
gstring_of_string (string): gstring
overload gstring with gstring_of_string
//
(* ****** ****** *)

(* end of [glib_basics.sats] *)

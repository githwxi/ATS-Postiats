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

abstype gsignal = ptr // gchar*

(* ****** ****** *)

castfn gsignal (x: string):<> gsignal

(* ****** ****** *)
//
macdef
GSIGNAL_ACTIVATE = $extval (gsignal, "\"activate\"")
//
macdef GSIGNAL_CLICKED = $extval (gsignal, "\"clicked\"")
//
macdef GSIGNAL_DESTROY = $extval (gsignal, "\"destroy\"")
//
macdef GSIGNAL_EVENT = $extval (gsignal, "\"event\"")
macdef GSIGNAL_DELETE_EVENT = $extval (gsignal, "\"delete_event\"")
//
(* ****** ****** *)

fun g_signal_connect
(
  x: !GObject1, sig: gsignal, handler: GCallback, data: gpointer
) : guint = "mac#%" // endfun

(* ****** ****** *)

fun g_signal_connect_swapped
(
  gobj: !GObject1, sig: gsignal, handler: GCallback, data: !GObject1
) : guint = "mac#%" // endfun

(* ****** ****** *)

(* end of [gsignal.sats] *)

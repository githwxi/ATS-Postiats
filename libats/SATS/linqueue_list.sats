(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, Boston University
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
** along  with  ATS;  see  the  file  COPYING.  If not, write to the Free
** Software Foundation, 51  Franklin  Street,  Fifth  Floor,  Boston,  MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(*
**
** A list-based queue implementation
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: July, 2010 // based on a version done in October, 2008
**
*)

(* ****** ****** *)
//
// HX-2012-12: ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)
//
// HX: no need for staloading at
#define ATS_STALOADFLAG 0 // run-time
//
(* ****** ****** *)

%{#
#include "libats/CATS/linqueue_list.cats"
%} // end of [%{#]

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

#include "./SHARE/linqueue.hats"
#include "./SHARE/linqueue_node.hats"

(* ****** ****** *)

absviewt@ype
queue_struct =
  $extype "atslib_linqueue_list_queue_struct"
// end of [queue_struct]

(* ****** ****** *)

fun{a:vt0p}
queue_make_ngc {l:addr}
  (pf: queue_struct? @ l | p: ptr l): (free_ngc_v (l) | queue (a, 0))
// end of [queue_make_ngc]

(* ****** ****** *)

fun{a:vt0p}
queue_free_ngc
  {l:addr} (
  pf: free_ngc_v l | p: ptr l, q: queue (INV(a), 0)
) :<!wrt> (queue_struct? @ l | void) // endfun

(* ****** ****** *)

(* end of [linqueue_list.sats] *)

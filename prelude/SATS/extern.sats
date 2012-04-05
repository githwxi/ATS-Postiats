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

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [extern.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

abstype
cptr_viewt0ype_addr_type
  (a:viewt@ype+, addr) // HX: simulating C pointers
stadef cptr = cptr_viewt0ype_addr_type

castfn
cptr2ptr {a:viewt@ype}{l:addr} (p: cptr (a, l)): ptr l
// end of [castfn]

(* ****** ****** *)
//
// HX: note that (vt1 \minus v2) roughly means that a ticket of
// [v2] is taken from [vt1]; the ticket must be returned before
// [vt1] is consumed. However, the ticket should not be issued
// repeatedly for otherwise safety may be potentially compromised.
//
absview
minus_viewt0ype_view
  (vt1: viewt@ype, v2: view) = vt1
stadef minus = minus_viewt0ype_view
prfun minus_addback
  {vt1:viewt@ype} {v2:view} (pf1: minus (vt1, v2), pf2: v2 | x: !vt1): void
// end of [minus_addback]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [extern.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* end of [extern.sats] *)

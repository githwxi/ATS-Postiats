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
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [option_vt.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

sortdef vt0p = viewt@ype

(* ****** ****** *)

fun{}
option_vt_is_some{a:vt0p}
  {b:bool} (opt: !option_vt (a, b)):<> bool (b)
// end of [option_vt_is_some]

fun{}
option_vt_is_none{a:vt0p}
  {b:bool} (opt: !option_vt (a, b)):<> bool (~b)
// end of [option_vt_is_none]

(* ****** ****** *)

fun{a:t@ype}
option_vt_unsome (opt: option_vt (a, true)):<> a

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [option_vt.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [option_vt.sats] *)

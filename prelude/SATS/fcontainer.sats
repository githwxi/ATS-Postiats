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
#print "Loading [fcontainer.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

fun{
xs:t@ype // container
}{
x:t@ype // type for elements
} foreach_funenv
  {v:view}{vt:viewtype}{fe:eff} (
  pfv: !v | xs: xs, f: (!v | x, !vt) -<fun,fe> void, env: !vt
) :<fe> void // end of [foreach_funenv]

fun{
xs:t@ype}{x:t@ype
} foreach_fun {fe:eff}
  (xs: xs, f: (x) -<fun,fe> void):<fe> void
// end of [foreach_fun]

fun{
xs:t@ype}{x:t@ype
} foreach_clo {fe:eff}
  (xs: xs, f: &(x) -<clo,fe> void):<fe> void
// end of [foreach_clo]
fun{
xs:t@ype}{x:t@ype
} foreach_vclo {v:view} {fe:eff}
  (pfv: !v | xs: xs, f: &(!v | x) -<clo,fe> void):<fe> void
// end of [foreach_vclo]

fun{
xs:t@ype}{x:t@ype
} foreach_cloptr {fe:eff}
  (xs: xs, f: !(x) -<cloptr,fe> void):<fe> void
fun{
xs:t@ype}{x:t@ype
} foreach_vcloptr {v:view} {fe:eff}
  (pfv: !v | xs: xs, f: !(!v | x) -<cloptr,fe> void):<fe> void
// end of [foreach_vcloptr]

fun{
xs:t@ype}{x:t@ype
} foreach_cloref {fe:eff}
  (xs: xs, f: (x) -<cloref,fe> void):<fe> void
// end of [foreach_cloref]

(* ****** ****** *)

fun{
xs:t@ype // container
}{
x:t@ype // type for elements
} iforeach_funenv
  {v:view}{vt:viewtype}{fe:eff} (
  pfv: !v | xs: xs, f: (!v | int, x, !vt) -<fun,fe> void, env: !vt
) :<fe> uint // end of [iforeach_funenv]

fun{
xs:t@ype}{x:t@ype
} iforeach_clo {fe:eff}
  (xs: xs, f: &(int, x) -<clo,fe> void):<fe> uint
// end of [iforeach_clo]
fun{
xs:t@ype}{x:t@ype
} iforeach_vclo {v:view} {fe:eff}
  (pfv: !v | xs: xs, f: &(!v | int, x) -<clo,fe> void):<fe> uint
// end of [iforeach_vclo]

fun{
xs:t@ype}{x:t@ype
} iforeach_cloptr {fe:eff}
  (xs: xs, f: !(int, x) -<cloptr,fe> void):<fe> uint
fun{
xs:t@ype}{x:t@ype
} iforeach_vcloptr {v:view} {fe:eff}
  (pfv: !v | xs: xs, f: !(!v | int, x) -<cloptr,fe> void):<fe> uint
// end of [iforeach_vcloptr]

fun{
xs:t@ype}{x:t@ype
} iforeach_cloref {fe:eff}
  (xs: xs, f: (int, x) -<cloref,fe> void):<fe> uint
// end of [iforeach_cloref]

(* ****** ****** *)

fun{
xs:t@ype}{x:t@ype
} exists_funenv
  {v:view} {vt:viewtype} {pe:eff} (
  pf: !v | xs: xs, p: (!v | x, !vt) -<fun,pe> bool, env: !vt
) :<pe> bool // end of [exists_funenv]

(* ****** ****** *)

fun{
xs:t@ype}{x:t@ype
} listize (xs: xs):<> List_vt (x)
fun{
xs:t@ype
}{
x:t@ype}{y:viewt@ype
} listize_funenv
  {v:view}{vt:viewtype}{fe:eff} (
  pfv: !v | xs: xs, f: (!v | x, !vt) -<fun,fe> y, env: !vt
) :<fe> List_vt (y)

(* ****** ****** *)

fun{
xs:t@ype}{x:t@ype
} rlistize (xs: xs):<> List_vt (x)
fun{
xs:t@ype
}{
x:t@ype}{y:viewt@ype
} rlistize_funenv
  {v:view}{vt:viewtype}{fe:eff} (
  pfv: !v | xs: xs, f: (!v | x, !vt) -<fun,fe> y, env: !vt
) :<fe> List_vt (y)

(* ****** ****** *)

fun{
xs:t@ype}{x:t@ype
} streamize (xs: xs):<> stream (x)
fun{
xs:t@ype}{x:t@ype
} streamize_vt (xs: xs):<> stream_vt (x)

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fcontainer.sats] *)

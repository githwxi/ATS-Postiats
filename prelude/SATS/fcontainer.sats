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
  {v:view}{env:viewtype}{f:eff} (
  pf: !v | xs: xs, f: (!v | x, !env) -<fun,f> void, env: !env
) :<f> void // end of [foreach_funenv]

fun{
xs:t@ype}{x:t@ype
} foreach_fun {f:eff}
  (xs: xs, f: (x) -<fun,f> void):<f> void
// end of [foreach_fun]

fun{
xs:t@ype}{x:t@ype
} foreach_clo {f:eff}
  (xs: xs, f: &(x) -<clo,f> void):<f> void
// end of [foreach_clo]
fun{
xs:t@ype}{x:t@ype
} foreach_vclo {v:view} {f:eff}
  (pf: !v | xs: xs, f: &(!v | x) -<clo,f> void):<f> void
// end of [foreach_vclo]

fun{
xs:t@ype}{x:t@ype
} foreach_cloptr {f:eff}
  (xs: xs, f: !(x) -<cloptr,f> void):<f> void
fun{
xs:t@ype}{x:t@ype
} foreach_vcloptr {v:view} {f:eff}
  (pf: !v | xs: xs, f: !(!v | x) -<cloptr,f> void):<f> void
// end of [foreach_vcloptr]

fun{
xs:t@ype}{x:t@ype
} foreach_cloref {f:eff}
  (xs: xs, f: (x) -<cloref,f> void):<f> void
// end of [foreach_cloref]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fcontainer.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fcontainer.sats] *)

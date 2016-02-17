(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_define.hats"
//
#include
"share\
/atspre_staload.hats"
//
#include
"share\
/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload "libc/SATS/time.sats"

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"utils/atexting/SATS/atexting.sats"
//
(* ****** ****** *)

local

fun
mytime() =
  str2 where
{
//
var t_now
  : time_t = time_get()
//
val (fpf | str) = ctime(t_now)
//
val str2 =
(
if
isneqz(str)
then strptr2string(strptr1_copy(str))
else "__mytime()__"
// end of [if]
) : string // end of [val]
//
prval ((*void*)) = fpf(str)
//
} (* end of [mytime] *)

val
def0 =
TEXTDEFfun
(
lam(loc, _) =>
  atext_make_string(loc, mytime())
) (* TEXTDEFfun *)

in (* in-of-local *)

val () = the_atextdef_insert("mytime", def0)

end // end of [local]

(* ****** ****** *)

local

fun
fp64
(
  loc: loc_t, xs: atextlst
) : atext = let
//
val-cons0(x, xs) = xs
val rep = atext_strngfy(x)
//
val strlst =
$list{string}
  ("$UN.cast{double(", rep, ")}(", rep, ")")
//
val strlst = g0ofg1(strlst)
//
in
//
atext_make_string(loc, stringlst_concat(strlst))
//
end // end of [fp64]

val def0 = TEXTDEFfun(lam(loc, xs) => fp64(loc, xs))

in (* in-of-local *)

val () = the_atextdef_insert("fp64", def0)
val () = the_atextdef_insert("float64", def0)

end // end of [local]

(* ****** ****** *)

(* end of [atexting_myutil.dats] *)

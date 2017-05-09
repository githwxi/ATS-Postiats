(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: June, 2013 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload "libats/ML/SATS/stdlib.sats"

(* ****** ****** *)

implement
{}(*tmp*)
getenv_exn (name) = let
//
val str = $STDLIB.getenv_gc (name)
//
in
//
if isneqz (str) then
  strptr2string (str)
else let
  prval (
  ) = strptr_free_null (str)
  val () = prerrln! "exit(ATS): [getenv_exn]: variable [" name "] is undefined."
in
  exit (1)
end // end of [if]
//
end // end of [getenv_exn]

(* ****** ****** *)

implement
{}(*tmp*)
getenv_opt (name) = let
//
val str = $STDLIB.getenv_gc (name)
//
in
//
if isneqz (str) then
  Some0 (strptr2string (str))
else let
  prval () = strptr_free_null (str)
in
  None0 ()
end (* end of [if] *)
//
end // end of [getenv_opt]

(* ****** ****** *)
//
implement
{}(*tmp*)
setenv_exn
  (name, value, ow) = let
//
val err = $STDLIB.setenv (name, value, ow)
//
in
//
if
err < 0
then let
//
val () =
prerrln!
(
"exit(ATS): [setenv_exn]: variable: [")(name)("] cannot be set."
) (* prerrln! *)
//
in
  exit (1)
end else () // end of [if]
//
end // end of [setenv_exn]
//
implement
{}(*tmp*)
setenv_err
(
  name, value, ow
) = $STDLIB.setenv (name, value, ow)
// end of [setenv_err]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
randint(n) =
  $UN.cast($UN.cast2int($STDLIB.random()) % n)
//
(* ****** ****** *)

implement
{}(*tmp*)
streamize_random
  () = auxmain() where
{
//
fun
auxmain
(
// argless
) :
stream_vt(Nat) = $ldelay
(
//
let
//
val r = $STDLIB.random()
val r = $UN.cast{intGte(0)}(r)
//
in
//
  stream_vt_cons(r, auxmain())
//
end // end of [let]
//
) (* end of [auxmain] *)
//
} (* end of [streamize_random] *)

(* ****** ****** *)

implement
{}(*tmp*)
streamize_randint
{n}(n) = auxmain() where
{
//
fun
auxmain
(
// argless
) :
stream_vt(natLt(n)) = $ldelay
(
//
let
//
val r = $STDLIB.random()
val r = $UN.cast{intGte(0)}(r)
//
in
  stream_vt_cons(nmod(r, n), auxmain())
end // end of [let]
//
) (* end of [auxmain] *)
//
} (* end of [streamize_randint] *)

(* ****** ****** *)

(* end of [stdlib.dats] *)

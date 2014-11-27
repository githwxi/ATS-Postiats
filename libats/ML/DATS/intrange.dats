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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: September, 2014 *)

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload "libats/ML/SATS/intrange.sats"

(* ****** ****** *)
//
implement
{}(*tmp*)
int_repeat_lazy
  (n, f) =
  int_repeat_cloref<> (n, lazy2cloref(f))
//
(* ****** ****** *)

implement
{}(*tmp*)
int_repeat_cloref
  (n, f) = let
//
fun
loop
(
  n: int, f: cfun0(void)
) : void = (
//
if n > 0
  then let val () = f () in loop (n-1, f) end
  else ()
//
) (* end of [loop] *)
//
in
  loop (n, f)
end // end of [int_repeat_cloref]

(* ****** ****** *)
//
implement
{}(*tmp*)
int_foreach_cloref
  (n, f) = intrange_foreach_cloref<> (0, n, f)
//
(* ****** ****** *)

implement
{}(*tmp*)
intrange_foreach_cloref
  (l, r, f) = let
//
fun
loop
(
  l: int, r: int, f: cfun1(int, void)
) : void = (
//
if l < r
  then let val () = f (l) in loop (l+1, r, f) end
  else ()
//
) (* end of [loop] *)
//
in
  loop (l, r, f)
end // end of [intrange_foreach_cloref]

(* ****** ****** *)

(* end of [intrange.dats] *)

(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi
// Start Time: December, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
#staload
"libats/ATS2/SATS/fcntainer2.sats"
//
(* ****** ****** *)

implement
{xs}{x}
foreach(xs) = let
//
implement
forall$test<x>(x) =
let
val () =
foreach$fwork<x>(x) in true
end // end of [forall$test]
//
in
  ignoret(forall<xs><x>(xs))
end // end of [foreach]

implement
{xs}{x}
foreach_cloref
  (xs, fwork) = let
//
implement
foreach$fwork<x>
  (x) = fwork(x)
//
in
  $effmask_all(foreach<xs><x>(xs))
end // end of [foreach_cloref]

(* ****** ****** *)

implement
{xs}{x}
iforeach(xs) = let
//
var i0: Nat = 0
val p0 = addr@(i0)
//
implement
foreach$fwork<x>(x) =
iforeach$fwork(i0, x) where
{
val i0 = $UN.ptr0_get<intGte(0)>(p0)
val () = $UN.ptr0_set<intGte(0)>(p0, i0+1)
}
//
in
  foreach<xs><x>(xs)
end // end of [iforeach]

implement
{xs}{x}
iforeach_cloref
  (xs, fwork) = let
//
implement
iforeach$fwork<x>
  (i, x) = fwork(i, x)
//
in
  $effmask_all(iforeach<xs><x>(xs))
end // end of [iforeach_cloref]

(* ****** ****** *)

(* end of [fcntainer2.dats] *)

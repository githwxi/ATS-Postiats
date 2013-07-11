(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"

(* ****** ****** *)

implement{a}
gmatrix_foreach (A, m, n) = let
  var env: void = () in gmatrix_foreach_env<a><void> (A, m, n, env)
end // end of [gmatrix_foreach]

implement
{a}{env}
gmatrix_foreach_env
  (A, m, n, env) = let
//
implement
array_foreach$cont<a><env> (x, env) = true
implement
array_foreach$fwork<a><env> (x, env) = gmatrix_foreach$fwork<a><env> (x, env)
//
val p = addr@(A)
prval pf = gmatrix2array_v (view@(A))
val _(*mn*) = array_foreach_env<a> (!p, m*n, env)
prval () = view@(A) := array2gmatrix_v (pf)
//
in
  // nothing
end // end of [gmatrix_foreach_env]

(* ****** ****** *)

(* end of [gmatrix.dats] *)

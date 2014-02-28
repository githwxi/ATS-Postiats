(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: February, 2014 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/matrix0.sats"

(* ****** ****** *)
//
implement{}
matrix0_of_mtrxszref{a}(A) = $UN.cast{matrix0(a)}(A)
//
implement{}
mtrxszref_of_matrix0{a}(A) = $UN.cast{mtrxszref(a)}(A)
//
(* ****** ****** *)

implement
{a}(*tmp*)
matrix0_make_elt
  (nrow, ncol, x0) =
  matrix0_of_mtrxszref (mtrxszref_make_elt<a> (nrow, ncol, x0))
// end of [matrix0_make_elt]

(* ****** ****** *)

implement
{a}{tk}
matrix0_get_at_gint
  (M0, i, j) = let
in
//
if i >= 0
then (
if j >= 0 then
  matrix0_get_at_size<a> (M0, g0i2u(i), g0i2u(j))
else
  $raise MatrixSubscriptExn((*void*)) // neg index
// end of [if]
) else
  $raise MatrixSubscriptExn((*void*)) // neg index
// end of [if]
//
end // end of [matrix0_get_at_gint]

implement
{a}{tk}
matrix0_get_at_guint
  (M0, i, j) =
(
  matrix0_get_at_size<a> (M0, g0u2u(i), g0u2u(j))
) // end of [matrix0_get_at_guint]

(* ****** ****** *)

implement{a}
matrix0_get_at_size
  (M0, i, j) = let
  val MSZ =
    mtrxszref_of_matrix0 (M0) in mtrxszref_get_at_size (MSZ, i, j)
  // end of [val]
end // end of [matrix0_get_at_size]

(* ****** ****** *)

implement
{a}{tk}
matrix0_set_at_gint
  (M0, i, j, x) = let
in
//
if i >= 0
then (
if j >= 0 then
  matrix0_set_at_size<a> (M0, g0i2u(i), g0i2u(j), x)
else
  $raise MatrixSubscriptExn((*void*)) (* neg index *)
// end of [if]
) else
  $raise MatrixSubscriptExn((*void*)) (* neg index *)
// end of [if]
//
end // end of [matrix0_set_at_gint]

implement
{a}{tk}
matrix0_set_at_guint
  (M0, i, j, x) =
(
  matrix0_set_at_size<a> (M0, g0u2u(i), g0u2u(j), x)
) // end of [matrix0_set_at_guint]

(* ****** ****** *)

implement{a}
matrix0_set_at_size
  (M0, i, j, x) = let
  val MSZ =
    mtrxszref_of_matrix0 (M0) in mtrxszref_set_at_size (MSZ, i, j, x)
  // end of [val]
end // end of [matrix0_set_at_size]

(* ****** ****** *)

implement{a}
fprint_matrix0 (out, M) =
fprint_mtrxszref (out, mtrxszref_of_matrix0 (M))

(* ****** ****** *)

implement{a}
matrix0_tabulate
  (nrow, ncol, f) = let
//
implement{a2}
matrix_tabulate$fopr
  (i, j) = $UN.castvwtp0{a2}(f(i,j))
//
val MSZ = mtrxszref_tabulate<a> (nrow, ncol)
//
in
  matrix0_of_mtrxszref (MSZ)  
end // end of [matrix0_tabulate]

(* ****** ****** *)

(* end of [matrix.dats] *)

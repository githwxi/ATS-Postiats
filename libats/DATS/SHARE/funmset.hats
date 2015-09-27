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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: September, 2015 *)

(* ****** ****** *)

implement
{a}(*tmp*)
compare_elt_elt = gcompare_val_val<a>

(* ****** ****** *)
//
implement
{}(*tmp*)
funmset_isnot_nil
  (xs) = not(funmset_is_nil<> (xs))
//
(* ****** ****** *)

implement
{a}(*tmp*)
funmset_isnot_member
  (xs, x0) = not(funmset_is_member<a> (xs, x0))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
fprint_funmset$sep
  (out) = fprint_string (out, ", ")
//
implement
{a}(*tmp*)
fprint_mset_sep
  (out, xs, sep) = let
//
implement{}
fprint_mset$sep(out) = fprint_string(out, sep)
//
in
  fprint_mset<a> (out, xs)
end // end of [fprint_mset]
//
(* ****** ****** *)

(* end of [funmset.hats] *)

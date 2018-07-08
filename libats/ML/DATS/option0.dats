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
(* Start time: July, 2012 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/option0.sats"

(* ****** ****** *)
//
implement
{a}(*tmp*)
option0_some(x) = Some0{a}(x)
//
implement{}
option0_none((*void*)) = None0((*void*))
//
(* ****** ****** *)

implement{}
option0_is_some(opt) =
(
//
case+ opt of
| Some0 _ => true | None0 _ => false
//
) // end of [option0_is_some]

implement{}
option0_is_none(opt) =
(
//
case+ opt of
| Some0 _ => false | None0 _ => true
//
) // end of [option0_is_none]

(* ****** ****** *)

implement
{a}(*tmp*)
option0_unsome_exn
  (opt) =
(
//
case+ opt of
| Some0(x) => x
| None0 _  => $raise NotSomeExn()
//
) // end of [option0_unsome_exn]

(* ****** ****** *)
//
implement
{a}{b}
option0_map
  (opt, fopr) =
(
case+ opt of
| None0() => None0()
| Some0(x) => Some0(fopr(x))
) (* end of [option0_map] *)
//
implement
{a}{b}
option0_map_method
(
  opt, _(*TYPE*)
) =
(
lam(fopr) => option0_map<a>(opt, fopr)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
option0_filter(opt, pred) =
(
case+ opt of
| None0 _ =>
  None0((*void*))
| Some0 x =>
  if pred(x) then opt else None0()
) (* end of [option0_map] *)
//
implement
{a}(*tmp*)
option0_filter_method
(
  opt
) =
(
lam(pred) => option0_filter<a>(opt, pred)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
option0_foreach
  (opt, fwork) =
(
case+ opt of
| None0() => () | Some0(x) => fwork(x)
)
implement
{a}(*tmp*)
option0_foreach_method
(
  opt
) =
(
lam(fwork) => option0_foreach<a>(opt, fwork)
)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
print_option0
  (opt) =
  fprint_option0<a>(stdout_ref, opt)
implement
{a}(*tmp*)
prerr_option0
  (opt) =
  fprint_option0<a>(stderr_ref, opt)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
fprint_option0
(
  out, opt
) = let
//
val
opt =
g1ofg0_option(opt)
//
in
  fprint_option<a>(out, opt)
end // end of [fprint_option0]
//
(* ****** ****** *)
//
implement
(a)(*tmp*)
fprint_val<option0(a)>
  (out, x) = fprint_option0<a>(out, x)
//
(* ****** ****** *)

(* end of [option0.dats] *)

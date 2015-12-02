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
(* Authoremail:
   gmhwxiATgmailDOTcom *)
(* Start time: December, 2015 *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/gvalue.sats"

(* ****** ****** *)
//
implement
print_gvalue(x0) =
  fprint_gvalue(stdout_ref, x0)
//
implement
prerr_gvalue(x0) =
  fprint_gvalue(stderr_ref, x0)
//
(* ****** ****** *)

implement
fprint_gvalue
  (out, gv0) = let
(*
// fprint_gvalue: enter
*)
in
//
case+ gv0 of
| GVnil() => fprint! (out, "GVnil(", ")")
//
| GVint(i) => fprint! (out, "GVint(", i, ")")
//
| GVbool(b) => fprint! (out, "GVbool(", b, ")")
| GVchar(c) => fprint! (out, "GVchar(", c, ")")
//
| GVfloat(x) => fprint! (out, "GVfloat(", x, ")")
| GVstring(x) => fprint! (out, "GVstring(", x, ")")
//
| GVlist(xs) => fprint! (out, "GVlist(", xs, ")")
//
| GVarray(xs) => fprint! (out, "GVarray(", xs, ")")
//
| GVhashtbl(kxs) => fprint! (out, "GVhashtbl(", kxs, ")")
//
end // end of [fprint_gvalue]

(* ****** ****** *)

implement
fprint_val<gvalue> = fprint_gvalue

(* ****** ****** *)

(* end of [gvalue.dats] *)

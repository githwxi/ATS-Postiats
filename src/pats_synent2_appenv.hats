(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author:
// Hongwei Xi
// Authoremail:
// gmhwxiATgmailDOTcom
// Start Time: December, 2014
//
(* ****** ****** *)
//
// HX-2014-12-09:
// This one implements a standard [app] function over the level-2 syntax tree
// Note that [app] is often referred to as [foreach]
//
(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

abstype appenv = ptr

(* ****** ****** *)
//
typedef
synent_app
  (a:type) = (a, appenv) -> void
//
(* ****** ****** *)
  
extern
fun s2cst_app : synent_app (s2cst)  

(* ****** ****** *)

extern
fun s2var_app : synent_app (s2var)
  
(* ****** ****** *)

extern
fun d2con_app : synent_app (d2con)

(* ****** ****** *)

extern
fun s2exp_app : synent_app (s2exp)
extern
fun s2explst_app : synent_app (s2explst)

(* ****** ****** *)

extern
fun d2cst_app : synent_app (d2cst)  

(* ****** ****** *)

extern
fun d2var_app : synent_app (d2var)
  
(* ****** ****** *)

extern
fun d2exp_app : synent_app (d2exp)
extern
fun d2explst_app : synent_app (d2explst)

(* ****** ****** *)

implement
s2explst_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    s2exp_app(x, env); s2explst_app(xs, env)
  )
//
end (* end of [s2explst_app] *)

(* ****** ****** *)

implement
d2explst_app
  (xs, env) = let
in
//
case+ xs of
| list_nil () => ()
| list_cons (x, xs) =>
  (
    d2exp_app(x, env); d2explst_app(xs, env)
  )
//
end (* end of [d2explst_app] *)

(* ****** ****** *)

(* end of [pats_synent2_appenv.dats] *)

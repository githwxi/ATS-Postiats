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
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: November, 2013
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_stamp.sats"
staload "./pats_symbol.sats"
staload "./pats_location.sats"

(* ****** ****** *)

staload "./pats_jsonize.sats"

(* ****** ****** *)

implement
jsonval_int (i) =
  JSONint (lint_of_int(i))

implement
jsonval_bool (b) = JSONbool (b)

implement
jsonval_double (d) = JSONfloat (d)

implement
jsonval_string (str) = JSONstring (str)

(* ****** ****** *)

implement
jsonval_loc (loc) = JSONloc (loc)

(* ****** ****** *)

implement
jsonval_list (xs) = JSONlist (xs)

implement
jsonval_sing (x) = JSONlist (list_sing(x))
implement
jsonval_pair (x1, x2) = JSONlist (list_pair(x1, x2))

(* ****** ****** *)
//
implement
jsonval_labval (l, jsv) =
  JSONlablist (list_cons((l, jsv), list_nil))
implement
jsonval_labval2 (l1, v1, l2, v2) =
  JSONlablist (list_cons((l1, v1), list_cons((l2, v2), list_nil)))
implement
jsonval_labval3
(
  l1, v1, l2, v2, l3, v3
) = JSONlablist
(
  list_cons((l1, v1), list_cons((l2, v2), list_cons((l3, v3), list_nil)))
) (* end of [jsonval_labval3] *)
implement
jsonval_labval4
(
  l1, v1, l2, v2, l3, v3, l4, v4
) = JSONlablist
(
  list_cons((l1, v1), list_cons((l2, v2), list_cons((l3, v3), list_cons((l4, v4), list_nil))))
) (* end of [jsonval_labval3] *)
//
(* ****** ****** *)

implement
fprint_jsonval
  (out, x0) = let
//
macdef
prstr (str) = fprint_string (out, ,(str))
//
in
//
case+ x0 of
| JSONnul () => prstr "{}"
| JSONint (i) => fprint_lint (out, i)
| JSONbool (b) => fprint_bool (out, b)
| JSONfloat (d) => fprint_double (out, d)
| JSONstring (str) => fprintf (out, "\"%s\"", @(str))
//
| JSONloc (loc) =>
  {
    val () = prstr "\""
    val () = fprint_location (out, loc)
    val () = prstr "\""
  } (* end of [JSONloc] *)
//
| JSONlist (xs) =>
  {
    val () = prstr "["
    val () = fprint_jsonvalist (out, xs)
    val () = prstr "]"
  }
//
| JSONlablist (lxs) =>
  {
    val () = prstr "{"
    val () = fprint_labjsonvalist (out, lxs)
    val () = prstr "}"
  }
//
end // end of [fprint_jsonval]

(* ****** ****** *)

implement
fprint_jsonvalist
  (out, xs0) = let
//
fun aux
(
  out: FILEref
, xs0: jsonvalist, i: int
) : void = let
in
//
case+ xs0 of
| list_nil () => ()
| list_cons (x, xs) => let
    val () =
      if i > 0
        then fprint (out, ", ")
      // end of [if]
    val () = fprint_jsonval (out, x)
  in
    aux (out, xs, i+1)
  end // end of [list_cons]
//
end // end of [aux]
//
in
  aux (out, xs0, 0)
end // end of [fprint_jsonvalist]

(* ****** ****** *)

implement
fprint_labjsonvalist
  (out, lxs0) = let
//
fun aux
(
  out: FILEref
, lxs0: labjsonvalist, i: int
) : void = let
in
//
case+ lxs0 of
| list_nil () => ()
| list_cons ((l, x), lxs) => let
    val () =
      if i > 0
        then fprint (out, ", ")
      // end of [if]
    val () = fprint_string (out, l)
    val () = fprint_string (out, ": ")
    val () = fprint_jsonval (out, x)
  in
    aux (out, lxs, i+1)
  end // end of [list_cons]
//
end // end of [aux]
//
in
  aux (out, lxs0, 0)
end // end of [fprint_labjsonvalist]

(* ****** ****** *)

implement
jsonize_anon (x0) = JSONnul () 

(* ****** ****** *)

datatype
funkind =
//
// end of [funkind]

implement
jsonize_funkind (knd) =
(
  case+ knd of
//
  | FK_fn () => jsonval_string "FK_fn"
  | FK_fnx () => jsonval_string "FK_fnx"
  | FK_fun () => jsonval_string "FK_fun"
//
  | FK_prfn () => jsonval_string "FK_prfn"
  | FK_prfun () => jsonval_string "FK_prfun"
//
  | FK_praxi () => jsonval_string "FK_praxi"
//
  | FK_castfn () => jsonval_string "FK_castfn"
//
) (* end of [jsonize_funkind] *)

implement
jsonize_valkind (knd) =
(
  case+ knd of
  | VK_val () => jsonval_string "VK_val"
  | VK_prval () => jsonval_string "VK_prval"
  | VK_val_pos () => jsonval_string "VK_val_pos"
  | VK_val_neg () => jsonval_string "VK_val_neg"
) (* end of [jsonize_valkind] *)

(* ****** ****** *)
//
implement
jsonize_stamp
  (x0) = jsonval_int (stamp_get_int (x0))
//
implement
jsonize_location (loc) = jsonval_loc (loc)
//
implement
jsonize_symbol
  (sym) = jsonval_string (symbol_get_name (sym))
//
(* ****** ****** *)

(* end of [pats_jsonize.dats] *)

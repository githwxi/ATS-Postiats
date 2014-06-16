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
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_stamp.sats"
staload "./pats_symbol.sats"
staload "./pats_location.sats"

(* ****** ****** *)

staload "./pats_label.sats"

(* ****** ****** *)

staload "./pats_jsonize.sats"

(* ****** ****** *)

implement
jsonval_int (i) = JSONint (i)

implement
jsonval_intinf (i) = JSONintinf (i)

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

#define :: list_cons

(* ****** ****** *)

implement
jsonval_sing (x) = JSONlist (list_sing(x))
implement
jsonval_pair (x1, x2) = JSONlist (list_pair(x1, x2))

(* ****** ****** *)
//
implement
jsonval_labval1 (l, x) =
  JSONlablist (list_cons((l, x), list_nil))
implement
jsonval_labval2 (l1, x1, l2, x2) =
  JSONlablist (list_cons((l1, x1), list_cons((l2, x2), list_nil)))
implement
jsonval_labval3
(
  l1, x1, l2, x2, l3, x3
) = JSONlablist ((l1, x1) :: (l2, x2) :: (l3, x3) :: list_nil(*void*))
implement
jsonval_labval4
(
  l1, x1, l2, x2, l3, x3, l4, x4
) = JSONlablist ((l1, x1) :: (l2, x2) :: (l3, x3) :: (l4, x4) :: list_nil)
//
implement
jsonval_labval5
(
  l1, x1, l2, x2, l3, x3, l4, x4, l5, x5
) = JSONlablist
(
  (l1, x1) :: (l2, x2) :: (l3, x3) :: (l4, x4) :: (l5, x5) :: list_nil
)
implement
jsonval_labval6
(
  l1, x1, l2, x2, l3, x3, l4, x4, l5, x5, l6, x6
) = JSONlablist
(
  (l1, x1) :: (l2, x2) :: (l3, x3) :: (l4, x4) :: (l5, x5) :: (l6, x6) :: list_nil
)
//
(* ****** ****** *)
//
implement
jsonval_conarg0
  (con) = jsonval_conarglst (con, list_nil)
implement
jsonval_conarg1
  (con, arg1) =
  jsonval_conarglst (con, list_sing (arg1))
implement
jsonval_conarg2
  (con, arg1, arg2) =
  jsonval_conarglst (con, list_pair (arg1, arg2))
implement
jsonval_conarg3
  (con, arg1, arg2, arg3) =
  jsonval_conarglst (con, arg1 :: arg2 :: arg3 :: list_nil)
implement
jsonval_conarg4
  (con, arg1, arg2, arg3, arg4) =
  jsonval_conarglst (con, arg1 :: arg2 :: arg3 :: arg4 :: list_nil())
//
implement
jsonval_conarglst
  (con, arglst) = jsonval_labval1 (con, JSONlist (arglst))
// end of [jsonval_conarglst]
  
(* ****** ****** *)
//
implement
jsonval_none () = JSONoption (None())
implement
jsonval_some (x) = JSONoption (Some(x))
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
| JSONint (i) => fprint_int (out, i)
| JSONintinf (i) =>
  {
    val () = fprint_char (out, '"')
    val () = $INTINF.fprint_intinf (out, i)
    val () = fprint_char (out, '"')
  }
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
| JSONlablist (lxs) =>
  {
    val () = prstr "{"
    val () = fprint_labjsonvalist (out, lxs)
    val () = prstr "}"
  }
//
| JSONoption (opt) =>
  {
    val () = prstr "["
    val () =
    (
      case+ opt of
      | Some x => fprint_jsonval (out, x) | None () => ()
    ) : void // end of [val]
    val () = prstr "]"
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
| list_cons
    (lx, lxs) => let
    val () =
      if i > 0
        then fprint (out, ", ")
      // end of [if]
    val () =
      fprintf (out, "\"%s\"", @(lx.0))
    val () = fprint_string (out, ": ")
    val () = fprint_jsonval (out, lx.1)
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

local

fun aux0
(
  name: string
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = JSONlist (list_nil())
in
  jsonval_labval2 ("funclo_name", name, "funclo_arglst", arglst)
end // end of [aux0]

fun aux1
(
  name: string, arg: jsonval
) : jsonval = let
  val name = jsonval_string (name)
  val arglst = jsonval_sing (arg)
in
  jsonval_labval2 ("funclo_name", name, "funclo_arglst", arglst)
end // end of [aux1]

in (* in of [local] *)

implement
jsonize_funclo (fc) =
(
  case+ fc of
  | FUNCLOfun () => aux0 ("FUNCLOfun")
  | FUNCLOclo (knd) => aux1 ("FUNCLOclo", jsonval_int (knd))
) (* end of [jsonize_funclo] *)

end // end of [local]

(* ****** ****** *)

implement
jsonize_caskind (knd) =
(
  case+ knd of
  | CK_case () => jsonval_string "CK_case"
  | CK_case_pos () => jsonval_string "CK_case_pos"
  | CK_case_neg () => jsonval_string "CK_case_neg"
) (* end of [jsonize_caskind] *)

(* ****** ****** *)

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

(* ****** ****** *)

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

implement
jsonize_dcstkind (knd) =
(
  case+ knd of
//
  | DCKfun () => jsonval_string "DCKfun"
  | DCKval () => jsonval_string "DCKval"
  | DCKpraxi () => jsonval_string "DCKpraxi"
  | DCKprfun () => jsonval_string "DCKprfun"
  | DCKprval () => jsonval_string "DCKprval"
  | DCKcastfn () => jsonval_string "DCKcastfn"
//
) (* end of [jsonize_dcstkind] *)

(* ****** ****** *)
//
implement
jsonize_stamp (x0) =
  jsonval_int (stamp_get_int (x0))
//
implement
jsonize_symbol (sym) =
  jsonval_string (symbol_get_name (sym))
//
implement
jsonize_location (loc) = jsonval_loc (loc)
//
(* ****** ****** *)

implement
jsonize_label
  (lab) = let
//
val opt = label_get_int (lab)
//
in
//
case+ opt of
| ~Some_vt (x) => let
    val jsv = jsonval_int (x)
  in
    jsonval_labval1 ("LABint", jsv)
  end (* end of [Some_vt] *)
| ~None_vt ((*void*)) => let
    val opt = label_get_sym (lab)
  in
    case+ opt of
    | ~Some_vt (sym) => let
        val jsv = jsonize_symbol (sym)
      in
        jsonval_labval1 ("LABsym", jsv)
      end // end of [Some_vt]
    | ~None_vt ((*void*)) => JSONnul ((*void*))
  end (* end of [None_vt] *)
//
end // end of [jsonize_label]

(* ****** ****** *)

implement
jsonize_ignored (x0) = JSONnul ((*void*)) 

(* ****** ****** *)

implement
jsonize_list_fun
  {a} (xs, f) = let
//
val jsvs = list_map_fun<a> (xs, f)
//
in
  JSONlist (list_of_list_vt(jsvs))
end // end of [jsonize_list_fun]

(* ****** ****** *)

implement
jsonize_option_fun
  {a} (opt, f) = let
in
//
case+ opt of
| None () => jsonval_none ()
| Some (x) => jsonval_some (f(x))
//
end // end of [jsonize_option_fun]

(* ****** ****** *)

(* end of [pats_jsonize.dats] *)

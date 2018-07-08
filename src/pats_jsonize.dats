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
//
staload
UN = "prelude/SATS/unsafe.sats"
staload
_(*UN*) = "prelude/DATS/unsafe.dats"
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
staload "./pats_filename.sats"

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
jsonval_location (loc) = JSONlocation (loc)
implement
jsonval_filename (fil) = JSONfilename (fil)

(* ****** ****** *)
//
#define nil list_nil
//
#define :: list_cons
#define cons list_cons
//
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
implement
jsonval_labval7
(
  l1, x1, l2, x2, l3, x3, l4, x4, l5, x5, l6, x6, l7, x7
) = JSONlablist
(
  (l1, x1) :: (l2, x2) :: (l3, x3) :: (l4, x4) :: (l5, x5) :: (l6, x6) :: (l7, x7) :: list_nil
)
implement
jsonval_labval8
(
  l1, x1, l2, x2, l3, x3, l4, x4, l5, x5, l6, x6, l7, x7, l8, x8
) = JSONlablist
(
  (l1, x1) :: (l2, x2) :: (l3, x3) :: (l4, x4) :: (l5, x5) :: (l6, x6) :: (l7, x7) :: (l8, x8) :: list_nil
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

local

fun
fprint_jsonval_string
(
  out: FILEref, str: string
) : void = let
//
fun
auxch
(
  out: FILEref, c: char
) : void = let
in
//
case+ c of
| '"' => fprint_string (out, "\\\"")
| '\\' => fprint_string (out, "\\\\")
| '\n' => fprint_string (out, "\\n")
| '\r' => fprint_string (out, "\\r")
| '\t' => fprint_string (out, "\\t")
| '\b' => fprint_string (out, "\\b")
| '\f' => fprint_string (out, "\\f")
| _ (*rest-of-char*) =>
  (
    if char_isprint(c)
      then fprint_char(out, c)
      else let
        val uc = uchar_of_char(c) in
        fprintf (out, "\\u00%.2X", @($UN.cast2uint(uc)))
      end // end of [else]
    // end of [if]
  ) (* end of [_] *)
//
end // end of [auxch]
//
fun
loop
(
  out: FILEref, p: ptr
) : void = let
//
val c = $UN.ptr0_get<char> (p)
//
in
//
if
c != '\000'
then (auxch(out, c); loop (out, p+sizeof<char>)) else ()
//
end // end of [loop]
//
in
//
fprint_char (out, '"');
loop (out, $UN.cast{ptr}(str));
fprint_char (out, '"');
//
end // end of [fprint_jsonval_string]

in (* in-of-local *)

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
//
| JSONnul () => prstr "{}"
//
| JSONint (i) => fprint_int (out, i)
| JSONintinf (i) =>
  {
    val () = fprint_char (out, '"')
    val () = $INTINF.fprint_intinf (out, i)
    val () = fprint_char (out, '"')
  }
//
| JSONbool (b) => fprint_bool (out, b)
| JSONfloat (d) => fprint_double (out, d)
//
| JSONstring (str) => fprint_jsonval_string (out, str)
//
| JSONlocation (loc) =>
  {
    val () = prstr "\""
    val () = fprint_location (out, loc)
    val () = prstr "\""
  } (* end of [JSONlocation] *)
| JSONfilename (fil) =>
  {
    val () = prstr "\""
    val () = fprint_filename_full (out, fil)
    val () = prstr "\""
  } (* end of [JSONfilename] *)
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

end // end of [local]

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
jsonize_caskind(knd) = (
//
case+ knd of
| CK_case () => jsonval_string "CK_case"
| CK_case_pos () => jsonval_string "CK_case_pos"
| CK_case_neg () => jsonval_string "CK_case_neg"
//
) (* end of [jsonize_caskind] *)

(* ****** ****** *)

implement
jsonize_funkind(knd) = (
//
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
jsonize_valkind(knd) = (
//
case+ knd of
| VK_val () => jsonval_string "VK_val"
| VK_prval () => jsonval_string "VK_prval"
| VK_val_pos () => jsonval_string "VK_val_pos"
| VK_val_neg () => jsonval_string "VK_val_neg"
//
) (* end of [jsonize_valkind] *)

(* ****** ****** *)

implement
jsonize_dcstkind(knd) = (
//
case+ knd of
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
jsonize_stamp(x0) =
  jsonval_int(stamp_get_int(x0))
//
(* ****** ****** *)
//
implement
jsonize_symbol(sym) =
  jsonval_string(symbol_get_name(sym))
implement
jsonize_symbolopt(opt) =
(
//
case+ opt of
| None() => jsonval_none()
| Some(x) => jsonval_some(jsonize_symbol(x))
//
) (* end of [jsonize_symbolopt] *)
//
(* ****** ****** *)
//
implement
jsonize_location(loc) = jsonval_location (loc)
implement
jsonize_filename(fil) = jsonval_filename (fil)
//
(* ****** ****** *)

implement
jsonize_label(lab) = let
//
val opt = label_get_int(lab)
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
//
implement
jsonize_ignored(x0) = JSONnul((*void*)) 
//
(* ****** ****** *)

implement
{a}(*tmp*)
jsonize_list_fun(xs, f) = let
//
(*
val () =
  println! ("jsonize_option_fun")
*)
//
val
jsvs = list_map_fun<a> (xs, f)
//
val jsvs = list_of_list_vt(jsvs) in JSONlist (jsvs)
//
end // end of [jsonize_list_fun]

(* ****** ****** *)

implement
{a}(*tmp*)
jsonize_option_fun(opt, f) = let
//
(*
val () =
  println! ("jsonize_option_fun")
*)
//
in
//
case+ opt of
| None() => jsonval_none() | Some(x) => jsonval_some(f(x))
//
end // end of [jsonize_option_fun]

(* ****** ****** *)

(* end of [pats_jsonize.dats] *)

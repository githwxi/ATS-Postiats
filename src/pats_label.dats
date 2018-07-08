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
// Start Time: March, 2011
//
(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"
overload
compare with $SYM.compare_symbol_symbol

(* ****** ****** *)

staload "./pats_label.sats"

(* ****** ****** *)

datatype
label = LABint of int | LABsym of symbol
assume label_type = label

(* ****** ****** *)

implement
label_make_int (int) = LABint (int)
implement
label_make_sym (sym) = LABsym (sym)

(* ****** ****** *)

implement
label_make_string (str) = let
  val sym = $SYM.symbol_make_string (str) in LABsym (sym)
end // end of [label_make_string]

(* ****** ****** *)

implement
label_is_int (l) = 
  case+ l of LABint _ => true | LABsym _ => false
// end of [label_is_int]

implement
label_get_int (l) =
  case+ l of LABint (x) => Some_vt (x) | _ => None_vt ()
// end of [label_get_int]

(* ****** ****** *)

implement
label_is_sym (l) = 
  case+ l of LABint _ => false | LABsym _ => true
// end of [label_is_sym]

implement
label_get_sym (l) =
  case+ l of LABsym (x) => Some_vt (x) | _ => None_vt ()
// end of [label_get_sym]

(* ****** ****** *)

implement
label_dotize
  (l) = let
//
val dotname = (
//
case+ l of
| LABint (int) =>
    string_of_strptr (sprintf (".%i", @(int)))
  // end of [LABint]
| LABsym (sym) =>
    string_of_strptr (sprintf (".%s", @($SYM.symbol_get_name (sym))))
  // end of [LABsym]
//
) : string // end of [val]
//
in
  $SYM.symbol_make_string (dotname)
end // end of [label_dotize]

(* ****** ****** *)

implement
eq_label_label
  (l1, l2) = compare_label_label (l1, l2) = 0
// end of [eq_label_label]
implement
neq_label_label
  (l1, l2) = compare_label_label (l1, l2) != 0
// end of [neq_label_label]

(* ****** ****** *)

implement
compare_label_label
  (l1, l2) = let
(*
val () =
println!
  ("compare_label_label: l1 = ", l1)
val () =
println!
  ("compare_label_label: l2 = ", l2)
*)
in
//
case+
(l1, l2)
of // case+
//
| (LABint i1, LABint i2) => compare(i1, i2)
| (LABsym s1, LABsym s2) => compare(s1, s2)
//
| (LABint _, LABsym _) => ~1
//
| (LABsym _, LABint _) =>  1
//
end // end of [compare_label_label]

(* ****** ****** *)

implement
tostring_label
  (l) = let
in
//
case+ l of
| LABint(int) =>
    string_of_strptr(tostrptr_int(int))
  // end of [LABint]
| LABsym(sym) => $SYM.symbol_get_name(sym)
//
end // end of [tostring_label]

(* ****** ****** *)
//
implement
print_label(x) = fprint_label(stdout_ref, x)
implement
prerr_label(x) = fprint_label(stderr_ref, x)
//
implement
fprint_label (out, x) =
(
  case+ x of
  | LABint(int) => fprint_int(out, int)
  | LABsym(sym) => $SYM.fprint_symbol(out, sym)
) (* end of [fprint_label] *)
//
(* ****** ****** *)

(* end of [pats_label.dats] *)

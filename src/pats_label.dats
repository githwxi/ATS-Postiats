(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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

staload
SYM = "pats_symbol.sats"
overload
compare with $SYM.compare_symbol_symbol

(* ****** ****** *)

staload "pats_label.sats"

(* ****** ****** *)

datatype
label = LABint of int | LABsym of symbol
assume label_type = label

(* ****** ****** *)

implement
label_make_int (int) = LABint (int)
implement
label_make_sym (sym) = LABsym (sym)

implement
label_make_string (str) = let
  val sym = $SYM.symbol_make_string (str) in LABsym (sym)
end // end of [label_make_string]

(* ****** ****** *)

implement
eq_label_label
  (l1, l2) = compare_label_label (l1, l2) = 0
// end of [eq_label_label]
implement
neq_label_label
  (l1, l2) = compare_label_label (l1, l2) != 0
// end of [neq_label_label]

implement
compare_label_label (l1, l2) =
  case+ (l1, l2) of
  | (LABint i1, LABint i2) => compare (i1, i2)
  | (LABsym s1, LABsym s2) => compare (s1, s2)
  | (LABint _, LABsym _) => ~1
  | (LABsym _, LABint _) =>  1
// end of [compare_label_label]

(* ****** ****** *)

implement
fprint_label (out, x) =
  case+ x of
  | LABint (int) => fprint_int (out, int)
  | LABsym (sym) => $SYM.fprint_symbol (out, sym)
// end of [fprint_label]

implement
print_label (x) = fprint_label (stdout_ref, x)
implement
prerr_label (x) = fprint_label (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_label.dats] *)

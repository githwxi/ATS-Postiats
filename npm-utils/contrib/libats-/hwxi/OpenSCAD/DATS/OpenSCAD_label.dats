(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: May, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
(*
** For supporting in ATS a form
** of meta-programming for OpenSCAD 
*)
(* ****** ****** *)
//
#staload
"./../SATS/OpenSCAD.sats"
//
(* ****** ****** *)

local
//
assume label_type = string
//
in (*in-of-local*)
//
(* ****** ****** *)
//
implement label_make(x) = x
//
(* ****** ****** *)
//
implement
fprint_label
  (out, x) = fprint_string(out, x)
//
(* ****** ****** *)
//
implement
compare_label_label
  (l1, l2) = compare_string_string(l1, l2)
//
(* ****** ****** *)

end // end of [local]

(* ****** ****** *)
//
implement
eq_label_label
  (l1, l2) = (compare(l1, l2) = 0)
implement
neq_label_label
  (l1, l2) = (compare(l1, l2) != 0)
//
(* ****** ****** *)

(* end of [OpenSCAD_label.dats] *)

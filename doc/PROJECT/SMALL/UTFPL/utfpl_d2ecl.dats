(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

implement
fprint_d2ecl
  (out, d2c0) = let
in
//
case+ d2c0.d2ecl_node of
//
| D2Cfundecs _ => fprint! (out, "D2Cfundecs(...)")
| D2Cvaldecs _ => fprint! (out, "D2Cvaldecs(...)")
//
| D2Cerr((*void*)) => fprint! (out, "D2Cerr(", ")")
//
(*
| _ (*temporary*) => fprint! (out, "D2C...(", "...", ")")
*)
//
end // end of [fprint_d2ecl]

(* ****** ****** *)

implement
fprint_d2eclist
  (out, d2cs) = let
//
implement
fprint_val<d2ecl> = fprint_d2ecl
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<d2ecl> (out, d2cs)
end // end of [fprint_d2eclist]

(* ****** ****** *)

implement
f2undec_make
  (loc, d2v, d2e) = '{
  f2undec_loc= loc
, f2undec_var= d2v
, f2undec_def= d2e
} (* end of [f2undec_make] *)

(* ****** ****** *)

implement
v2aldec_make
  (loc, p2t, d2e) = '{
  v2aldec_loc= loc
, v2aldec_pat= p2t
, v2aldec_def= d2e
} (* end of [v2aldec_make] *)

(* ****** ****** *)

implement
d2ecl_make_node
  (loc, node) = '{
  d2ecl_loc= loc, d2ecl_node= node
} (* end of [d2ecl_make_node] *)

(* ****** ****** *)
//
implement
d2ecl_fundeclst
  (loc, knd, f2ds) =
  d2ecl_make_node (loc, D2Cfundecs (knd, f2ds))
//
(* ****** ****** *)
//
implement
d2ecl_valdeclst
  (loc, knd, v2ds) =
  d2ecl_make_node (loc, D2Cvaldecs (knd, v2ds))
//
(* ****** ****** *)

implement
d2ecl_err (loc) = d2ecl_make_node (loc, D2Cerr())

(* ****** ****** *)

(* end of [utfpl_d2ecl.dats] *)

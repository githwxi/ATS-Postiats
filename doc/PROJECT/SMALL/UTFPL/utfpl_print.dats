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
fprint_p2at
  (out, p2t0) = let
in
//
case+ p2t0.p2at_node of
//
| P2Tvar (d2v) => fprint! (out, "P2Tvar(", d2v, ")")
//
| P2Terr ((*void*)) => fprint! (out, "P2Terr(", ")")
//
end // end of [fprint_p2at]

(* ****** ****** *)

implement
fprint_d2exp
  (out, d2e0) = let
in
//
case+ d2e0.d2exp_node of
//
| D2Evar (d2v) => fprint! (out, "D2Evar(", d2v, ")")
//
| D2Eerr ((*void*)) => fprint! (out, "D2Eerr(", ")")
//
| _ (*temporary*) => fprint! (out, "D2E...(", "...", ")")
//
end // end of [fprint_d2exp]

(* ****** ****** *)

implement
fprint_d2explst
  (out, d2es) = let
//
implement
fprint_val<d2exp> = fprint_d2exp
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<d2exp> (out, d2es)
end // end of [fprint_d2explst]

(* ****** ****** *)

implement
fprint_d2ecl
  (out, d2c0) = let
in
//
case+ d2c0.d2ecl_node of
//
| D2Cfundecs _ => fprint! (out, "D2Cfundecs(...)")
//
(*
| _ (*temporary*) => fprint! (out, "D2E...(", "...", ")")
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

(* end of [utfpl_print.dats] *)

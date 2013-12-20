(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

(* ****** ****** *)

implement
fprint_s2rt
  (out, s2t0) = let
in
//
case+ s2t0 of
//
| S2RTint () => fprint (out, "S2RTint()")
| S2RTaddr () => fprint (out, "S2RTaddr()")
| S2RTbool () => fprint (out, "S2RTbool()")
//
| S2RTfun () => fprint (out, "S2RTfun()")
| S2RTtup () => fprint (out, "S2RTtup()")
| S2RTerr () => fprint (out, "S2RTerr()")
//
| S2RTignored () => fprint (out, "S2RTignored()")
//
end // end of [fprint_s2rt]

(* ****** ****** *)

(* end of [constraint_s2rt.dats] *)

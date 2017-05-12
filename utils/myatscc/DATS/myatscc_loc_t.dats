(*
** HX-2017-04-22:
** For turning string into tokens
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#staload UN = $UNSAFE
//
(* ****** ****** *)

#staload "./../SATS/myatscc.sats"

(* ****** ****** *)
//
datatype
loc_t = LOC of (int, int)
//
(* ****** ****** *)
//
assume loc_type = loc_t
//
(* ****** ****** *)

implement
loc_t_left(LOC(p0, _)) = p0
implement
loc_t_right(LOC(_, p1)) = p1

(* ****** ****** *)
//
implement
loc_t_make(p0, p1) = LOC(p0, p1)
//
implement
loc_t_combine
  (x1, x2) = let
  val LOC(p10, p11) = x1
  val LOC(p20, p21) = x2
in
  LOC(min(p10, p20), max(p11, p21))
end // end of [loc_t_combine]
//
(* ****** ****** *)
//
implement
print_loc_t(x) = fprint(stdout_ref, x)
implement
prerr_loc_t(x) = fprint(stderr_ref, x)
//
(* ****** ****** *)

implement
fprint_loc_t
  (out, loc) = let
  val LOC(p0, p1) = loc
in
  fprint!(stdout_ref, "(", p0, "--", p1, ")")
end // end of [fprint_loc_t]

(* ****** ****** *)

(* end of [myatscc_loc_t.dats] *)

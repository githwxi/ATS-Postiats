(*
**
** Some utility functions for
** manipulating the syntax of ATS2
**
** Contributed by
** Hongwei Xi (gmhwxiATgmailDOTcom)
**
** Start Time: July, 2016
**
*)

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
staload "prelude/DATS/list.dats"
//
(* ****** ****** *)
//
staload
LOC = "src/pats_location.sats"
//
overload
fprint with $LOC.fprint_location
//
(* ****** ****** *)

staload "src/pats_staexp2.sats"
staload "src/pats_dynexp2.sats"

(* ****** ****** *)
//
staload "./../SATS/libatsyntext.sats"
//
(* ****** ****** *)

local
//
fun
aux_fundecs
(
  out: FILEref, d2c0: d2ecl
) : void = let
//
fun
auxf2d
(
  out: FILEref, f2d: f2undec
) : void =
{
val () = fprintln! (out, f2d.f2undec_var)
val () = fprintln! (out, f2d.f2undec_loc)
} (* end of [auxf2d] *)
//
val-
D2Cfundecs(fk, s2qs, f2ds) = d2c0.d2ecl_node
//
in
  list_foreach_cloptr(f2ds, lam f2d =<1> auxf2d(out, f2d))
end // end of [aux_fundecs]

fun
aux_valdecs
  (out: FILEref, d2c0: d2ecl): void = ()
//
in (* in-of-local *)

implement
syntext_d2ecl
  (out, d2c0) = let
//
val () =
println!
(
  "syntext_d2ecl: d2c0 = ", d2c0
) (* println! *)
//
in
//
case+
d2c0.d2ecl_node
of // case+
| D2Cnone() => ()
| D2Clist(d2cs) =>
    syntext_d2eclist(out, d2cs)
  // D2Clist
//
| D2Cfundecs _ => aux_fundecs(out, d2c0)
| D2Cvaldecs _ => aux_valdecs(out, d2c0)
//
| _(* rest-of-d2ecl *) => ((*void*))
//
end // end of [syntext_d2ecl]

end // end of [local]

(* ****** ****** *)

implement
syntext_d2eclist
  (out, d2cs) = let
//
fun
loop
(
  i: int, d2cs: d2eclist
) :<cloref1> void =
(
case+ d2cs of
| list_nil() => ()
| list_cons(d2c, d2cs) =>
  (
    syntext_d2ecl(out, d2c); loop(i+1, d2cs)
  )
) (* end of [loop] *)
//
in
  loop(0, d2cs)
end // end of [syntext_d2eclist]

(* ****** ****** *)

(* end of [libatsyntext_d2ecl.dats] *)

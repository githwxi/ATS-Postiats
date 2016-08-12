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
  (d2c0: d2ecl): void = ()
fun
aux_valdecs
  (d2c0: d2ecl): void = ()
//
in (* in-of-local *)

implement
syntext_d2ecl
  (d2c0) = let
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
    syntext_d2eclist(d2cs)
  // D2Clist
//
| D2Cfundecs _ => aux_fundecs(d2c0)
| D2Cvaldecs _ => aux_valdecs(d2c0)
//
| _(* rest-of-d2ecl *) => ((*void*))
//
end // end of [syntext_d2ecl]

end // end of [local]

(* ****** ****** *)

implement
syntext_d2eclist
  (d2cs) = let
//
fun
loop
(
  i: int, d2cs: d2eclist
) : void =
(
case+ d2cs of
| list_nil() => ()
| list_cons(d2c, d2cs) =>
  (
    syntext_d2ecl(d2c); loop(i+1, d2cs)
  )
) (* end of [loop] *)
//
in
  loop(0, d2cs)
end // end of [syntext_d2eclist]

(* ****** ****** *)

(* end of [libatsyntext_d2ecl.dats] *)

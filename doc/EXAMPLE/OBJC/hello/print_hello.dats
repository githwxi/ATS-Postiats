(*
** HX-2013-10-16
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
staload "libc/SATS/stdlib.sats"
//
(* ****** ****** *)

extern
fun print_hello (): void= "ext#ATS_print_hello"

(* ****** ****** *)

implement
print_hello () = let
//
val (fpf | str) = getenv ("USER")
//
val p = strptr2ptr (str)
val (
) = (
  println! ("Hello from ", $UN.cast{string}(p), "!")
) (* end of [val] *)
//
prval ((*void*)) = fpf (str)
//
in
  // nothing
end // end of [print_hello]

(* ****** ****** *)

(* end of [print_hello.dats] *)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _ = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

(*
implement{a}
fprint_list0_sep (out, xs, sep) = ()
*)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val xs1 = nil0()
val xs2 = nil0()
val xss = cons0{list0(int)}(xs1, cons0{list0(int)}(xs2, nil0()))
//
(*
implement
fprint_val<list0(int)> (out, xs) = ()
*)
implement
fprint_val<list0(int)>
  (out, xs) = fprint_list0_sep<int> (out, xs, ", ")
//
val () = fprint_list0_sep<list0(int)> (out, xss, "\n")
//
} (* end of [val] *)

(* ****** ****** *)

implement
main0 () =
{
//
val () = println! ("Your code has passed all the tests given here.")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [mysolution4.dats] *)

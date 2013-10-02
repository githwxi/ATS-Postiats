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
//
// This function prints out a given matrix
//
extern
fun{a:t@ype}
fprint_matlist
  (out: FILEref, M: list0(list0(a))): void
//
(* ****** ****** *)

implement{a}
fprint_matlist
  (out, xss) = let
//
implement
fprint_val<list0(a)>
  (out, xs) = fprint_list0_sep<a> (out, xs, ", ")
//
val () = fprint_list0_sep<list0(a)> (out, xss, "\n")
//
in
  // nothing
end // end of [fprint_matlist]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val xs1 = (list0)$arrpsz{int}(1, 2, 3, 4)
val xs2 = (list0)$arrpsz{int}(5, 6, 7, 8)
val mat = cons0{list0(int)}(xs1, cons0{list0(int)}(xs2, nil0()))
//
val () = fprintln! (out, "mat = ")
val () = fprint_matlist<int> (out, mat)
val () = fprint_newline (out)
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

(*
** For testing
** intset implementation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#staload
"./../SATS/basis_intset.sats"
#staload _ =
"./../DATS/basis_intset.dats"
//
(* ****** ****** *)

overload + with intset_add_elt

(* ****** ****** *)

overload + with intset_union
overload * with intset_intersect

(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println!
  ("Hello from [intset]!")
//
#define N 10
//
val xs =
intset_nil{N}()
//
val xs = xs + 1
val xs = xs + 5
val xs = xs + 6
val xs = xs + 3
val () = println! ("xs = ", xs)
//
val xs = xs + xs
val () = println! ("xs = ", xs)
//
val xs = xs * xs
val () = println! ("xs = ", xs)
//
val ys =
  intset_ncomplement(xs, N)
//
val () = println! ("ys = (", ys, ")")
//
val () = println! ("xs * ys = (", xs * ys, ")")
val () = println! ("xs + ys = (", xs + ys, ")")
//
val () = intset_foreach_cloref(xs, lam(x) => println! ("x = ", x))
val () = intset_foreach_cloref(ys, lam(y) => println! ("y = ", y))
//
val () = cintset_foreach_cloref(N, xs, lam(x) => println! ("x = ", x))
val () = cintset_foreach_cloref(N, ys, lam(y) => println! ("y = ", y))
//
val () = intset2_foreach_cloref(xs, ys, lam(x, y) => println! ("(x, y) = (", x, ", ", y, ")"))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [intset.dats] *)

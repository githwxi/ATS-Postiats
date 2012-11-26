(*
//
// Implementing Erathosthene's sieve
//
// author: Hongwei Xi (November, 2006)
//
*)
(* ****** ****** *)
//
// HX-2012-11-25: ported to ATS/Postiats
//
(* ****** ****** *)
//
// lazy list:
//
datatype llist = lcons of (intGte 2, () -<cloref1> llist)
//
#define :: lcons
//
(* ****** ****** *)

fun filter
  (p: intGte 2 -<cloref> bool, xs: llist): llist = let
  val+ x :: fxs = xs
in
  if p (x) then x :: (lam () =<cloref1> filter (p, fxs ()))
  else filter (p, fxs ())
end // end of [filter]

//

infix nmod
macdef nmod (x1, x2) = g1int_nmod<int_kind> (,(x1), ,(x2))

fun sieve (
  xs: llist
) : llist = let
  val+ x :: fxs = xs
in
  x :: (lam () => sieve (filter (lam (x') => (x' nmod x) != 0, fxs ())))
end // end of [sieve]

//

val primes: llist = let
  fun aux (i: intGte 2): llist = i :: (lam () => aux (i + 1))
in
  sieve (aux 2)
end // end of [primes]

//

fun print_ints (
  xs: llist
) : void = let
  val+ x :: fxs = xs in
  print x; print_newline (); print_ints (fxs ())
end // end of [print_ints]

(* ****** ****** *)
//
implement
main (argc, argv) =
  let val () = print_ints (primes) in 0(*normal*) end
// end of [main]
//
(* ****** ****** *)

(* end of [sieve.dats] *)

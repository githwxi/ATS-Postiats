//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
(*
//
// Implementing Erathosthene's sieve
//
// author: Hongwei Xi (November, 2006)
//
*)
(* ****** ****** *)
//
// HX-2012-11-25: ported to ATS/Postiats (typecheck)
// HX-2012-06-08: ported to ATS/Postiats (compilation)
//
(* ****** ****** *)
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
(* ****** ****** *)

staload INT = "prelude/DATS/integer.dats"

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

val
rec primes: llist = let
  fun aux (i: intGte 2): llist = i :: (lam () => aux (i + 1))
in
  sieve (aux 2)
end // end of [primes]

//

(* ****** ****** *)

fun print_ints
  (N: int, xs: llist): void =
(
if N > 0 then let
  val+ x :: fxs = xs
in
  print x; print ", ";
  print_ints (N-1, fxs ())
end else
  (print "..."; print_newline ())
) // end of [print_ints]

(* ****** ****** *)
//
implement
main (argc, argv) = let
//
val N =
(
if argc >= 2 then
  $extfcall (int, "atoi", argv[1]) else 100
) : int // end of [val]
//
val () = assertloc (N > 0)
//
in
  let val () = print_ints (N, primes) in 0(*normal*) end
end // end of [main]
//
(* ****** ****** *)

(* end of [sieve.dats] *)

(*
//
// HX-2013-04:
// some code for use in Matt's HCSS talk in May
//
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/SATS/sllist.sats"
staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/sllist.dats"

(* ****** ****** *)

extern
fun{
a:t0p}{b:t0p
} sllist_mapfree$fwork (x: a): b
extern
fun{
a:t0p}{b:t0p
} sllist_mapfree {n:nat} (xs: sllist (INV(a), n)): sllist (b, n)

(* ****** ****** *)

#define nil sllist_nil
#define cons sllist_cons
#define :: sllist_cons

(* ****** ****** *)

implement{a}{b}
sllist_mapfree (xs) =
(
if sllist_is_cons (xs) then let
  var xs = xs
  val x0 = sllist_uncons (xs)
  val y0 = sllist_mapfree$fwork<a><b> (x0)
in
  y0 :: sllist_mapfree<a><b> (xs)
end else let
  prval () = sllist_free_nil (xs)
in
  sllist_nil ()
end (* end of [if] *)
)

(* ****** ****** *)

fun test() = let
//
val out = stdout_ref
val xs = sllist_nil{int}()
val xs = 1 :: 2 :: 3 :: 4 :: 5 :: xs
val () = fprintln! (out, "xs = ", xs)
//
local
implement
sllist_mapfree$fwork<int><int> (a) = a * a
in
val xs2 = sllist_mapfree<int><int> (xs)
end
//
val () = fprintln! (out, "xs2 = ", xs2)
//
val () = sllist_free<int> (xs2)
//
in
  // nothing
end // end of [test]

(* ****** ****** *)

implement main0 (argc, argv) = test()

(* ****** ****** *)

(* end of [sllist_mapfree.dats] *)

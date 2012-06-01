//
// Reversing the content of an array. This is a simple example
// for illustrating some benefits of dependent types.
//
// Author: Hongwei Xi (Spring, 2009)
// Author: Hongwei Xi (May, 2012) // porting to ATS2
//

(* ****** ****** *)

sortdef vt0p = viewt@ype

(* ****** ****** *)

fun{a:vt0p}
revarr {n:nat} .<>. (
  A: &array (a, n), n: size_t n
) :<!wrt> void = let
  fun loop
    {i,j:nat | i <= j+1; i+j==n-1} .<j>. (
    A: &array (a, n), i: size_t i, j: size_t j
  ) :<!wrt> void =
    if i < j then let
      val () = A.[i] :=: A.[j] in loop (A, succ i, pred j)
    end // end of [if]
in
  if n > 0 then loop (A, g1int2uint(0), pred (n))
end // end of [revarr]

(* ****** ****** *)

staload "contrib/atshwxi/testing/tprint.sats"
staload "contrib/atshwxi/testing/randgen.sats"

(* ****** ****** *)

implement
randgen<int> () = 0

implement
main (argc, argv) = let
  val asz = g1int2uint (10)
  val A = randgen_arrayptr (asz)
//
  val () = tprint "A = "
  val () = tprint_arrayptr<int> (A, asz)
  val () = tprint_newline ()
//
  val p = ptrcast (A)
  prval pfarr = arrayptr_takeout (A)
  val () = revarr (!p, asz)
  prval () = arrayptr_addback (pfarr | A)
//
  val () = tprint "A = "
  val () = tprint_arrayptr<int> (A, asz)
  val () = tprint_newline ()
//
  val () = arrayptr_free (A)
//
in
  0 (*norm*)
end // end of [main]

(* ****** ****** *)

(* end of [revarr.dats] *)

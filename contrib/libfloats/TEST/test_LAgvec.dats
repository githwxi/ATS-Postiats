(* ****** ****** ****** ****** ****** ****** ****** ****** *)
//
// Some test for Linear Algebra vector operations
//
(* ****** ****** ****** ****** ****** ****** ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

(* Author: Brandon Barker *)
(* Authoremail: brandon.barker AT gmail DOT com *)
(* Start time: July, 2013 *)

(* ****** ****** *)

#include "share/atspre_staload.hats"
//
staload _ = "prelude/DATS/gnumber.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libats/SATS/gvector.sats"
//
staload _ = "libats/DATS/gvector.dats"
staload _ = "libats/DATS/refcount.dats"
//
(* ****** ****** *)
//
staload "./../SATS/lavector.sats"
//
staload _ = "./../DATS/blas0.dats"
staload _ = "./../DATS/blas1.dats"
staload _ = "./../DATS/lavector.dats"
//
(* ****** ****** *)

val () =
{
//
typedef T = int
//
val N = 10
val out = stdout_ref
//
local
implement
array_tabulate$fopr<T> (i) = g0u2i(i)
in (* in of [local] *)
val A = arrayptr_tabulate<T> (i2sz(N))
end // end of [local]
//
val V = LAgvec_make_arrayptr (A, N)
val () = fprintln! (out, "V = ", V)
//
val V' = copy_LAgvec (V)
val () = fprintln! (out, "V' = ", V')
//
val (V1, V2) = LAgvec_split (V, 5)
val () = fprintln! (out, "V1 = ", V1)
val () = fprintln! (out, "V2 = ", V2)
//
val dotprod = LAgvec_inner (V1, V2)
val () = fprintln! (out, "dotprod = ", dotprod)
//
val () = LAgvec_decref (V')
val () = LAgvec_decref2 (V1, V2)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test_LAgvec.dats] *)

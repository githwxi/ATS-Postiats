//
// Reversing the content of an array.
// This is a simple and convincing example for
// illustrating some benefits of dependent types.
//
// Author: Hongwei Xi (Spring, 2009)
// Author: Hongwei Xi (May, 2012) // porting to ATS2
//

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

fun{
a:t@ype
} revarr {n:nat} .<>.
(
  A: &array (INV(a), n), n: size_t n
) :<!wrt> void = let
//
fun loop
{
  i,j:nat | i <= j+1; i+j==n-1
} .<j>. (
  A: &array (a, n), i: size_t i, j: size_t j
) :<!wrt> void =
  if i < j then let
    val () = A.[i] :=: A.[j] in loop (A, succ i, pred j)
  end // end of [if]
//
in
  if n > 0 then loop (A, g1i2u(0), pred (n))
end // end of [revarr]

(* ****** ****** *)
//
staload UN = "prelude/SATS/unsafe.sats"
//
staload STDLIB = "libc/SATS/stdlib.sats"
//
(* ****** ****** *)
//
staload
RG = "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload
_(*RG*) = "{$LIBATSHWXI}/testing/DATS/randgen.dats"
//
(* ****** ****** *)
%{^
//
#include <time.h>
//
extern void srand48 (long int) ; // in [stdlib.h]
extern double drand48 (/*void*/) ; // in [stdlib.h]
//
atsvoid_t0ype
srand48_with_time ()
{
  srand48(time(0)) ; return ;
}
%}
extern
fun srand48_with_time (): void = "ext#"
//
(* ****** ****** *)

typedef T = double

(* ****** ****** *)

implement
$RG.randgen_val<T> () = $STDLIB.drand48()

(* ****** ****** *)

implement
main0 () =
{
//
#define N 10
//
val asz = g1i2u (N)
//
val () = srand48_with_time ()
val A = $RG.randgen_arrayptr<T> (asz)
//
val () = gprint_string "A(bef) = "
val () = gprint_arrayptr (A, asz)
val () = gprint_newline ()
//
val p = ptrcast (A)
prval pfarr = arrayptr_takeout (A)
val () = revarr (!p, asz)
prval () = arrayptr_addback (pfarr | A)
//
val () = gprint_string "A(aft) = "
val () = gprint_arrayptr (A, asz)
val () = gprint_newline ()
//
val () = arrayptr_free (A)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [areverse.dats] *)

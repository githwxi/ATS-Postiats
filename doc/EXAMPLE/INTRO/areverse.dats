(* ****** ****** *)
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
#staload
UN = "prelude/SATS/unsafe.sats"
//
#staload
STDLIB = "libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)
//
#define
MYTESTING_targetloc
"\
$PATSHOME/contrib\
/atscntrb/atscntrb-hx-mytesting"
//
(* ****** ****** *)
//
#staload
RG = "{$MYTESTING}/SATS/randgen.sats"
#staload
_(*RG*) = "{$MYTESTING}/DATS/randgen.dats"
//
(* ****** ****** *)
//
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
val (pf_B, pf_free_B | p_B) = array_ptr_alloc<T> (asz)
//
val () = gprint_string "A(bef) = "
val () = gprint_arrayptr (A, asz)
val () = gprint_newline ()
//
val p = ptrcast (A)
prval pfarr = arrayptr_takeout (A)
val () = array_copy<T> (!p_B, !p, asz)
val () = revarr (!p, asz)
//
val () = assertloc (!p_B.[0] = !p.[9])
val () = assertloc (!p_B.[1] = !p.[8])
val () = assertloc (!p_B.[2] = !p.[7])
val () = assertloc (!p_B.[3] = !p.[6])
val () = assertloc (!p_B.[4] = !p.[5])
val () = assertloc (!p_B.[5] = !p.[4])
val () = assertloc (!p_B.[6] = !p.[3])
val () = assertloc (!p_B.[7] = !p.[2])
val () = assertloc (!p_B.[8] = !p.[1])
val () = assertloc (!p_B.[9] = !p.[0])
//
prval () = arrayptr_addback (pfarr | A)
//
val () = gprint_string "A(aft) = "
val () = gprint_arrayptr (A, asz)
val () = gprint_newline ()
//
val () = array_ptr_free (pf_B, pf_free_B | p_B)
val () = arrayptr_free (A)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [areverse.dats] *)

//
//
// One of the early examples first done in ATS/Geizella
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: circa May 2007
//
(* ****** ****** *)
//
// HX:
// The *awkward* style should be not be changed so as to preserve
// a bit history about the development of ATS
//
(* ****** ****** *)
//
// HX-2013-06-08: ported to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload TIME = "libc/SATS/time.sats"
staload STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)

extern
fun array_int_ptr_make
  : {n:nat} int n -<0,!wrt> [l:addr] (@[Nat][n] @ l | ptr l)
  = "ats_array_int_ptr_make"

extern
fun array_int_ptr_free
  : {n:nat} {l:addr} (@[Nat?][n] @ l | ptr l) -<0,!wrt> void
  = "ats_array_int_ptr_free"

extern
fun array_int_ptr_get
  : {n:nat} {l:addr} (! @[Nat][n] @ l | ptr l, natLt n) -<> Nat
  = "ats_array_int_ptr_get"

extern
fun array_int_ptr_set
  : {n:nat} {l:addr} (! @[Nat][n] @ l | ptr l, natLt n, Nat) -<0,!wrt> void
  = "ats_array_int_ptr_set"

%{^

atstype_ptr
ats_array_int_ptr_make (atstype_int n) {
  return calloc (n, sizeof(int)) ;  
}

atsvoid_t0ype
ats_array_int_ptr_free (atstype_ptr A) {
  free (A) ; return ;
}

atstype_int
ats_array_int_ptr_get (atstype_ptr A, atstype_int i) {
  return ((atstype_int *)A)[i] ;
}

atsvoid_t0ype
ats_array_int_ptr_set (atstype_ptr A, atstype_int i, atstype_int x) {
  ((atstype_int *)A)[i] = x ; return ;
}

%} // end of [%{^]

(* ****** ****** *)

fn heads_one (): bool = $STDLIB.drand48 () < 0.5

fn heads_many{n:nat}
  (n: int n): natLte n = let
//
fun aux {i,s:nat | i + s <= n} .<i>.
  (i: int i, s: int s): natLte n =
  if i > 0 then
    (if heads_one () then aux (i-1, s+1) else aux (i-1, s))
  else s // end of [if]
in
  aux (n, 0)
end // end of [heads_many]

fn test_one {n:nat} {l:addr}
  (pf: ! @[Nat][n+1] @ l | A: ptr l, n: int n): void = let
  val cnt = heads_many (n)
in
  array_int_ptr_set (pf | A, cnt, array_int_ptr_get (pf | A, cnt) + 1)
end // end of [test_one]

fun test_many
  {m,n:nat}{l:addr} .<m>.
(
  pf: ! @[Nat][n+1] @ l | A: ptr l, m: int m, n: int n
) : void = let
in
//
if m > 0 then
  (test_one (pf | A, n); test_many (pf | A, m-1, n))
else () // end of [if]
//
end // end of [test_many]

#define INC 16

fn test_show_one {l:addr} (times: Nat): void = let
  fun aux {t,i:nat} .<t \nsub i>. (t: int t, i: int i): void =
    if i < t then (print '*'; aux (t, i+INC)) else print_newline ()
in
  if times > 0 then aux (times, 0) else print ".\n"
end // end of [test_show_one]

fun test_show_all {n,i:nat | i <= n+1} {l:addr} .<n+1-i>.
  (pf: ! @[Nat][n+1] @ l | A: ptr l, n: int n, i: int i): void =
  if i <= n then
    (test_show_one (array_int_ptr_get (pf | A, i)); test_show_all (pf | A, n, i+1))
  else ()
// end of [test_show_all]

(* ****** ****** *)

#define M 4096
#define N   32

staload UN = "prelude/SATS/unsafe.sats"

implement
main0 () =
{
//
val time = $TIME.time ()
val () = $STDLIB.srand48($UN.cast{lint}(time))
val (pf | A) = array_int_ptr_make (N+1)
//
val clock_sta = $UN.cast{double}($TIME.clock ())
//
val () = test_many (pf | A, M, N)
val () = test_show_all (pf | A, N, 1)
val () = array_int_ptr_free (pf | A)
//
val clock_fin = $UN.cast{double}($TIME.clock ())
//
val time_spent =
   (clock_fin - clock_sta) / $UN.cast{double}($TIME.CLOCKS_PER_SEC)
// end of [val]
//
val _ = $extfcall (int, "printf", "time spent = %.10f\n", time_spent)
//
} // end of [main0]

(* ****** ****** *)

(* end of [coinflip.dats] *)

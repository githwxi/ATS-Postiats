(*
** HX-2014-06-02:
** Parallelizing Dotprod
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
#include <pthread.h>
%} // end of [%{^]

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
extern
fun{
a:t@ype
} dotprod{n:nat}
  (A: &array(a, n), B: &array(a, n), n: int(n)): (a)
//
(* ****** ****** *)
//
extern
fun{
a:t@ype
} dotprod_mt{n:nat}
  (A: &array(a, n), B: &array(a, n), n: int(n), cutoff: intGte(1)): (a)
//
(* ****** ****** *)

implement
{a}(*tmp*)
dotprod{n}
  (A, B, n) = let
//
fun loop
  {i:nat | i <= n} .<n-i>.
(
  pa: ptr, pb: ptr, i: int(i), res: a
) : (a) = let
in
//
if
(i < n)
then let
  val x = $UN.ptr0_get<a> (pa)
  val y = $UN.ptr0_get<a> (pb)
  val res = gadd_val<a> (res, gmul_val<a> (x, y))
in
  loop (ptr_succ<a> (pa), ptr_succ<a> (pb), succ(i), res)
end // end of [then]
else res // end of [else]
//
end // end of [loop]
//
prval () = lemma_array_param (A)
prval () = lemma_array_param (B)
//
in
  loop (addr@A, addr@B, 0, gnumber_int<a> (0))
end (* end of [dotprod] *)

(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/teaching/mythread/SATS/spinvar.sats"
staload
"{$LIBATSHWXI}/teaching/mythread/SATS/spinref.sats"
staload
"{$LIBATSHWXI}/teaching/mythread/SATS/nwaiter.sats"
staload
"{$LIBATSHWXI}/teaching/mythread/SATS/parallelize.sats"
//
(* ****** ****** *)

implement
{a}(*tmp*)
dotprod_mt{n}
  (A, B, n, cutoff) = let
//
val pa = addr@A
val pb = addr@B
val _0_ = gnumber_int<a> (0)
val spnv = spinvar_create_exn (_0_)
val spnr = $UN.castvwtp1{spinref(a)}(spnv)
//
fun dotprod2
(
  p1: ptr, p2: ptr, n: int, spnr: spinref(a)
) : void = let
  val [n:int] n = g1ofg0 (n)
in
//
if
n >= 0
then let
  val (pf1, fpf1 | p1) =
    $UN.ptr0_vtake{array(a,n)}(p1)
  and (pf2, fpf2 | p2) =
    $UN.ptr0_vtake{array(a,n)}(p2)
  val res = dotprod (!p1, !p2, n)
  prval () = fpf1 (pf1) and () = fpf2 (pf2)
  local
  implement(env)
  spinref_process$fwork<a><env> (x, env) = x := gadd_val<a> (x, res)
  in(*in-of-local*)
  val ((*void*)) = spinref_process (spnr)
  end // end of [local]
in
  // nothing
end // end of [then]
else () // end of [else]
//
end // end of [dotprod2]
//
local
//
implement
intrange_parallelize$loop<>
  (m, n) = let
  val pa2 = ptr_add<a> (pa, m)
  val pb2 = ptr_add<a> (pb, m)
in
  dotprod2 (pa2, pb2, n-m, spnr)
end // end of [intrange_parallelize$loop]
//
in(*in-of-local*)
//
val nw = nwaiter_create_exn ()
val () = intrange_parallelize (0, n, cutoff, nw)
val ((*freed*)) = nwaiter_destroy (nw)
//
end // end of [local]
//
in
  spinvar_getfree (spnv)
end // end of [dotprod_mt]

(* ****** ****** *)
//
staload "libc/SATS/stdlib.sats"
staload
"{$LIBATSHWXI}/testing/SATS/randgen.sats"
//
(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/teaching/mythread/SATS/workshop.sats"
//  
(* ****** ****** *)
//
staload _ = "prelude/DATS/gnumber.dats"
//  
staload _ =
"{$LIBATSHWXI}/testing/DATS/randgen.dats"
//
staload _ = "libats/DATS/deqarray.dats"
staload _ =
"{$LIBATSHWXI}/teaching/mythread/DATS/channel.dats"
//
staload _(*anon*) =
"{$LIBATSHWXI}/teaching/mythread/DATS/spinvar.dats"
staload _(*anon*) =
"{$LIBATSHWXI}/teaching/mythread/DATS/spinref.dats"
staload _(*anon*) =
"{$LIBATSHWXI}/teaching/mythread/DATS/nwaiter.dats"
staload _ =
"{$LIBATSHWXI}/teaching/mythread/DATS/workshop.dats"
staload _ =
"{$LIBATSHWXI}/teaching/mythread/DATS/parallelize.dats"
//
staload _ = "libats/DATS/athread.dats"
staload _ = "libats/DATS/athread_posix.dats"
//
(* ****** ****** *)

extern
fun
{a:t@ype}
test_dotprod
  {n:nat}
(
  times: int
, A: &array(a, n), B: &array(a, n), n: int(n)
, cutoff: intGte(1)
) : (a) // end of [test_dotprod]
//
implement
{a}(*tmp*)
test_dotprod
  (times, A, B, n, cutoff) =
(
  if times > 0
    then let
      val res1 =
        dotprod_mt<a> (A, B, n, cutoff)
      // end of [val]
      val res2 =
        test_dotprod<a> (times-1, A, B, n, cutoff)
      // end of [val]
    in
      gadd_val (res1, res2)
    end // end of [then]
    else gnumber_int<a> (0)
  // end of [if]
)
//
(* ****** ****** *)

implement
main0 () = () where
{
//
val ws0 =
workshop_create_cap<lincloptr> (i2sz(2))
//
val nworker =
  workshop_add_nworker<lincloptr> (ws0, 4)
//
val nworker = workshop_get_nworker (ws0)
val ((*void*)) = println! ("nworker = ", nworker)
//
implement
intrange_parallelize$submit<> (fwork) =
(
  workshop_insert_job<lincloptr> (ws0, $UN.castvwtp0{lincloptr}(fwork))
) (* end of [intrange_parallelize$submit] *)
//
typedef T = double
//
#define N 10000000
//
local
implement
randgen_val<T> () = drand48 ()
in(*in-of-local*)
val A = randgen_arrayptr<T> (i2sz(N))
val pA = ptrcast (A)
val (pf1, fpf1 | p1) = $UN.ptr0_vtake{array(T,N)}(pA)
val (pf2, fpf2 | p2) = $UN.ptr0_vtake{array(T,N)}(pA)
end // end of [local]
//
#define TIMES 200
#define CUTOFF 1000000
//
val res = test_dotprod<T> (TIMES, !p1, !p2, N, CUTOFF) / TIMES
//
val ((*void*)) = fprintln! (stdout_ref, "res = ", res)
//
prval () = fpf1 (pf1)
prval () = fpf2 (pf2)
//
val ((*freed*)) = arrayptr_free (A)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [dotprod2_mt.dats] *)

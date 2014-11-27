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
//
#include <pthread.h>
//
#undef ATSextfcall
#define ATSextfcall(f, xs) f xs
//
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
  (A: &array(a, n), B: &array(a, n), n: int(n)): (a)
//
extern
fun{}
dotprod_mt$submit (fwork: () -<lincloptr1> void): void
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

#define CUTOFF 1000000

(* ****** ****** *)

staload "libats/SATS/athread.sats"

(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/teaching/mythread/SATS/spinvar.sats"
staload
"{$LIBATSHWXI}/teaching/mythread/SATS/spinref.sats"
staload
"{$LIBATSHWXI}/teaching/mythread/SATS/nwaiter.sats"
//
(* ****** ****** *)
//
extern
fun{
a:t0p
} dotprod2{n:nat}
(
  nwaiter_ticket, spinref(a), ptr, ptr, int(n)
) : void // end of [dotprod2]
//
implement
{a}(*tmp*)
dotprod2{n}
(
  tick, spnr, pa, pb, n
) = let
//
val fwork =
llam (): void =<cloptr1>
{
  val (pfa, fpfa | pa) =
    $UN.ptr0_vtake{array(a,n)}(pa)
  val (pfb, fpfb | pb) =
    $UN.ptr0_vtake{array(a,n)}(pb)
  val res = dotprod (!pa, !pb, n)
  prval () = fpfa (pfa) and () = fpfb (pfb)
  local
  implement(env)
  spinref_process$fwork<a><env> (x, env) = x := gadd_val<a> (x, res)
  in(*in-of-local*)
  val ((*void*)) = spinref_process (spnr)
  end // end of [local]
  val ((*void*)) = nwaiter_ticket_put (tick)
} (* end of [llam] *)
//
in
  dotprod_mt$submit (fwork)
end // end of [dotprod2]
//
(* ****** ****** *)

implement
{a}(*tmp*)
dotprod_mt
  {n}(A, B, n) = let
//
vtypedef
ticket = nwaiter_ticket
//
val nw = nwaiter_create_exn ()
val tick = nwaiter_initiate (nw)
//
fun loop{n:nat}
(
  tick: ticket
, spnr: spinref(a)
, pa: ptr, pb: ptr, n: int(n)
) : void = let
in
//
if
n > CUTOFF
then let
  val tick2 =
    nwaiter_ticket_split (tick)
  val ((*void*)) =
    dotprod2<a> (tick2, spnr, pa, pb, CUTOFF)
  val pa2 = ptr_add<a> (pa, CUTOFF)
  val pb2 = ptr_add<a> (pb, CUTOFF)
in
  loop (tick, spnr, pa2, pb2, n - CUTOFF)
end // end of [then]
else let
  val tick2 = tick
  val () = dotprod2<a> (tick2, spnr, pa, pb, n)
in
  // nothing
end // end of [else]
//
end // end of [loop]
//
val _0_ = gnumber_int (0)
val spnv = spinvar_create_exn (_0_)
val ((*void*)) =
  loop (tick, $UN.castvwtp1{spinref(a)}(spnv), addr@A, addr@B, n)
//
val ((*void*)) = nwaiter_waitfor (nw)
val ((*void*)) = nwaiter_destroy (nw)
//
in
  spinvar_getfree<a> (spnv)
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
staload _(*anon*) =
"{$LIBATSHWXI}/teaching/mythread/DATS/workshop.dats"
//
staload _ = "libats/DATS/athread.dats"
staload _ = "libats/DATS/athread_posix.dats"
//
(* ****** ****** *)
//
extern
fun{
a:t@ype
} test_dotprod{n:nat}
(
  times: int
, A: &array(a, n), B: &array(a, n), n: int(n)
) : (a) // end of [test_dotprod]
//
implement
{a}(*tmp*)
test_dotprod
  (times, A, B, n) =
(
  if times > 0
    then let
      val res1 =
        dotprod_mt<a> (A, B, n)
      // end of [val]
      val res2 =
        test_dotprod<a> (times-1, A, B, n)
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
val err = workshop_add_worker<lincloptr> (ws0)
val err = workshop_add_worker<lincloptr> (ws0)
val err = workshop_add_worker<lincloptr> (ws0)
val err = workshop_add_worker<lincloptr> (ws0)
//
val nworker = workshop_get_nworker (ws0)
val ((*void*)) = println! ("nworker = ", nworker)
//
implement
dotprod_mt$submit<> (fwork) =
(
  workshop_insert_job<lincloptr> (ws0, $UN.castvwtp0{lincloptr}(fwork))
) (* end of [dotprod_mt$submit] *)
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
//
val res = test_dotprod<T> (TIMES, !p1, !p2, N) / TIMES
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

(* end of [dotprod_mt.dats] *)

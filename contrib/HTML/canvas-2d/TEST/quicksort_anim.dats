//
// Animating Quicksort
//

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/array0.sats"
//
staload _ = "libats/ML/DATS/list0.dats"
staload _ = "libats/ML/DATS/array0.dats"
//
(* ****** ****** *)

extern
fun{a:t@ype}
array0_swap
  (A: array0 (a), i: size_t, j: size_t): void
// end of [array0_swap]

(* ****** ****** *)

extern
fun{
a:t@ype
} qsort (
  A: array0 (a), st: size_t, len: size_t
) : void // end of [qsort]

(* ****** ****** *)

extern
fun{a:t@ype}
qsort_partition
  (A: array0 (a), st: size_t, len: size_t): size_t
// end of [qsort_partition]

(* ****** ****** *)

implement
{a}(*tmp*)
qsort (A, st, len) =
(
if len >= 2 then let
  val len_f = qsort_partition<a> (A, st, len)
  val ((*void*)) = qsort<a> (A, st, len_f)
  val len_r = len - len_f
  val ((*void*)) = qsort<a> (A, succ(st+len_f), pred(len_r))
in
  // nothing
end else () // end of [if]
)

(* ****** ****** *)

#define MYMAX 1000

(* ****** ****** *)

datatype myint =
MYINT of (int(*value*), int(*color*))

(* ****** ****** *)

extern
fun fprint_myint (FILEref, myint): void

overload fprint with fprint_myint
overload fprint with fprint_array0

(* ****** ****** *)

implement
fprint_myint (out, x) = let
  val+MYINT (i, _) = x in fprint (out, i)
end // end of [fprint_myint]

implement
fprint_val<myint> (out, x) = fprint (out, x)

(* ****** ****** *)

implement
gcompare_val<myint>
  (x1, x2) = let
  val+MYINT(i1, _) = x1
  and MYINT(i2, _) = x2
in
  g0int_compare_int (i1, i2)
end // end of [gcompare_val]

(* ****** ****** *)
(*
//
// HX-2013-10:
// I learned
// this style of partitioning from K&R
//
implement
qsort_partition<myint>
  (A, st, len) = let
//
val last = pred(st+len)
val pivot = A[last] // need randomness?
val+MYINT(v, c) = pivot
val pivot = MYINT(v, 1) // coloring the pivot
val () = A[last] := pivot
//
fun loop
(
  k1: size_t, k2: size_t
) : size_t =
  if k2 < last then let
    val sgn = gcompare_val<myint> (pivot, A[k2])
  in
    if sgn <= 0
      then loop (k1, succ(k2))
      else (array0_swap(A, k1, k2); loop (succ(k1), succ(k2)))
    // end of [if]
  end else k1 // end of [loop]
//
val k1 = loop (st, st)
val () = array0_swap (A, k1, last)
//
in
  (k1 - st)
end // end of [qort_partition]
*)

(* ****** ****** *)
//
// HX-2013-10:
// This is probably
// the most popular style of partitioning
//
implement
qsort_partition<myint>
  (A, st, len) = let
//
val last = pred(st+len)
val pivot = A[last] // need randomness?
val+MYINT(v, c) = pivot
val pivot = MYINT(v, 1) // coloring the pivot
val () = A[last] := pivot
//
fnx loop_lf
(
  l: size_t, r: size_t
) : size_t =
  if l < r then let
    val sgn = gcompare_val<myint> (A[l], pivot)
  in
    if sgn < 0
      then loop_lf (succ(l), r) else loop_rb (l, r)
    // end of [if]
  end else l // end of [loop_rb]
//
and loop_rb
(
  l: size_t, r: size_t
) : size_t =
  if l < r then let
    val r1 = pred (r)
    val sgn = gcompare_val<myint> (pivot, A[r1])
  in
    if sgn <= 0
      then loop_rb (l, r1) else loop_swap (l, r1)
    // end of [if]
  end else l // end of [loop_lf]
//
and loop_swap
(
  l: size_t, r: size_t
) : size_t = let
  val () = array0_swap (A, l, r) in loop_lf (succ(l), r)
end // end of [loop_swap]
//
val lf = loop_lf (st, last)
val () = array0_swap (A, lf, last)
//
in
  (lf - st)
end // end of [qort_partition]

(* ****** ****** *)

extern
fun myintqsort (A: array0(myint)): void

(* ****** ****** *)

extern
fun snapshot_pop (): array0(myint)
extern
fun snapshot_push (A: array0(myint)): void
extern
fun snapshot_reverse (): void
extern
fun snapshot_hasmore (): bool

local
//
val theSnapshots =
  ref<list0(array0(myint))> (list0_nil)
val theSnapshots_hasmore = ref<bool> (true)
//
in (* in of [local] *)

implement
snapshot_pop () = x where
{
  val-cons0(x, xs) = !theSnapshots
  val () = (
    case+ xs of
    | cons0 _ => !theSnapshots := xs
    | nil0 () => !theSnapshots_hasmore := false
  ) : void (* end of [val] *)
}

implement
snapshot_push (A) = let
  val A = array0_copy (A)
in
  !theSnapshots := list0_cons{array0(myint)}(A, !theSnapshots)
end // end of [snapshot_push]

implement
snapshot_reverse () = !theSnapshots := list0_reverse (!theSnapshots)

implement
snapshot_hasmore () = !theSnapshots_hasmore

end // end of [local]

(* ****** ****** *)

implement
myintqsort (A) = let
//
implement
array0_swap<myint>
  (A, i, j) =
{
  val tmp = A[i]
  val () = A[i] := A[j]
  val () = A[j] := tmp
  val () = snapshot_push (A)
}
//
in
  qsort<myint> (A, i2sz(0), A.size)
end // end of [intqsort]

(* ****** ****** *)

staload "{$HTML}/SATS/document.sats"
staload "{$HTML5canvas2d}/SATS/canvas2d.sats"

(* ****** ****** *)

fun
draw_array0
  {l:agz}
(
  ctx: !canvas2d(l)
, W: double, H: double, A: array0 (myint)
) : void = let
//
val n = A.size
//
fun
loop{l:agz}
(
  ctx: !canvas2d(l), i: size_t
) : void = let
in
//
if i < n then let
  val Ai = A[i]
  val+MYINT(v, c) = Ai
  val xul = $UN.cast{double}(i)
  val yul = 1.0 * g0i2f(MYMAX-v)
//
  val () =
    if c = 0 then
      canvas2d_set_fillStyle_string (ctx, "#7F7F7F")
    // end of [if]
  val () =
    if c = 1 then
      canvas2d_set_fillStyle_string (ctx, "#000000")
    // end of [if]
//
  val () = canvas2d_fillRect (ctx, xul, yul, 1.0, g0i2f(v))
//
in
  loop (ctx, succ(i))
end else () // end of [if]
//
end // end of [loop]
//
val (pf | ()) = canvas2d_save (ctx)
//
val n = g0uint2int_size_int(n)
val () = canvas2d_translate (ctx, 0.0, 0.10*H)
val () = canvas2d_scale (ctx, W/n, 0.85*H/MYMAX)
val () = loop (ctx, i2sz(0))
//
val ((*void*)) = canvas2d_restore (pf | ctx)
//
in
  // nothing
end // end of [draw_array0]

(* ****** ****** *)

staload "libc/SATS/time.sats"
staload "libc/SATS/stdlib.sats"
staload "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload _ = "{$LIBATSHWXI}/testing/DATS/randgen.dats"

(* ****** ****** *)
//
extern
fun canvas2d_set_size_int
(
  id: string
, width: int(*px*), height: int(*px*)
) : void = "ext#JS_canvas2d_set_size_int"
//
extern
fun request_animation_frame
  (f: (double) -> void): void = "ext#JS_request_animation_frame"
//
(* ****** ****** *)

local

val dt = 100.0

in (* in of [local] *)

extern
fun
do_animation (): void
implement
do_animation () =
request_animation_frame
(
fix step
(
  stamp: double
) : void => let
//
val A = snapshot_pop ()
//
val ctx = canvas2d_make ("QuicksortAnim")
val ((*void*)) = assertloc (ptrcast(ctx) > 0)
//
val W = document_get_documentElement_clientWidth()
val H = document_get_documentElement_clientHeight()
//
val () = canvas2d_set_size_int ("QuicksortAnim", W, H)
//
val Wf = g0i2f(W) and Hf = g0i2f(H)
val () = canvas2d_clearRect (ctx, 0.0, 0.0, Wf, Hf)
val () = canvas2d_set_fillStyle_string (ctx, "#FFFFFF")
val () = canvas2d_fillRect (ctx, 0.0, 0.0, Wf, Hf)
//
val () =
(
  draw_array0 (ctx, Wf, Hf, A); canvas2d_free (ctx)
) (* end of [val] *)
//
in
  if snapshot_hasmore () then request_animation_frame (step)
end // end of [fix]
) (* end of [request_animation_frame] *)

end // end of [local]

(* ****** ****** *)

implement
main0{n}
(
  argc, argv
) = let
//
val N = 100
val N = (
  if argc >= 2 then g0string2int(argv[1]) else N
) : int // end of [val]
val N = g1ofg0_int(N)
val () = assertloc (N >= 0)
val N = i2sz(N)
//
(*
val seed = time_get ()
val seed = $UN.cast{lint}(seed)
val ((*void*)) = srand48 (seed)
*)
//
implement{
} randint{n}(n) =
  $UN.cast{natLt(n)}(0.999999 * drand48 () * n)
implement
randgen_val<myint> () = MYINT(randint(MYMAX), 0)
//
val A = randgen_arrayref (N)
val A = array0_make_arrayref (A, N)
//
val out = stdout_ref
//
val () = snapshot_push (A)
//
(*
val () = fprintln! (out, "A(bef) = ", A)
*)
val () = myintqsort (A)
(*
val () = fprintln! (out, "A(aft) = ", A)
*)
//
val () = snapshot_reverse ()
//
val ((*void*)) = do_animation ()
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [quicksort_anim.dats] *)

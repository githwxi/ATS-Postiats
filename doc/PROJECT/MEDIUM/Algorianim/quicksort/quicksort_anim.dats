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

staload "{$HTML}/SATS/document.sats"
staload "{$HTML5canvas2d}/SATS/canvas2d.sats"

(* ****** ****** *)

(*
** Generate a number in [0, 1)
*)
extern
fun Math_random ((*void*)): double = "ext#JS_Math_random"

(* ****** ****** *)

staload "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload _ = "{$LIBATSHWXI}/testing/DATS/randgen.dats"

(* ****** ****** *)

extern
fun{a:t@ype}
array0_swap
  (A: array0 (a), i: size_t, j: size_t): void
// end of [array0_swap]

(* ****** ****** *)

typedef range_t = @(size_t, size_t)

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

extern
fun{a:t@ype}
qsort_partition_render
  (A: array0 (a), partition: range_t, pivot: size_t): void
// end of [qsort_partition_render]

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

#define MYMAX 165

(* ****** ****** *)

implement
gcompare_val<int>
  (x1, x2) = g0int_compare_int (x1, x2)
// end of [gcompare_val]

(* ****** ****** *)

implement{
} randint{n}(n) =
(
  $UN.cast{natLt(n)} (n * Math_random ())
)

(* ****** ****** *)

implement{a}
qsort_partition
  (A, st, len) = let
//
val last = pred(st+len)
//
// Pick a pivot uniformly at random 
//
val n = g1ofg0(g0u2i(len))
val () = assertloc (n > 0)
val offset = i2sz(randint(n))
val pivot = A[st + offset]
val () = array0_swap (A, st + offset, last)
//
val () = qsort_partition_render<a> (A, @(st, len), last)
//
fun loop
(
  k1: size_t, k2: size_t
) : size_t =
  if k2 < last then let
    val sgn = gcompare_val<a> (pivot, A[k2])
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

(* ****** ****** *)

extern
fun intqsort (A: array0(int)): void

(* ****** ****** *)

typedef swap_t = @(size_t, size_t)

datatype snapshot = 
  | Normal of (array0(int))
  | SelectPivot of (array0(int), range_t, size_t)
  | Swap of (array0(int), range_t, size_t, swap_t)
  
(* ****** ****** *)

extern
fun
snapshot_pop (): snapshot
extern
fun snapshot_push (snap: snapshot): void
extern
fun snapshot_reverse (): void
extern
fun snapshot_hasmore (): bool

local
//
val theSnapshots =
  ref<list0(snapshot)> (list0_nil)
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
snapshot_push (snap) = let
in
  !theSnapshots := list0_cons{snapshot} (snap, !theSnapshots)
end // end of [snapshot_push]

implement
snapshot_reverse () = !theSnapshots := list0_reverse (!theSnapshots)

implement
snapshot_hasmore () = !theSnapshots_hasmore

end // end of [local]

(* ****** ****** *)

extern
fun thePivot_get (): size_t
and thePivot_set (size_t): void
extern
fun thePartition_get (): range_t
and thePartition_set (range_t): void
extern
fun theNextRender_get (): double
and theNextRender_set (double): void
and theNextRender_incby (double): void

(* ****** ****** *)

local

val
thePivot = ref<size_t> (i2sz(0))
and
thePartition = ref<range_t> @(i2sz(0), i2sz(0))

val
theNextRender = ref<double> (0.0)

in (* in of [local] *)

implement
thePartition_get () = !thePartition
implement
thePartition_set (x) = !thePartition := x

implement
thePivot_get () = !thePivot
implement
thePivot_set (x) = !thePivot := x

implement
theNextRender_get () = !theNextRender
implement
theNextRender_incby (x) = !theNextRender := !theNextRender + x

end // end of [local]

(* ****** ****** *)

implement
qsort_partition_render<int>
  (A, part, p) = let
  val A'   = array0_copy(A)
  val snap = SelectPivot (A', part, p)
  val ()   = thePartition_set (part)
  val ()   = thePivot_set (p)
in
  snapshot_push(snap);
end

implement
intqsort (A) = let
//
implement
array0_swap<int>
  (A, i, j) =
{
val () = let
  val A = array0_copy(A)
  val part = thePartition_get ()
  val pivot = thePivot_get ()
in
  snapshot_push (Swap(A, part, pivot, @(i,j)))
end // end of [val]
//
val tmp = A[i]
val () = A[i] := A[j]
val () = A[j] := tmp
//
}
//
in
  qsort<int> (A, i2sz(0), A.size)
end // end of [intqsort]

(* ****** ****** *)

extern
fun
draw_array0
  {l:agz} (
  cnv: !canvas2d(l), A: array0(int), W: int, H: int, _: range_t, _: int
) : void // end of [draw_array0]

local

val dt = 100.0

in (* in of [local] *)

implement
draw_array0{l}
(
  cnv, A, W, H, range, p
) = let
//
val n = A.size
val asz = A.size
val sx = g0i2f(W) / $UN.cast{double}(asz)
val sy = g0i2f(H) / $UN.cast{double}(MYMAX)
val (pf | ()) = canvas2d_save (cnv)
val () = canvas2d_scale (cnv, sx, sy)
//
fun loop
(
  cnv: !canvas2d l, i: size_t
) : void =
(
  if i < n then let
    val v = A[i]
    val xul = g0uint2int(i)
    val yul = MYMAX - v
    val color = let
      val normal = "rgb(200, 200, 200)"
    in
      case+ p of 
      | _ when p = ~1 => normal
      | _  =>> if p = g0uint2int(i) then "rgb(255, 0, 0)" else normal
    end : string // end of [val]
  in
    canvas2d_set_fillStyle_string (cnv, color);
    canvas2d_fillRect (cnv, 1.0 * xul, 1.0 * yul, 1.0, 1.0 * v);
    loop (cnv, succ(i))
  end
) (* end of [loop] *)
//
val () = loop (cnv, i2sz(0))
val part_start = g0uint2int(range.0) and part_len = g0uint2int(range.1)
val () = // draw a blue line to indicate the pivot
if p > ~1 then let
   val v  = A[$UN.cast{size_t}(p)]
   val (pf' | ()) = canvas2d_save (cnv)
in
   canvas2d_beginPath (cnv);
   canvas2d_moveTo (cnv, 1.0 * part_start, 1.0 * (MYMAX - v));
   canvas2d_lineTo (cnv, 1.0 * (part_start + part_len), 1.0 * (MYMAX - v));
   canvas2d_set_lineWidth (cnv, 0.25);
   canvas2d_set_strokeStyle_string (cnv, "#0000FF");
   canvas2d_stroke (cnv);
   canvas2d_closePath (cnv);
   canvas2d_restore (pf' | cnv)
end // end of [if] // end of [val]
//
val () = canvas2d_set_fillStyle_string (cnv, "rgba(0, 0, 0, 0.1)")
val () = canvas2d_fillRect (cnv, 1.0 * part_start, 0.0, 1.0 * part_len, 1.0 * MYMAX)
//
in
  canvas2d_restore (pf | cnv)
end (* end of [draw_array0] *)

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
fun window_requestAnimationFrame
  (f: (double)-> void): void = "ext#JS_window_requestAnimationFrame"
//
(* ****** ****** *)

extern
fun
start_animation (): void
implement
start_animation () =
window_requestAnimationFrame
(
fix step (timestamp:double): void =>
(
  if theNextRender_get() < timestamp then let
    val shot = snapshot_pop ()
    val () = theNextRender_incby (dt)
    // render the shot
    val cnv = canvas2d_make ("QuicksortAnim")
    val ((*void*)) = assertloc (ptrcast(cnv) > 0)
    // Get the latest dimensions of the viewport
    val W = document_get_documentElement_clientWidth()
    val H = document_get_documentElement_clientHeight()
    // Resize our canvas 
    val () = canvas2d_set_size_int ("QuicksortAnim", W, H)
    val Wf = g0i2f(W) and Hf = g0i2f(H)
    val (
    ) = canvas2d_clearRect (cnv, 0.0, 0.0, Wf, Hf)
    val () = canvas2d_set_fillStyle_string (cnv, "#FFFFFF")
    val () = canvas2d_fillRect (cnv, 0.0, 0.0, Wf, Hf)
  in (
    case+ shot of 
    | Normal (A) => let
        val range = (i2sz(0), i2sz(0))
      in
        draw_array0 (cnv, A, W, H, range, ~1); canvas2d_free (cnv);
      end
    | SelectPivot (A, range, p) => begin
        draw_array0 (cnv, A, W, H, range, g0uint2int(p)); canvas2d_free (cnv)
      end
    | Swap (A, range, p , _) => begin
        draw_array0 (cnv, A, W, H, range, g0uint2int(p));  canvas2d_free (cnv);
      end
  ) end ; if snapshot_hasmore () then window_requestAnimationFrame (step) ;
)
) // end of [window_requestAnimationFrame]

end // end of [local]

(* ****** ****** *)

(*
staload TIME = "libc/SATS/time.sats"
staload STDLIB = "libc/SATS/stdlib.sats"
*)

(* ****** ****** *)
  
implement
main0 () = let
//
val N = 150
val N = g1ofg0_int (N)
val () = assertloc (N > 0)
//
(*
val () =
$STDLIB.srand48 ($UN.cast{lint}($TIME.time_get()))
*)
//
(* 
** Generate a random permutation of the array [1,2,...,N]
*)
//
val A =
  arrayptr_make_intrange (1, N+1)
val p = ptrcast (A)
prval pf = arrayptr_takeout{int} (A)
implement{}
array_permute$randint{n}(n) = g1i2u(randint(g1u2i(n)))
//
val N = i2sz(N)
//
val () = array_permute (!p, N)
//
prval () = arrayptr_addback (pf | A)
//
val A = arrayptr_refize (A)
val A = array0_make_arrayref (A, N)
//
val out = stdout_ref
//
val () = snapshot_push (Normal(A)) where { val A = array0_copy(A) }
//
val () = intqsort (A)
//
val () = snapshot_push (Normal(A)) where { val A = array0_copy (A) }
//
val () = snapshot_reverse ()
//
in
  start_animation ()
end // end of [main0]

(* ****** ****** *)

(* end of [quicksort_anim.dats] *)

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

staload "contrib/HTML/canvas-2d/SATS/canvas.sats"

(* ****** ****** *)

(*
  Generate a number between 0 (inclusive) and 1 (exclusive)
*)
extern
fun Math_random (): double = "ext#"

extern
fun Math_floor (_: double): int = "ext#"

(* ****** ****** *)

staload "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload _ = "{$LIBATSHWXI}/testing/DATS/randgen.dats"

implement{} randint{n}(n) = let
  val r = Math_random ()
  val sample = Math_floor (r * n)
in $UN.cast{natLt(n)} (sample) end

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

#define MYMAX 1000

(* ****** ****** *)

implement
gcompare_val<int>
  (x1, x2) = g0int_compare_int (x1, x2) // end of [gcompare_val]

(* ****** ****** *)

implement{a}
qsort_partition
  (A, st, len) = let
//
val last = pred(st+len)
// Pick a pivot uniformly at random 
val n = $UN.cast{[n:pos] int n}(len)
val offset = $UN.cast{size_t}(randint(n))
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
fun snapshot_pop (): snapshot
extern
fun snapshot_push (
  snap: snapshot
): void
extern
fun snapshot_reverse (): void

local
//
val theSnapshots =
  ref<list0(snapshot)> (list0_nil)
//
in (* in of [local] *)

implement
snapshot_pop () = x where
{
  val-cons0(x, xs) = !theSnapshots
  val () = (
    case+ xs of cons0 _ => !theSnapshots := xs | nil0 () => ()
  ) : void (* end of [val] *)
}

implement
snapshot_push (snap) = let
in
  !theSnapshots := list0_cons{snapshot} (snap, !theSnapshots)
end // end of [snapshot_push]

implement
snapshot_reverse () = !theSnapshots := list0_reverse (!theSnapshots)

end // end of [local]

(* ****** ****** *)

val next_render = ref<double> (0.0)

typedef state_t = @{
  partition=range_t,
  pivot=size_t,
  next_render = double
}

val state = ref<state_t> ( @{
  partition= @(u2sz(0u), u2sz(0u)),
  pivot= u2sz(0u),
  next_render= 0.0
})

implement
qsort_partition_render<int> (A, part, p) = let
  val A'   = array0_copy(A)
  val snap = SelectPivot (A', part, p)
in
  !state.partition := part;
  !state.pivot := p;
  snapshot_push(snap);
end

implement
intqsort (A) = let
//
implement
array0_swap<int>
  (A, i, j) =
{
  val () = snapshot_push (Swap(A', r, p, @(i,j))) where {
    val A' = array0_copy(A)
    val r = !state.partition
    val p = !state.pivot
  }
  val tmp = A[i]
  val () = A[i] := A[j]
  val () = A[j] := tmp
}
//
in
  qsort<int> (A, i2sz(0), A.size)
end // end of [intqsort]

(* ****** ****** *)

extern
fun document_documentElement_clientWidth(): int = "ext#"
extern
fun document_documentElement_clientHeight(): int = "ext#"

extern
fun window_request_animation_frame (_: (double)-> void): void = "ext#"

extern
fun start_animation (): void = "ext#"

(* ****** ****** *)

extern
fun draw_array {l:agz} (
  cnv: !canvas2d l, A: array0(int), W: int, H: int, _: range_t, _: int
): void

local
  val dt = 100.0
in

  implement draw_array {l} (cnv, A, W, H, range, p) = let
    val n = A.size
    val asz = A.size
    val sx = g0i2f(W) / $UN.cast{double}(asz)
    val sy = g0i2f(H) / $UN.cast{double}(MYMAX)
    val (pf | ()) = canvas2d_save (cnv)
    val () = canvas2d_scale (cnv, sx, sy)
    //
    fun loop (
      cnv: !canvas2d l, i: size_t
    ): void =
      if i < n then let
        val v = A[i]
        val xul = g0uint2int(i)
        val yul = MYMAX - v
        val color = (let
            val normal = "rgb(200, 200, 200)"
          in
            case+ p of 
              | _ when p = ~1 => normal
              | _  =>> 
                if p = g0uint2int(i) then
                "rgb(255, 0, 0)"
               else
                 normal
          end
        ): string
      in
        canvas2d_fillStyle_string (cnv, color);
        canvas2d_fillRect (cnv, xul, yul, 1, v);
        loop (cnv, succ(i))
      end
    val () = loop (cnv, i2sz(0))
    val part_start = g0uint2int(range.0) and part_len = g0uint2int(range.1)
    val () =
    //draw a blue line to indicate the pivot
      if p > ~1 then let
        val v  = A[$UN.cast{size_t}(p)]
        val (pf' | ()) = canvas2d_save (cnv)
      in
        canvas2d_beginPath (cnv);
        canvas2d_moveTo (cnv, part_start, MYMAX - v);
        canvas2d_lineTo (cnv, part_start + part_len, MYMAX - v);
        canvas2d_strokeStyle_string (cnv, "rgb(0,0,255)");
        canvas2d_stroke (cnv);
        canvas2d_restore (pf' | cnv)
      end    
    val () = canvas2d_fillStyle_string (cnv, "rgba(0, 0, 0, 0.1)")
    val () = canvas2d_fillRect (cnv, part_start, 0, part_len , MYMAX)
  in
    canvas2d_restore (pf | cnv)
  end

  implement start_animation () =
    window_request_animation_frame (
      fix step (timestamp:double): void => begin
        if !state.next_render < timestamp then let
          val event = snapshot_pop ()
          val () = !state.next_render := !state.next_render + dt
          // render the event
          val cnv = canvas2d_make ("quicksort")
          val () = assertloc (ptr_isnot_null(ptrcast(cnv)))
          //Get the latest dimensions of the viewport
          val W = document_documentElement_clientWidth()
          val H = document_documentElement_clientHeight()
          //Resize our canvas 
          val () = canvas2d_set_size (cnv, W, H)
          val () = canvas2d_clearRect (cnv, 0, 0, W, H)
          val () = canvas2d_fillStyle_string (cnv, "rgb(255,255,255)")
          val () = canvas2d_fillRect (cnv, 0, 0, W, H)
        in (
          case+ event of 
          | Normal (A) => begin
            draw_array (cnv, A, W, H, @(i2sz(0),i2sz(0)), ~1);
            canvas2d_free (cnv);
          end
          | SelectPivot (A, range, p) => begin
            draw_array (cnv, A, W, H, range, g0uint2int(p));
            canvas2d_free (cnv)
          end
          | Swap (A, range, p , _) => begin
            draw_array (cnv, A, W, H, range, g0uint2int(p)); 
            canvas2d_free (cnv);
          end
        )
       end;
        window_request_animation_frame (step);
      end
    )

end
  
implement
main0 () = let
//
val N = 150
val N = g1ofg0_int (N)
val () = assertloc (N > 0)
val N' = N
val N = i2sz (N)
//
(* 
  Get a random permutation of [1,2,...,N]
*)
fun gen (): array0(int) = let
  fun loop (i: int, res: list0(int)): list0(int) = 
    if i > N' then 
      res
    else let
      val frac = Math_floor(g0i2f(i) / $UN.cast{double}(N) * g0i2f(MYMAX))
    in loop (succ(i), list0_cons{int}(frac, res)) end
  val sequence =  loop (1, list0_nil())
  val sequence = array0_make_list<int> (sequence)
  //
  fun shuffle (i: size_t): void =
    if i = i2sz(0) then 
      ()
    else let
      val r = randint(succ($UN.cast{[n:nat] int n}(i)))
      val tmp = sequence[r]
      val () = sequence[r] := sequence[i]
      val () = sequence[i] := tmp
    in shuffle (pred(i)) end
  //
in
  shuffle(pred(N));
  sequence
end
//
val A = gen()
//
val out = stdout_ref
//
val () = snapshot_push (Normal(A')) where {
  val A' = array0_copy(A)
}
//
val () = intqsort (A)
// The finished product
val () = snapshot_push (Normal(A')) where {
  val A' = array0_copy (A)
}
//
val () = snapshot_reverse ()
//
in
  start_animation ()
end // end of [main0]

(* ****** ****** *)

(* end of [quicksort_anim.dats] *)

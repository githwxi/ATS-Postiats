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

(* ****** ****** *)

local
//
val theSnapshots =
  ref<list0(array0(myint))> (list0_nil)
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
snapshot_push (A) = let
  val A = array0_copy (A)
in
  !theSnapshots := list0_cons{array0(myint)}(A, !theSnapshots)
end // end of [snapshot_push]

implement
snapshot_reverse () = !theSnapshots := list0_reverse (!theSnapshots)

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

staload "{$CAIRO}/SATS/cairo.sats"

(* ****** ****** *)

fun
draw_array0
(
  cr: !xr1, A: array0 (myint)
) : void = let
//
val n = A.size
//
fun
loop{l:agz}
(
  cr: !xr(l), i: size_t
) : void = let
in
//
if i < n then let
  val Ai = A[i]
  val+MYINT(v, c) = Ai
  val xul = $UN.cast{double}(i)
  val yul = 1.0 * g0i2f(MYMAX-v)
  val () =
    if c = 0 then cairo_set_source_rgb (cr, 0.0, 0.0, 1.0) // blue
  val () =
    if c = 1 then cairo_set_source_rgb (cr, 1.0, 0.0, 0.0) // red
  val () = cairo_rectangle (cr, xul, yul, 1.0, g0i2f(v))
  val () = cairo_fill (cr)
in
  loop (cr, succ(i))
end else () // end of [if]
//
end // end of [loop]
//
in
  loop (cr, i2sz(0))
end // end of [draw_array0]

(* ****** ****** *)

extern
fun mydraw_clock
(
  cr: !cairo_ref1, width: int, height: int
) : void // end of [mydraw_clock]

implement
mydraw_clock
  (cr, W, H) = let
//
val A = snapshot_pop ()
val asz = array0_get_size (A)
//
val sx = g0i2f(W) / $UN.cast{double}(asz)
val sy = g0i2f(H) / $UN.cast{double}(MYMAX)
//
val (pf | ()) = cairo_save (cr)
val () = cairo_scale (cr, sx, sy)
val () = draw_array0 (cr, A)
val ((*void*)) = cairo_restore (pf | cr)
//
in
end // [mydraw_clock]

(* ****** ****** *)

staload "libc/SATS/time.sats"
staload "libc/SATS/stdlib.sats"
staload "{$LIBATSHWXI}/testing/SATS/randgen.sats"
staload _ = "{$LIBATSHWXI}/testing/DATS/randgen.dats"

(* ****** ****** *)

%{^
typedef char **charptrptr ;
%} ;
abstype charptrptr = $extype"charptrptr"

(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/teaching/myGTK/SATS/gtkcairoclock.sats"
staload
_ = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairoclock.dats"
//
(* ****** ****** *)

implement
main0{n}
(
  argc, argv
) = let
//
val N = 100
val N =
(
if argc >= 2
  then g0string2int(argv[1]) else N
// end of [if]
) : int // end of [val]
val N = g1ofg0_int(N)
val () = assertloc (N >= 0)
val N = i2sz(N)
//
val seed = time_get ()
val seed = $UN.cast{lint}(seed)
val ((*void*)) = srand48 (seed)
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
var argc: int = argc
var argv: charptrptr = $UN.castvwtp1{charptrptr}(argv)
//
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
implement
gtkcairoclock_title<> () = stropt_some"QuicksortAnimation"
implement
gtkcairoclock_timeout_interval<> () = 100U // millisecs
implement
gtkcairoclock_mydraw<> (cr, width, height) = mydraw_clock (cr, width, height)
//
val ((*void*)) = gtkcairoclock_main ((*void*))
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [quicksort_anim.dats] *)

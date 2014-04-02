(* ****** ****** *)
//
// HX-2014-03:
// Animating QueenPuzzle (LazyEval)
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload
_(*MATH*) = "libc/DATS/math.dats"

(* ****** ****** *)
//
staload UN = $UNSAFE
//
(* ****** ****** *)

fun path_test
(
  xs: list0 (int), x0: int
) : bool = let
//
fun aux
(
  xs: list0 (int), df: int
) : bool =
(
  case+ xs of
  | nil0 () => true
  | cons0 (x, xs) =>
      if x0 != x && abs (x0 - x) != df then aux (xs, df+1) else false
    // end of [cons0]
)
//
in
  aux (xs, 1(*df*))
end // end of [path_test]

(* ****** ****** *)
//
#define N 8
//
(*
#define N 32
*)
//
(* ****** ****** *)

fun path_next
(
  xs: list0(int)
) : stream(list0(int)) = $delay
(
let
  val n = length (xs)
in
//
if n < N
  then path_next2 (xs, 0)
  else let
    val-cons0 (x, xs) = xs
  in
    path_next2 (xs, x + 1)
  end // end of [else]
//
end
) // end of [path_next]

and path_next2
(
  xs: list0(int), x0: int
) : stream_con(list0(int)) =
(
if x0 < N
  then let
    val pass = path_test (xs, x0)
  in
    if pass
      then let
        val xs = cons0 (x0, xs)
        val xs_rev = list0_reverse (xs)
      in
        stream_cons (xs_rev, path_next (xs))
      end // end of [then]
      else path_next2 (xs, x0 + 1)
    // end of [if]
  end // end of [then]
  else (
    case+ xs of
    | cons0 (x, xs) => path_next2 (xs, x+1) | nil0 () => stream_nil(*void*)
  ) (* end of [else] *)
) (* end of [path_next2] *)
  
(* ****** ****** *)

staload
gtkcairotimer_toplevel =
{
#include "./gtkcairotimer_toplevel.dats"
} (* end of [gtkcairotimer_toplevel] *)

(* ****** ****** *)

val the_board =
matrix0_make_elt<int> (i2sz(N), i2sz(N), 0)

(* ****** ****** *)

val the_pathlst = path_next (nil0(*void*))

(* ****** ****** *)

val the_pathlst2 = ref<stream(list0(int))> (the_pathlst)

(* ****** ****** *)

fun
the_board_cleanup (): void =
{
  var i: int and j: int = 0
  val () =
  for (i := 0; i < N; i := i+1)
  for (j := 0; j < N; j := j+1) the_board[i,j] := 0
} 

(* ****** ****** *)

fun
the_board_update
  (path: list0(int)): void =
{
//
val () = the_board_cleanup ()
//
fun
loop
(
  i: int, js: list0 (int)
) : void =
  case+ js of
  | nil0 () => ()
  | cons0 (j, js) => (the_board[i, j] := 1; loop (i+1, js))
//
val () = loop (0, path)
//
} (* end of [the_board_update] *)

(* ****** ****** *)
//
staload "{$LIBATSHWXI}/teaching/myGTK/SATS/gtkcairotimer.sats"
staload "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/gtkcairotimer_toplevel.dats"
//
staload CP = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/ControlPanel.dats"
staload DP = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/DrawingPanel.dats"
staload MAIN = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/gtkcairotimer_main.dats"
staload TIMER = "{$LIBATSHWXI}/teaching/myGTK/DATS/gtkcairotimer/gtkcairotimer_timer.dats"
//
(* ****** ****** *)

extern
fun
the_timer_reset2 (): void
implement
the_timer_reset2 () =
{
  val () = the_board_cleanup ()
  val () = !the_pathlst2 := the_pathlst
  val () = the_timer_reset () // HX: gtkcairotimer_toplevel.dats
} (* end of [the_timer_reset2] *)

(* ****** ****** *)

implement
$CP.on_reset_clicked<> (widget, event, _) = the_timer_reset2 ()

(* ****** ****** *)
//
staload "{$GTK}/SATS/gdk.sats"
staload "{$GTK}/SATS/gtk.sats"
staload "{$GLIB}/SATS/glib.sats"
staload "{$GLIB}/SATS/glib-object.sats"
//
(* ****** ****** *)
//
staload "{$CAIRO}/SATS/cairo.sats"
//
staload "{$LIBATSHWXI}/teaching/mydraw/SATS/mydraw.sats"
staload "{$LIBATSHWXI}/teaching/mydraw/SATS/mydraw_cairo.sats"
//
staload "{$LIBATSHWXI}/teaching/mydraw/DATS/mydraw_matgraph.dats"
//
staload _(*anon*) = "{$LIBATSHWXI}/teaching/mydraw/DATS/mydraw.dats"
staload _(*anon*) = "{$LIBATSHWXI}/teaching/mydraw/DATS/mydraw_cairo.dats"
//
(* ****** ****** *)

extern
fun
cairo_draw_matrix0
(
  cr: !cairo_ref1
, point, point, point, point, matrix0(int)
) : void // end of [cairo_draw_matrix0]

implement
cairo_draw_matrix0
(
  cr, p1, p2, p3, p4, MSZ
) = let
//
val p_cr = ptrcast (cr)
//
implement
mydraw_get0_cairo<> () = let
//
extern
castfn __cast {l:addr} (ptr(l)): vttakeout (void, cairo_ref(l))
//
in
  __cast (p_cr)
end // end of [mydraw_get0_cairo]
//
implement{}
mydraw_matgraph$draw_cell
  (i, j, p1, p2, p3, p4) =
{
//
  val x = MSZ[i, j]
  val () =
    mydraw_quadrilateral (p1, p2, p3, p4)
  val ((*void*)) =
    if ((i+j) mod 2 = 0)
      then mydraw_fill_set_rgb (0.75, 0.75, 0.75)
      else mydraw_fill_set_rgb (1.00, 1.00, 1.00)
    // end of [if]
  val ((*void*)) = mydraw_fill ((*void*))
//
(*
  val () =
  if x > 0 then
  {
    val p12 = p1+(p2-p1)/2.0
    val p23 = p2+(p3-p2)/2.0
    val p34 = p3+(p4-p3)/2.0
    val p41 = p4+(p1-p4)/2.0
    val () =
    mydraw_quadrilateral (p12, p23, p34, p41)
    val () = mydraw_fill_set_rgb (0.0, 0.0, 0.0)
    val ((*void*)) = mydraw_fill ((*void*))
  }
*)
//
  val () =
  if x > 0 then
  {
    val center = p1 + (p3 - p1) / 2.0
    val radius = vector_length (p2 - p1) / 2
    val ((*void*)) = mydraw_circle (center, radius)
    val () = mydraw_fill_set_rgb (0.0, 0.0, 0.0)
    val ((*void*)) = mydraw_fill ((*void*))
  }
//
} (* end of [mydraw_matgraph$draw_cell] *)
//
val nrow = MSZ.nrow
val nrow = g1ofg0(nrow)
val () = assertloc (nrow > 0)
val nrow = sz2i (nrow)
val ncol = MSZ.ncol
val ncol = g1ofg0(ncol)
val () = assertloc (ncol > 0)
val ncol = sz2i (ncol)
//
in
  mydraw_matgraph (nrow, ncol, p1, p2, p3, p4)
end // end of [cairo_draw_matrix0]

(* ****** ****** *)
//
extern
fun
mydraw_clock
  (cr: !cairo_ref1, width: int, height: int) : void
//
implement
mydraw_clock
  (cr, W, H) = let
//
val W =
g0int2float_int_double(W)
and H =
g0int2float_int_double(H)
//
val WH = min (W, H)
//
val xm = (W - WH) / 2
val ym = (H - WH) / 2
//
val v0 = vector_make (xm, ym)
//
val p1 = point_make (0. , WH) + v0
val p2 = point_make (WH , WH) + v0
val p3 = point_make (WH , 0.) + v0
val p4 = point_make (0. , 0.) + v0
//
val running = the_timer_is_running ()
//
val () =
if running then
{
  val xss = !the_pathlst2
  val () =
  (
    case+ !xss of
    | stream_nil((*void*)) =>
      {
        val () = the_timer_reset2 ()
      }
    | stream_cons (xs, xss) =>
      {
        val () = !the_pathlst2 := xss
        val () = the_board_update (xs)
        val () = if length (xs) >= N then the_timer_pause ()
      } (* end fof [cons0] *)
  ) : void // end of [val]
} 
//
val (pf | ()) = cairo_save (cr)
//
val ((*void*)) =
  cairo_draw_matrix0 (cr, p4, p1, p2, p3, the_board)
//
val ((*void*)) = cairo_restore (pf | cr)
//
in
  // nothing
end // [mydraw_clock]

(* ****** ****** *)

%{^
typedef char **charptrptr ;
%} ;
abstype charptrptr = $extype"charptrptr"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var argc: int = argc
var argv: charptrptr = $UNSAFE.castvwtp1{charptrptr}(argv)
//
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
implement
gtkcairotimer_title<> () = stropt_some"QueenPuzzle"
implement
gtkcairotimer_timeout_interval<> () = 500U // millisecs
implement
gtkcairotimer_mydraw<> (cr, width, height) = mydraw_clock (cr, width, height)
//
val ((*void*)) = gtkcairotimer_main<> ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [QueenPuzzle_anim2.dats] *)

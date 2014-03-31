(* ****** ****** *)
//
// HX-2014-03:
// Animating QueenPuzzle
//
(* ****** ****** *)

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

staload
_(*MATH*) = "libc/DATS/math.dats"

(* ****** ****** *)

#define N 8 // the number of queen pieces

(* ****** ****** *)

staload
DF = "./../depth-first.sats"

(* ****** ****** *)
//
staload "./gtkcairotimer_toplevel.dats"
//
(* ****** ****** *)

datatype
node = NODE of (int, int)
assume $DF.node_type = node

(* ****** ****** *)

typedef nodelst = $DF.nodelst

(* ****** ****** *)

(*
extern
fun fpprint_node (FILEref, node): void
implement
fpprint_node
  (out, nx) = let
//
val+NODE(i, j) = nx
//
fun prdot (n: int): void =
  if n > 0 then (fprint (out, ". "); prdot (n-1))
//
in
//
prdot (j); fprint (out, "Q "); prdot (N-j-1); fprint_newline (out)
//
end // end of [fpprint_node]

extern
fun fpprint_nodelst (FILEref, nodelst): void
implement
fpprint_nodelst
  (out, nxs) = let
in
  list0_foreach (nxs, lam nx => fpprint_node (out, nx))
end // end of [fpprint_nodelst]
*)

(* ****** ****** *)

implement
$DF.node_get_children
  (nx) = let
//
val NODE (i, _) = nx
//
in
  list0_tabulate<node> (N, lam n => NODE (i+1, n))
end // end of [node_get_children]
    
(* ****** ****** *)

implement
$DF.handle_node
  (path, nx0) = let
//
val+NODE(i0, j0) = nx0
//
fun test (nxs: nodelst): bool =
  case+ nxs of
  | nil0 () => true
  | cons0 (NODE(i, j), nxs) =>
      if (j0 != j) && abs(i0-i) != abs(j0-j) then test (nxs) else false
    // end of [cons0]
//
val ans = test (path)
//
in
//
if ans then let
  val path2 = cons0(nx0, path)
  val path2_rev = list0_reverse(path2)
  val ((*void*)) = $PATHLST.push (path2_rev)
in
  if length (path2) < N then true else false
end else false // end of [if]
//
end // end of [handle_node]
      
(* ****** ****** *)

dynload "./../depth-first.dats"
dynload "./gtkcairotimer_toplevel.dats"

(* ****** ****** *)

val the_board =
matrix0_make_elt<int> (i2sz(N), i2sz(N), 0)

(* ****** ****** *)

val the_pathlst = ref<list0(nodelst)> (list0_nil)
val the_pathlst2 = ref<list0(nodelst)> (list0_nil)
  
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
  (path: nodelst): void =
{
//
val () = the_board_cleanup ()
//
fun
loop
(
  nxs: nodelst
) : void =
  case+ nxs of
  | nil0 () => ()
  | cons0 (NODE (i, j), nxs) => (the_board[i, j] := 1; loop (nxs))
//
val () = loop (path)
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
  val () = !the_pathlst2 := !the_pathlst
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
  val nxss = !the_pathlst2
  val () =
  (
    case+ nxss of
    | nil0 ((*void*)) =>
      {
        val () = the_timer_reset2 ()
      }
    | cons0 (nxs, nxss) =>
      {
        val () = !the_pathlst2 := nxss
        val () = the_board_update (nxs)
        val () = if length (nxs) >= N then the_timer_pause ()
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
val nxs0 =
list0_tabulate<node> (N, lam n => NODE (0, n))
val ((*void*)) = $DF.depth_search_list (nil0(*path*), nxs0)
val pathlst = $PATHLST.pop_all ()
val pathlst = list_vt_reverse (pathlst)
val pathlst = g0ofg1 (list_vt2t (pathlst))
(*
val () = println! ("length(pathlst) = ", length(pathlst))
val () = list0_foreach (pathlst, lam path => fpprint_nodelst (stdout_ref, path))
*)
//
val () = !the_pathlst := pathlst
val () = !the_pathlst2 := !the_pathlst
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

(* end of [QueenPuzzle_anim.dats] *)

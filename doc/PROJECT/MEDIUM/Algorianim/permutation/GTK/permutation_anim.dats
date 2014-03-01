//
// Animating Permutation
//

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
fun{
a:t@ype
} list0_mcons
(
  x0: a, xss: list0(list0(a))
) : list0(list0(a)) =
(
  list0_map<list0(a)><list0(a)> (xss, lam xs => cons0{a}(x0, xs))
) (* end of [list0_mcons] *)
//
(* ****** ****** *)

fun
{a:t@ype}
list0_permute
(
  xs: list0(a), n: int
) : list0(list0(a)) =
(
  if n > 0
    then list0_permute2<a> (xs, n, 0)
    else cons0{list0(a)}(list0_nil, list0_nil)
  // end of [if]
)

and
list0_permute2
(
  xs: list0(a), n: int, i: int
) : list0(list0(a)) =
(
if i < n then let
  var x0: a
  val xs1 =
    list0_takeout_at_exn<a> (xs, i, x0)
  val res1 = list0_mcons<a> (x0, list0_permute<a> (xs1, n-1))
  val res2 = list0_permute2<a> (xs, n, i+1)
in
  list0_append<list0(a)> (res1, res2)
end else
  list0_nil ()
// end of [if]
)

(* ****** ****** *)

#define N 6

(* ****** ****** *)

extern
fun
snapshot_pop (): list0 (int)

(* ****** ****** *)

local
//
val xss0 =
list0_permute<int>
  (list0_make_intrange (0, N), N)
//
val xss_current = ref<list0(list0(int))> (xss0)
//
in (* in-of-local *)

implement
snapshot_pop
  ((*void*)) = let
//
val xss = !xss_current
//
in
//
case+ xss of
| nil0 ((*void*)) =>
  (
    !xss_current := xss0; snapshot_pop ()
  ) (* end of [nil0] *)
| cons0 (xs, xss) => (!xss_current := xss; xs)
//
end // end of [snapshot_pop]
//
end // end of [local]

(* ****** ****** *)
//
staload "{$CAIRO}/SATS/cairo.sats"
//
staload "{$LIBATSHWXI}/teaching/mydraw/SATS/mydraw.sats"
staload "{$LIBATSHWXI}/teaching/mydraw/SATS/mydraw_cairo.sats"
//
staload "{$LIBATSHWXI}/teaching/mydraw/DATS/mydraw_bargraph.dats"
//
staload _(*anon*) = "{$LIBATSHWXI}/teaching/mydraw/DATS/mydraw.dats"
staload _(*anon*) = "{$LIBATSHWXI}/teaching/mydraw/DATS/mydraw_cairo.dats"
//
(* ****** ****** *)

extern
fun
cairo_draw_list
(
  cr: !cairo_ref1
, point, point, point, point, list0(int)
) : void // end-of-fun

(* ****** ****** *)

implement
cairo_draw_list
(
  cr, p1, p2, p3, p4, xs
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
implement
mydraw_bargraph$color<>
  (i) = let
//
val alpha =
  0.50 * (xs[i]+1) / N
//
in
  color_make (alpha, alpha, alpha)
end // end of [mydraw_bargraph$color]

implement
mydraw_bargraph$height<> (i) = 1.0 * (xs[i]+1) / N
//
in
  mydraw_bargraph (N, p1, p2, p3, p4)
end // end of [cairo_draw_list]

(* ****** ****** *)

extern
fun mydraw_clock
(
  cr: !cairo_ref1, width: int, height: int
) : void // end of [mydraw_clock]

(* ****** ****** *)

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
val xs = snapshot_pop ()
//
val v0 = vector_make (xm, ym)
//
val p1 = point_make (0. , WH) + v0
val p2 = point_make (WH , WH) + v0
val p3 = point_make (WH , 0.) + v0
val p4 = point_make (0. , 0.) + v0
//
val (pf | ()) = cairo_save (cr)
val () = cairo_draw_list (cr, p1, p2, p3, p4, xs)
val ((*void*)) = cairo_restore (pf | cr)
//
in
end // [mydraw_clock]

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
var argc: int = argc
var argv: charptrptr = $UN.castvwtp1{charptrptr}(argv)
//
val () = $extfcall (void, "gtk_init", addr@(argc), addr@(argv))
//
implement
gtkcairoclock_title<> () = stropt_some"Permutation"
implement
gtkcairoclock_timeout_interval<> () = 500U // millisecs
implement
gtkcairoclock_mydraw<> (cr, width, height) = mydraw_clock (cr, width, height)
//
val ((*void*)) = gtkcairoclock_main ((*void*))
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [permutation_anim.dats] *)

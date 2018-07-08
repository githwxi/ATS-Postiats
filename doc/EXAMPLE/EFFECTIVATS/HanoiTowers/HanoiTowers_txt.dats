(*
** Poorman's 
** Playing Hanoi Towers
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
//
#define
ATS_DYNLOADNAME
"HanoiTowers_txt__dynload"
//
#define
ATS_STATIC_PREFIX "HanoiTowers_txt__"
//
(* ****** ****** *)
//
// HX: for accessing LIBATSCC2JS 
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib\
/libatscc2js/ATS2-0.3.2" // latest stable release
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
//
staload
_ = "{$LIBATSCC2JS}/DATS/print.dats"
//
(* ****** ****** *)
//
#define NROW 24
#define NCOL 80
//
#define DELAY 500
//
(* ****** ****** *)

val theLevel = 8

(* ****** ****** *)
//
val
theCanvas =
matrixref_make_elt{int}(NROW, NCOL, 0)
//
(* ****** ****** *)
//
fun
theCanvas_clear() =
matrixref_foreach_cloref
  (theCanvas, NROW, NCOL, lam(i, j) => (theCanvas[i,NCOL,j] := 0))
//
(* ****** ****** *)
//
extern
fun
theCanvas_print
(
// argumentless
) : void = "mac#"
//
implement
theCanvas_print() =
matrixref_foreach_cloref
(
  theCanvas
, NROW, NCOL
, lam(i, j) =>
  let
    val x = theCanvas[i,NCOL,j]
  in
    print_string(if x = 0 then " " else "O"); if j=NCOL-1 then print_newline()
  end // end of [let]
) (* end of [matrixref_foreach] *)
//
(* ****** ****** *)
//
extern
fun
draw_point(x: int, y: int): void
//
implement
draw_point(x, y) = let
//
val x = g1ofg0(x) and y = g1ofg0(y)
//
(*
val () = println! ("draw_point: x = ", x)
val () = println! ("draw_point: y = ", y)
*)
//
in
  if x < 0 then ()
  else if y < 0 then ()
  else if x >= NCOL then ()
  else if y >= NROW then ()
  else (theCanvas[y, NCOL, x] := 1)
end // end of [draw_point]
//
(* ****** ****** *)
//
extern
fun
draw_hline
  (x1: int, x2: int, y: int): void
//
(* ****** ****** *)

implement
draw_hline
  (x1, x2, y) = let
//
fun loop (x1: int): void =
  if x1 <= x2
    then (draw_point(x1, y); loop(x1+1)) else ()
  // end of [if]
//
in
  loop (x1)
end // end of [draw_hline]
//
(* ****** ****** *)
//
extern
fun
draw_disk
(
  x0: int, y0: int
, prad: int, rad: int
) : void
//
implement
draw_disk
  (x0, y0, prad, rad) = let
//
val () = assertloc(prad >= rad)
//
in
//
draw_hline
  (x0+prad-rad+1, x0+prad+rad-1, y0)
//
end // end of [draw_disk]
//
(* ****** ****** *)
//
extern
fun
draw_pole
(
  x0: int, y0: int
, ht0: int, prad: int, rads: List(int)
) : void
//
implement
draw_pole
(
  x0, y0, ht0, prad, rads
) = let
//
fun
aux
(
  y0: int, rads: List(int)
) : void =
(
case+ rads of
| list_nil() => ()
| list_cons(rad, rads) =>
  (
    draw_disk(x0, y0, prad, rad); aux(y0+1, rads)
  ) (* end of [list_cons] *)
)
//
in
  aux(y0 + (ht0 - list_length(rads)), rads)
end // end of [draw_pole]
//
(* ****** ****** *)
//
val theRad = theLevel
val theWd0 = 2 * theLevel + 2
val theHt0 = theLevel
//
val theYY0 = (NROW - theHt0)/2
val theXX0 = (NCOL - 3 * theWd0)/2
//
(* ****** ****** *)
//
extern
fun
draw_poles
(
  P1: List(int), P2: List(int), P3: List(int)
) : void
//
implement
draw_poles
(
  P1, P2, P3
) =
{
//
val x0 = theXX0
val y0 = theYY0
//
val ht0 = theHt0
val wd0 = theWd0
//
val prad = theRad
//
val () = draw_pole(x0, y0, ht0, prad, P1)
val x0 = x0 + wd0
val () = draw_pole(x0, y0, ht0, prad, P2)
val x0 = x0 + wd0
val () = draw_pole(x0, y0, ht0, prad, P3)
//
} (* end of [draw_poles] *)
//
(* ****** ****** *)
//
macdef
setTimeout
  (fwork, ntime) =
(
//
$extfcall
( void
, "setTimeout"
, cloref2fun0(,(fwork)), ,(ntime)
) (* $extfcall *)
//
) (* end of [setTimeout] *)
//
(* ****** ****** *)
//
%{$
//
function
theCanvas_display()
{
//
var _ =
ats2jspre_the_print_store_clear();
//
var _ = theCanvas_print(/*void*/);
//
var _ =
document.getElementById("theDrawingString").innerHTML = ats2jspre_the_print_store_join();
//
}
%} // end of [%{$]
//
extern
fun
theCanvas_display(): void = "mac#"
//
(* ****** ****** *)
//
extern
fun
play_hanoitowers_demo(): void = "mac#"
//
(* ****** ****** *)
//
typedef pole = List0(int)
typedef poler = ref(pole)
//
local
//
val rads =
  list_make_intrange(1, theLevel+1)
//
in
//
val theP1 = ref{pole}(rads)
val theP2 = ref{pole}(list_nil())
and theP3 = ref{pole}(list_nil())
//
end // end of [local]
//
(* ****** ****** *)

fun
theCanvas_draw(): void =
{
  val () = theCanvas_clear()
  val () = draw_poles(theP1[], theP2[], theP3[])
}

(* ****** ****** *)

implement
play_hanoitowers_demo
  ((*void*)) = let
//
typedef kont =
  (poler, poler, poler) -<cloref1> void
//
fun
move_1
(
  P1: poler
, P2: poler
, P3: poler
, kont: kont
) : void = let
//
  val-list_cons(rad, rads) = P1[]
//
  val () = P1[] := rads
  val () = P2[] := list_cons(rad, P2[])
//
  val () = theCanvas_draw((*void*))
  val () = theCanvas_display((*void*))
//
in
  setTimeout(lam() => kont(P1, P2, P3), DELAY)
end // end of [move_1]
//
fun
move_n
(
  n: int
, P1: poler
, P2: poler
, P3: poler
, kont: kont
) : void = (
//
if
(
  n > 0
) then (
//
move_n
(
  n-1
, P1, P3, P2
, lam(P1, P3, P2) =>
    move_1(P1, P2, P3, lam(P1, P2, P3) => move_n(n-1, P3, P2, P1, lam(P3, P2, P1) => kont(P1, P2, P3)))
  // end of [lam]
) (* end of move_n *)
//
) else kont(P1, P2, P3)
//
) (* end of [move_n] *)
//
val () = theCanvas_draw((*void*))
val () = theCanvas_display((*void*))
//
in
//
setTimeout
(
  lam() => move_n(theLevel, theP1, theP2, theP3, lam(P1, P2, P3) => alert("The puzzle is solved!")), 1500
) (* setTimeout *)
end // end of [play_hanoitowers_demo]

(* ****** ****** *)

%{$
//
jQuery(document).ready(function(){ HanoiTowers_txt__dynload(); play_hanoitowers_demo(); }); // HX: starting here!
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [HanoiTowers_txt.dats] *)

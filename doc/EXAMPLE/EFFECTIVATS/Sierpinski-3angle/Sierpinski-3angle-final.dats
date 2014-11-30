(*
** Animating a drawing
** of Sierpinski triangles
*)

(* ****** ****** *)
//
// HX-2014-11-19
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
extern
fun
drawAnim (): void = "mac#"
extern
fun
drawAnim_init (): void = "mac#"
extern
fun
drawAnim_loop (): void = "mac#"
//
extern
fun drawFrame (): void = "mac#"
//
(* ****** ****** *)

implement
drawAnim() =
{
//
val () = drawAnim_init ()
val () = drawAnim_loop ()
//
}
implement
drawAnim_init () = ()
implement
drawAnim_loop () = () where
{
//
val () = drawFrame ()
val () =
$extfcall
(
  void, "setTimeout", drawAnim_loop, 1000(*ms*)
) (* end of [val] *)
//
} (* end of [drawAnim_loop] *)

(* ****** ****** *)
//
abstype color
//
val BLUE = $extval(color, "BLUE")
val YELLOW = $extval(color, "YELLOW")
//
(* ****** ****** *)

extern
fun
drawTriangle
(
  c: color
, Ax: double, Ay: double
, Bx: double, By: double
, Cx: double, Cy: double
) : void = "mac#"
//
extern
fun
drawSTriangle
(
  c: color
, Ax: double, Ay: double
, Bx: double, By: double
, Cx: double, Cy: double
, level: int
) : void = "mac#"
//
(* ****** ****** *)

implement
drawSTriangle
(
  c, Ax, Ay, Bx, By, Cx, Cy, level
) =
(
if
level > 0
then let
  val Px = (Ax + Bx) / 2
  and Py = (Ay + By) / 2
  val Qx = (Bx + Cx) / 2
  and Qy = (By + Cy) / 2
  val Rx = (Cx + Ax) / 2
  and Ry = (Cy + Ay) / 2
//
  val () = drawTriangle (c, Px, Py, Qx, Qy, Rx, Ry)
//
  val level1 = level - 1
  val () = drawSTriangle (c, Ax, Ay, Px, Py, Rx, Ry, level1)
  val () = drawSTriangle (c, Px, Py, Bx, By, Qx, Qy, level1)
  val () = drawSTriangle (c, Rx, Ry, Qx, Qy, Cx, Cy, level1)
in
  // nothing
end // end of [then]
else () // end of [else]
) (* end of [drawSTriangle] *)

(* ****** ****** *)
//
extern
fun theAx_get(): double = "mac#"
and theAy_get(): double = "mac#"
extern
fun theBx_get(): double = "mac#"
and theBy_get(): double = "mac#"
extern
fun theCx_get(): double = "mac#"
and theCy_get(): double = "mac#"
//
(* ****** ****** *)
  
local
//
extern
fun
theLevel_getinc(): int = "mac#"
//
in
//
implement
drawFrame () =
{
//
  val Ax = theAx_get() // x-coordinate of A
  val Ay = theAy_get() // y-coordinate of A
  val Bx = theBx_get() // x-coordinate of B
  val By = theBy_get() // y-coordinate of B
  val Cx = theCx_get() // x-coordinate of C
  val Cy = theCy_get() // y-coordinate of C
//
  val level = theLevel_getinc () // get and increase
  val ((*void*)) = drawTriangle (BLUE, Ax, Ay, Bx, By, Cx, Cy)
  val ((*void*)) = drawSTriangle (YELLOW, Ax, Ay, Bx, By, Cx, Cy, level)
//
} (* end of [drawFrame] *)
//
end // end of [local]

(* ****** ****** *)

%{^
//
var BLUE = "#0000ff"
var YELLOW = "#ffff00"
//
%} // end of [%{^]

(* ****** ****** *)

%{$
//
var
canvas =
document.getElementById
  ("Patsoptaas-Evaluate-canvas");
var
ctx2d = canvas.getContext( '2d' );
//
function
theAx_get() { return 0; }
function
theAy_get() { return canvas.height; }
function
theBx_get() { return canvas.width/2; }
function
theBy_get() { return 0; }
function
theCx_get() { return canvas.width; }
function
theCy_get() { return canvas.height; }
//
var
theLevel = 0;
function
theLevel_getinc()
{
  var
  level = theLevel;
  theLevel = (level+1)%7;
  return level;
}
//
function
drawTriangle
(
  color, Ax, Ay, Bx, By, Cx, Cy
)
{
  ctx2d.beginPath();
  ctx2d.moveTo(Ax, Ay);
  ctx2d.lineTo(Bx, By);
  ctx2d.lineTo(Cx, Cy);
  ctx2d.closePath();
  ctx2d.fillStyle = color; ctx2d.fill();
  return;
}
//
jQuery(document).ready(function(){drawAnim();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [Sierpinski-3angle-final.dats] *)

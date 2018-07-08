(* ****** ****** *)
(*
Drawing a Sierpinski Triangle
*)
(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

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
"{$LIBATSCC2JS}/staloadall.hats" // for prelude stuff
//
(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

abstype point

(* ****** ****** *)

extern
fun
midpoint: (point, point) -> point = "mac#"

(* ****** ****** *)
//
extern
fun
SierpinskiDraw
( n: int
, A: point, B: point, C: point): void = "mac#"
//
(* ****** ****** *)
//
extern
fun
TriangleRemove
  (A: point, B: point, C: point): void = "mac#"
//
(* ****** ****** *)

implement
SierpinskiDraw
(n, A, B, C) = (
//
if
(n > 0)
then let
//
val AB = midpoint(A, B)
val BC = midpoint(B, C)
val CA = midpoint(C, A)
//
val () = TriangleRemove(AB, BC, CA)
//
val () = SierpinskiDraw(n-1, A, AB, CA)
val () = SierpinskiDraw(n-1, B, BC, AB)
val () = SierpinskiDraw(n-1, C, CA, BC)
//
in
  // nothing
end // end of [then]
else () // end of [else]
//
) (* end of [SierpinskiDraw] *)

(* ****** ****** *)

%{^
//
var
theCanvas =
document.getElementById("theCanvas");
var
theCtx = theCanvas.getContext( '2d' );
//
var N = 6;
//
var W =
theCanvas.width;
var H =
theCanvas.height;
var WH = Math.min(W, H);
var WH2 = 0.88 * WH;
//
function
midpoint
(p1, p2)
{
//
  var
  xmid = (p1.x + p2.x)/2;
  var
  ymid = (p1.y + p2.y)/2;
//
  return { x: xmid, y: ymid };
//
}
//
function
TriangleRemove
 (A, B, C)
{
  theCtx.save();
//
  theCtx.beginPath();
  theCtx.moveTo(A.x, A.y);
  theCtx.lineTo(B.x, B.y);
  theCtx.lineTo(C.x, C.y);
  theCtx.closePath();
//
  theCtx.fill();
//
  theCtx.restore();
} // end of [TriangleRemove]
//
%} // end of [%{^]

(* ****** ****** *)
//
extern
fun
execute_after
(fwork: cfun(void), ms: int): void
//
implement
execute_after
  (fwork, ms) = (
//
$extfcall
( void
, "setTimeout", cloref2fun0(fwork), ms)
//
) (* end of [execute_after] *)
//
(* ****** ****** *)
//
extern
fun
repeat_execute_after
( N: int,
  fwork: (int) -> void, ms: int
) : void = "mac#" // end-of-fun
//
implement
repeat_execute_after
(
N, fwork, ms
) = let
//
fun
auxmain(i: int): void =
if i >= N
  then auxmain(0)
  else (fwork(i); execute_after(lam() => auxmain(i+1), ms))
//
in
  auxmain(0)
end // end of [repeat_execute_after]
//
(* ****** ****** *)

%{$
//
function
SierpinskiMain()
{
var A0 =
{x: WH2/2, y: 0  };
var B0 =
{x:     0, y: WH2};
var C0 =
{x: WH2  , y: WH2};
//
theCtx.translate
((W-WH2)/2, (H-WH2)/2);
//
repeat_execute_after
(
N
,
function(i)
{
theCtx.fillStyle="#0000ff";
TriangleRemove(A0, B0, C0);
theCtx.fillStyle="#ffff00";
SierpinskiDraw(i, A0, B0, C0);
}
,
1000/*delay in ms*/
);
//
}
//
%} // end of [%{$]

(* ****** ****** *)

%{$
//
jQuery(document).ready(function(){SierpinskiMain();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [Sierpinski.dats] *)

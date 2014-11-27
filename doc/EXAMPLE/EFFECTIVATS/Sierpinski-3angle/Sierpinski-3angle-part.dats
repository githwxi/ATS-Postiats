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
//
val () =
$extfcall
(
  void, "setTimeout", drawAnim_loop, 1000(*ms*)
) (* end of [val] *)
//
} (* end of [drawAnim_loop] *)

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
var
theToggle = 0;
//
function
drawFrame()
{
  var w = canvas.width;
  var h = canvas.height;
  if (theToggle) ctx2d.fillStyle = "#ffff00";
  if (!theToggle) ctx2d.fillStyle = "#0000ff";
  theToggle = 1 - theToggle;
  ctx2d.rect(0, 0, w, h);
  ctx2d.fill();
}
//
jQuery(document).ready(function(){drawAnim();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [Sierpinski-3angle-part.dats] *)

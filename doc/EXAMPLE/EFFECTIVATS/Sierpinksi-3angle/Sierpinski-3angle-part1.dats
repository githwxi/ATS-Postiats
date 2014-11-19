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
drawAnim_cont (): void = "mac#"
//
extern
fun drawFrame (): void = "mac#"
//
(* ****** ****** *)

implement
drawAnim () =
{
//
val () = drawFrame ()
val () = drawAnim_cont ()
//
} (* end of [drawAnim] *)

(* ****** ****** *)

implement
drawAnim_cont () =
{
//
val () =
$extfcall
(
  void, "setTimeout", drawAnim, 1000(*ms*)
) (* end of [val] *)
//
} (* end of [drawAnim_cont] *)

(* ****** ****** *)

%{$
//
var
canvas =
document.getElementById("Patsoptaas-Evaluate-canvas");
var ctx2d = canvas.getContext( '2d' );
//
var theToggle = 0
//
function
drawFrame()
{
  var w = canvas.width;
  var h = canvas.heigh;
  if (theToggle) ctx2d.fillStyle = "#ff0000";
  if (!theToggle) ctx2d.fillStyle = "#ff0000";
  theToggle = 1 - theToggle;
  ctx2d.rect(0, 0, w, h);
  ctx2d.fill();
}
//
jQuery(document).ready(function(){drawAnim();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [Sierpinski-3angle-part1.dats] *)

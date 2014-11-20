<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>EFFECTIVATS-Sierpinski-3angle</title>

<style type="text/css">
  .patsyntax {width:99%;margin:auto;}
  .patsyntax {color:#808080;background-color:#E0E0E0;}
  .patsyntax span.keyword {color:#000000;font-weight:bold;}
  .patsyntax span.comment {color:#787878;font-style:italic;}
  .patsyntax span.extcode {color:#A52A2A;}
  .patsyntax span.neuexp  {color:#800080;}
  .patsyntax span.staexp  {color:#0000F0;}
  .patsyntax span.prfexp  {color:#603030;}
  .patsyntax span.dynexp  {color:#F00000;}
  .patsyntax span.stalab  {color:#0000F0;font-style:italic}
  .patsyntax span.dynlab  {color:#F00000;font-style:italic}
  .patsyntax span.dynstr  {color:#008000;font-style:normal}
  .patsyntax span.stacstdec  {text-decoration:none;}
  .patsyntax span.stacstuse  {color:#0000CF;text-decoration:underline;}
  .patsyntax span.dyncstdec  {text-decoration:none;}
  .patsyntax span.dyncstuse  {color:#B80000;text-decoration:underline;}
  .patsyntax span.dyncst_implement  {color:#B80000;text-decoration:underline;}
</style>

<?php
include
"./SERVER/MYCODE/atslangweb_pats2xhtmlize.php";
?><!--php-->
</head>

<body>

<h1>
Effective ATS:<br>
Drawing Sierpinski triangles
</h1>

<p>
In this article, I would like to give an example that
combines ATS code with JavaScript (JS) code. This is also
another occasion for me to advocate refinement-based
programming.
</p>

<h2>
Setup for animation
</h2>

The following code implements a typical setup for doing animation:

<?php
$mycode = <<<EOT
//
extern
fun drawAnim(): void
extern
fun drawAnim_init(): void
extern
fun drawAnim_loop(): void
extern
fun drawFrame (): void
//
implement
drawAnim() =
{
  val () = drawAnim_init ()
  val () = drawAnim_loop ()
}
implement
drawAnim_loop() =
{
  val () = drawFrame ()
  val () = sleep (1(*sec*)) // HX: this needs to be fixed
  val () = drawAnim_loop ()
}
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
The code is self-explanatory: [drawAnim] is the main function to be
called for doing animation; it calls [drawAnim_init] to do some form of
initialization and then [dramAnim_loop] to start a loop that repeatedly
draws a frame (by calling [drawFrame]) and sleeps (by calling [sleep]).
</p>

<p>
However, the call to [sleep] inside the body of [drawAnim_loop] is
problematic. As we want to run the animation inside a browser, calling
[sleep], if supported, means to stop the browzer entirely, which is
probably unacceptable. Instead, [drawAnim_loop] can be implemented as
follows:
</p>

<?php
$mycode = <<<EOT
//
implement
drawAnim_loop() =
{
  val () = drawFrame ()
  val () = \$extfcall (void, "setTimeout", drawAnim_loop, 1000(*ms*))
}
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
Essentially, the call to the external function [setTimeout] in JS requests
the browser that a call to [drawAnim_loop] be scheduled 1000 milliseconds
(that is, 1 second) after the current time.
</p>

<p>
I present as follows a simple implementation of [drawFrame] in JS
directly so as to allow the reader to obtain a concrete feel for the
above animation setup:
</p>

<?php
$mycode = <<<EOT
%{\$
//
var
canvas =
document.getElementById
  ("Patsoptaas-Evaluate-canvas");
//
var ctx2d = canvas.getContext( '2d' );
//
var theToggle = 0
//
function
drawFrame()
{
  var w = canvas.width;
  var h = canvas.height;
  if (theToggle) ctx2d.fillStyle = "#ffff00"; // yellow
  if (!theToggle) ctx2d.fillStyle = "#0000ff"; // blue
  theToggle = 1 - theToggle;
  ctx2d.rect(0, 0, w, h);
  ctx2d.fill();
}
//
jQuery(document).ready(function(){drawAnim();});
//
%} // end of [%{\$]
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
I do not plan to go over the JS code in detail.  Essentially, it locates a
canvas identified by the string "Patsoptaas-Evaluate-canvas". The
implementation of [drawFrame] paints the entire canvas with blue and
yellow, alternately. The entirety of the code presented so far (with few
minor modifications) is stored in Sierpinski-3angle-part1.dats, which can
be readily tested
<a href="http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php?mycode_url=https://raw.githubusercontent.com/githwxi/ATS-Postiats/master/doc/EXAMPLE/EFFECTIVATS/Sierpinksi-3angle/Sierpinski-3angle-part1.dats">on-line</a>.
</p>

<h2>
Drawing Sierpinski triangles
</h2>

<p>
The reader can take a look at an animated drawing of Sierpinski triangles
<a href="http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php?mycode_url=https://raw.githubusercontent.com/githwxi/ATS-Postiats-contrib/master/projects/SMALL/JSmydraw/Sierpinski_3angle/Sierpinski_3angle_php.dats">on-line</a>.
</p>

<p>
Given a natural number, a Sierpinski triangle at level n can be defined
inductively on n. A regular triangle is regarded as a Sierpinski triangle
at level 0. For a positive number n, a triangle ABC is a Sierpinski
triangle at level n if the three triangles APR, PBQ, and RQC are Sierpinski
triangle at level n-1, where P, Q, and R are the midpoints of the three
sides AB, BC and CA, respectively.
</p>

<?php
$mycode = <<<EOT
//
abstype color
//
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
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
The function [drawSTriangle] can be implemented on top of [drawTriangle] as follows:
</p>

<?php
$mycode = <<<EOT
//
implement
drawSTriangle
(
  c, Ax, Ay, Bx, By, Cx, Cy, level
) = (
//
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
//
) (* end of [drawSTriangle] *)
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
<a href="http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php?mycode_url=https://raw.githubusercontent.com/githwxi/ATS-Postiats/master/doc/EXAMPLE/EFFECTIVATS/Sierpinksi-3angle/Sierpinski-3angle.dats">on-line</a>.
</p>

<hr size="2">

This article is written by <a href="http://www.cs.bu.edu/~hwxi/">Hongwei Xi</a>.

</body>
</html>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>EFFECTIVATS-Sierpinski-3angle</title>
##patsyntax()
##thePage_style()

<?php
include
"./SERVER/MYCODE/atslangweb_pats2xhtmlize.php";
?><!--php-->
</head>

<body>

<h1>
Effective ATS:<br>
Drawing Sierpinski Triangles
</h1>

<p>
In this article, I would like to give an example that
combines ATS code with JavaScript (JS) code. This is also
an occasion for me to advocate refinement-based programming.
</p>

<h2>
Setup for Animation
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
initialization and then [drawAnim_loop] to start a loop that repeatedly
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
Essentially, the call to the external function [setTimeout] in
JS requests that the browser schedule a call to [drawAnim_loop]
1000 milliseconds (that is, 1 second) after the time when the call is made.
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
yellow, alternately. The entirety of the code presented so far is stored in
<u>Sierpinski-3angle-part.dats</u>, which can be readily tested
<a href="http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php?mycode_url=https://raw.githubusercontent.com/githwxi/ATS-Postiats/master/doc/EXAMPLE/EFFECTIVATS/Sierpinski-3angle/Sierpinski-3angle-part.dats">on-line</a>.
</p>

<h2>
Drawing Sierpinski Triangles
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
triangles at level n-1, where P, Q, and R are the midpoints of the three
sides AB, BC and CA, respectively.
</p>

<p>
Let us introduce an abstract type [color] for colors
and use [BLUE] and [YELLOW] to refer to two colors defined in JS
of the same names:
</p>

<?php
$mycode = <<<EOT
//
abstype color
//
macdef BLUE = \$extval(color, "BLUE")
macdef YELLOW = \$extval(color, "YELLOW")
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
Following is the interface of a function [drawTriangle],
which is called to draw a triangle ABC filled with a given
color:
</p>

<?php
$mycode = <<<EOT
//
extern
fun
drawTriangle
(
  c: color // color for filling
, Ax: double, Ay: double // x-y-coordinates for A
, Bx: double, By: double // x-y-coordinates for B
, Cx: double, Cy: double // x-y-coordinates for C
) : void = "mac#"
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
Let us introduce another function [drawSTriangle]
for drawing a Sierpinski triangle filled with a given color
and then implement it based on the function [drawTriangle]:
</p>

<?php
$mycode = <<<EOT
//
extern
fun
drawSTriangle
(
  c: color
, Ax: double, Ay: double // x-y-coordinates for A
, Bx: double, By: double // x-y-coordinates for B
, Cx: double, Cy: double // x-y-coordinates for C
, level: int
) : void = "mac#"
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
The function [drawFrame] can be implemented as follows:
</p>

<?php
$mycode = <<<EOT
//
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
  val level = theLevel_getinc ()
  val ((*void*)) = drawTriangle (BLUE, Ax, Ay, Bx, By, Cx, Cy)
  val ((*void*)) = drawSTriangle (YELLOW, Ax, Ay, Bx, By, Cx, Cy, level)
//
} (* end of [drawFrame] *)
//
end // end of [local]
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
After the canvas for drawing is located, three points A, B and C are
choosen on the canvas to be the vertices of a Sierpinski triangle. The
x-y-coordinates of A can be obtained by calling [theAx_get] and
[theAy_get], which are implemented in JS.  The x-y-coordinates of B and C
can be obtained similarly. The function [theLevel_getinc] is called to
yield the level of the Sierpinski triangle to be drawn. Please find all
the details in the following JS code, which also includes an implementation
of [drawTriangle]:
</p>

<?php
$mycode = <<<EOT
//
%{\$
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
%} // end of [%{\$]
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
The entirety of the code for this implementation of
an animated drawing of Sierpinski triangles is stored in
<u>Sierpinski-3angle-final.dats</u>, which can be readily tested
<a href="http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php?mycode_url=https://raw.githubusercontent.com/githwxi/ATS-Postiats/master/doc/EXAMPLE/EFFECTIVATS/Sierpinski-3angle/Sierpinski-3angle-final.dats">on-line</a>.
Of course, it is also possible to use <u>patsopt</u> to compile
<u>Sierpinski-3angle-final.dats</u> into some C code and then use
<u>atscc2js</u> to compile the C code into some JS code. Please
find the related details in the provided Makefile. There is a file
<u>Sierpinski-3angle.html</u> available for testing the generated JS code.
</p>

<hr size="2">
<p>
This article is written by <a href="http://www.cs.bu.edu/~hwxi/">Hongwei Xi</a>.
</p>
##thePage_script()
</body>
</html>

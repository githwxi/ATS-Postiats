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
Effective ATS: Drawing Sierpinski triangles
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
  val () = sleep (1000(*ms*)) // HX: this needs to be fixed
  val () = drawAnim_loop ()
}
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
The code is self-explanatory: [drawAnim] is the main function to be
called for doing animation; it calls [drawAnim_init] to do some form of
initialization and then [dramAnim_loop] to start a loop that draws a
frame repeatedly (by calling [drawFrame]).
</p>

<p>
</p>

<p>
<a href="http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php?mycode_url=https://raw.githubusercontent.com/githwxi/ATS-Postiats/master/doc/EXAMPLE/EFFECTIVATS/Sierpinksi-3angle/Sierpinski-3angle-part1.dats">Sierpinski-3angle-part1</a>
</p>

</body>
</html>

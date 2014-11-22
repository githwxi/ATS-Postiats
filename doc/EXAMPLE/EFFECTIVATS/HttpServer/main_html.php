<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>EFFECTIVATS-HttpServer</title>

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
Implementing a simple http-server
</h1>

<p>
In this article, I would like to present an implementation
of a simple http-server. This is also a good occasion for me
to advocate refinement-based programming.
</p>

<h2>
A simplistic abstract server
</h2>

<p>
As I have said repeatedly, I, like many others, feel that the most
challenging issue in programming (and many other forms of engineering) is
to keep the inherent complexity of the implemented system under
control. What may sound ironic is that keeping-it-simple is probably the
hardest thing to do. I hope that programmers can rely on the support for
abstract types in ATS to make this hardest thing significantly easier to
manage.
</p>

<p>
Let us first take a look at the following self-explanatory implementation
of a simplistic abstract server:
</p>

<?php
$mycode = <<<EOT
//
extern
fun myserver (): void
extern
fun myserver_init (): void
extern
fun myserver_loop (): void

(* ****** ****** *)

implement
myserver () =
{
//
val () = myserver_init ()
val () = myserver_loop ()
//
} (* end of [myserver] *)

(* ****** ****** *)

implement
myserver_init () =
{
//
val () = println! ("myserver_init: start")
val () = println! ("myserver_init: finish")
//
} (* end of [myserver_init] *)

(* ****** ****** *)

abstype request

(* ****** ****** *)
//
extern
fun myserver_waitfor_request (): request
extern
fun myserver_process_request (request): void
//
(* ****** ****** *)

implement
myserver_loop () =
{
//
val req =
myserver_waitfor_request ()
//
val () =
myserver_process_request (req)
//
val () = myserver_loop ((*void*))
//
} (* end of [myserver_loop] *)
//
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
Basically, [myserver] implements a server; it does some form of
initializating by calling [myserver_init] and then starts a loop for
handling requests by calling [myserver_loop]. The function
[myserver_waitfor_request] is supposed to be blocked until a request
is available, and the function [myserver_process_request] processes a
given request.
</p>

<hr size="2">

This article is written by <a href="http://www.cs.bu.edu/~hwxi/">Hongwei Xi</a>.

</body>
</html>

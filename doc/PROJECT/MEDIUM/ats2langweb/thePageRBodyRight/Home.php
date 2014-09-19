<style>
#hello_dats {
  font-size: 8pt;
  font-family: monospace;
  background-color: #c0c0c0;
}
#listsub_dats {
  font-size: 8pt;
  font-family: monospace;
  background-color: #c0c0c0;
}
#thePageRBodyRight
{
  font-size: 11pt;
}
</style>

ATS is versatile in its support for programming syntax.  Following is a
short program of functional style:<br>

<TEXTAREA
 ID="hello_dats"
 ROWS="13" COLS="38">
//
// Say Hello! once
//
val () = print"Hello!"
//
// Say Hello! 5 times
//
val () =
repeat(5, a) where
{
  val a = $delay(print"Hello!")
} (* end of [where] *)
//
</TEXTAREA>

<button type="button" onclick="">Try-it-yourself</button>

<p>

ATS allows for great precision in typechecking.
The following code demonstrates the detection of out-of-bounds subscripting
at compile-time:<br>

<TEXTAREA
 ID="listsub_dats"
 ROWS="10" COLS="38">
//
// Build a list of 3
//
val xs = $list(0,1,2)
//
val x0 = xs[0] // legal
val x1 = xs[1] // legal
val x2 = xs[2] // legal
val x3 = xs[3] // illegal
//
</TEXTAREA>

<button type="button" onclick="">Try-it-yourself</button>

<?php /* end of [Home.php] */ ?>

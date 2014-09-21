<style>
#hello_dats {
  font-size: 9pt;
  font-family: monospace;
  background-color: #c0c0c0;
}
#listsub_dats {
  font-size: 9pt;
  font-family: monospace;
  background-color: #c0c0c0;
}
#repeat_f0f1_dats {
  font-size: 9pt;
  font-family: monospace;
  background-color: #c0c0c0;
}
#thePageRBodyRight
{
  font-size: 11pt;
}
</style>

ATS is versatile in its support for programming syntax.
For example, a tiny program in ATS of functional style is given as
follows:<br>

<TEXTAREA
 ID="hello_dats"
 ROWS="14" COLS="38">
//
// Say Hello! once
//
val () = print"Hello!\n"
//
// Say Hello! 3 times
//
val () =
repeat(3, a) where
{
  val a = $delay(print"Hello!")
} (* end of [where] *)
val () = print_newline((*void*))
//
</TEXTAREA>

<button type="button" onclick="Home_hello_onclick()">Try-it-yourself</button>

<p>

ATS can support (static) typechecking with great precision.
The following code demonstrates the ability of ATS in detecting
out-of-bounds subscripting at compile-time:<br>

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

<button type="button" onclick="Home_listsub_onclick()">Try-it-yourself</button>

<p>

The template system of ATS provides a highly flexible approach to code
sharing. The following example should probably reminds someone of
higher-order functions but it is actually every bit of a first-order
implementation:

<TEXTAREA
 ID="repeat_f0f1_dats"
 ROWS="16" COLS="38">
//
extern
fun{} f0 (): int
extern
fun{} f1 (x: int): int
extern
fun{}
repeat_f0f1 (n: int): int
//
implement
{}(*tmp*)
repeat_f0f1(n) =
  if n = 0
    then f0()
    else f1(repeat_f0f1(n-1))
  // end of [if]
//
fun
times (
  m:int, n:int
) : int = // m*n
  repeat_f0f1 (m) where
{
  implement f0<> () = 0
  implement f1<> (x) = x + n
}
//
fun
power (
  m:int, n:int
) : int = // m^n
  repeat_f0f1 (n) where
{
  implement f0<> () = 1
  implement f1<> (x) = m * x
}
//
val () =
println! ("5*5 = ", times(5,5))
val () =
println! ("5^2 = ", power(5,2))
val () =
println! ("2^5 = ", power(2,5))
//
</TEXTAREA>

<button type="button" onclick="Home_repeat_f0f1_onclick()">Try-it-yourself</button>

<?php /* end of [Home.php] */ ?>

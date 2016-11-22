<style>
#hello_dats {
  font-size: 9pt;
  font-family: Lucida Console, Courier New, monospace;
  color: #8B0000;
  background-color: #FFFAF0;
}
#listsub_dats {
  font-size: 9pt;
  font-family: Lucida Console, Courier New, monospace;
  color: #8B0000;
  background-color: #FFFAF0;
}
#repeat_f0f1_dats {
  font-size: 9pt;
  font-family: Lucida Console, Courier New, monospace;
  color: #8B0000;
  background-color: #FFFAF0;
}
#queenpuzzle_dats {
  font-size: 9pt;
  font-family: Lucida Console, Courier New, monospace;
  color: #8B0000;
  background-color: #FFFAF0;
}
</style>

<div
style="margin-top:8px;padding:8px;"
><!--div-->

<h2 style="display:inline;">Yes, ATS can!</h2>

<hr></hr>

<p>
What is new in the community?
<button
 ID="whatisnew_button"
 type="button" onclick="Home_whatisnew_onclick()"
>GO</button>
</p>

<hr></hr>

<p>
Would you like to try ATS on-line?
<button
 ID="tryatsnow_button"
 type="button" onclick="Home_tryatsnow_onclick()"
>OK</button>
</p>

<hr></hr>

<p>
The core of ATS is a typed call-by-value functional
programming language that is largely inspired by ML. For instance, the
following tiny ATS program is written in a style of functional programming:
</p>

<div
width=98% margin=auto
><!--div-->

<table
 style="width: 100%; border-spacing: 0px;">

<tr>
<th width="10%"></th>
<th width="80%"></th>
<th width="10%"></th>
</tr>

<tr>
<td></td>
<td align="center">
<textarea
 id="hello_dats"
 rows="10" cols="36" wrap="off"
>
//
// Yes, you can edit
//
(* Say Hello! once *)
val () = print"Hello!\n"
//
(* Say Hello! 3 times *)
val () = 3*delay(print"Hello!")
val () = print_newline((*void*))
//
</textarea>
</td>
<td></td>
</tr>

<tr>
<td></td>
<td align="center">
<button
 ID="hello_button"
 type="button" onclick="Home_hello_onclick()"
>Try-it-yourself</button>
</td>
<td></td>
</tr>

</table>

</div>

<hr></hr>

<p>
ATS is both accurate and expressive in its support for (static)
typechecking.  The following code demonstrates the ability of ATS in
detecting out-of-bounds subscripting at compile-time:
</p>

<div
width=98% margin=auto
><!--div-->

<table
 style="width: 100%; border-spacing: 0px;">

<tr>
<th width="10%"></th>
<th width="80%"></th>
<th width="10%"></th>
</tr>

<tr>
<td></td>
<td align="center">
<textarea
 id="listsub_dats"
 rows="11" cols="36" wrap="off"
>
//
// Yes, you can edit
//
(* Build a list of 3 *)
val xs = $list{int}(0, 1, 2)
//
val x0 = xs[0] // legal
val x1 = xs[1] // legal
val x2 = xs[2] // legal
val x3 = xs[3] // illegal
//
</textarea>
</td>
<td></td>
</tr>

<tr>
<td></td>
<td align="center">
<button
 ID="listsub_button"
 type="button" onclick="Home_listsub_onclick()"
>Try-it-yourself</button>
</td>
<td></td>
</tr>

</table>

</div>

<hr></hr>

<p>
ATS is highly effective and flexible in its support for a template-based
approach to code reuse. As an example, the following code is likely to
remind someone of higher-order functions but it is actually every bit of a
first-order implementation in ATS:
</p>

<div
width=98% margin=auto
><!--div-->

<table
 style="width: 100%; border-spacing: 0px;">

<tr>
<th width="10%"></th>
<th width="80%"></th>
<th width="10%"></th>
</tr>

<tr>
<td></td>
<td align="center">
<textarea
 id="repeat_f0f1_dats"
 rows="12" cols="36" wrap="off"
>
//
// Yes, you can edit
//
extern
fun{} f0 (): int
extern
fun{} f1 (int): int
extern
fun{} repeat_f0f1 (int): int
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
println! ("2^10 = ", power(2,10))
val () =
println! ("3^10 = ", power(3,10))
//
</textarea>
</td>
<td></td>
</tr>

<tr>
<td></td>
<td align="center">
<button
 ID="repeat_f0f1_button"
 type="button" onclick="Home_repeat_f0f1_onclick()"
>Try-it-yourself</button>
</td>
<td></td>
</tr>

</table>

</div>

<hr></hr>

<p>
With a functional core of ML-style and certain ad-hoc support for
overloading (of function symbols), ATS can readily accommodate a
typical combinator-based style of coding that is often considered a
prominent signature of functional programming. The following
"one-liner" solution to the famous Queen Puzzle should offer a glimpse
of using combinators in ATS:
</p>

<div
width=98% margin=auto
><!--div-->

<table
 style="width: 100%; border-spacing: 0px;">

<tr>
<th width="10%"></th>
<th width="80%"></th>
<th width="10%"></th>
</tr>

<tr>
<td></td>
<td align="center">
<textarea
 id="queenpuzzle_dats"
 rows="10" cols="36" wrap="off"
>
//
(* Solving the Queen Puzzle *)
//
#define N 8 // it can be changed
#define NSOL 10 // it can be changed 
//
val () =
(((fix qsolve(n: int): stream(list0(int)) => if(n > 0)then((qsolve(n-1)*list0_make_intrange(0,N)).map(TYPE{list0(int)})(lam($tup(xs,x))=>cons0(x,xs))).filter()(lam(xs)=>let val-cons0(x0,xs) = xs in xs.iforall()(lam(i, x)=>((x0)!=x)&&(abs(x0-x)!=i+1)) end)else(stream_make_sing(nil0())))(N)).takeLte(NSOL)).iforeach()(lam(i, xs)=>(println!("Solution#", i+1, ":"); xs.rforeach()(lam(x) => ((N).foreach()(lam(i)=>(print_string(ifval(i=x," Q", " ."))));println!()));println!()))
//
</textarea>
</td>
<td></td>
</tr>

<tr>
<td></td>
<td align="center">
<button
 ID="queenpuzzle_button"
 type="button" onclick="Home_queenpuzzle_onclick()"
>Try-it-yourself</button>
</td>
<td></td>
</tr>

</table>

<p>
Please find
<a href="https://github.com/githwxi/ATS-Postiats-contrib/blob/master/projects/MEDIUM/CATS-atsccomp/CATS-atscc2js/TEST/queens_comb.dats">on-line</a>
the entirety of this example, which is meant to showcase programming with combinators in ATS.
</p>

</div>

<hr></hr>

</div>
<?php /* end of [Home.php] */ ?>

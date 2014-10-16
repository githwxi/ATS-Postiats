<div
class="thePageRBodyLContent"
><!--div-->

<?php
include
"./SERVER/MYCODE/atslangweb_pats2xhtmlize.php";
?><!--php-->

<hr></hr>

<h2><a id="Hello_world">Hello, world!</a></h2>

<p>
Following is a tiny program in ATS for printing out the string "Hello,
world!" plus a newline: </p>

<?php
$mycode = <<<EOT
implement main0 () = print("Hello, world!\\n")
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
Assume that the program is stored in a file named <u>hello.dats</u>.  We
can generate an executable named <u>hello</u> by executing the following
command-line: </p>

<div
class="command_line"
>patscc -o hello hello.dats</div>

<p>
If executed, <u>hello</u> does what is mentioned above. The command
<u>patscc</u> first compiles the ATS program contained in <u>hello.dats</u>
into some C code and then invokes a C compiler (gcc in this case) to
translate the generated C code into some binary object code.  </p>

<!--
<p>
Here is a button for trying this example on-line:
<button
 ID="hello_button"
 type="button" onclick="Examples_hello_open_onclick()"
>Try-it-yourself</button>
</p>
-->

<hr></hr>

<h2><a id="Copying_files">Copying files</a></h2>

<p>
Given an input channel and an output channel, the following function fcopy
writes to the latter the characters read from the former:
</p>

<?php
$mycode = <<<EOT
fun
fcopy (
  inp: FILEref
, out: FILEref
) : void = let
  val c = fileref_getc (inp)
in
  if c >= 0 then let
    val () = fileref_putc (out, c) in fcopy (inp, out)
  end // end of [if]
end (* end of [fcopy] *)
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
Note that loops in imperative languages such as C and Java are often
implemented as tail-recursive functions in ATS, which are then compiled
back into loops in C. For instance, fcopy as is implemented above is such
a tail-recursive function.
</p>

<hr></hr>

<h2><a id="Fibonacci_numbers">Computing Fibonacci numbers</a></h2>

<p>
ATS advocates a programming paradigm in which programs and proofs can be
constructed in a syntactically intertwined manner. This paradigm is often
referred to as <em>programming with theorem-proving</em> (PwTP), and it
plays a central indispensible role in the development of ATS.
Let us now see a simple and concrete example that clearly illustrates PwTP
as is supported in ATS.
</p>

<p>
A function fib can be specified as follows for computing Fibonacci numbers:
</p>

<pre
class="patsyntax"
style="color:#000000;"
>
fib(0)   = 0
fib(1)   = 1
fib(n+2) = fib(n) + fib(n+1) for n >= 0
</pre>

<p>
Following is a direct implementation of this specified function in ATS: 
</p>

<?php
$mycode = <<<EOT
fun
fib (
  n: int
) : int =
  if n >= 2 then fib (n-2) + fib (n-1) else n
// end of [fib]
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
Clearly, this is a terribly inefficient implementation of exponential
time-complexity. An implementation of fib in C is given as follows that is
of linear time-complexity:
</p>

<pre
class="patsyntax"
style="color:#000000;"
>
int
fibc (int n) {
  int tmp, f0 = 0, f1 = 1 ;
  while (n-- > 0) { tmp = f1 ; f1 = f0 + f1 ; f0 = tmp ; } ; return f0 ;
} // end of [fibc]
</pre>

<p>
If translated into ATS, the function fibc can essentially be implemented as
follows:
</p>

<?php
$mycode = <<<EOT
fun
fibc (
  n: int
) : int = let
  fun loop (n: int, f0: int, f1: int) =
    if n > 0 then loop (n-1, f1, f0+f1) else f0
  // end of [loop]
in
  loop (n, 0, 1)
end // end of [fibc]
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
There is obviously a logic gap between the defintion of fib and its
implementation as is embodied in fibc. In ATS, an implementation of fib can
be given that completely bridges this gap. First, the specification of fib
needs to be encoded into ATS, which is fulfilled by the declaration of the
following dataprop:
</p>

<?php
$mycode = <<<EOT
dataprop FIB (int, int) =
  | FIB0 (0, 0) | FIB1 (1, 1)
  | {n:nat} {r0,r1:int} FIB2 (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))
// end of [FIB] // end of [dataprop]
EOT;
atslangweb_pats2xhtmlize_static($mycode);
?><!--php-->

<p>
This declaration introduces a type FIB for proofs, and such a type is
referred to as a prop in ATS. Intuitively, if a proof can be assgined the
type FIB(n,r) for some integers n and r, then fib(n) equals r. In other
words, FIB(n,r) encodes the relation fib(n)=r. There are three constructors
FIB0, FIB1 and FIB2 associated with FIB, which are given the following
types corresponding to the three equations in the definition of fib:
</p>

<pre class="patsyntax">
<span class="dynexp">FIB0 <span
class="keyword">:</span> <span class="keyword">(</span><span
class="keyword">)</span> <span class="staexp"><span
class="keyword">-&gt;</span></span> <span class="staexp">FIB</span> <span
class="keyword">(</span><span class="staexp">0</span><span
class="keyword">,</span> <span class="staexp">0</span><span
class="keyword">)</span></span>
<span class="dynexp">FIB1 <span
class="keyword">:</span> <span class="keyword">(</span><span
class="keyword">)</span> <span class="staexp"><span
class="keyword">-&gt;</span></span> <span class="staexp">FIB</span> <span
class="keyword">(</span><span class="staexp">1</span><span
class="keyword">,</span> <span class="staexp">1</span><span
class="keyword">)</span></span>
<span class="dynexp">FIB2 <span
class="keyword">:</span> <span class="staexp"><span
class="keyword">{</span>n<span class="keyword">:</span>nat<span
class="keyword">}</span></span><span class="staexp"><span
class="keyword">{</span>r0<span class="keyword">,</span>r1<span
class="keyword">:</span>int<span class="keyword">}</span></span> <span
class="keyword">(</span><span class="staexp">FIB</span> <span
class="keyword">(</span><span class="staexp">n</span><span
class="keyword">,</span> <span class="staexp">r0</span><span
class="keyword">)</span><span class="keyword">,</span> <span
class="staexp">FIB</span> <span class="keyword">(</span><span
class="staexp">n</span><span class="keyword">,</span> <span
class="staexp">r1</span><span class="keyword">)</span><span
class="keyword">)</span> <span class="staexp"><span
class="keyword">-&gt;</span></span> <span class="staexp">FIB</span> <span
class="keyword">(</span><span class="staexp">n</span><span
class="staexp">+</span><span class="staexp">2</span><span
class="keyword">,</span> <span class="staexp">r0</span><span
class="staexp">+</span><span class="staexp">r1</span><span
class="keyword">)</span></span></pre>
<!--php-->

<p>
Note that {...} is the concrete syntax in ATS for universal
quantification. For instance, FIB2(FIB0(), FIB1()) is a term of the type
FIB(2,1), attesting to fib(2)=1.
</p>

<p>
A fully verified implementaion of the fib function in ATS can now be given
as follows:
</p>

<?php
$mycode = <<<EOT
fun
fibats{n:nat}
  (n: int (n))
: [r:int] (FIB (n, r) | int r) = let
  fun loop
    {i:nat | i <= n}{r0,r1:int}
  (
    pf0: FIB (i, r0), pf1: FIB (i+1, r1)
  | ni: int (n-i), r0: int r0, r1: int r1
  ) : [r:int] (FIB (n, r) | int r) =
    if (ni > 0)
      then loop{i+1}(pf1, FIB2 (pf0, pf1) | ni - 1, r1, r0 + r1)
      else (pf0 | r0)
    // end of [if]
  // end of [loop]
in
  loop {0} (FIB0 (), FIB1 () | n, 0, 1)
end // end of [fibats]
EOT;
atslangweb_pats2xhtmlize_dynamic($mycode);
?><!--php-->

<p>
Note that fibats is given the following declaration:
</p>

<?php
$mycode = <<<EOT
fun fibats : {n:nat} int(n) -> [r:int] (FIB(n,r) | int(r))
EOT;
atslangweb_pats2xhtmlize_static($mycode);
?><!--php-->

<p>
where [...] is the concrete syntax in ATS for existential quantification
and the bar symbol (|) is just a separator (like a comma) for separating
proofs from values. For each integer I, int(I) is a singleton type for the
only integer whose value equals I. When fibats is applied to an integer of
value n, it returns a pair consisting of a proof and an integer value r such
that the proof, which is of the type FIB(n,r), asserts fib(n)=r.
Therefore, fibats is a verified implementation of fib as is encoded by FIB.
Note that the inner function loop directly corresponds to the while-loop in
the body of the function fibc (written in C).
</p>

<p>
Lastly, it should be emphasized that proofs are completely erased after
typechecking. In particular, there is no proof construction at run-time.
</p>

<p>
Please click
<a href="./SERVER/MYCODE/Patsoptaas_serve.php?mycode=fibats">here</a>
if you are interested in compiling and running this example on-line.
</p>

<!--
<p>
Here is a button for trying this example on-line:
<button
 ID="hello_button"
 type="button" onclick="Examples_fibats_open_onclick()"
>Try-it-yourself</button>
</p>
-->

<hr></hr>

</div>

<?php /* end of [Examples.php] */ ?>

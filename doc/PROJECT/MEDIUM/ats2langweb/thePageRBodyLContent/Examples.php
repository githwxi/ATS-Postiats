<div
class="thePageRBodyLContent"
><!--div-->

<hr></hr>

<h2><a id="Hello_world">Hello, world!</a></h2>

<p>
Following is a tiny program in ATS for printing out the string "Hello,
world!" plus a newline: </p>

implement main0 () = print ("Hello, world!\n")

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

<p>
Would you like to try this example online?
<button>Try-it-yourself</button>
</p>

</div>

<?php /* end of [Examples.php] */ ?>

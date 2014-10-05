<div>
#include<br>
"share/atspre_define.hats"<br>
#include<br>
"share/atspre_staload.hats"<br>
//<br>
#include<br>
"{$LIBATSCC2JS}/staloadall.hats"<br>
//<br>
staload "{$LIBATSCC2JS}/SATS/print.sats"</br>
//<br>
#define ATS_MAINATSFLAG 1<br>
#define ATS_DYNLOADNAME "my_dynload"<br>
//<br>
/* ****** ****** */<br>
//<br>
%{$<br>
//<br>
ats2jspre_the_print_store_clear();<br>
my_dynload();<br>
alert(ats2jspre_the_print_store_join());<br>
//<br>
%} // end of [%{$]<br>
//<br>
/* ****** ****** */<br>
<br>
extern<br>
fun fact : int -> int<br>
<br>
implement<br>
fact (n) = if n > 0 then n * fact(n-1) else 1<br>
<br>
val N = 10<br>
val () = println! ("fact(", N, ") = ", fact(N))<br>
<br>
/* ****** ****** */<br>
<br>
/* end of [fact.dats] */<br>
</div>

<?php /* end of [Patsoptaas.php] */ ?>

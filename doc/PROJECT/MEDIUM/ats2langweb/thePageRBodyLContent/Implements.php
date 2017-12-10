<div
class="thePageRBodyLContent"
><!--div-->

<hr></hr>

<table>
<tr>
<td>
<h2
style="margin-bottom:0px">
<a id="ATSproto">ATS/Proto</a></h2>

<p>
ATS/Proto, written in OCaml, is the first released implementation of ATS,
consisting of a typechecker, an interpreter and a compiler (to C).
In this implementation, the standard boxed data representation is chosen to
implement parametric polymorphism. There is direct support in ATS/Proto for
object-oriented programming (OOP), which is no longer available in later
implementations of ATS. Also, there is support in ATS/Proto for typed
meta-programming (MP), that is, constructing programs that can generate
well-typed programs, which is also abandoned in later implementations. As
of now, ATS/Proto is no longer actively maintained and its main purpose is
to serve as a historic reference.
</p>

</td>
</tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2
style="margin-bottom:0px">
<a id="ATSgeizella">ATS/Geizella</a></h2>

<p>
ATS/Geizella, written in OCaml, is a previously released implementation
of ATS. In this implementation, the native unboxed data representation (as
is in C) is adopted, making ATS/Geizella particularly well-suited for
direct interaction with C (that incurs no run-time overhead). As for
parametric polymorphism, it is supported in ATS/Geizella through the use of
templates. ATS/Geizella is now largely out of active use as ATS/Anairiats,
a compiler for ATS that is also nearly entirely written in ATS, can be
self-bootstrapped successfully. At this point, ATS/Geizella primarily serves as
the backup for ATS/Anairiats in case it is needed for building ATS/Postiats,
that is, ATS2.
</p>

</td>
</tr> </table>

<hr></hr>

<table>
<tr>
<td>
<h2
style="margin-bottom:0px">
<a id="ATSanairiats">ATS/Anairiats</a></h2>
<p>
ATS/Anairiats is a previously released implementation of ATS.
It is nearly entirely written in ATS itself, consisting of 100K+ lines
of source code. When compared to ATS/Geizella, another previous
implementation of ATS, ATS/Anairiats is significantly more efficient, and
it issues in general more informative messages for identifying program
errors. ATS/Anairiats is now often referred to as ATS1, and it is
currently being actively used for the purpose of developing ATS/Postiats,
that is, ATS2.
</p>
</td>
</tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2
style="margin-bottom:0px">
<a id="ATSpostiats">ATS/Postiats</a></h2>
<p>
ATS/Postiats is the currently released implementation of ATS.  It is often
referred to as ATS2, the second generation of ATS.  ATS/Postiats is nearly
entirely implemented in ATS1, consisting of 180K+ lines of source code. Its
major improvement over ATS1 lies in a highly versatile template system that
aims at maximally facilitating code reuse. Note that ATS/Postiats is in general
unable to compile code written in ATS1. However, turning ATS1 code into legal
ATS2 code is largely a straightforward process due to the great syntactic similarity
between ATS1 and ATS2.
</p>
</td>
</tr>
</table>

<hr></hr>

</div>

<?php /* end of [Implements.php] */ ?>

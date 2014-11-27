<div
class="thePageRBodyLContent"
><!--div-->

<hr></hr>

<h2><a id="What_is_ATS">What is ATS?</a></h2>
<!--
<h2 style="display:inline;">What is ATS?</h2>
-->

<p>
ATS is a statically typed programming language that unifies
implementation with formal specification. It is equipped with a highly
expressive type system rooted in the framework <em>Applied Type
System</em>, which gives the language its name.  In particular, both
dependent types and linear types are available in ATS.
</p>

<p>
The current implementation of ATS2 (ATS/Postiats) is written in ATS1
(ATS/Anairiats), consisting of more than 150K lines of code. ATS can be as
efficient as C/C++ both time-wise and memory-wise and supports a variety of
programming paradigms that include:
</p>

<ul
style="list-style-position:outside;"
>
<li
style="margin-top:10px;margin-bottom:10px;"
>
<strong>Functional programming</strong>.
The core of ATS is a call-by-value functional language inspired by ML.
The availability of linear types in ATS often makes functional programs
written in it run not only with surprisingly high efficiency (when compared
to C) but also with surprisingly small (memory) footprint (when compared to
C as well).
</li>

<li
style="margin-top:10px;margin-bottom:10px;"
>
<strong>Imperative programming</strong>.
The novel approach to imperative programming in ATS is firmly rooted in the
paradigm of <em>programming with theorem-proving</em>. The type system of
ATS allows many features considered dangerous in other languages (such as
explicit pointer arithmetic and explicit memory allocation/deallocation) to
be safely supported in ATS, making ATS well-suited for implementing
high-quality low-level systems.
</li>

<li
style="margin-top:10px;margin-bottom:10px;"
>
<strong>Concurrent programming</strong>.
ATS can support multithreaded programming through safe use of pthreads. The
availability of linear types for tracking and safely manipulating resources
provides an effective approach to constructing reliable programs that can take
great advantage of multicore architectures.
</li>

<li
style="margin-top:10px;margin-bottom:10px;"
>
<strong>Modular programming</strong>.
The module system of ATS is largely infuenced by that of Modula-3, which is
both simple and general as well as effective in supporting large scale
programming.
</li>

</ul>

<p>
In addition, ATS contains a subsystem ATS/LF that supports a form of
(interactive) theorem-proving, where proofs are constructed as total
functions.  With this subsystem, ATS is able to advocate a
<em>programmer-centric</em> approach to program verification that combines
programming with theorem-proving in a syntactically intertwined
manner. Furthermore, ATS/LF can also serve as a logical framework (LF)
for encoding various formal systems (such as logic systems and type systems)
together with proofs of their (meta-)properties.
</p>

<hr></hr>

<h2><a id="What_is_ATS_good_for">What is ATS good for?</a></h2>

<ul>

<li>
ATS can greatly enforce precision in practical programming.
</li>

<li>
ATS can greatly facilitate refinement-based software development.
</li>

<li>
ATS allows the programmer to write efficient functional programs that
directly manipulate native unboxed data representation.
</li>

<li>
ATS allows the programmer to reduce the memory footprint of a program
by making use of linear types.
</li>

<li>
ATS allows the programmer to enhance the safety (and efficiency) of a
program by making use of theorem-proving.
</li>

<li>
ATS allows the programmer to write safe low-level code that runs in OS
kernels.
</li>

<li>
ATS can help teach type theory, demonstrating both convincingly and
concretely the power and potential of types in constructing high-quality
software.
</li>

</ul>

<hr></hr>

<h2><a id="Acknowledgments">Acknowledgments</a></h2>

<p>
The development of ATS has been funded in part by <a
href="http://www.nsf.gov">National Science Foundation</a> (NSF) under the
grants no. CCR-0081316/CCR-0224244, no. CCR-0092703/0229480,
no. CNS-0202067, no. CCF-0702665 and no CCF-1018601.
As always, <em>any opinions, findings, and conclusions or recommendations
expressed here are those of the author(s) and do not necessarily reflect
the views of the NSF.</em>
</p>

<hr></hr>

</div>

<?php /* end of [Home.php] */ ?>

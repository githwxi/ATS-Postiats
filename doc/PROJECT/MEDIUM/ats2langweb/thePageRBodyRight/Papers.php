<div
style="margin-top:8px;padding:8px;"
><!--div-->

<h2 style="display:inline;">A little history of ATS</h2>

<hr></hr>

<p>
Dependent ML (DML) extends ML conservatively with a restrictive
form of dependent types. In DML, program values are not allowed
in the formation of types. However, types dependent on certain
program values (such as integers) can still be constructed due to
the availability of singleton types for classifying such values.
Dependent ML was developed and prototyped during the second half
of 1997 and through the year of 1998 as the primary contribution
of Hongwei Xi's doctoral thesis, which was supervised by Prof.
Frank Pfenning and completed and defended in December, 1998.
The prototype implementation of DML consisted primarily of a
typechecker written in Standard ML (SML).
</p>

<hr></hr>

<p>
Further developement of DML continued at Oregon Graduate Institute (OGI) of
Science and Technology, where Hongwei Xi worked as a post-doctoral
researcher until the end of August, 1999. During this period, a programming
language system of the name <u>deCaml</u> was implemented as an extension
of Caml-light (the predecessor of OCaml) with DML-style dependent types.
Programs in deCaml can be first typechecked and then passed to Caml-light
for further compilation. Various demos of deCaml were given but the system
itself has never been documented for public release.
</p>

<hr></hr>

<p>
How can DML-style dependent types be made available to support imperative
programming? An experimental programming language of the name <u>Xanadu</u>
was designed and implemented mostly during the second half of 1999 in an
attempt to answer this question. While many concepts developed in Xanadu
would eventually find their way into ATS, Xanadu as a programming language
did not provide a satisfactory answer to imperative programming with
dependent types. In particular, the manner in which dependent types are
supported in Xanadu is very limited, and it is clear that this manner
cannot accommodate many common programming features in the C programming
language. Various demos of Xanadu were given based on a prototype
implementation consisting primarily of a typechecker and an interpreter.
</p>

<hr></hr>

<p>

A guarded recursive datatype (GRDT) is also referred to as a generalized
algebraic datatype (GADT). This notion can be seen as a natural adaptation
of DML-style dependent types in a setting where types replace integers as
type indexes. While GRDTs are fundamentally different from DML-style
dependent types semantically, the former and the latter are treated
similarly at the level of syntax. In particular, typechecking for the
former can be readily adapted from typechecking for the latter. The concept
of ATS was conceived around the end of 2002 (immediately after the
development of GRDTs) as an attempt to form a unifying framework for both
DML-style dependent types and GRDTs.

</p>

<hr></hr>

<p>

Implementation for ATS started around the beginning of 2003, when the
theory for ATS was being developed and formalized as well. By Summer 2003,
a functioning typechecker for ATS could be tested on a variety of simple
examples. By the beginning of 2004, an interpreter for programs in ATS
started to be functioning. However, it was still unclear by then how common
imperative programming features can or should be supported in ATS. The
breakthrough came before Summer 2004, when it was finally realized that a
form of theorem-proving based on linear logic can be incorporated into ATS
as the basis for supporting imperative programming. The moment of this
realization is probably the single most crucial moment in the development
of ATS. By the middle of July 2004, the implementation for ATS (extended
with linear types) reached a point where the typechecker and the
interpreter were able to handle a variety of imperative programs.

</p>

<hr></hr>

<p>
The following list consists of the major implementations of ATS
that were publicly released in the past:
<ul>
<li>
ATS0/Proto (written in OCaml)
</li>
<li>
ATS1/Geizella (written in OCaml)
</li>
<li>
ATS1/Anairiats (written in ATS1)
</li>
</ul>
The current release of ATS is ATS2/Postiats, which consists of
more than 150K lines of code written in ATS1.
</p>

<hr></hr>

</div>

<?php /* end of [Papers.php] */ ?>

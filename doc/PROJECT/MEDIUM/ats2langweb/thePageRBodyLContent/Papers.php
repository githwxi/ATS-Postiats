<div
class="thePageRBodyLContent"
><!--div-->

<hr></hr>

<table>
<tr>
<td>
<h2
style="margin-bottom:0px">
<a id="ATSfound">ATS</a>:</h2>
<h3 style="margin-top:2px">
An approach to practical programming with theorem-proving</h3>
</td>
</tr>
</table>

<table>
<tr>
<td>
<em>Abstract</em>:
The framework Pure Type System (PTS) offers a simple and general
approach to designing and formalizing type systems. However, in the
presence of dependent types, there often exist certain acute problems
that make it difficult for PTS to directly accommodate many common
realistic programming features such as general recursion, recursive
types, effects (e.g., exceptions, references, input/output), etc. In
this paper, Applied Type System (<b>ATS</b>) is presented as a
framework for designing and formalizing type systems in support of
practical programming with advanced types (including dependent
types). In particular, it is demonstrated that <b>ATS</b> can readily
accommodate a paradigm referred to as programming with theorem-proving
(PwTP) in which programs and proofs are constructed in a syntactically
intertwined manner, yielding a practical approach to internalizing
constraint-solving needed during type-checking. The key salient
feature of <b>ATS</b> lies in a complete separation between statics,
where types are formed and reasoned about, and dynamics, where
programs are constructed and evaluated. With this separation, it is no
longer possible for a program to occur in a type as is otherwise
allowed in PTS.  The paper contains not only a formal development of
<b>ATS</b> (of minimalist style) but also some examples taken from
<u>ATS</u>, a programming language with a type system rooted in
<b>ATS</b>, in support of employing <b>ATS</b> as a framework to
formulate advanced type systems for practical programming.
</td>
</tr>
<tr><td>
Links:
<a href="MYDATA/ATSfoundation.pdf">pdf</a>
</td></tr>
<tr height="8px"><td></td></tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2
style="margin-bottom:0px">
<a id="Dependent_ML">Dependent ML</a>:</h2>
<h3 style="margin-top:2px">
An approach to practical programming with dependent types</h3>
</td>
</tr>
</table>

<table>
<tr>
<td>
<em>Abstract</em>:
The paper presents an approach to enriching the type system of ML
with a restricted form of dependent types, where type index terms are
required to be drawn from a given type index language L that is completely
separate from run-time programs, leading to the DML(L) language
schema. This enrichment allows for specification and inference of
significantly more precise type information, facilitating program error
detection and compiler optimization. The primary contribution of the paper
lies in a novel language design, which can effectively support the use of
dependent types in practical programming. In particular, this design makes
it both natural and straightforward to accommodate dependent types in the
presence of effects such as references and exceptions.
</td>
</tr>
<tr><td>
Links:
<a href="MYDATA/DML-jfp07.pdf">pdf</a>
</td></tr>
<tr height="8px"><td></td></tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2><a id="GRDT-popl2003">Guarded Recursive Datatype Constructors</a></h2>
</td>
</tr>
</table>

<table>
<tr>
<td>
<em>Abstract</em>:
The paper introduces a notion of guarded recursive (g.r.)
datatype constructors, generalizing the notion of recursive datatypes in
functional programming languages such as ML and Haskell. Both theoretical
and practical issues resulted from this generalization are addressed. On
one hand, a type system is designed to formalize the notion of
g.r. datatype constructors and its soundness is proven. On the other hand,
some significant applications (e.g., implementing objects, implementing
staged computation, etc.) of g.r. datatype constructors are given,
indicating that g.r. datatype constructors can have far-reaching
consequences in programming. The main contribution of the paper lies in the
recognition and then the formalization of a programming notion that is of
both theoretical interest and practical use.
</td>
</tr>
<tr><td>
Links:
<a href="MYDATA/GRDT-popl03.pdf">pdf</a>
</td></tr>
<tr height="8px"><td></td></tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2>
<a id="Xanadu-lics2000">Imperative Programming with Dependent Types</a>
</h2>
</td>
</tr>
</table>

<table>
<tr>
<td>
<em>Abstract</em>:
This paper enriches imperative programming with a form of dependent
types. It starts with some motivations for the enrichment as well as some
major obstacles that need to be overcome. The design of a source-level
dependently typed imperative programming language of the name
<em>Xanadu</em> is presented, together with a formalization of both static and
dynamic semantics for Xanadu.  In addition, the type soundness for Xanadu is
established and various realistic programming examples in support of the
practicality of Xanadu are given. It is claimed that the language design of
Xanadu is novel and it can serve as an informative example to demonstrate a
means for combining imperative programming with dependent types.
</td>
</tr>
<tr><td>
Links:
<a href="MYDATA/Xanadu-lics00.pdf">pdf</a>
</td></tr>
<!--
<tr><td>
Translations:
<a href="https://www.homeyou.com/~edu/programacao-imperativa">Portuguese</a>
</td></tr>
-->
<tr height="8px"><td></td></tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2><a id="CPwTP-icfp05">Combining Programming with Theorem-Proving</a></h2>
</td>
</tr>
</table>

<table>
<tr>
<td>
<em>Abstract</em>:
Applied Type System (ATS) is recently proposed as a framework for
designing and formalizing (advanced) type systems in support of practical
programming. In ATS, the definition of type equality involves a constraint
relation, which may or may not be algorithmically decidable. To support
practical programming, we adopted a design in the past that imposes certain
restrictions on the syntactic form of constraints so that some effective
means can be found for solving constraints automatically. Evidently, this
is a rather ad hoc design in its nature. In this paper, we rectify the
situation by presenting a fundamentally different design, which we claim to
be both novel and practical. Instead of imposing syntactical restrictions
on constraints, we provide a means for the programmer to construct proofs
that attest to the validity of constraints. In particular, we are to
accommodate a programming paradigm that enables the programmer to combine
programming with theorem proving. Also we present some concrete examples in
support of the practicality of this design.
</td>
</tr>
<tr><td>
Links:
<a href="MYDATA/CPwTP-icfp05.pdf">pdf</a>
</td></tr>
<tr height="8px"><td></td></tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2><a id="SPPSV-padl05">Safe Programming with Pointers through Stateful Views</a></h2>
</td>
</tr>
</table>

<table>
<tr>
<td>
<em>Abstract</em>:
The need for direct memory manipulation through pointers is
essential in many applications. However, it is also commonly understood
that the use (or probably misuse) of pointers is often a rich source of
program errors. Therefore, approaches that can effectively enforce safe use
of pointers in programming are highly sought after. ATS is a programming
language with a type system rooted in a recently developed framework
Applied Type System, and a novel and desirable feature in ATS lies in its
support for safe programming with pointers through a novel notion of
stateful views. In particular, even pointer arithmetic is allowed in ATS
and guaranteed to be safe by the type system of ATS. In this paper, we give
an overview of this feature in ATS, presenting some interesting examples
based on a prototype implementation of ATS to demonstrate the practicality
of safe programming with pointer through stateful views.
</td>
</tr>
<tr><td>
Links:
<a href="MYDATA/SPPSV-padl05.pdf">pdf</a>
</td></tr>
<tr height="8px"><td></td></tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2><a id="VsTsVTs-2018-10-28">To Memory Safety through Proofs</a></h2>
</td>
</tr>
</table>

<table>
<tr>
<td>
<em>Abstract</em>:
We present a type system capable of guaranteeing the memory safety of
programs that may involve (sophisticated) pointer manipulation such as
pointer arithmetic. With its root in a recently developed framework
<em>Applied Type System</em> (ATS), the type system imposes a level of
abstraction on program states through a novel notion of recursive stateful
views and then relies on a form of linear logic to reason about such
stateful views.  We consider the design and then the formalization of the
type system to constitute the primary contribution of the paper. In
addition, we also mention a running implementation of the type system and
then give some examples in support of the practicality of programming with
recursive stateful views.
</td>
</tr>
<tr><td>
Links:
<a href="MYDATA/VsTsVTs-2018-10-28.pdf">pdf</a>
</td></tr>
<tr height="8px"><td></td></tr>
</table>

<hr></hr>

</div>

<?php /* end of [Papers.php] */ ?>

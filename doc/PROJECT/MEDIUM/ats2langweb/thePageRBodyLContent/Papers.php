<div
class="thePageRBodyLContent"
><!--div-->

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
<h2><a id="Applied_Type_System">Applied Type System</a>:</h2>
</td>
</tr>
</table>

<table>
<tr>
<td>
<em>Abstract</em>:
The framework Pure Type System (PTS) offers a simple and general
approach to designing and formalizing type systems. However, in the
presence of dependent types, there often exist some acute problems that
make it difficult for PTS to accommodate many common realistic programming
features such as general recursion, recursive types, effects (e.g.,
exceptions, references, input/output), etc. In this paper, we propose a new
framework Applied Type System (ATS) to allow for designing and formalizing
type systems that can readily support common realistic programming
features. The key salient feature of ATS lies in a complete separation of
statics, in which types are formed and reasoned about, from dynamics, in
which programs are constructed and evaluated. With this separation, it is
no longer possible for a program to occur in a type as is otherwise allowed
in PTS. We outline a formal development of ATS, establishing various (meta)
properties of applied type systems. In addition, we provide some examples
taken from ATS, a programming language with its type system rooted in ATS,
to demonstrate the expressiveness and flexibility of ATS as a framework for
type system design and formalization in support of practical programming.
</td>
</tr>
<tr><td>
Links:
<a href="MYDATA/ATS-types03.pdf">pdf</a>
</td></tr>
<tr height="8px"><td></td></tr>
</table>

<hr></hr>

<table>
<tr>
<td>
<h2><a id="Combining_PwTP">Combining Programming with Theorem-Proving</a>:</h2>
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

</div>

<?php /* end of [Papers.php] */ ?>

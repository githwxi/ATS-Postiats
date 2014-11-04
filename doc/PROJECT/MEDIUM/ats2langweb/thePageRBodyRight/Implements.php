<div
style="margin-top:8px;padding:8px;"
><!--div-->

<h2
 style="display:inline;"
>A little history of ATS</h2><br>
(following the implementation trail)

<hr></hr>

<p>
Implementing ATS-Proto involved several iterations.
The first trial started at the end of 2002 and continued
through much of 2003. The second trial started immediately
after the first one ended and then continued into 2004.
By the beginning of Summer 2004, the realization that
imperative programming in ATS should be built on top of
PwTP (programming-with-theorem-proving) set off the
third trial of implementing ATS, which resulted in a
functioning typechecker in July 2004 and a functioning
interpreter by the end of 2004. The fourth trial started
during the first half of 2005 and continued throughout 2006,
finally leading to ATS-Proto. There was yet another trial,
the fifth one, but it was soon abandoned. For learning
more details about the development of ATS-Proto, please
find the code written for each of the mentioned trial versions 
<a href="https://sourceforge.net/projects/ats-first/files/ats-first/">on-line</a>.
The conservative mark-sweep garbage collector included in the runtime of
ATS-Proto was written by Rick Lavoe.
</p>

<hr></hr>

<p>
The implementation of ATS-Geizella started in Fall 2006 and it became
functioning by Summer 2007. Unlike ATS-Proto, there was no longer support
in ATS-Geizella for interpreting ATS code. With ATS-Geizella being ready
for use, the development of ATS reached the point where the natural step
to take next would be to make ATS capable of boostrapping itself.
</p>

<hr></hr>

<p>
The implementation of ATS-Anairiats started in Summer 2007. By the middle
of May 2008, ATS-Anairiats succeeded in compiling itself into a
set C-files that could be further compiled into an excutable by a standard
C-compiler such as gcc. After about 5 and one-half years of continuing
effort, the development of ATS finally reached the milestone where the
language was able to bootstrap itself.
</p>

<hr></hr>

<p>
The support for templates was an "add-on" in ATS-Anairiats. It was
not properly designed and could cause acute problems in programming.
The primary motivation for designing and implementing ATS-Postiats (ATS2)
was to greatly improve the support for template-based programming in ATS.
The implementation of ATS-Postiats started in March 2010. It took 2 years
and 3 months to produce a running typechecker for ATS-Postiats. In total,
it took 3 years and 6 months for the first version of ATS-Postiats to be
officially released at the end of August, 2013.
</p>

<hr></hr>

</div>

<?php /* end of [Implements.php] */ ?>

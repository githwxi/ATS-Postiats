<div
class="thePageRBodyLContent"
><!--div-->

<hr></hr>

<h2><a id="ATSPRE">ATSPRE</a></h2>

<p>
<u>ATSPRE</u>
is also referred to as <u>ATSLIB/prelude</u>.
</p>

<ul>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/fixity.ats">fixity</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/basics_pre.sats">basics_pre</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/basics_sta.sats">basics_sta</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/basics_dyn.sats">basics_dyn</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/integer.sats">integer</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/pointer.sats">pointer</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/bool.sats">bool</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/char.sats">char</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/float.sats">float</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/string.sats">string</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/strptr.sats">strptr</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/filebas.sats">filebas</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/intrange.sats">intrange</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/list.sats">list</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/list_vt.sats">list_vt</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/array.sats">array</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/arrayptr.sats">arrayptr</a>
</li>
<li>
<a href="http://ats-lang.sourceforge.net/DOCUMENT/ATS-Postiats/prelude/SATS/arrayref.sats">arrayref</a>
</li>
</ul>

<hr></hr>

<h2><a id="ATSLIB_libc">ATSLIB/libc</a></h2>

<p>
<u>ATSLIB/libc</u>
essentially consists of the API for calling libc-functions in ATS.
</p>

<hr></hr>

<h2><a id="ATSLIB_libats">ATSLIB/libats</a></h2>

<p>

<u>ATSLIB/libats</u> consists of various data structures implemented in
ATS. The implementation code is largely template-based and it is mostly
being used by the compiler (ATS/Postiats) to generate C code (rather than
itself being directly compiled into object code).  Often a data structure
is given a functional implementation as well as a linear implementation in
ATSLIB/libats, where the former requires the availability of garbage
collection (GC) for automatic memory management while the latter relies on
linear types to ensure the safety of manual memory management.

</p>

<hr></hr>

</div>

<?php /* end of [Libraries.php] */ ?>

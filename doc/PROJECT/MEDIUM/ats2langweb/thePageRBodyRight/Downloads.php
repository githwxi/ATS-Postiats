<div
style="margin-top:8px;padding:8px;"
><!--div-->

<h2 style="display:inline;">More on ATS packages</h2>

<hr></hr>

<p>
ATS2 (ATS/Postiats) is implemented in ATS1 (ATS/Anairiats), and ATS1 is
implemented in itself. The lastest released version of ATS1 is
<a href="http://sourceforge.net/projects/ats-lang/files/latest/download?source=files">ATS1-0.2.11</a>,
which needs to be installed first in order to build ATS2 from its source
(written in ATS1). Essentially, the process of installing ATS1 is the same
as installing ATS2. For more information, please check out a simple shell script
<a href="https://github.com/githwxi/ATS-Postiats/blob/master/travis-ci/setup.sh">on-line</a>
for installing ATS1 under Linux.
</p>

<hr></hr>

<p>
Note that the C code generated from compiling the ATS1 source of ATS2 is
included in a released package of ATS2. When the package is used to build
ATS2, the included C code is first compiled by a C compiler (such as gcc
and clang) into <u>patsopt</u> for compiling ATS2 code subsequently.  In
general, there should be very little effort required to port ATS2 to a platform
if the platform happens to run a Unix-like OS.
</p>

<hr></hr>

<p>
The name
<a href="https://github.com/githwxi/ATS-Postiats">ATS2-github</a>
often refers to the version of ATS2 available at github.com.
This version contains the latest changes made after the last
release of ATS2. Assume that ATS1 has been installed. Then ATS2-github
can be built by issuing the following 3 command-lines after it is first
git-cloned into a directory of the name ATS2-github:
<pre
style="font-size:125%;"
>
cd ATS2-github
make -f codegen/Makefile_atslib
make -f Makefile_devl
</pre>
</p>

<hr></hr>

</div>
<?php /* end of [Downloads.php] */ ?>

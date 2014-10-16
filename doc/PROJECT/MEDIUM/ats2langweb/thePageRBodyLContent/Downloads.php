<div
class="thePageRBodyLContent"
><!--div-->

<hr></hr>

<h2><a id="ATS_packages">ATS packages for download</a></h2>

<p>
ATS is Open Source and Free Software, and it is freely available under
the GNU GENERAL PUBLIC LICENSE version 3 (GPLv3) as is published by the
Free Software Foundation. The current implementation of ATS is given the
name ATS/Postiats or simply Postiats. Also, this implementation is
referred to as ATS2 for it is the successor of a previous implementation of
the name ATS/Anairiats, which is often referred to as ATS1.  The latest
released packages of ATS2 are available at the following links:
</p>

<ul>
<li>
The current <em>stable</em> release of ATS2 is at
<a href="http://sourceforge.net/projects/ats2-lang/download">ATS2-0.1.3</a>.

</li>
<li>
The current <em>unstable</em> release of ATS2 is at
<a href="http://www.ats-lang.org/IMPLEMENT/Positats/ATS2-0.1.4.tgz">ATS-0.1.4</a>.
</li>
</ul>

<p>
The previous stable releases of ATS2 are also available
<a href="http://sourceforge.net/projects/ats2-lang/files/ats2-lang/">on-line</a>.
</p>

<hr></hr>

<h2><a id="Requirements_install">Requirements for installation</a></h2>

<p>
The following requirements are supposed to be met in order to install ATS:
</p>

<ul>
<li>
Operating System requirement:
ATS is supported under the following operating systems:
<ul>
<li>Linux</li>
<li>MacOS</li>
<li>Windows with Cygwin</li>
</ul>
</li>
<li>
Programming Language requirement: GNU C-Compiler (gcc). Other C-compilers
should also work in principle. In particular, it is known that both clang
and <a href="http://bellard.org/tcc/">tcc</a> can succeed in compiling both
ATS1 and ATS2.
</li>
</ul>

<p>
If you are able to port ATS to a platform not listed here, please drop us
a note so that other users of ATS may benefit.
</p>

<p>
The GMP library (libgmp.a), which is in general included in a GNU/Linux
distribution, is currently required for installing a release of ATS2.
Please see <a href="http://gmplib.org">http://gmplib.org</a> for more
details on GMP.
</p>

<hr></hr>

<h2><a id="Precompiledpack_install">Precompiled packages for installation</a></h2>

<ul>

<li>
<a href="https://packages.debian.org/sid/ats2-lang">Official Debian package</a>:
It is currently maintained by
<a href="http://cs-people.bu.edu/md/">Matthew Danish</a>.
</li>

<li>
Unofficial Redhat package:
It is currently maintained by
<a href="http://cs-people.bu.edu/md/">Matthew Danish</a>.
</li>

</ul>

<hr></hr>

<h2>
<a id="Install_source_compile">Installation through source compilation</a>
</h2>

<p>
This installation method
requires access to gcc or some other C-compiler
(such as clang) and is also in need of the GMP library.
It takes 3 simple steps to complete with the third one being
optional.
</p>

<p>
<strong>Step 1</strong>:
</p>
<p>
You can download a released package of ATS2 available
<a href="http://sourceforge.net/projects/ats2-lang/download">on-line</a>
and then untar it in a directory, say MYATS, of your choice by issuing the following
command-line:
</p>
<div
class="command_line"
>tar -zvxf ATS2-Postiats-x.x.x.tgz
</div>
<p>
where <u>ATS2-Postiats-x.x.x.tgz</u> refers to the downloaded package and
x.x.x is the version number of the package.  All the directories and files
extracted from the tarball are stored in the directory <u>MYATS/ATS2-Postiats-x.x.x</u>.
</p>
<p>
If you have access to the <em>git</em> command, then you can also do a git-clone
as follows to obtain the current released package of ATS2:
</p>
<div
class="command_line"
>git clone git://git.code.sf.net/p/ats2-lang/code ATS2-Postiats
</div>

<p>
<strong>Step 2</strong>:
</p>
<p>
Please enter the directory <u>MYATS/ATS2-Postiats-x.x.x</u>, and then execute
the following command-line:
</p>
<div
class="command_line"
>./configure && make all
</div>
<p>
You can expect that two executables <u>patscc</u> and <u>patsopt</u> be generated.
After setting PATSHOME to <u>MYATS/ATS2-Positiats-x.x.x</u> and adding ${PATSHOME}/bin
to the value of PATH, you are ready to use <u>patscc</u> and <u>patsopt</u> for compiling
ATS programs.
</p>

<p>
If you encounter errors during or after building <u>patscc</u> and <u>patsopt</u>,
please re-build by issuing the following command-line:
</p>
<div
class="command_line"
>make cleanall && ./configure && make GCFLAG=-D_ATS_NGC all
</div>

<p>
<strong>Step3</strong>
</p>

<p>
Optionally, you may choose to install ATS.
The default directory for installing ATS is <u>/usr/local</u>.
If you want to change it, please first execute the following command-line:
</p>
<div
class="command_line"
>./configure --prefix=DESTDIR
</div>
<p>
where DESTDIR refers to the directory into which ATS is to be installed.
</p>

<p>
You can now install ATS by executing:
</p>
<div class="command_line">make install</div>
<p>
After installation, you need to set PATSHOME to
<u>DESTDIR/lib/ats2-postiats-x.x.x</u>, which is the name of the directory
where ATS is installed.
</p>

<p>
Note that you can always re-configure before executing <em>make install</em>
if you would like to change a previously selected directory for installation:
</p>
<div class="command_line">./configure --prefix=DESTDIR2</div>
<p>
Also, you can perform staged installation by making use of the variable DESTDIR.
Please find explanation
<a href="http://www.gnu.org/prep/standards/html_node/DESTDIR.html">on-line</a>.
</p>

<hr></hr>

<h2>
<a id="Install_of_ATS2_contrib">Installation of ATS2-contrib</a>
</h2>

<p>
ATS2-contrib primarily consists of external contributions in the forms
of library packages, tutorials, examples, documentation of various sorts, etc.
</p>

<ul>
<li>
The current <em>stable</em> release of ATS2-contrib is at
<a href="http://sourceforge.net/projects/ats2-lang-contrib/download">ATS2-contrib-0.1.3</a>.
</li>
</ul>

<p>
You can download a package of ATS2-contrib available
<a href="http://sourceforge.net/projects/ats2-lang-contrib/download">on-line</a>
and then untar it in a directory, say MYATS, of your choice by issuing the following
command-line:
</p>
<div
class="command_line"
>tar -zvxf ATS2-Postiats-contrib-x.x.x.tgz
</div>
<p>
where <u>ATS2-Postiats-contrib-x.x.x.tgz</u> refers to the downloaded package and
x.x.x is the version number of the package.  All the directories and files extracted
from the tarball are now in the directory <u>MYATS/ATS2-Postiats-contrib-x.x.x</u>.
</p>
<p>
Please set the environment variable PATSHOMERELOC to the name of this
directory and then you are ready to use ATS2-contrib.  If you like, you can
set PATSHOMERELOC to be the same as ${PATSHOME} after moving the content of
the directory <u>MYATS/ATS2-Postiats-contrib-x.x.x</u> into the directory of
the name ${PATSHOME}.
</p>

<p>
If you have access to the <em>git</em> command, then you can also do a git-clone as follows
to obtain the current release of ATS2-contrib:
</p>
<div
class="command_line"
>git clone git://git.code.sf.net/p/ats2-lang-contrib/code ATS2-Postiats-contrib
</div>
<p>
This approach is preferred as it can greatly simplify the process of pulling in new contributions
added to ATS2-contrib later.
</p>

<hr></hr>

<h2>
<a id="Install_of_ATS2_include">Installation of ATS2-include</a>
</h2>

<p>
ATS2-include consists of the header files needed to compile the C code
generated from ATS source.  Its primary purpose is to support the
distribution of C code generated from a software package written in ATS.
Note that the header files in ATS2-include are given a BSD-like license so
that they can essentially be used anywhere without concerns of license
violations.
</p>
<p>
Strickly speaking, ATS2-include can be downloaded and then
stored at any directory one likes. If ATS2-include is to be installed,
then a directory like <u>/usr/lib/ats2-postiats-x.x.x</u> or
<u>/usr/local/lib/ats2-postiats-x.x.x</u> should be proper for storing
the header files contained in it, where x.x.x refers to the verison number of
ATS2-include.
</p>

<hr></hr>

</div>

<?php /* end of [Downloads.php] */ ?>

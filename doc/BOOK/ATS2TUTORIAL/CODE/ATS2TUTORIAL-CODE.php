<!DOCTYPE html>

<?php
//
$mydir_url=
'https://raw.githubusercontent.com/githwxi/ATS-Postiats/master/doc/BOOK/ATS2TUTORIAL/CODE';
//
$Patsoptaas_serve_php=
'http://www.ats-lang.org/SERVER/MYCODE/Patsoptaas_serve.php';
//
function
listitem_gen($fname)
{
  global $mydir_url;
  global $Patsoptaas_serve_php;
  echo "\n";
  echo "<li><a href=\"$Patsoptaas_serve_php?mycode_url=$mydir_url/$fname\">$fname(c)</a></li>";
  echo "\n";
}
function
listitem_gen2($fname)
{
  global $mydir_url;
  global $Patsoptaas_serve_php;
  echo "\n";
  echo "<li><a href=\"$Patsoptaas_serve_php?mycode_url=$mydir_url/JS/$fname\">$fname(js)</a></li>";
  echo "\n";
}
//
?>

<html>
<head>
<meta charset="utf-8">
</head>
<body>

<h1>ATS2TUTORIAL-CODE</h1>

<p>
The following links are listed to allow for access to some code used in
the on-line book
<a
 href="http://ats-lang.sourceforge.net/DOCUMENT/ATS2TUTORIAL/HTML/book1.html"
>Introduction to Programming in ATS</a>.
If the name of a file mentioned in a link is followed by the symbol (c),
then the code contained in the file can be typechecked on-line. If the name
is followed by (js), then the code can be first typechecked and then compiled
into Javascript for execution in the browser.
</p>

<hr></hr>

<h1>Basics Tutorial Topics</h1>

<hr></hr>

<h2>Bracket Overloading</h2>
<ul>
<?php listitem_gen('chap_dotoverld.dats'); ?>
</ul>

<h2>Dot-Symbol Overloading</h2>
<ul>
<?php listitem_gen('chap_brktoverld.dats'); ?>
</ul>

<h2>Recursion</h2>
<ul>
<?php listitem_gen('chap_recursion.dats'); ?>
</ul>

<h2>Datatypes</h2>
<ul>
<?php listitem_gen('chap_datatypes.dats'); ?>
</ul>

<h2>Exceptions</h2>
<ul>
<?php listitem_gen('chap_exception.dats'); ?>
</ul>

<h2>References</h2>
<ul>
<?php listitem_gen('chap_reference.dats'); ?>
</ul>

<h2>Persistent Arrays</h2>
<ul>
<?php listitem_gen('chap_arrayref.dats'); ?>
</ul>

<h2>Persistent Arrays-with-size</h2>
<ul>
<?php listitem_gen('chap_arrszref.dats'); ?>
</ul>

<h2>Persistent Matrices</h2>
<ul>
<?php listitem_gen('chap_matrixref.dats'); ?>
</ul>

<h2>Persistent Matrices-with-size</h2>
<ul>
<?php listitem_gen('chap_mtrxszref.dats'); ?>
</ul>

<h2>Tail-Recursion</h2>
<ul>
<?php listitem_gen('chap_tailrec.dats'); ?>
</ul>

<h2>Higher-Order Functions</h2>
<ul>
<?php listitem_gen('chap_hordfun.dats'); ?>
</ul>

<h2>Stream-Based Lazy Evaluation</h2>
<ul>
<?php listitem_gen('chap_stream.dats'); ?>
</ul>

<hr></hr>

<h1>Advanced Tutorial Topics</h1>

<hr></hr>

<h2>Extvar-Declaration</h2>
<ul>
<?php listitem_gen('chap_extvar.dats'); ?>
</ul>

<h2>Linear Closure-Functions</h2>
<ul>
<?php listitem_gen('chap_cloptr.dats'); ?>
</ul>

<h2>Linear Stream-Based Lazy Evaluation</h2>
<ul>
<?php listitem_gen('chap_stream_vt.dats'); ?>
</ul>

<hr></hr>

<table>
<tr>
<td style="width: 100%;">
This page is created with
<a href="http://www.ats-lang.org">ATS</a>
by
<a href="http://www.cs.bu.edu/~hwxi/">Hongwei Xi</a>
and also maintained by
<a href="http://www.cs.bu.edu/~hwxi/">Hongwei Xi</a>.
</td>
<td style="width: 0%;">
<a href="http://sourceforge.net">
<img
src="http://sflogo.sourceforge.net/sflogo.php?group_id=205722&amp;type=2"
width="120"
height="36"
alt="SourceForge.net Logo"
/>
</a>
</td>
</tr>
</table>

</body>
</html>

<?php /* end of [ATS2TUTORIAL-CODE.php] */ ?>

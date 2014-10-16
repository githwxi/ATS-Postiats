<!DOCTYPE html>

<?php
//
$mydir_url=
'http://www.ats-lang.org/DOCUMENT/INT2PROGINATS/CODE';
//
$Patsoptaas_serve_php=
'http://atslangweb-postiats.rhcloud.com/SERVER/MYCODE/Patsoptaas_serve.php';
//
function
listitem_gen($CHAP, $fname)
{
  global $mydir_url;
  global $Patsoptaas_serve_php;
  echo "\n";
  echo "<li><a href=\"$Patsoptaas_serve_php?mycode_url=$mydir_url/$CHAP/$fname\">$fname(c)</a></li>";
  echo "\n";
}
function
listitem_gen2($CHAP, $fname)
{
  global $mydir_url;
  global $Patsoptaas_serve_php;
  echo "\n";
  echo "<li><a href=\"$Patsoptaas_serve_php?mycode_url=$mydir_url/$CHAP/JS/$fname\">$fname(js)</a></li>";
  echo "\n";
}
//
?>

<html>
<head>
<meta charset="utf-8">
</head>
<body>

<h1>INT2PROGINATS-CODE</h1>

<hr></hr>

<h2>Chapter: Start</h2>
<ul>
<?php listitem_gen('CHAP_START', 'hello.dats'); ?>
<?php listitem_gen2('CHAP_START', 'hello.dats'); ?>
<?php listitem_gen('CHAP_START', 'queens.dats'); ?>
<?php listitem_gen2('CHAP_START', 'queens.dats'); ?>
</ul>

<hr></hr>

<h2>Chapter: Elements of Programming</h2>
<ul>
<?php listitem_gen('CHAP_PROGELEM', 'misc.dats'); ?>
</ul>

<hr></hr>

<h2>Chapter: Functions</h2>
<ul>
<?php listitem_gen('CHAP_FUNCTION', 'misc.dats'); ?>
<?php listitem_gen('CHAP_FUNCTION', 'acker.dats'); ?>
<?php listitem_gen2('CHAP_FUNCTION', 'acker.dats'); ?>
<?php listitem_gen('CHAP_FUNCTION', 'bsearch.dats'); ?>
<?php listitem_gen2('CHAP_FUNCTION', 'bsearch.dats'); ?>
<?php listitem_gen('CHAP_FUNCTION', 'coinchange.dats'); ?>
<?php listitem_gen2('CHAP_FUNCTION', 'coinchange.dats'); ?>
<?php listitem_gen('CHAP_FUNCTION', 'queens.dats'); ?>
<?php listitem_gen2('CHAP_FUNCTION', 'queens.dats'); ?>
<?php listitem_gen('CHAP_FUNCTION', 'twice.dats'); ?>
<?php listitem_gen2('CHAP_FUNCTION', 'twice.dats'); ?>
</ul>

<hr></hr>

<h2>Chapter: Datatypes</h2>
<ul>
<?php listitem_gen('CHAP_DATATYPE', 'misc.dats'); ?>
<?php listitem_gen('CHAP_DATATYPE', 'intexp.dats'); ?>
<?php listitem_gen2('CHAP_DATATYPE', 'intexp.dats'); ?>
</ul>

<hr></hr>

<h2>Chapter: Parametric Polymorphism</h2>
<ul>
<?php listitem_gen2('CHAP_POLYMORPH', 'misc.dats'); ?>
<?php listitem_gen2('CHAP_POLYMORPH', 'listfuns.dats'); ?>
<?php listitem_gen2('CHAP_POLYMORPH', 'mergesort.dats'); ?>
</ul>

<hr></hr>

<h2>Chapter: Effectful Programming Features</h2>
<ul>
<?php listitem_gen('CHAP_EFFECTFUL', 'misc.dats'); ?>
<?php listitem_gen('CHAP_EFFECTFUL', 'counter.dats'); ?>
<?php listitem_gen2('CHAP_EFFECTFUL', 'counter.dats'); ?>
<?php listitem_gen('CHAP_EFFECTFUL', 'hello.dats'); ?>
<?php listitem_gen('CHAP_EFFECTFUL', 'echoline.dats'); ?>
<!--
<?php listitem_gen('CHAP_EFFECTFUL', 'insort.dats'); ?>
-->
<?php listitem_gen('CHAP_EFFECTFUL', 'permord.dats'); ?>
<?php listitem_gen('CHAP_EFFECTFUL', 'montecarlo.dats'); ?>
<!--
<?php listitem_gen('CHAP_EFFECTFUL', 'brauntest.dats'); ?>
-->
</ul>

<hr></hr>

<h2>Chapter: Introduction to Dependent Types</h2>
<ul>
<?php listitem_gen('CHAP_DEPTYPES', 'misc.dats'); ?>
<!--
<?php listitem_gen('CHAP_DEPTYPES', 'bsearch_arr.dats'); ?>
-->
</ul>

<hr></hr>

<h2>Chapter: Datatype Refinement</h2>
<ul>
<?php listitem_gen('CHAP_DEPDTREF', 'misc.dats'); ?>
<?php listitem_gen('CHAP_DEPDTREF', 'listfuns.dats'); ?>
<?php listitem_gen('CHAP_DEPDTREF', 'mergesort.dats'); ?>
<?php listitem_gen('CHAP_DEPDTREF', 'rbtree.dats'); ?>
</ul>

<hr></hr>

<h2>Chapter: Theorem-Proving in ATS/LF</h2>
<ul>
<?php listitem_gen('CHAP_THMPRVING', 'misc.dats'); ?>
<?php listitem_gen('CHAP_THMPRVING', 'tree.dats'); ?>
<?php listitem_gen('CHAP_THMPRVING', 'brauntree.dats'); ?>
</ul>

<hr></hr>

<h2>Chapter: Programming with Theorem-Proving</h2>
<ul>
<?php listitem_gen('CHAP_PRGTHMPRV', 'misc.dats'); ?>
<?php listitem_gen('CHAP_PRGTHMPRV', 'ifact.dats'); ?>
<?php listitem_gen2('CHAP_PRGTHMPRV', 'ifact.dats'); ?>
<?php listitem_gen('CHAP_PRGTHMPRV', 'ifact23.dats'); ?>
<?php listitem_gen2('CHAP_PRGTHMPRV', 'ifact23.dats'); ?>
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
<td style="width: 0%;"><!--pushed to the right-->
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

<?php /* end of [INT2PROGINATS-CODE.php] */ ?>

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

<h2>Chapter: Functions</h2>
<ul>
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
<?php listitem_gen('CHAP_DATATYPE', 'intexp.dats'); ?>
<?php listitem_gen2('CHAP_DATATYPE', 'intexp.dats'); ?>
</ul>

<hr></hr>

<h2>Chapter: Parametric Polymorphism</h2>
<ul>
<?php listitem_gen2('CHAP_POLYMORPH', 'mergesort.dats'); ?>
</ul>

<hr></hr>

</body>
</html>

<?php /* end of [INT2PROGINATS-CODE.php] */ ?>

<?php
//
// HX-2014-09:
// for local use
//
$MYPHPDIR = "SERVER/mycode";
//
include
"./$MYPHPDIR/libatscc2php_all.php";
//
include "./$MYPHPDIR/basics_cats.php";
//
include "./$MYPHPDIR/basics_dats.php";
include "./$MYPHPDIR/atslangweb_utils_dats.php";
//
/* ****** ****** */
//
function
atslangweb__pats2xhtmlize_static
  ($mycode)
{
//
  $mycode_res =
  atslangweb__pats2xhtml_static_code_0_($mycode);
//
  $status =
  $mycode_res[0];
  if($status===0)
  {
    echo $mycode_res[1];
  } else {
    echo "Pats2xhtmlization failed\n"; echo $mycode_res[1];
  } // end of [if]
  return $status;
//
} /* end of [atslangweb__pats2xhtmlize_static] */
//
function
atslangweb__pats2xhtmlize_dynamic
  ($mycode)
{
//
  $mycode_res =
  atslangweb__pats2xhtml_dynamic_code_0_($mycode);
//
  $status =
  $mycode_res[0];
  if($status===0)
  {
    echo $mycode_res[1];
  } else {
    echo "<b>Pats2xhtmlization failed</b><br>"; echo $mycode_res[1];
  } // end of [if]
  return $status;
//
} /* end of [atslangweb__pats2xhtmlize_dynamic] */
//
?>

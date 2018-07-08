<?php
//
// HX-2014-09:
// It is for local use
// HX-2016-07:
// For instance, the code in Example.php
// is syntax-hilited by calling the following:
//
// atslangweb_pats2xhtmlize_static
// atslangweb_pats2xhtmlize_dynamic
//
//
$MYPHPDIR = "SERVER/MYCODE";
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
atslangweb_pats2xhtmlize_static
  ($mycode)
{
//
  $mycode_res =
  atslangweb_pats2xhtml_eval_code_0_(0, $mycode);
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
} /* end of [atslangweb_pats2xhtmlize_static] */
//
function
atslangweb_pats2xhtmlize_dynamic
  ($mycode)
{
//
  $mycode_res =
  atslangweb_pats2xhtml_eval_code_0_(1, $mycode);
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
} /* end of [atslangweb_pats2xhtmlize_dynamic] */
//
?>

<?php

/*
******
*
* HX-2014-08:
* for PHP code
* translated from ATS
*
******
*/

/*
******
* beg of [PHParref_cats.php]
******
*/

/* ****** ****** */
//
function
ats2phppre_PHParray_nil
  () { return array(); }
function
ats2phppre_PHParray_sing
  ($x) { return array($x); }
function
ats2phppre_PHParray_pair
  ($x1, $x2)
  { return array($x1, $x2); }
//
/* ****** ****** */

function
ats2phppre_PHParray_make_elt
  ($asz, $x0)
{
  return array_fill(0, $asz, $x0);
}
  
/* ****** ****** */
//
function
ats2phppre_PHParray_size
  ($A) { return count($A) ; }
//
/* ****** ****** */
//
function
ats2phppre_PHParray_get_at
  ($A, $i) { return $A[$i] ; }
//
/* ****** ****** */
//
function
ats2phppre_PHParray_of_string
  ($str) { return (str_split($str)); }
//
/* ****** ****** */

function
ats2phppre_PHParray_join
  ($A) { return (implode($A)); }
function
ats2phppre_PHParray_join_sep
  ($A, $sep) { return (implode($A, $sep)); }

/* ****** ****** */

/* end of [PHParray_cats.php] */

?>

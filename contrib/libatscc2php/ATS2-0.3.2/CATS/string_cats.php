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
* beg of [string_cats.php]
******
*/

/* ****** ****** */
//
function
ats2phppre_strval
  ($x) { return strval($x); }
//
/* ****** ****** */
//
function
ats2phppre_strlen
  ($x) { return strlen($x); }
function
ats2phppre_string_length
  ($x) { return strlen($x); }
//
/* ****** ****** */

function
ats2phppre_lt_string_string
  ($x1, $x2)
{
  return (strcmp($x1, $x2) < 0) ;
}
function
ats2phppre_lte_string_string
  ($x1, $x2)
{
  return (strcmp($x1, $x2) <= 0) ;
}

/* ****** ****** */

function
ats2phppre_gt_string_string
  ($x1, $x2)
{
  return (strcmp($x1, $x2) > 0) ;
}
function
ats2phppre_gte_string_string
  ($x1, $x2)
{
  return (strcmp($x1, $x2) >= 0) ;
}

/* ****** ****** */

function
ats2phppre_eq_string_string
  ($x1, $x2)
{
  return (strcmp($x1, $x2) === 0) ;
}
function
ats2phppre_neq_string_string
  ($x1, $x2)
{
  return (strcmp($x1, $x2) !== 0) ;
}

/* ****** ****** */
//
function
compare_string_string
  ($x1, $x2)
{
  $sgn = strcmp($x1, $x2) ;
  return (($sgn < 0)? -1 : (($sgn > 0) ? 1 : 0));
}
//
/* ****** ****** */

/* end of [string_cats.php] */

?>

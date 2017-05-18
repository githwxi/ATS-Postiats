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
* beg of [PHPref_cats.php]
******
*/

/* ****** ****** */

class
PHPref {
//
// HX: payload
//
   public $value ;
} /* end of [class] */

/* ****** ****** */
//
function
ats2phppre_PHPref_new
  ($x0)
{
  $res = new PHPref;
  $res->value = $x0; return $res;
}
function
ats2phppre_PHPref_make_elt
  ($x0)
  { return PHPref_new($x0); }
//
/* ****** ****** */
//
function
ats2phppre_PHPref_get_elt
  ($A)
  { return $A->value ; }
//
function
ats2phppre_PHPref_set_elt
  ($A, $x)
  { $A->value = $x; return ; }
//
/* ****** ****** */

/* end of [PHPref_cats.php] */

?>

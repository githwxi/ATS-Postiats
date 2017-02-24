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

class
PHParref {
  public $array ; // this is a PHParray
} /* end of [class] */

/* ****** ****** */
//
function
PHParref_nil() {
  $res = new PHParref; $res->array = array(); return $res;
}
//
function
PHParref_sing($x) {
  $res = new PHParref; $res->array = array($x); return $res;
}
//
function
PHParref_pair($x1, $x2) {
  $res = new PHParref; $res->array = array($x1, x2); return $res;
}
//
/* ****** ****** */

function
PHParref_size($A) { return count($A->array) ; }
function
PHParref_length($A) { return count($A->array) ; }

/* ****** ****** */
//
function
PHParref_get_at($A, $i)
{
  return $A->array[$i] ;
}
//
function
PHParref_set_at($A, $i, $x)
{
  $A->array[$i] = $x; return ;
}
//
/* ****** ****** */
//
function
PHParref_unset($A, $k)
  { unset($A->array[$k]); return; }
//
/* ****** ****** */
//
function
PHParref_extend($A, $x) { $A->array[] = $x; return; }
//
/* ****** ****** */

function
PHParref_copy ($A)
{
  $A2 = new PHParref;
  $A2->array = $A->array; return $A2;
}

/* ****** ****** */

function
PHParref_values($A)
{
  $A2 = new PHParref;
  $A2->array = array_values($A->array); return $A2;
}

/* ****** ****** */

/* end of [PHParref_cats.php] */

?>

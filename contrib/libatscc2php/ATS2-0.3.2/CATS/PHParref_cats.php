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
//
// HX: PHParray
//
  public $array ;
} /* end of [class] */

/* ****** ****** */
//
function
ats2phppre_PHParref_nil
  ()
{
  $res = new PHParref;
  $res->array = array();
  return $res;
}
//
function
ats2phppre_PHParref_sing
  ($x)
{
  $res = new PHParref;
  $res->array = array($x);
  return $res;
}
//
function
ats2phppre_PHParref_pair
  ($x1, $x2)
{
  $res = new PHParref;
  $res->array = array($x1, x2);
  return $res;
}
//
/* ****** ****** */

function
ats2phppre_PHParref_size
  ($A)
{
  return count($A->array) ;
}
function
ats2phppre_PHParref_length
  ($A)
{
  return count($A->array) ;
}
//
/* ****** ****** */
//
function
ats2phppre_PHParref_get_at
  ($A, $i)
  { return $A->array[$i] ; }
//
function
ats2phppre_PHParref_set_at
  ($A, $i, $x)
{
  $A->array[$i] = $x; return;
}
//
/* ****** ****** */
//
function
ats2phppre_PHParref_unset
  ($A, $k)
{
  unset($A->array[$k]); return;
}
//
/* ****** ****** */
//
function
ats2phppre_PHParref_extend
  ($A, $x)
{
  $A->array[] = $x; return;
}
//
/* ****** ****** */

function
ats2phppre_PHParref_copy
  ($A)
{
  $A2 = new PHParref;
  $A2->array = $A->array; return $A2;
}

/* ****** ****** */

function
ats2phppre_PHParref_values
  ($A)
{
  $A2 = new PHParref;
  $A2->array = array_values($A->array);
  return $A2; // end-of-body
}

/* ****** ****** */

/* end of [PHParref_cats.php] */

?>

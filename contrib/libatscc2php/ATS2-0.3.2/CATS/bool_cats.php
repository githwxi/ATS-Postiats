<?php

/*
******
*
* HX-2014-11:
* for PHP code
* translated from ATS
*
******
*/

/*
******
* beg of [bool_cats.php]
******
*/

/* ****** ****** */
//
function
ats2phppre_boolize($x) { return ($x ? true : false); }
function
ats2phppre_boolize_vt($x) { return ($x ? true : false); }
//
/* ****** ****** */

function
ats2phppre_neg_bool0($x) { return ($x ? false : true); }
function
ats2phppre_neg_bool1($x) { return ($x ? false : true); }

/* ****** ****** */

function
ats2phppre_add_bool0_bool0($x, $y) { return ($x || $y); }
function
ats2phppre_add_bool0_bool1($x, $y) { return ($x || $y); }
function
ats2phppre_add_bool1_bool0($x, $y) { return ($x || $y); }
function
ats2phppre_add_bool1_bool1($x, $y) { return ($x || $y); }

/* ****** ****** */

function
ats2phppre_mul_bool0_bool0($x, $y) { return ($x && $y); }
function
ats2phppre_mul_bool0_bool1($x, $y) { return ($x && $y); }
function
ats2phppre_mul_bool1_bool0($x, $y) { return ($x && $y); }
function
ats2phppre_mul_bool1_bool1($x, $y) { return ($x && $y); }

/* ****** ****** */
//
function
ats2phppre_eq_bool0_bool0($x, $y) { return ($x === $y); }
function
ats2phppre_eq_bool1_bool1($x, $y) { return ($x === $y); }
//
function
ats2phppre_neq_bool0_bool0($x, $y) { return ($x !== $y); }
function
ats2phppre_neq_bool1_bool1($x, $y) { return ($x !== $y); }
//
/* ****** ****** */

function
ats2phppre_bool2int0($x) { return ($x ? 1 : 0); }
function
ats2phppre_bool2int1($x) { return ($x ? 1 : 0); }

/* ****** ****** */

function
ats2phppre_int2bool20($x) { return ($x !== 0 ? true : false); }

/* ****** ****** */

/* end of [bool_cats.php] */

?>

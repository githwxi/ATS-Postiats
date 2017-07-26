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
* beg of [float_cats.php]
******
*/

/* ****** ****** */
//
function
ats2phppre_double2int($x) { return intval($x); }
function
ats2phppre_int_of_double($x) { return intval($x); }
//
/* ****** ****** */
//
function
ats2phppre_int2double($x) { return floatval($x); }
function
ats2phppre_double_of_int($x) { return floatval($x); }
//
/* ****** ****** */

function
ats2phppre_abs_double($x) { return abs($x); }
function
ats2phppre_neg_double($x) { return ( -$x ); }

/* ****** ****** */

function
ats2phppre_succ_double($x) { return ($x + 1); }
function
ats2phppre_pred_double($x) { return ($x - 1); }

/* ****** ****** */

function
ats2phppre_sqrt_double($x) { return sqrt($x); }
function
ats2phppre_cbrt_double($x) { return pow($x, 1/3); }

/* ****** ****** */

function
ats2phppre_add_double_int($x, $y) { return ($x + $y); }
function
ats2phppre_sub_double_int($x, $y) { return ($x - $y); }
function
ats2phppre_mul_double_int($x, $y) { return ($x * $y); }
function
ats2phppre_div_double_int($x, $y) { return ($x / $y); }

/* ****** ****** */

function
ats2phppre_add_int_double($x, $y) { return ($x + $y); }
function
ats2phppre_sub_int_double($x, $y) { return ($x - $y); }
function
ats2phppre_mul_int_double($x, $y) { return ($x * $y); }
function
ats2phppre_div_int_double($x, $y) { return ($x / $y); }

/* ****** ****** */

function
ats2phppre_add_double_double($x, $y) { return ($x + $y); }
function
ats2phppre_sub_double_double($x, $y) { return ($x - $y); }
function
ats2phppre_mul_double_double($x, $y) { return ($x * $y); }
function
ats2phppre_div_double_double($x, $y) { return ($x / $y); }

/* ****** ****** */

function
ats2phppre_lt_double_double($x, $y) { return ($x < $y); }
function
ats2phppre_lte_double_double($x, $y) { return ($x <= $y); }
function
ats2phppre_gt_double_double($x, $y) { return ($x > $y); }
function
ats2phppre_gte_double_double($x, $y) { return ($x >= $y); }
function
ats2phppre_eq_double_double($x, $y) { return ($x === $y); }
function
ats2phppre_neq_double_double($x, $y) { return ($x !== $y); }

/* ****** ****** */
//
function
ats2phppre_max_double_double($x, $y) { return max($x, $y); }
function
ats2phppre_min_double_double($x, $y) { return min($x, $y); }
//
/* ****** ****** */

function
ats2phppre_exp_int($n) { return exp($n); }
function
ats2phppre_exp_double($n) { return exp($n); }

/* ****** ****** */

function
ats2phppre_log_double($p) { return log($p); }
function
ats2phppre_log_double_double($p, $base) { return log($p, $base); }

/* ****** ****** */

function
ats2phppre_pow_double_int($base, $n) { return pow($base, $n); }
function
ats2phppre_pow_double_double($base, $n) { return pow($base, $n); }

/* ****** ****** */

/* end of [float_cats.php] */

?>

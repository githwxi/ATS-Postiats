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
* beg of [basics_cats.php]
******
*/

/* ****** ****** */

function
ATSCKiseqz($x) { return ($x === 0); }
function
ATSCKisneqz($x) { return ($x !== 0); }

/* ****** ****** */

function
ATSCKptrisnull($xs) { return ($xs === NULL) ; }
function
ATSCKptriscons($xs) { return ($xs !== NULL) ; }

/* ****** ****** */

function
ATSCKpat_int($tmp, $given) { return ($tmp === $given) ; }
function
ATSCKpat_bool($tmp, $given) { return ($tmp === $given) ; }
function
ATSCKpat_char($tmp, $given) { return ($tmp === $given) ; }
function
ATSCKpat_float($tmp, $given) { return ($tmp === $given) ; }

/* ****** ****** */

function
ATSCKpat_con0($con, $tag) { return ($con === $tag) ; }
function
ATSCKpat_con1($con, $tag) { return ($con[0] === $tag) ; }

/* ****** ****** */

function
ats2phppre_echo_obj($x) { echo($x); return; }

/* ****** ****** */
/*
//
function
ats2phppre_echo0_obj() { return; }
function
ats2phppre_echo1_obj($x1) { echo($x1); return; }
function
ats2phppre_echo2_obj($x1, $x2) { echo $x1, $x2; return; }
//
function
ats2phppre_echo3_obj
  ($x1, $x2, $x3) { echo $x1, $x2, $x3; return; }
function
ats2phppre_echo4_obj
  ($x1, $x2, $x3, $x4) { echo $x1, $x2, $x3, $x4; return; }
function
ats2phppre_echo5_obj
  ($x1, $x2, $x3, $x4, $x5) { echo $x1, $x2, $x3, $x4, $x5; return; }
function
ats2phppre_echo6_obj
  ($x1, $x2, $x3, $x4, $x5, $x6) { echo $x1, $x2, $x3, $x4, $x5, $x6; return; }
//
function
ats2phppre_echo7_obj
  ($x1, $x2, $x3, $x4, $x5, $x6, $x7)
  { echo $x1, $x2, $x3, $x4, $x5, $x6, $x7; return; }
function
ats2phppre_echo8_obj
  ($x1, $x2, $x3, $x4, $x5, $x6, $x7, $x8)
  { echo $x1, $x2, $x3, $x4, $x5, $x6, $x7, $x8; return; }
//
*/
/* ****** ****** */
//
function
ats2phppre_print_obj($x) { print($x); return; }
//
function
ats2phppre_print_r_obj($x) { print_r($x); return; }
//
/* ****** ****** */

function
ats2phppre_print_newline() { ats2phppre_fprint_newline(STDOUT); }
function
ats2phppre_prerr_newline() { ats2phppre_fprint_newline(STDERR); }
function
ats2phppre_fprint_newline($out) { fprintf($out, "\n"); fflush($out); return; }

/* ****** ****** */

function
ats2phppre_lazy2cloref($lazyval) { return $lazyval[1]; }

/* ****** ****** */
//
function
ats2phppre_assert_bool0($tfv) { if (!$tfv) exit("**EXIT**"); return; }
function
ats2phppre_assert_bool1($tfv) { if (!$tfv) exit("**EXIT**"); return; }
//
/* ****** ****** */
//
function
ats2phppre_assert_errmsg_bool0($tfv, $errmsg)
{
  if (!$tfv) { fprintf(STDERR, "%s", $errmsg); exit(errmsg); }; return;
}
function
ats2phppre_assert_errmsg_bool1($tfv, $errmsg)
{
  if (!$tfv) { fprintf(STDERR, "%s", $errmsg); exit(errmsg); }; return;
}
//
/* ****** ****** */

/* end of [basics_cats.php] */

?>
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
* beg of [integer_cats.php]
******
*/

/* ****** ****** */

function
ats2phppre_abs_int0($x) { return abs($x); }
function
ats2phppre_neg_int0($x) { return ( -$x ); }

/* ****** ****** */

function
ats2phppre_succ_int0($x) { return ($x + 1); }
function
ats2phppre_pred_int0($x) { return ($x - 1); }

/* ****** ****** */

function
ats2phppre_add_int0_int0($x, $y) { return ($x + $y); }
function
ats2phppre_sub_int0_int0($x, $y) { return ($x - $y); }
function
ats2phppre_mul_int0_int0($x, $y) { return ($x * $y); }

/* ****** ****** */

function
ats2phppre_add_int1_int1($x, $y) { return ($x + $y); }
function
ats2phppre_sub_int1_int1($x, $y) { return ($x - $y); }
function
ats2phppre_mul_int1_int1($x, $y) { return ($x * $y); }

/* ****** ****** */

function
ats2phppre_lt_int0_int0($x, $y) { return ($x < $y); }
function
ats2phppre_lte_int0_int0($x, $y) { return ($x <= $y); }
function
ats2phppre_gt_int0_int0($x, $y) { return ($x > $y); }
function
ats2phppre_gte_int0_int0($x, $y) { return ($x >= $y); }
function
ats2phppre_eq_int0_int0($x, $y) { return ($x === $y); }
function
ats2phppre_neq_int0_int0($x, $y) { return ($x !== $y); }

/* ****** ****** */

function
ats2phppre_lt_int1_int1($x, $y) { return ($x < $y); }
function
ats2phppre_lte_int1_int1($x, $y) { return ($x <= $y); }
function
ats2phppre_gt_int1_int1($x, $y) { return ($x > $y); }
function
ats2phppre_gte_int1_int1($x, $y) { return ($x >= $y); }
function
ats2phppre_eq_int1_int1($x, $y) { return ($x === $y); }
function
ats2phppre_neq_int1_int1($x, $y) { return ($x !== $y); }

/* ****** ****** */

function
ats2phppre_print_int($x) { fprintf(STDOUT, "%d", $x); return; }
function
ats2phppre_prerr_int($x) { fprintf(STDERR, "%d", $x); return; }
function
ats2phppre_fprint_int($out, $x) { fprintf($out, "%d", $x); return; }

/* ****** ****** */

/* end of [integer_cats.php] */

?>
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

function
ats2phppre_print_double($x) { fprintf(STDOUT, "%f", $x); return; }
function
ats2phppre_prerr_double($x) { fprintf(STDERR, "%f", $x); return; }
function
ats2phppre_fprint_double($out, $x) { fprintf($out, "%f", $x); return; }

/* ****** ****** */

/* end of [float_cats.php] */

?>
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

function
ats2phppre_print_string($x) { fprintf(STDOUT, "%s", $x); return ; }
function
ats2phppre_prerr_string($x) { fprintf(STDERR, "%s", $x); return ; }
function
ats2phppre_fprint_string($out, $x) { fprintf($out, "%s", $x); return ; }

/* ****** ****** */

/* end of [string_cats.php] */

?>
<?php

/*
******
*
* HX-2014-09:
* for PHP code
* translated from ATS
*
******
*/

/*
******
* beg of [filebas_cats.php]
******
*/

/* ****** ****** */
//
/*
$ats2phppre_stdin = STDIN;
$ats2phppre_stdout = STDOUT;
$ats2phppre_stderr = STDERR;
*/
//
/* ****** ****** */

/* end of [filebas_cats.php] */

?>
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
  public $value ; // this is the payload
} /* end of [class] */

/* ****** ****** */
//
function
PHPref_new($x0) {
  $res = new PHPref;
  $res->value = $x0; return $res;
}
function
PHPref_make_elt($x0) { return PHPref_new($x0); }
//
/* ****** ****** */
//
function
PHPref_get_elt($A) { return $A->value ; }
//
function
PHPref_set_elt($A, $x) { $A->value = $x; return ; }
//
/* ****** ****** */

/* end of [PHPref_cats.php] */

?>
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
PHParray_nil() { return array(); }
function
PHParray_sing($x) { return array($x); }
function
PHParray_pair($x1, $x2) { return array($x1, $x2); }
//
/* ****** ****** */

/* end of [PHParray_cats.php] */

?>
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
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2014-9-19: 21h: 5m
**
*/

function
ats2phppre_list_length($arg0)
{
/*
  // $tmpret0
*/
  __patsflab_list_length:
  $tmpret0 = _ats2phppre_list_loop_1($arg0, 0);
  return $tmpret0;
} // end-of-function


function
_ats2phppre_list_loop_1($arg0, $arg1)
{
/*
  // $apy0
  // $apy1
  // $tmpret1
  // $tmp3
  // $tmp4
*/
  __patsflab__ats2phppre_list_loop_1:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab0:
    if(ATSCKptrisnull($arg0)) goto __atstmplab2;
    __atstmplab1:
    $tmp3 = $arg0[1];
    $tmp4 = ats2phppre_add_int1_int1($arg1, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp3;
    $apy1 = $tmp4;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_loop_1;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab2:
    $tmpret1 = $arg1;
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret1;
} // end-of-function


function
ats2phppre_list_append($arg0, $arg1)
{
/*
  // $tmpret5
  // $tmp6
  // $tmp7
  // $tmp8
*/
  __patsflab_list_append:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab3:
    if(ATSCKptriscons($arg0)) goto __atstmplab6;
    __atstmplab4:
    $tmpret5 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab5:
    __atstmplab6:
    $tmp6 = $arg0[0];
    $tmp7 = $arg0[1];
    $tmp8 = ats2phppre_list_append($tmp7, $arg1);
    $tmpret5 = array($tmp6, $tmp8);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret5;
} // end-of-function


function
ats2phppre_list_reverse($arg0)
{
/*
  // $tmpret9
  // $tmp10
*/
  __patsflab_list_reverse:
  $tmp10 = null;
  $tmpret9 = ats2phppre_list_reverse_append($arg0, $tmp10);
  return $tmpret9;
} // end-of-function


function
ats2phppre_list_reverse_append($arg0, $arg1)
{
/*
  // $tmpret11
*/
  __patsflab_list_reverse_append:
  $tmpret11 = _ats2phppre_list_loop_5($arg0, $arg1);
  return $tmpret11;
} // end-of-function


function
_ats2phppre_list_loop_5($arg0, $arg1)
{
/*
  // $apy0
  // $apy1
  // $tmpret12
  // $tmp13
  // $tmp14
  // $tmp15
*/
  __patsflab__ats2phppre_list_loop_5:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab7:
    if(ATSCKptriscons($arg0)) goto __atstmplab10;
    __atstmplab8:
    $tmpret12 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab9:
    __atstmplab10:
    $tmp13 = $arg0[0];
    $tmp14 = $arg0[1];
    $tmp15 = array($tmp13, $arg1);
    // ATStailcalseq_beg
    $apy0 = $tmp14;
    $apy1 = $tmp15;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_loop_5;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret12;
} // end-of-function


function
ats2phppre_list_map($arg0, $arg1)
{
/*
  // $tmpret16
  // $tmp17
  // $tmp18
  // $tmp19
  // $tmp20
*/
  __patsflab_list_map:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab11:
    if(ATSCKptriscons($arg0)) goto __atstmplab14;
    __atstmplab12:
    $tmpret16 = null;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab13:
    __atstmplab14:
    $tmp17 = $arg0[0];
    $tmp18 = $arg0[1];
    $tmp19 = $arg1[0]($arg1, $tmp17);
    $tmp20 = ats2phppre_list_map($tmp18, $arg1);
    $tmpret16 = array($tmp19, $tmp20);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret16;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2014-9-19: 21h: 5m
**
*/

function
ats2phppre_int_repeat_lazy($arg0, $arg1)
{
/*
  // $tmp1
*/
  __patsflab_int_repeat_lazy:
  $tmp1 = ats2phppre_lazy2cloref($arg1);
  ats2phppre_int_repeat_cloref($arg0, $tmp1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_repeat_cloref($arg0, $arg1)
{
/*
*/
  __patsflab_int_repeat_cloref:
  _ats2phppre_intrange_loop_2($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_intrange_loop_2($arg0, $arg1)
{
/*
  // $apy0
  // $apy1
  // $tmp4
  // $tmp6
*/
  __patsflab__ats2phppre_intrange_loop_2:
  $tmp4 = ats2phppre_gt_int0_int0($arg0, 0);
  if($tmp4) {
    $arg1[0]($arg1);
    $tmp6 = ats2phppre_sub_int0_int0($arg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp6;
    $apy1 = $arg1;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_intrange_loop_2;
    // ATStailcalseq_end
  } else {
    // ATSINSmove_void;
  } // endif
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_foreach_cloref($arg0, $arg1)
{
/*
*/
  __patsflab_int_foreach_cloref:
  ats2phppre_intrange_foreach_cloref(0, $arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_intrange_foreach_cloref($arg0, $arg1, $arg2)
{
/*
*/
  __patsflab_intrange_foreach_cloref:
  _ats2phppre_intrange_loop_5($arg0, $arg1, $arg2);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_intrange_loop_5($arg0, $arg1, $arg2)
{
/*
  // $apy0
  // $apy1
  // $apy2
  // $tmp10
  // $tmp12
*/
  __patsflab__ats2phppre_intrange_loop_5:
  $tmp10 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp10) {
    $arg2[0]($arg2, $arg0);
    $tmp12 = ats2phppre_add_int0_int0($arg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp12;
    $apy1 = $arg1;
    $apy2 = $arg2;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    goto __patsflab__ats2phppre_intrange_loop_5;
    // ATStailcalseq_end
  } else {
    // ATSINSmove_void;
  } // endif
  return/*_void*/;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2014-9-19: 21h: 5m
**
*/

function
ats2phppre_ref($arg0)
{
/*
  // $tmpret0
*/
  __patsflab_ref:
  $tmpret0 = ats2phppre_ref_make_elt($arg0);
  return $tmpret0;
} // end-of-function


function
ats2phppre_ref_make_elt($arg0)
{
/*
  // $tmpret1
  // $tmp2
*/
  __patsflab_ref_make_elt:
  $tmp2 = PHPref_new($arg0);
  $tmpret1 = $tmp2;
  return $tmpret1;
} // end-of-function


function
ats2phppre_ref_get_elt($arg0)
{
/*
  // $tmpret3
*/
  __patsflab_ref_get_elt:
  $tmpret3 = PHPref_get_elt($arg0);
  return $tmpret3;
} // end-of-function


function
ats2phppre_ref_set_elt($arg0, $arg1)
{
/*
*/
  __patsflab_ref_set_elt:
  PHPref_set_elt($arg0, $arg1);
  return/*_void*/;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>

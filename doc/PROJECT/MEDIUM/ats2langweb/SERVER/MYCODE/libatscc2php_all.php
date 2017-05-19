
<?php
/*
** Time of Generation:
** Thu May 18 09:11:07 EDT 2017
*/
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
//
function
ATSINScaseof_fail($errmsg)
{
  fprintf(STDERR, "ATSINScaseof_fail:%s", $errmsg); exit(1);
  return;
}
//
function
ATSINSdeadcode_fail()
  { fprintf(STDERR, "ATSINSdeadcode_fail"); exit(1); return; }
//
/* ****** ****** */

function
ATSPMVempty() { return; }

/* ****** ****** */

function
ATSPMVlazyval
  ($thunk)
{
  return array(0, $thunk);
}

/* ****** ****** */

function
ATSPMVlazyval_eval
  (&$lazyval)
{
//
  $flag = $lazyval[0];
//
  if($flag===0)
  {
    $lazyval[0] = 1;
    $mythunk = $lazyval[1];
    $lazyval[1] = $mythunk[0]($mythunk);
  } else {
    $lazyval[0] = $flag + 1;
  } // end of [if]
//
  return ($lazyval[1]);
//
} // end of [ATSPMVlazyval_eval]

/* ****** ****** */
//
function
ATSPMVllazyval($thunk){ return $thunk; }
//
/* ****** ****** */
//
function
ATSPMVllazyval_eval($llazyval)
  { return $llazyval[0]($llazyval, TRUE); }
function
atspre_lazy_vt_free($llazyval)
  { return $llazyval[0]($llazyval, FALSE); }
//
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
function
ats2phppre_div_int0_int0($x, $y) { return intval($x / $y); }
function
ats2phppre_mod_int0_int0($x, $y) { return ($x % $y); }

/* ****** ****** */

function
ats2phppre_add_int1_int1($x, $y) { return ($x + $y); }
function
ats2phppre_sub_int1_int1($x, $y) { return ($x - $y); }
function
ats2phppre_mul_int1_int1($x, $y) { return ($x * $y); }
function
ats2phppre_div_int1_int1($x, $y) { return intval($x / $y); }

/* ****** ****** */
//
function
ats2phppre_mod_int1_int1($x, $y) { return ($x % $y); }
function
ats2phppre_nmod_int1_int1($x, $y) { return ($x % $y); }
//
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

/* end of [integer_cats.php] */

?>
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

function
ats2phppre_neg_bool0($x) { return !($x); }
function
ats2phppre_neg_bool1($x) { return !($x); }

/* ****** ****** */

function
ats2phppre_add_bool0_bool0($x, $y) { return (x || y); }
function
ats2phppre_add_bool0_bool1($x, $y) { return (x || y); }
function
ats2phppre_add_bool1_bool0($x, $y) { return (x || y); }
function
ats2phppre_add_bool1_bool1($x, $y) { return (x || y); }

/* ****** ****** */

function
ats2phppre_mul_bool0_bool0($x, $y) { return (x && y); }
function
ats2phppre_mul_bool0_bool1($x, $y) { return (x && y); }
function
ats2phppre_mul_bool1_bool0($x, $y) { return (x && y); }
function
ats2phppre_mul_bool1_bool1($x, $y) { return (x && y); }

/* ****** ****** */
//
function
ats2phppre_eq_bool0_bool0($x, $y) { return (x === y); }
function
ats2phppre_eq_bool1_bool1($x, $y) { return (x === y); }
//
function
ats2phppre_neq_bool0_bool0($x, $y) { return (x !== y); }
function
ats2phppre_neq_bool1_bool1($x, $y) { return (x !== y); }
//
/* ****** ****** */

function
ats2phppre_bool2int0($x) { return (x ? 1 : 0); }
function
ats2phppre_bool2int1($x) { return (x ? 1 : 0); }

/* ****** ****** */

function
ats2phppre_int2bool20($x) { return (x !== 0 ? true : false); }

/* ****** ****** */

/* end of [bool_cats.php] */

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
ats2phppre_strval($x) { return strval($x); }

/* ****** ****** */

function
ats2phppre_strlen($x) { return strlen($x); }
function
ats2phppre_string_length($x) { return strlen($x); }

/* ****** ****** */

/* end of [string_cats.php] */

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
* beg of [print_cats.php]
******
*/

/* ****** ****** */
//
function
ats2phppre_print_int($x)
  { fprintf(STDOUT, "%d", $x); return; }
function
ats2phppre_prerr_int($x)
  { fprintf(STDERR, "%d", $x); return; }
function
ats2phppre_fprint_int
  ($out, $x) { fprintf($out, "%d", $x); return; }
//
/* ****** ****** */
//
function
ats2phppre_print_bool($x)
{
  ats2phppre_fprint_bool(STDOUT, $x); return;
}
function
ats2phppre_prerr_bool($x)
{
  ats2phppre_fprint_bool(STDERR, $x); return;
}
function
ats2phppre_fprint_bool
  ($out, $x)
{
  if($x) {
    fprintf($out, "true"); return;
  } else {
    fprintf($out, "false"); return;
  } // end of [if]
}
//
/* ****** ****** */
//
function
ats2phppre_print_double($x)
  { fprintf(STDOUT, "%f", $x); return; }
function
ats2phppre_prerr_double($x)
  { fprintf(STDERR, "%f", $x); return; }
function
ats2phppre_fprint_double
  ($out, $x) { fprintf($out, "%f", $x); return; }
//
/* ****** ****** */
//
function
ats2phppre_print_string($x)
  { fprintf(STDOUT, "%s", $x); return ; }
function
ats2phppre_prerr_string($x)
  { fprintf(STDERR, "%s", $x); return ; }
function
ats2phppre_fprint_string
 ($out, $x) { fprintf($out, "%s", $x); return ; }
//
/* ****** ****** */
//
function
ats2phppre_print_obj($x) { print($x); return; }
function
ats2phppre_print_r_obj($x) { print_r($x); return; }
//
/* ****** ****** */

/* end of [print_cats.php] */

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
ats2phppre_PHParray_nil() { return array(); }
function
ats2phppre_PHParray_sing($x) { return array($x); }
function
ats2phppre_PHParray_pair($x1, $x2) { return array($x1, $x2); }
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
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/
function
_ats2phppre_list_patsfun_35__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_35($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_39__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_39($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_42__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_42($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_46__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_46($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_50__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_50($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_54__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_54($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_57__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_57($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_61__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_61($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_65__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_65($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_69__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_69($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_list_patsfun_73__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_73($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_list_patsfun_77__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_77($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_list_patsfun_81__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_81($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_list_patsfun_86__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_86($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_list_patsfun_89__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_89($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_list_patsfun_92__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_92($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_list_patsfun_94__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_list_patsfun_94($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}


function
ats2phppre_list_make_elt($arg0, $arg1)
{
//
  $tmpret2 = NULL;
  $tmp7 = NULL;
//
  __patsflab_list_make_elt:
  $tmp7 = NULL;
  $tmpret2 = _ats2phppre_list_loop_3($arg1, $arg0, $tmp7);
  return $tmpret2;
} // end-of-function


function
_ats2phppre_list_loop_3($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret3 = NULL;
  $tmp4 = NULL;
  $tmp5 = NULL;
  $tmp6 = NULL;
//
  __patsflab__ats2phppre_list_loop_3:
  $tmp4 = ats2phppre_gt_int1_int1($arg0, 0);
  if($tmp4) {
    $tmp5 = ats2phppre_sub_int1_int1($arg0, 1);
    $tmp6 = array($env0, $arg1);
    // ATStailcalseq_beg
    $apy0 = $tmp5;
    $apy1 = $tmp6;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_loop_3;
    // ATStailcalseq_end
  } else {
    $tmpret3 = $arg1;
  } // endif
  return $tmpret3;
} // end-of-function


function
ats2phppre_list_make_intrange_2($arg0, $arg1)
{
//
  $tmpret8 = NULL;
//
  __patsflab_list_make_intrange_2:
  $tmpret8 = ats2phppre_list_make_intrange_3($arg0, $arg1, 1);
  return $tmpret8;
} // end-of-function


function
ats2phppre_list_make_intrange_3($arg0, $arg1, $arg2)
{
//
  $tmpret9 = NULL;
  $tmp20 = NULL;
  $tmp21 = NULL;
  $tmp22 = NULL;
  $tmp23 = NULL;
  $tmp24 = NULL;
  $tmp25 = NULL;
  $tmp26 = NULL;
  $tmp27 = NULL;
  $tmp28 = NULL;
  $tmp29 = NULL;
  $tmp30 = NULL;
  $tmp31 = NULL;
  $tmp32 = NULL;
  $tmp33 = NULL;
  $tmp34 = NULL;
  $tmp35 = NULL;
  $tmp36 = NULL;
  $tmp37 = NULL;
  $tmp38 = NULL;
  $tmp39 = NULL;
  $tmp40 = NULL;
//
  __patsflab_list_make_intrange_3:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab6:
    $tmp20 = ats2phppre_gt_int0_int0($arg2, 0);
    if(!ATSCKpat_bool($tmp20, true)) goto __atstmplab7;
    $tmp21 = ats2phppre_lt_int0_int0($arg0, $arg1);
    if($tmp21) {
      $tmp25 = ats2phppre_sub_int0_int0($arg1, $arg0);
      $tmp24 = ats2phppre_add_int0_int0($tmp25, $arg2);
      $tmp23 = ats2phppre_sub_int0_int0($tmp24, 1);
      $tmp22 = ats2phppre_div_int0_int0($tmp23, $arg2);
      $tmp28 = ats2phppre_sub_int0_int0($tmp22, 1);
      $tmp27 = ats2phppre_mul_int0_int0($tmp28, $arg2);
      $tmp26 = ats2phppre_add_int0_int0($arg0, $tmp27);
      $tmp29 = NULL;
      $tmpret9 = _ats2phppre_list_loop1_6($tmp22, $tmp26, $arg2, $tmp29);
    } else {
      $tmpret9 = NULL;
    } // endif
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab7:
    $tmp30 = ats2phppre_lt_int0_int0($arg2, 0);
    if(!ATSCKpat_bool($tmp30, true)) goto __atstmplab8;
    $tmp31 = ats2phppre_gt_int0_int0($arg0, $arg1);
    if($tmp31) {
      $tmp32 = ats2phppre_neg_int0($arg2);
      $tmp36 = ats2phppre_sub_int0_int0($arg0, $arg1);
      $tmp35 = ats2phppre_add_int0_int0($tmp36, $tmp32);
      $tmp34 = ats2phppre_sub_int0_int0($tmp35, 1);
      $tmp33 = ats2phppre_div_int0_int0($tmp34, $tmp32);
      $tmp39 = ats2phppre_sub_int0_int0($tmp33, 1);
      $tmp38 = ats2phppre_mul_int0_int0($tmp39, $tmp32);
      $tmp37 = ats2phppre_sub_int0_int0($arg0, $tmp38);
      $tmp40 = NULL;
      $tmpret9 = _ats2phppre_list_loop2_7($tmp33, $tmp37, $tmp32, $tmp40);
    } else {
      $tmpret9 = NULL;
    } // endif
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab8:
    $tmpret9 = NULL;
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret9;
} // end-of-function


function
_ats2phppre_list_loop1_6($arg0, $arg1, $arg2, $arg3)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $tmpret10 = NULL;
  $tmp11 = NULL;
  $tmp12 = NULL;
  $tmp13 = NULL;
  $tmp14 = NULL;
//
  __patsflab__ats2phppre_list_loop1_6:
  $tmp11 = ats2phppre_gt_int0_int0($arg0, 0);
  if($tmp11) {
    $tmp12 = ats2phppre_sub_int0_int0($arg0, 1);
    $tmp13 = ats2phppre_sub_int0_int0($arg1, $arg2);
    $tmp14 = array($arg1, $arg3);
    // ATStailcalseq_beg
    $apy0 = $tmp12;
    $apy1 = $tmp13;
    $apy2 = $arg2;
    $apy3 = $tmp14;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    goto __patsflab__ats2phppre_list_loop1_6;
    // ATStailcalseq_end
  } else {
    $tmpret10 = $arg3;
  } // endif
  return $tmpret10;
} // end-of-function


function
_ats2phppre_list_loop2_7($arg0, $arg1, $arg2, $arg3)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $tmpret15 = NULL;
  $tmp16 = NULL;
  $tmp17 = NULL;
  $tmp18 = NULL;
  $tmp19 = NULL;
//
  __patsflab__ats2phppre_list_loop2_7:
  $tmp16 = ats2phppre_gt_int0_int0($arg0, 0);
  if($tmp16) {
    $tmp17 = ats2phppre_sub_int0_int0($arg0, 1);
    $tmp18 = ats2phppre_add_int0_int0($arg1, $arg2);
    $tmp19 = array($arg1, $arg3);
    // ATStailcalseq_beg
    $apy0 = $tmp17;
    $apy1 = $tmp18;
    $apy2 = $arg2;
    $apy3 = $tmp19;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    goto __patsflab__ats2phppre_list_loop2_7;
    // ATStailcalseq_end
  } else {
    $tmpret15 = $arg3;
  } // endif
  return $tmpret15;
} // end-of-function


function
ats2phppre_list_length($arg0)
{
//
  $tmpret52 = NULL;
//
  __patsflab_list_length:
  $tmpret52 = _ats2phppre_list_loop_14($arg0, 0);
  return $tmpret52;
} // end-of-function


function
_ats2phppre_list_loop_14($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret53 = NULL;
  $tmp55 = NULL;
  $tmp56 = NULL;
//
  __patsflab__ats2phppre_list_loop_14:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab13:
    if(ATSCKptriscons($arg0)) goto __atstmplab16;
    __atstmplab14:
    $tmpret53 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab15:
    __atstmplab16:
    $tmp55 = $arg0[1];
    $tmp56 = ats2phppre_add_int1_int1($arg1, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp55;
    $apy1 = $tmp56;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_loop_14;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret53;
} // end-of-function


function
ats2phppre_list_last($arg0)
{
//
  $apy0 = NULL;
  $tmpret57 = NULL;
  $tmp58 = NULL;
  $tmp59 = NULL;
//
  __patsflab_list_last:
  $tmp58 = $arg0[0];
  $tmp59 = $arg0[1];
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab17:
    if(ATSCKptriscons($tmp59)) goto __atstmplab20;
    __atstmplab18:
    $tmpret57 = $tmp58;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab19:
    __atstmplab20:
    // ATStailcalseq_beg
    $apy0 = $tmp59;
    $arg0 = $apy0;
    goto __patsflab_list_last;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret57;
} // end-of-function


function
ats2phppre_list_get_at($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret60 = NULL;
  $tmp61 = NULL;
  $tmp62 = NULL;
  $tmp63 = NULL;
  $tmp64 = NULL;
//
  __patsflab_list_get_at:
  $tmp61 = ats2phppre_eq_int1_int1($arg1, 0);
  if($tmp61) {
    $tmp62 = $arg0[0];
    $tmpret60 = $tmp62;
  } else {
    $tmp63 = $arg0[1];
    $tmp64 = ats2phppre_sub_int1_int1($arg1, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp63;
    $apy1 = $tmp64;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab_list_get_at;
    // ATStailcalseq_end
  } // endif
  return $tmpret60;
} // end-of-function


function
ats2phppre_list_snoc($arg0, $arg1)
{
//
  $tmpret65 = NULL;
  $tmp66 = NULL;
  $tmp67 = NULL;
//
  __patsflab_list_snoc:
  $tmp67 = NULL;
  $tmp66 = array($arg1, $tmp67);
  $tmpret65 = ats2phppre_list_append($arg0, $tmp66);
  return $tmpret65;
} // end-of-function


function
ats2phppre_list_extend($arg0, $arg1)
{
//
  $tmpret68 = NULL;
  $tmp69 = NULL;
  $tmp70 = NULL;
//
  __patsflab_list_extend:
  $tmp70 = NULL;
  $tmp69 = array($arg1, $tmp70);
  $tmpret68 = ats2phppre_list_append($arg0, $tmp69);
  return $tmpret68;
} // end-of-function


function
ats2phppre_list_append($arg0, $arg1)
{
//
  $tmpret71 = NULL;
  $tmp72 = NULL;
  $tmp73 = NULL;
  $tmp74 = NULL;
//
  __patsflab_list_append:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab21:
    if(ATSCKptriscons($arg0)) goto __atstmplab24;
    __atstmplab22:
    $tmpret71 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab23:
    __atstmplab24:
    $tmp72 = $arg0[0];
    $tmp73 = $arg0[1];
    $tmp74 = ats2phppre_list_append($tmp73, $arg1);
    $tmpret71 = array($tmp72, $tmp74);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret71;
} // end-of-function


function
ats2phppre_mul_int_list($arg0, $arg1)
{
//
  $tmpret75 = NULL;
  $tmp80 = NULL;
//
  __patsflab_mul_int_list:
  $tmp80 = NULL;
  $tmpret75 = _ats2phppre_list_loop_21($arg1, $arg0, $tmp80);
  return $tmpret75;
} // end-of-function


function
_ats2phppre_list_loop_21($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret76 = NULL;
  $tmp77 = NULL;
  $tmp78 = NULL;
  $tmp79 = NULL;
//
  __patsflab__ats2phppre_list_loop_21:
  $tmp77 = ats2phppre_gt_int1_int1($arg0, 0);
  if($tmp77) {
    $tmp78 = ats2phppre_sub_int1_int1($arg0, 1);
    $tmp79 = ats2phppre_list_append($env0, $arg1);
    // ATStailcalseq_beg
    $apy0 = $tmp78;
    $apy1 = $tmp79;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_loop_21;
    // ATStailcalseq_end
  } else {
    $tmpret76 = $arg1;
  } // endif
  return $tmpret76;
} // end-of-function


function
ats2phppre_list_reverse($arg0)
{
//
  $tmpret81 = NULL;
  $tmp82 = NULL;
//
  __patsflab_list_reverse:
  $tmp82 = NULL;
  $tmpret81 = ats2phppre_list_reverse_append($arg0, $tmp82);
  return $tmpret81;
} // end-of-function


function
ats2phppre_list_reverse_append($arg0, $arg1)
{
//
  $tmpret83 = NULL;
//
  __patsflab_list_reverse_append:
  $tmpret83 = _ats2phppre_list_loop_24($arg0, $arg1);
  return $tmpret83;
} // end-of-function


function
_ats2phppre_list_loop_24($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret84 = NULL;
  $tmp85 = NULL;
  $tmp86 = NULL;
  $tmp87 = NULL;
//
  __patsflab__ats2phppre_list_loop_24:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab25:
    if(ATSCKptriscons($arg0)) goto __atstmplab28;
    __atstmplab26:
    $tmpret84 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab27:
    __atstmplab28:
    $tmp85 = $arg0[0];
    $tmp86 = $arg0[1];
    $tmp87 = array($tmp85, $arg1);
    // ATStailcalseq_beg
    $apy0 = $tmp86;
    $apy1 = $tmp87;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_loop_24;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret84;
} // end-of-function


function
ats2phppre_list_concat($arg0)
{
//
  $tmpret88 = NULL;
//
  __patsflab_list_concat:
  $tmpret88 = _ats2phppre_list_auxlst_26($arg0);
  return $tmpret88;
} // end-of-function


function
_ats2phppre_list_auxlst_26($arg0)
{
//
  $tmpret89 = NULL;
  $tmp90 = NULL;
  $tmp91 = NULL;
  $tmp92 = NULL;
//
  __patsflab__ats2phppre_list_auxlst_26:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab29:
    if(ATSCKptriscons($arg0)) goto __atstmplab32;
    __atstmplab30:
    $tmpret89 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab31:
    __atstmplab32:
    $tmp90 = $arg0[0];
    $tmp91 = $arg0[1];
    $tmp92 = _ats2phppre_list_auxlst_26($tmp91);
    $tmpret89 = ats2phppre_list_append($tmp90, $tmp92);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret89;
} // end-of-function


function
ats2phppre_list_take($arg0, $arg1)
{
//
  $tmpret93 = NULL;
  $tmp94 = NULL;
  $tmp95 = NULL;
  $tmp96 = NULL;
  $tmp97 = NULL;
  $tmp98 = NULL;
//
  __patsflab_list_take:
  $tmp94 = ats2phppre_gt_int1_int1($arg1, 0);
  if($tmp94) {
    $tmp95 = $arg0[0];
    $tmp96 = $arg0[1];
    $tmp98 = ats2phppre_sub_int1_int1($arg1, 1);
    $tmp97 = ats2phppre_list_take($tmp96, $tmp98);
    $tmpret93 = array($tmp95, $tmp97);
  } else {
    $tmpret93 = NULL;
  } // endif
  return $tmpret93;
} // end-of-function


function
ats2phppre_list_drop($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret99 = NULL;
  $tmp100 = NULL;
  $tmp101 = NULL;
  $tmp102 = NULL;
//
  __patsflab_list_drop:
  $tmp100 = ats2phppre_gt_int1_int1($arg1, 0);
  if($tmp100) {
    $tmp101 = $arg0[1];
    $tmp102 = ats2phppre_sub_int1_int1($arg1, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp101;
    $apy1 = $tmp102;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab_list_drop;
    // ATStailcalseq_end
  } else {
    $tmpret99 = $arg0;
  } // endif
  return $tmpret99;
} // end-of-function


function
ats2phppre_list_split_at($arg0, $arg1)
{
//
  $tmpret103 = NULL;
  $tmp104 = NULL;
  $tmp105 = NULL;
//
  __patsflab_list_split_at:
  $tmp104 = ats2phppre_list_take($arg0, $arg1);
  $tmp105 = ats2phppre_list_drop($arg0, $arg1);
  $tmpret103 = array($tmp104, $tmp105);
  return $tmpret103;
} // end-of-function


function
ats2phppre_list_insert_at($arg0, $arg1, $arg2)
{
//
  $tmpret106 = NULL;
  $tmp107 = NULL;
  $tmp108 = NULL;
  $tmp109 = NULL;
  $tmp110 = NULL;
  $tmp111 = NULL;
//
  __patsflab_list_insert_at:
  $tmp107 = ats2phppre_gt_int1_int1($arg1, 0);
  if($tmp107) {
    $tmp108 = $arg0[0];
    $tmp109 = $arg0[1];
    $tmp111 = ats2phppre_sub_int1_int1($arg1, 1);
    $tmp110 = ats2phppre_list_insert_at($tmp109, $tmp111, $arg2);
    $tmpret106 = array($tmp108, $tmp110);
  } else {
    $tmpret106 = array($arg2, $arg0);
  } // endif
  return $tmpret106;
} // end-of-function


function
ats2phppre_list_remove_at($arg0, $arg1)
{
//
  $tmpret112 = NULL;
  $tmp113 = NULL;
  $tmp114 = NULL;
  $tmp115 = NULL;
  $tmp116 = NULL;
  $tmp117 = NULL;
//
  __patsflab_list_remove_at:
  $tmp113 = $arg0[0];
  $tmp114 = $arg0[1];
  $tmp115 = ats2phppre_gt_int1_int1($arg1, 0);
  if($tmp115) {
    $tmp117 = ats2phppre_sub_int1_int1($arg1, 1);
    $tmp116 = ats2phppre_list_remove_at($tmp114, $tmp117);
    $tmpret112 = array($tmp113, $tmp116);
  } else {
    $tmpret112 = $tmp114;
  } // endif
  return $tmpret112;
} // end-of-function


function
ats2phppre_list_takeout_at($arg0, $arg1)
{
//
  $tmpret118 = NULL;
  $tmp119 = NULL;
  $tmp120 = NULL;
  $tmp121 = NULL;
  $tmp122 = NULL;
  $tmp123 = NULL;
  $tmp124 = NULL;
  $tmp125 = NULL;
  $tmp126 = NULL;
//
  __patsflab_list_takeout_at:
  $tmp119 = $arg0[0];
  $tmp120 = $arg0[1];
  $tmp121 = ats2phppre_gt_int1_int1($arg1, 0);
  if($tmp121) {
    $tmp123 = ats2phppre_sub_int1_int1($arg1, 1);
    $tmp122 = ats2phppre_list_takeout_at($tmp120, $tmp123);
    $tmp124 = $tmp122[0];
    $tmp125 = $tmp122[1];
    $tmp126 = array($tmp119, $tmp125);
    $tmpret118 = array($tmp124, $tmp126);
  } else {
    $tmpret118 = array($tmp119, $tmp120);
  } // endif
  return $tmpret118;
} // end-of-function


function
ats2phppre_list_exists($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret127 = NULL;
  $tmp128 = NULL;
  $tmp129 = NULL;
  $tmp130 = NULL;
//
  __patsflab_list_exists:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab33:
    if(ATSCKptriscons($arg0)) goto __atstmplab36;
    __atstmplab34:
    $tmpret127 = false;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab35:
    __atstmplab36:
    $tmp128 = $arg0[0];
    $tmp129 = $arg0[1];
    $tmp130 = $arg1[0]($arg1, $tmp128);
    if($tmp130) {
      $tmpret127 = true;
    } else {
      // ATStailcalseq_beg
      $apy0 = $tmp129;
      $apy1 = $arg1;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab_list_exists;
      // ATStailcalseq_end
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret127;
} // end-of-function


function
ats2phppre_list_exists_method($arg0)
{
//
  $tmpret131 = NULL;
//
  __patsflab_list_exists_method:
  $tmpret131 = _ats2phppre_list_patsfun_35__closurerize($arg0);
  return $tmpret131;
} // end-of-function


function
_ats2phppre_list_patsfun_35($env0, $arg0)
{
//
  $tmpret132 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_35:
  $tmpret132 = ats2phppre_list_exists($env0, $arg0);
  return $tmpret132;
} // end-of-function


function
ats2phppre_list_iexists($arg0, $arg1)
{
//
  $tmpret133 = NULL;
//
  __patsflab_list_iexists:
  $tmpret133 = _ats2phppre_list_loop_37($arg1, 0, $arg0);
  return $tmpret133;
} // end-of-function


function
_ats2phppre_list_loop_37($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret134 = NULL;
  $tmp135 = NULL;
  $tmp136 = NULL;
  $tmp137 = NULL;
  $tmp138 = NULL;
//
  __patsflab__ats2phppre_list_loop_37:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab37:
    if(ATSCKptriscons($arg1)) goto __atstmplab40;
    __atstmplab38:
    $tmpret134 = false;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab39:
    __atstmplab40:
    $tmp135 = $arg1[0];
    $tmp136 = $arg1[1];
    $tmp137 = $env0[0]($env0, $arg0, $tmp135);
    if($tmp137) {
      $tmpret134 = true;
    } else {
      $tmp138 = ats2phppre_add_int1_int1($arg0, 1);
      // ATStailcalseq_beg
      $apy0 = $tmp138;
      $apy1 = $tmp136;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab__ats2phppre_list_loop_37;
      // ATStailcalseq_end
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret134;
} // end-of-function


function
ats2phppre_list_iexists_method($arg0)
{
//
  $tmpret139 = NULL;
//
  __patsflab_list_iexists_method:
  $tmpret139 = _ats2phppre_list_patsfun_39__closurerize($arg0);
  return $tmpret139;
} // end-of-function


function
_ats2phppre_list_patsfun_39($env0, $arg0)
{
//
  $tmpret140 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_39:
  $tmpret140 = ats2phppre_list_iexists($env0, $arg0);
  return $tmpret140;
} // end-of-function


function
ats2phppre_list_forall($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret141 = NULL;
  $tmp142 = NULL;
  $tmp143 = NULL;
  $tmp144 = NULL;
//
  __patsflab_list_forall:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab41:
    if(ATSCKptriscons($arg0)) goto __atstmplab44;
    __atstmplab42:
    $tmpret141 = true;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab43:
    __atstmplab44:
    $tmp142 = $arg0[0];
    $tmp143 = $arg0[1];
    $tmp144 = $arg1[0]($arg1, $tmp142);
    if($tmp144) {
      // ATStailcalseq_beg
      $apy0 = $tmp143;
      $apy1 = $arg1;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab_list_forall;
      // ATStailcalseq_end
    } else {
      $tmpret141 = false;
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret141;
} // end-of-function


function
ats2phppre_list_forall_method($arg0)
{
//
  $tmpret145 = NULL;
//
  __patsflab_list_forall_method:
  $tmpret145 = _ats2phppre_list_patsfun_42__closurerize($arg0);
  return $tmpret145;
} // end-of-function


function
_ats2phppre_list_patsfun_42($env0, $arg0)
{
//
  $tmpret146 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_42:
  $tmpret146 = ats2phppre_list_forall($env0, $arg0);
  return $tmpret146;
} // end-of-function


function
ats2phppre_list_iforall($arg0, $arg1)
{
//
  $tmpret147 = NULL;
//
  __patsflab_list_iforall:
  $tmpret147 = _ats2phppre_list_loop_44($arg1, 0, $arg0);
  return $tmpret147;
} // end-of-function


function
_ats2phppre_list_loop_44($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret148 = NULL;
  $tmp149 = NULL;
  $tmp150 = NULL;
  $tmp151 = NULL;
  $tmp152 = NULL;
//
  __patsflab__ats2phppre_list_loop_44:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab45:
    if(ATSCKptriscons($arg1)) goto __atstmplab48;
    __atstmplab46:
    $tmpret148 = true;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab47:
    __atstmplab48:
    $tmp149 = $arg1[0];
    $tmp150 = $arg1[1];
    $tmp151 = $env0[0]($env0, $arg0, $tmp149);
    if($tmp151) {
      $tmp152 = ats2phppre_add_int1_int1($arg0, 1);
      // ATStailcalseq_beg
      $apy0 = $tmp152;
      $apy1 = $tmp150;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab__ats2phppre_list_loop_44;
      // ATStailcalseq_end
    } else {
      $tmpret148 = false;
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret148;
} // end-of-function


function
ats2phppre_list_iforall_method($arg0)
{
//
  $tmpret153 = NULL;
//
  __patsflab_list_iforall_method:
  $tmpret153 = _ats2phppre_list_patsfun_46__closurerize($arg0);
  return $tmpret153;
} // end-of-function


function
_ats2phppre_list_patsfun_46($env0, $arg0)
{
//
  $tmpret154 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_46:
  $tmpret154 = ats2phppre_list_iforall($env0, $arg0);
  return $tmpret154;
} // end-of-function


function
ats2phppre_list_app($arg0, $arg1)
{
//
//
  __patsflab_list_app:
  ats2phppre_list_foreach($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_list_foreach($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmp157 = NULL;
  $tmp158 = NULL;
//
  __patsflab_list_foreach:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab49:
    if(ATSCKptriscons($arg0)) goto __atstmplab52;
    __atstmplab50:
    // ATSINSmove_void;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab51:
    __atstmplab52:
    $tmp157 = $arg0[0];
    $tmp158 = $arg0[1];
    $arg1[0]($arg1, $tmp157);
    // ATStailcalseq_beg
    $apy0 = $tmp158;
    $apy1 = $arg1;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab_list_foreach;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2phppre_list_foreach_method($arg0)
{
//
  $tmpret160 = NULL;
//
  __patsflab_list_foreach_method:
  $tmpret160 = _ats2phppre_list_patsfun_50__closurerize($arg0);
  return $tmpret160;
} // end-of-function


function
_ats2phppre_list_patsfun_50($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_list_patsfun_50:
  ats2phppre_list_foreach($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_list_iforeach($arg0, $arg1)
{
//
//
  __patsflab_list_iforeach:
  _ats2phppre_list_aux_52($arg1, 0, $arg0);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_list_aux_52($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmp164 = NULL;
  $tmp165 = NULL;
  $tmp167 = NULL;
//
  __patsflab__ats2phppre_list_aux_52:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab53:
    if(ATSCKptriscons($arg1)) goto __atstmplab56;
    __atstmplab54:
    // ATSINSmove_void;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab55:
    __atstmplab56:
    $tmp164 = $arg1[0];
    $tmp165 = $arg1[1];
    $env0[0]($env0, $arg0, $tmp164);
    $tmp167 = ats2phppre_add_int1_int1($arg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp167;
    $apy1 = $tmp165;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_aux_52;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2phppre_list_iforeach_method($arg0)
{
//
  $tmpret168 = NULL;
//
  __patsflab_list_iforeach_method:
  $tmpret168 = _ats2phppre_list_patsfun_54__closurerize($arg0);
  return $tmpret168;
} // end-of-function


function
_ats2phppre_list_patsfun_54($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_list_patsfun_54:
  ats2phppre_list_iforeach($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_list_rforeach($arg0, $arg1)
{
//
  $tmp171 = NULL;
  $tmp172 = NULL;
//
  __patsflab_list_rforeach:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab57:
    if(ATSCKptriscons($arg0)) goto __atstmplab60;
    __atstmplab58:
    // ATSINSmove_void;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab59:
    __atstmplab60:
    $tmp171 = $arg0[0];
    $tmp172 = $arg0[1];
    ats2phppre_list_rforeach($tmp172, $arg1);
    $arg1[0]($arg1, $tmp171);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2phppre_list_rforeach_method($arg0)
{
//
  $tmpret174 = NULL;
//
  __patsflab_list_rforeach_method:
  $tmpret174 = _ats2phppre_list_patsfun_57__closurerize($arg0);
  return $tmpret174;
} // end-of-function


function
_ats2phppre_list_patsfun_57($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_list_patsfun_57:
  ats2phppre_list_rforeach($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_list_filter($arg0, $arg1)
{
//
  $tmpret176 = NULL;
//
  __patsflab_list_filter:
  $tmpret176 = _ats2phppre_list_aux_59($arg1, $arg0);
  return $tmpret176;
} // end-of-function


function
_ats2phppre_list_aux_59($env0, $arg0)
{
//
  $apy0 = NULL;
  $tmpret177 = NULL;
  $tmp178 = NULL;
  $tmp179 = NULL;
  $tmp180 = NULL;
  $tmp181 = NULL;
//
  __patsflab__ats2phppre_list_aux_59:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab61:
    if(ATSCKptriscons($arg0)) goto __atstmplab64;
    __atstmplab62:
    $tmpret177 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab63:
    __atstmplab64:
    $tmp178 = $arg0[0];
    $tmp179 = $arg0[1];
    $tmp180 = $env0[0]($env0, $tmp178);
    if($tmp180) {
      $tmp181 = _ats2phppre_list_aux_59($env0, $tmp179);
      $tmpret177 = array($tmp178, $tmp181);
    } else {
      // ATStailcalseq_beg
      $apy0 = $tmp179;
      $arg0 = $apy0;
      goto __patsflab__ats2phppre_list_aux_59;
      // ATStailcalseq_end
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret177;
} // end-of-function


function
ats2phppre_list_filter_method($arg0)
{
//
  $tmpret182 = NULL;
//
  __patsflab_list_filter_method:
  $tmpret182 = _ats2phppre_list_patsfun_61__closurerize($arg0);
  return $tmpret182;
} // end-of-function


function
_ats2phppre_list_patsfun_61($env0, $arg0)
{
//
  $tmpret183 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_61:
  $tmpret183 = ats2phppre_list_filter($env0, $arg0);
  return $tmpret183;
} // end-of-function


function
ats2phppre_list_map($arg0, $arg1)
{
//
  $tmpret184 = NULL;
//
  __patsflab_list_map:
  $tmpret184 = _ats2phppre_list_aux_63($arg1, $arg0);
  return $tmpret184;
} // end-of-function


function
_ats2phppre_list_aux_63($env0, $arg0)
{
//
  $tmpret185 = NULL;
  $tmp186 = NULL;
  $tmp187 = NULL;
  $tmp188 = NULL;
  $tmp189 = NULL;
//
  __patsflab__ats2phppre_list_aux_63:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab65:
    if(ATSCKptriscons($arg0)) goto __atstmplab68;
    __atstmplab66:
    $tmpret185 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab67:
    __atstmplab68:
    $tmp186 = $arg0[0];
    $tmp187 = $arg0[1];
    $tmp188 = $env0[0]($env0, $tmp186);
    $tmp189 = _ats2phppre_list_aux_63($env0, $tmp187);
    $tmpret185 = array($tmp188, $tmp189);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret185;
} // end-of-function


function
ats2phppre_list_map_method($arg0, $arg1)
{
//
  $tmpret190 = NULL;
//
  __patsflab_list_map_method:
  $tmpret190 = _ats2phppre_list_patsfun_65__closurerize($arg0);
  return $tmpret190;
} // end-of-function


function
_ats2phppre_list_patsfun_65($env0, $arg0)
{
//
  $tmpret191 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_65:
  $tmpret191 = ats2phppre_list_map($env0, $arg0);
  return $tmpret191;
} // end-of-function


function
ats2phppre_list_foldleft($arg0, $arg1, $arg2)
{
//
  $tmpret192 = NULL;
//
  __patsflab_list_foldleft:
  $tmpret192 = _ats2phppre_list_loop_67($arg2, $arg1, $arg0);
  return $tmpret192;
} // end-of-function


function
_ats2phppre_list_loop_67($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret193 = NULL;
  $tmp194 = NULL;
  $tmp195 = NULL;
  $tmp196 = NULL;
//
  __patsflab__ats2phppre_list_loop_67:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab69:
    if(ATSCKptriscons($arg1)) goto __atstmplab72;
    __atstmplab70:
    $tmpret193 = $arg0;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab71:
    __atstmplab72:
    $tmp194 = $arg1[0];
    $tmp195 = $arg1[1];
    $tmp196 = $env0[0]($env0, $arg0, $tmp194);
    // ATStailcalseq_beg
    $apy0 = $tmp196;
    $apy1 = $tmp195;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_loop_67;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret193;
} // end-of-function


function
ats2phppre_list_foldleft_method($arg0, $arg1)
{
//
  $tmpret197 = NULL;
//
  __patsflab_list_foldleft_method:
  $tmpret197 = _ats2phppre_list_patsfun_69__closurerize($arg0, $arg1);
  return $tmpret197;
} // end-of-function


function
_ats2phppre_list_patsfun_69($env0, $env1, $arg0)
{
//
  $tmpret198 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_69:
  $tmpret198 = ats2phppre_list_foldleft($env0, $env1, $arg0);
  return $tmpret198;
} // end-of-function


function
ats2phppre_list_ifoldleft($arg0, $arg1, $arg2)
{
//
  $tmpret199 = NULL;
//
  __patsflab_list_ifoldleft:
  $tmpret199 = _ats2phppre_list_loop_71($arg2, 0, $arg1, $arg0);
  return $tmpret199;
} // end-of-function


function
_ats2phppre_list_loop_71($env0, $arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmpret200 = NULL;
  $tmp201 = NULL;
  $tmp202 = NULL;
  $tmp203 = NULL;
  $tmp204 = NULL;
//
  __patsflab__ats2phppre_list_loop_71:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab73:
    if(ATSCKptriscons($arg2)) goto __atstmplab76;
    __atstmplab74:
    $tmpret200 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab75:
    __atstmplab76:
    $tmp201 = $arg2[0];
    $tmp202 = $arg2[1];
    $tmp203 = ats2phppre_add_int1_int1($arg0, 1);
    $tmp204 = $env0[0]($env0, $arg0, $arg1, $tmp201);
    // ATStailcalseq_beg
    $apy0 = $tmp203;
    $apy1 = $tmp204;
    $apy2 = $tmp202;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    goto __patsflab__ats2phppre_list_loop_71;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret200;
} // end-of-function


function
ats2phppre_list_ifoldleft_method($arg0, $arg1)
{
//
  $tmpret205 = NULL;
//
  __patsflab_list_ifoldleft_method:
  $tmpret205 = _ats2phppre_list_patsfun_73__closurerize($arg0, $arg1);
  return $tmpret205;
} // end-of-function


function
_ats2phppre_list_patsfun_73($env0, $env1, $arg0)
{
//
  $tmpret206 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_73:
  $tmpret206 = ats2phppre_list_ifoldleft($env0, $env1, $arg0);
  return $tmpret206;
} // end-of-function


function
ats2phppre_list_foldright($arg0, $arg1, $arg2)
{
//
  $tmpret207 = NULL;
//
  __patsflab_list_foldright:
  $tmpret207 = _ats2phppre_list_aux_75($arg1, $arg0, $arg2);
  return $tmpret207;
} // end-of-function


function
_ats2phppre_list_aux_75($env0, $arg0, $arg1)
{
//
  $tmpret208 = NULL;
  $tmp209 = NULL;
  $tmp210 = NULL;
  $tmp211 = NULL;
//
  __patsflab__ats2phppre_list_aux_75:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab77:
    if(ATSCKptriscons($arg0)) goto __atstmplab80;
    __atstmplab78:
    $tmpret208 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab79:
    __atstmplab80:
    $tmp209 = $arg0[0];
    $tmp210 = $arg0[1];
    $tmp211 = _ats2phppre_list_aux_75($env0, $tmp210, $arg1);
    $tmpret208 = $env0[0]($env0, $tmp209, $tmp211);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret208;
} // end-of-function


function
ats2phppre_list_foldright_method($arg0, $arg1)
{
//
  $tmpret212 = NULL;
//
  __patsflab_list_foldright_method:
  $tmpret212 = _ats2phppre_list_patsfun_77__closurerize($arg0, $arg1);
  return $tmpret212;
} // end-of-function


function
_ats2phppre_list_patsfun_77($env0, $env1, $arg0)
{
//
  $tmpret213 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_77:
  $tmpret213 = ats2phppre_list_foldright($env0, $arg0, $env1);
  return $tmpret213;
} // end-of-function


function
ats2phppre_list_ifoldright($arg0, $arg1, $arg2)
{
//
  $tmpret214 = NULL;
//
  __patsflab_list_ifoldright:
  $tmpret214 = _ats2phppre_list_aux_79($arg1, 0, $arg0, $arg2);
  return $tmpret214;
} // end-of-function


function
_ats2phppre_list_aux_79($env0, $arg0, $arg1, $arg2)
{
//
  $tmpret215 = NULL;
  $tmp216 = NULL;
  $tmp217 = NULL;
  $tmp218 = NULL;
  $tmp219 = NULL;
//
  __patsflab__ats2phppre_list_aux_79:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab81:
    if(ATSCKptriscons($arg1)) goto __atstmplab84;
    __atstmplab82:
    $tmpret215 = $arg2;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab83:
    __atstmplab84:
    $tmp216 = $arg1[0];
    $tmp217 = $arg1[1];
    $tmp219 = ats2phppre_add_int1_int1($arg0, 1);
    $tmp218 = _ats2phppre_list_aux_79($env0, $tmp219, $tmp217, $arg2);
    $tmpret215 = $env0[0]($env0, $arg0, $tmp216, $tmp218);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret215;
} // end-of-function


function
ats2phppre_list_ifoldright_method($arg0, $arg1)
{
//
  $tmpret220 = NULL;
//
  __patsflab_list_ifoldright_method:
  $tmpret220 = _ats2phppre_list_patsfun_81__closurerize($arg0, $arg1);
  return $tmpret220;
} // end-of-function


function
_ats2phppre_list_patsfun_81($env0, $env1, $arg0)
{
//
  $tmpret221 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_81:
  $tmpret221 = ats2phppre_list_ifoldright($env0, $arg0, $env1);
  return $tmpret221;
} // end-of-function


function
ats2phppre_streamize_list_elt($arg0)
{
//
  $tmpret224 = NULL;
//
  __patsflab_streamize_list_elt:
  $tmpret224 = _ats2phppre_list_auxmain_85($arg0);
  return $tmpret224;
} // end-of-function


function
_ats2phppre_list_auxmain_85($arg0)
{
//
  $tmpret225 = NULL;
//
  __patsflab__ats2phppre_list_auxmain_85:
  $tmpret225 = ATSPMVllazyval(_ats2phppre_list_patsfun_86__closurerize($arg0));
  return $tmpret225;
} // end-of-function


function
_ats2phppre_list_patsfun_86($env0, $arg0)
{
//
  $tmpret226 = NULL;
  $tmp227 = NULL;
  $tmp228 = NULL;
  $tmp229 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_86:
  if($arg0) {
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab85:
      if(ATSCKptriscons($env0)) goto __atstmplab88;
      __atstmplab86:
      $tmpret226 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab87:
      __atstmplab88:
      $tmp227 = $env0[0];
      $tmp228 = $env0[1];
      $tmp229 = _ats2phppre_list_auxmain_85($tmp228);
      $tmpret226 = array($tmp227, $tmp229);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
  } // endif
  return $tmpret226;
} // end-of-function


function
ats2phppre_streamize_list_zip($arg0, $arg1)
{
//
  $tmpret230 = NULL;
//
  __patsflab_streamize_list_zip:
  $tmpret230 = _ats2phppre_list_auxmain_88($arg0, $arg1);
  return $tmpret230;
} // end-of-function


function
_ats2phppre_list_auxmain_88($arg0, $arg1)
{
//
  $tmpret231 = NULL;
//
  __patsflab__ats2phppre_list_auxmain_88:
  $tmpret231 = ATSPMVllazyval(_ats2phppre_list_patsfun_89__closurerize($arg0, $arg1));
  return $tmpret231;
} // end-of-function


function
_ats2phppre_list_patsfun_89($env0, $env1, $arg0)
{
//
  $tmpret232 = NULL;
  $tmp233 = NULL;
  $tmp234 = NULL;
  $tmp235 = NULL;
  $tmp236 = NULL;
  $tmp237 = NULL;
  $tmp238 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_89:
  if($arg0) {
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab89:
      if(ATSCKptriscons($env0)) goto __atstmplab92;
      __atstmplab90:
      $tmpret232 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab91:
      __atstmplab92:
      $tmp233 = $env0[0];
      $tmp234 = $env0[1];
      // ATScaseofseq_beg
      do {
        // ATSbranchseq_beg
        __atstmplab93:
        if(ATSCKptriscons($env1)) goto __atstmplab96;
        __atstmplab94:
        $tmpret232 = NULL;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        __atstmplab95:
        __atstmplab96:
        $tmp235 = $env1[0];
        $tmp236 = $env1[1];
        $tmp237 = array($tmp233, $tmp235);
        $tmp238 = _ats2phppre_list_auxmain_88($tmp234, $tmp236);
        $tmpret232 = array($tmp237, $tmp238);
        break;
        // ATSbranchseq_end
      } while(0);
      // ATScaseofseq_end
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
  } // endif
  return $tmpret232;
} // end-of-function


function
ats2phppre_streamize_list_cross($arg0, $arg1)
{
//
  $tmpret239 = NULL;
//
  __patsflab_streamize_list_cross:
  $tmpret239 = _ats2phppre_list_auxmain_93($arg0, $arg1);
  return $tmpret239;
} // end-of-function


function
_ats2phppre_list_auxone_91($arg0, $arg1)
{
//
  $tmpret240 = NULL;
//
  __patsflab__ats2phppre_list_auxone_91:
  $tmpret240 = ATSPMVllazyval(_ats2phppre_list_patsfun_92__closurerize($arg0, $arg1));
  return $tmpret240;
} // end-of-function


function
_ats2phppre_list_patsfun_92($env0, $env1, $arg0)
{
//
  $tmpret241 = NULL;
  $tmp242 = NULL;
  $tmp243 = NULL;
  $tmp244 = NULL;
  $tmp245 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_92:
  if($arg0) {
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab97:
      if(ATSCKptriscons($env1)) goto __atstmplab100;
      __atstmplab98:
      $tmpret241 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab99:
      __atstmplab100:
      $tmp242 = $env1[0];
      $tmp243 = $env1[1];
      $tmp244 = array($env0, $tmp242);
      $tmp245 = _ats2phppre_list_auxone_91($env0, $tmp243);
      $tmpret241 = array($tmp244, $tmp245);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
  } // endif
  return $tmpret241;
} // end-of-function


function
_ats2phppre_list_auxmain_93($arg0, $arg1)
{
//
  $tmpret246 = NULL;
//
  __patsflab__ats2phppre_list_auxmain_93:
  $tmpret246 = ATSPMVllazyval(_ats2phppre_list_patsfun_94__closurerize($arg0, $arg1));
  return $tmpret246;
} // end-of-function


function
_ats2phppre_list_patsfun_94($env0, $env1, $arg0)
{
//
  $tmpret247 = NULL;
  $tmp248 = NULL;
  $tmp249 = NULL;
  $tmp250 = NULL;
  $tmp251 = NULL;
  $tmp252 = NULL;
//
  __patsflab__ats2phppre_list_patsfun_94:
  if($arg0) {
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab101:
      if(ATSCKptriscons($env0)) goto __atstmplab104;
      __atstmplab102:
      $tmpret247 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab103:
      __atstmplab104:
      $tmp248 = $env0[0];
      $tmp249 = $env0[1];
      $tmp251 = _ats2phppre_list_auxone_91($tmp248, $env1);
      $tmp252 = _ats2phppre_list_auxmain_93($tmp249, $env1);
      $tmp250 = ats2phppre_stream_vt_append($tmp251, $tmp252);
      $tmpret247 = ATSPMVllazyval_eval($tmp250);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
  } // endif
  return $tmpret247;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/

function
ats2phppre_list_vt_length($arg0)
{
//
  $tmpret2 = NULL;
//
  __patsflab_list_vt_length:
  $tmpret2 = _ats2phppre_list_vt_loop_3($arg0, 0);
  return $tmpret2;
} // end-of-function


function
_ats2phppre_list_vt_loop_3($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret3 = NULL;
  $tmp5 = NULL;
  $tmp6 = NULL;
//
  __patsflab__ats2phppre_list_vt_loop_3:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab8:
    if(ATSCKptriscons($arg0)) goto __atstmplab11;
    __atstmplab9:
    $tmpret3 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab10:
    __atstmplab11:
    $tmp5 = $arg0[1];
    $tmp6 = ats2phppre_add_int1_int1($arg1, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp5;
    $apy1 = $tmp6;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_vt_loop_3;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret3;
} // end-of-function


function
ats2phppre_list_vt_snoc($arg0, $arg1)
{
//
  $tmpret7 = NULL;
  $tmp8 = NULL;
  $tmp9 = NULL;
//
  __patsflab_list_vt_snoc:
  $tmp9 = NULL;
  $tmp8 = array($arg1, $tmp9);
  $tmpret7 = ats2phppre_list_vt_append($arg0, $tmp8);
  return $tmpret7;
} // end-of-function


function
ats2phppre_list_vt_extend($arg0, $arg1)
{
//
  $tmpret10 = NULL;
  $tmp11 = NULL;
  $tmp12 = NULL;
//
  __patsflab_list_vt_extend:
  $tmp12 = NULL;
  $tmp11 = array($arg1, $tmp12);
  $tmpret10 = ats2phppre_list_vt_append($arg0, $tmp11);
  return $tmpret10;
} // end-of-function


function
ats2phppre_list_vt_append($arg0, $arg1)
{
//
  $tmpret13 = NULL;
//
  __patsflab_list_vt_append:
  $tmpret13 = _ats2phppre_list_vt_aux_7($arg0, $arg1);
  return $tmpret13;
} // end-of-function


function
_ats2phppre_list_vt_aux_7($arg0, $arg1)
{
//
  $tmpret14 = NULL;
  $tmp15 = NULL;
  $tmp16 = NULL;
  $tmp17 = NULL;
//
  __patsflab__ats2phppre_list_vt_aux_7:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab12:
    if(ATSCKptriscons($arg0)) goto __atstmplab15;
    __atstmplab13:
    $tmpret14 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab14:
    __atstmplab15:
    $tmp15 = $arg0[0];
    $tmp16 = $arg0[1];
    // ATSINSfreecon($arg0);
    $tmp17 = _ats2phppre_list_vt_aux_7($tmp16, $arg1);
    $tmpret14 = array($tmp15, $tmp17);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret14;
} // end-of-function


function
ats2phppre_list_vt_reverse($arg0)
{
//
  $tmpret18 = NULL;
  $tmp19 = NULL;
//
  __patsflab_list_vt_reverse:
  $tmp19 = NULL;
  $tmpret18 = ats2phppre_list_vt_reverse_append($arg0, $tmp19);
  return $tmpret18;
} // end-of-function


function
ats2phppre_list_vt_reverse_append($arg0, $arg1)
{
//
  $tmpret20 = NULL;
//
  __patsflab_list_vt_reverse_append:
  $tmpret20 = _ats2phppre_list_vt_loop_10($arg0, $arg1);
  return $tmpret20;
} // end-of-function


function
_ats2phppre_list_vt_loop_10($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret21 = NULL;
  $tmp22 = NULL;
  $tmp23 = NULL;
  $tmp24 = NULL;
//
  __patsflab__ats2phppre_list_vt_loop_10:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab16:
    if(ATSCKptriscons($arg0)) goto __atstmplab19;
    __atstmplab17:
    $tmpret21 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab18:
    __atstmplab19:
    $tmp22 = $arg0[0];
    $tmp23 = $arg0[1];
    // ATSINSfreecon($arg0);
    $tmp24 = array($tmp22, $arg1);
    // ATStailcalseq_beg
    $apy0 = $tmp23;
    $apy1 = $tmp24;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_list_vt_loop_10;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret21;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/

function
ats2phppre_option_some($arg0)
{
//
  $tmpret0 = NULL;
//
  __patsflab_option_some:
  $tmpret0 = array($arg0);
  return $tmpret0;
} // end-of-function


function
ats2phppre_option_none()
{
//
  $tmpret1 = NULL;
//
  __patsflab_option_none:
  $tmpret1 = NULL;
  return $tmpret1;
} // end-of-function


function
ats2phppre_option_unsome($arg0)
{
//
  $tmpret2 = NULL;
  $tmp3 = NULL;
//
  __patsflab_option_unsome:
  $tmp3 = $arg0[0];
  $tmpret2 = $tmp3;
  return $tmpret2;
} // end-of-function


function
ats2phppre_option_is_some($arg0)
{
//
  $tmpret4 = NULL;
//
  __patsflab_option_is_some:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab0:
    if(ATSCKptrisnull($arg0)) goto __atstmplab3;
    __atstmplab1:
    $tmpret4 = true;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab2:
    __atstmplab3:
    $tmpret4 = false;
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret4;
} // end-of-function


function
ats2phppre_option_is_none($arg0)
{
//
  $tmpret5 = NULL;
//
  __patsflab_option_is_none:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab4:
    if(ATSCKptriscons($arg0)) goto __atstmplab7;
    __atstmplab5:
    $tmpret5 = true;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab6:
    __atstmplab7:
    $tmpret5 = false;
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret5;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/
function
_ats2jspre_stream_patsfun_6__closurerize($env0)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_6($cenv[1]); }, $env0);
}

function
_ats2jspre_stream_patsfun_17__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2jspre_stream_patsfun_17($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2jspre_stream_patsfun_23__closurerize($env0, $env1)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_23($cenv[1], $cenv[2]); }, $env0, $env1);
}

function
_ats2jspre_stream_patsfun_25__closurerize($env0)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_25($cenv[1]); }, $env0);
}

function
_ats2jspre_stream_patsfun_27__closurerize($env0, $env1)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_27($cenv[1], $cenv[2]); }, $env0, $env1);
}

function
_ats2jspre_stream_patsfun_29__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2jspre_stream_patsfun_29($cenv[1], $arg0); }, $env0);
}

function
_ats2jspre_stream_patsfun_31__closurerize($env0, $env1)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_31($cenv[1], $cenv[2]); }, $env0, $env1);
}

function
_ats2jspre_stream_patsfun_33__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2jspre_stream_patsfun_33($cenv[1], $arg0); }, $env0);
}

function
_ats2jspre_stream_patsfun_36__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2jspre_stream_patsfun_36($cenv[1], $arg0); }, $env0);
}

function
_ats2jspre_stream_patsfun_39__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2jspre_stream_patsfun_39($cenv[1], $arg0); }, $env0);
}

function
_ats2jspre_stream_patsfun_42__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2jspre_stream_patsfun_42($cenv[1], $arg0); }, $env0);
}

function
_ats2jspre_stream_patsfun_46__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2jspre_stream_patsfun_46($cenv[1], $arg0); }, $env0);
}

function
_ats2jspre_stream_patsfun_49__closurerize($env0, $env1)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_49($cenv[1], $cenv[2]); }, $env0, $env1);
}

function
_ats2jspre_stream_patsfun_52__closurerize($env0, $env1, $env2, $env3)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_52($cenv[1], $cenv[2], $cenv[3], $cenv[4]); }, $env0, $env1, $env2, $env3);
}

function
_ats2jspre_stream_patsfun_53__closurerize($env0, $env1)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_53($cenv[1], $cenv[2]); }, $env0, $env1);
}

function
_ats2jspre_stream_patsfun_56__closurerize($env0)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_56($cenv[1]); }, $env0);
}

function
_ats2jspre_stream_patsfun_58__closurerize($env0)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_58($cenv[1]); }, $env0);
}

function
_ats2jspre_stream_patsfun_60__closurerize($env0, $env1)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_60($cenv[1], $cenv[2]); }, $env0, $env1);
}

function
_ats2jspre_stream_patsfun_65__closurerize($env0)
{
  return array(function($cenv, $arg0, $arg1) { return _ats2jspre_stream_patsfun_65($cenv[1], $arg0, $arg1); }, $env0);
}

function
_ats2jspre_stream_patsfun_67__closurerize($env0)
{
  return array(function($cenv, $arg0, $arg1) { return _ats2jspre_stream_patsfun_67($cenv[1], $arg0, $arg1); }, $env0);
}

function
_ats2jspre_stream_patsfun_70__closurerize($env0, $env1)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_70($cenv[1], $cenv[2]); }, $env0, $env1);
}

function
_ats2jspre_stream_patsfun_72__closurerize($env0, $env1)
{
  return array(function($cenv) { return _ats2jspre_stream_patsfun_72($cenv[1], $cenv[2]); }, $env0, $env1);
}


function
ats2phppre_stream_make_list($arg0)
{
//
  $tmpret7 = NULL;
//
  __patsflab_stream_make_list:
  $tmpret7 = ATSPMVlazyval(_ats2jspre_stream_patsfun_6__closurerize($arg0));
  return $tmpret7;
} // end-of-function


function
_ats2jspre_stream_patsfun_6($env0)
{
//
  $tmpret8 = NULL;
  $tmp9 = NULL;
  $tmp10 = NULL;
  $tmp11 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_6:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab0:
    if(ATSCKptriscons($env0)) goto __atstmplab3;
    __atstmplab1:
    $tmpret8 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab2:
    __atstmplab3:
    $tmp9 = $env0[0];
    $tmp10 = $env0[1];
    $tmp11 = ats2phppre_stream_make_list($tmp10);
    $tmpret8 = array($tmp9, $tmp11);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret8;
} // end-of-function


function
ats2phppre_stream_make_list0($arg0)
{
//
  $tmpret12 = NULL;
//
  __patsflab_stream_make_list0:
  $tmpret12 = ats2phppre_stream_make_list($arg0);
  return $tmpret12;
} // end-of-function


function
ats2phppre_stream_nth_opt($arg0, $arg1)
{
//
  $tmpret13 = NULL;
//
  __patsflab_stream_nth_opt:
  $tmpret13 = _ats2jspre_stream_loop_9($arg0, $arg1);
  return $tmpret13;
} // end-of-function


function
_ats2jspre_stream_loop_9($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret14 = NULL;
  $tmp15 = NULL;
  $tmp16 = NULL;
  $tmp17 = NULL;
  $tmp18 = NULL;
  $tmp19 = NULL;
//
  __patsflab__ats2jspre_stream_loop_9:
  $tmp15 = ATSPMVlazyval_eval($arg0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab4:
    if(ATSCKptriscons($tmp15)) goto __atstmplab7;
    __atstmplab5:
    $tmpret14 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab6:
    __atstmplab7:
    $tmp16 = $tmp15[0];
    $tmp17 = $tmp15[1];
    $tmp18 = ats2phppre_gt_int1_int1($arg1, 0);
    if($tmp18) {
      $tmp19 = ats2phppre_pred_int1($arg1);
      // ATStailcalseq_beg
      $apy0 = $tmp17;
      $apy1 = $tmp19;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab__ats2jspre_stream_loop_9;
      // ATStailcalseq_end
    } else {
      $tmpret14 = array($tmp16);
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret14;
} // end-of-function


function
ats2phppre_stream_length($arg0)
{
//
  $tmpret20 = NULL;
//
  __patsflab_stream_length:
  $tmpret20 = _ats2jspre_stream_loop_11($arg0, 0);
  return $tmpret20;
} // end-of-function


function
_ats2jspre_stream_loop_11($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret21 = NULL;
  $tmp22 = NULL;
  $tmp24 = NULL;
  $tmp25 = NULL;
//
  __patsflab__ats2jspre_stream_loop_11:
  $tmp22 = ATSPMVlazyval_eval($arg0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab8:
    if(ATSCKptriscons($tmp22)) goto __atstmplab11;
    __atstmplab9:
    $tmpret21 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab10:
    __atstmplab11:
    $tmp24 = $tmp22[1];
    $tmp25 = ats2phppre_add_int1_int1($arg1, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp24;
    $apy1 = $tmp25;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2jspre_stream_loop_11;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret21;
} // end-of-function


function
ats2phppre_stream2list($arg0)
{
//
  $tmpret26 = NULL;
//
  __patsflab_stream2list:
  $tmpret26 = _ats2jspre_stream_aux_13($arg0);
  return $tmpret26;
} // end-of-function


function
_ats2jspre_stream_aux_13($arg0)
{
//
  $tmpret27 = NULL;
  $tmp28 = NULL;
  $tmp29 = NULL;
  $tmp30 = NULL;
  $tmp31 = NULL;
//
  __patsflab__ats2jspre_stream_aux_13:
  $tmp28 = ATSPMVlazyval_eval($arg0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab12:
    if(ATSCKptriscons($tmp28)) goto __atstmplab15;
    __atstmplab13:
    $tmpret27 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab14:
    __atstmplab15:
    $tmp29 = $tmp28[0];
    $tmp30 = $tmp28[1];
    $tmp31 = _ats2jspre_stream_aux_13($tmp30);
    $tmpret27 = array($tmp29, $tmp31);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret27;
} // end-of-function


function
ats2phppre_stream2list_rev($arg0)
{
//
  $tmpret32 = NULL;
  $tmp38 = NULL;
//
  __patsflab_stream2list_rev:
  $tmp38 = NULL;
  $tmpret32 = _ats2jspre_stream_loop_15($arg0, $tmp38);
  return $tmpret32;
} // end-of-function


function
_ats2jspre_stream_loop_15($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret33 = NULL;
  $tmp34 = NULL;
  $tmp35 = NULL;
  $tmp36 = NULL;
  $tmp37 = NULL;
//
  __patsflab__ats2jspre_stream_loop_15:
  $tmp34 = ATSPMVlazyval_eval($arg0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab16:
    if(ATSCKptriscons($tmp34)) goto __atstmplab19;
    __atstmplab17:
    $tmpret33 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab18:
    __atstmplab19:
    $tmp35 = $tmp34[0];
    $tmp36 = $tmp34[1];
    $tmp37 = array($tmp35, $arg1);
    // ATStailcalseq_beg
    $apy0 = $tmp36;
    $apy1 = $tmp37;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2jspre_stream_loop_15;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret33;
} // end-of-function


function
ats2phppre_stream_takeLte($arg0, $arg1)
{
//
  $tmpret39 = NULL;
//
  __patsflab_stream_takeLte:
  $tmpret39 = ATSPMVllazyval(_ats2jspre_stream_patsfun_17__closurerize($arg0, $arg1));
  return $tmpret39;
} // end-of-function


function
_ats2jspre_stream_patsfun_17($env0, $env1, $arg0)
{
//
  $tmpret40 = NULL;
  $tmp41 = NULL;
  $tmp42 = NULL;
  $tmp43 = NULL;
  $tmp44 = NULL;
  $tmp45 = NULL;
  $tmp46 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_17:
  if($arg0) {
    $tmp41 = ats2phppre_gt_int1_int1($env1, 0);
    if($tmp41) {
      $tmp42 = ATSPMVlazyval_eval($env0); 
      // ATScaseofseq_beg
      do {
        // ATSbranchseq_beg
        __atstmplab20:
        if(ATSCKptriscons($tmp42)) goto __atstmplab23;
        __atstmplab21:
        $tmpret40 = NULL;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        __atstmplab22:
        __atstmplab23:
        $tmp43 = $tmp42[0];
        $tmp44 = $tmp42[1];
        $tmp46 = ats2phppre_sub_int1_int1($env1, 1);
        $tmp45 = ats2phppre_stream_takeLte($tmp44, $tmp46);
        $tmpret40 = array($tmp43, $tmp45);
        break;
        // ATSbranchseq_end
      } while(0);
      // ATScaseofseq_end
    } else {
      $tmpret40 = NULL;
    } // endif
  } else {
  } // endif
  return $tmpret40;
} // end-of-function


function
ats2phppre_stream_take_opt($arg0, $arg1)
{
//
  $tmpret47 = NULL;
  $tmp56 = NULL;
//
  __patsflab_stream_take_opt:
  $tmp56 = NULL;
  $tmpret47 = _ats2jspre_stream_auxmain_19($arg1, $arg0, 0, $tmp56);
  return $tmpret47;
} // end-of-function


function
_ats2jspre_stream_auxmain_19($env0, $arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmpret48 = NULL;
  $tmp49 = NULL;
  $tmp50 = NULL;
  $tmp51 = NULL;
  $tmp52 = NULL;
  $tmp53 = NULL;
  $tmp54 = NULL;
  $tmp55 = NULL;
//
  __patsflab__ats2jspre_stream_auxmain_19:
  $tmp49 = ats2phppre_lt_int1_int1($arg1, $env0);
  if($tmp49) {
    $tmp50 = ATSPMVlazyval_eval($arg0); 
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab24:
      if(ATSCKptriscons($tmp50)) goto __atstmplab27;
      __atstmplab25:
      $tmpret48 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab26:
      __atstmplab27:
      $tmp51 = $tmp50[0];
      $tmp52 = $tmp50[1];
      $tmp53 = ats2phppre_add_int1_int1($arg1, 1);
      $tmp54 = array($tmp51, $arg2);
      // ATStailcalseq_beg
      $apy0 = $tmp52;
      $apy1 = $tmp53;
      $apy2 = $tmp54;
      $arg0 = $apy0;
      $arg1 = $apy1;
      $arg2 = $apy2;
      goto __patsflab__ats2jspre_stream_auxmain_19;
      // ATStailcalseq_end
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
    $tmp55 = ats2phppre_list_reverse($arg2);
    $tmpret48 = array($tmp55);
  } // endif
  return $tmpret48;
} // end-of-function


function
ats2phppre_stream_drop_opt($arg0, $arg1)
{
//
  $tmpret57 = NULL;
//
  __patsflab_stream_drop_opt:
  $tmpret57 = _ats2jspre_stream_auxmain_21($arg1, $arg0, 0);
  return $tmpret57;
} // end-of-function


function
_ats2jspre_stream_auxmain_21($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret58 = NULL;
  $tmp59 = NULL;
  $tmp60 = NULL;
  $tmp62 = NULL;
  $tmp63 = NULL;
//
  __patsflab__ats2jspre_stream_auxmain_21:
  $tmp59 = ats2phppre_lt_int1_int1($arg1, $env0);
  if($tmp59) {
    $tmp60 = ATSPMVlazyval_eval($arg0); 
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab28:
      if(ATSCKptriscons($tmp60)) goto __atstmplab31;
      __atstmplab29:
      $tmpret58 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab30:
      __atstmplab31:
      $tmp62 = $tmp60[1];
      $tmp63 = ats2phppre_add_int1_int1($arg1, 1);
      // ATStailcalseq_beg
      $apy0 = $tmp62;
      $apy1 = $tmp63;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab__ats2jspre_stream_auxmain_21;
      // ATStailcalseq_end
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
    $tmpret58 = array($arg0);
  } // endif
  return $tmpret58;
} // end-of-function


function
ats2phppre_stream_append($arg0, $arg1)
{
//
  $tmpret64 = NULL;
//
  __patsflab_stream_append:
  $tmpret64 = ATSPMVlazyval(_ats2jspre_stream_patsfun_23__closurerize($arg0, $arg1));
  return $tmpret64;
} // end-of-function


function
_ats2jspre_stream_patsfun_23($env0, $env1)
{
//
  $tmpret65 = NULL;
  $tmp66 = NULL;
  $tmp67 = NULL;
  $tmp68 = NULL;
  $tmp69 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_23:
  $tmp66 = ATSPMVlazyval_eval($env0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab32:
    if(ATSCKptriscons($tmp66)) goto __atstmplab35;
    __atstmplab33:
    $tmpret65 = ATSPMVlazyval_eval($env1); 
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab34:
    __atstmplab35:
    $tmp67 = $tmp66[0];
    $tmp68 = $tmp66[1];
    $tmp69 = ats2phppre_stream_append($tmp68, $env1);
    $tmpret65 = array($tmp67, $tmp69);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret65;
} // end-of-function


function
ats2phppre_stream_concat($arg0)
{
//
  $tmpret70 = NULL;
//
  __patsflab_stream_concat:
  $tmpret70 = ATSPMVlazyval(_ats2jspre_stream_patsfun_25__closurerize($arg0));
  return $tmpret70;
} // end-of-function


function
_ats2jspre_stream_patsfun_25($env0)
{
//
  $tmpret71 = NULL;
  $tmp72 = NULL;
  $tmp73 = NULL;
  $tmp74 = NULL;
  $tmp75 = NULL;
  $tmp76 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_25:
  $tmp72 = ATSPMVlazyval_eval($env0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab36:
    if(ATSCKptriscons($tmp72)) goto __atstmplab39;
    __atstmplab37:
    $tmpret71 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab38:
    __atstmplab39:
    $tmp73 = $tmp72[0];
    $tmp74 = $tmp72[1];
    $tmp76 = ats2phppre_stream_concat($tmp74);
    $tmp75 = ats2phppre_stream_append($tmp73, $tmp76);
    $tmpret71 = ATSPMVlazyval_eval($tmp75); 
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret71;
} // end-of-function


function
ats2phppre_stream_map_cloref($arg0, $arg1)
{
//
  $tmpret77 = NULL;
//
  __patsflab_stream_map_cloref:
  $tmpret77 = ATSPMVlazyval(_ats2jspre_stream_patsfun_27__closurerize($arg0, $arg1));
  return $tmpret77;
} // end-of-function


function
_ats2jspre_stream_patsfun_27($env0, $env1)
{
//
  $tmpret78 = NULL;
  $tmp79 = NULL;
  $tmp80 = NULL;
  $tmp81 = NULL;
  $tmp82 = NULL;
  $tmp83 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_27:
  $tmp79 = ATSPMVlazyval_eval($env0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab40:
    if(ATSCKptriscons($tmp79)) goto __atstmplab43;
    __atstmplab41:
    $tmpret78 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab42:
    __atstmplab43:
    $tmp80 = $tmp79[0];
    $tmp81 = $tmp79[1];
    $tmp82 = $env1[0]($env1, $tmp80);
    $tmp83 = ats2phppre_stream_map_cloref($tmp81, $env1);
    $tmpret78 = array($tmp82, $tmp83);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret78;
} // end-of-function


function
ats2phppre_stream_map_method($arg0, $arg1)
{
//
  $tmpret84 = NULL;
//
  __patsflab_stream_map_method:
  $tmpret84 = _ats2jspre_stream_patsfun_29__closurerize($arg0);
  return $tmpret84;
} // end-of-function


function
_ats2jspre_stream_patsfun_29($env0, $arg0)
{
//
  $tmpret85 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_29:
  $tmpret85 = ats2phppre_stream_map_cloref($env0, $arg0);
  return $tmpret85;
} // end-of-function


function
ats2phppre_stream_filter_cloref($arg0, $arg1)
{
//
  $tmpret86 = NULL;
//
  __patsflab_stream_filter_cloref:
  $tmpret86 = ATSPMVlazyval(_ats2jspre_stream_patsfun_31__closurerize($arg0, $arg1));
  return $tmpret86;
} // end-of-function


function
_ats2jspre_stream_patsfun_31($env0, $env1)
{
//
  $tmpret87 = NULL;
  $tmp88 = NULL;
  $tmp89 = NULL;
  $tmp90 = NULL;
  $tmp91 = NULL;
  $tmp92 = NULL;
  $tmp93 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_31:
  $tmp88 = ATSPMVlazyval_eval($env0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab44:
    if(ATSCKptriscons($tmp88)) goto __atstmplab47;
    __atstmplab45:
    $tmpret87 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab46:
    __atstmplab47:
    $tmp89 = $tmp88[0];
    $tmp90 = $tmp88[1];
    $tmp91 = $env1[0]($env1, $tmp89);
    if($tmp91) {
      $tmp92 = ats2phppre_stream_filter_cloref($tmp90, $env1);
      $tmpret87 = array($tmp89, $tmp92);
    } else {
      $tmp93 = ats2phppre_stream_filter_cloref($tmp90, $env1);
      $tmpret87 = ATSPMVlazyval_eval($tmp93); 
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret87;
} // end-of-function


function
ats2phppre_stream_filter_method($arg0)
{
//
  $tmpret94 = NULL;
//
  __patsflab_stream_filter_method:
  $tmpret94 = _ats2jspre_stream_patsfun_33__closurerize($arg0);
  return $tmpret94;
} // end-of-function


function
_ats2jspre_stream_patsfun_33($env0, $arg0)
{
//
  $tmpret95 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_33:
  $tmpret95 = ats2phppre_stream_filter_cloref($env0, $arg0);
  return $tmpret95;
} // end-of-function


function
ats2phppre_stream_forall_cloref($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret96 = NULL;
  $tmp97 = NULL;
  $tmp98 = NULL;
  $tmp99 = NULL;
  $tmp100 = NULL;
//
  __patsflab_stream_forall_cloref:
  $tmp97 = ATSPMVlazyval_eval($arg0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab48:
    if(ATSCKptriscons($tmp97)) goto __atstmplab51;
    __atstmplab49:
    $tmpret96 = true;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab50:
    __atstmplab51:
    $tmp98 = $tmp97[0];
    $tmp99 = $tmp97[1];
    $tmp100 = $arg1[0]($arg1, $tmp98);
    if($tmp100) {
      // ATStailcalseq_beg
      $apy0 = $tmp99;
      $apy1 = $arg1;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab_stream_forall_cloref;
      // ATStailcalseq_end
    } else {
      $tmpret96 = false;
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret96;
} // end-of-function


function
ats2phppre_stream_forall_method($arg0)
{
//
  $tmpret101 = NULL;
//
  __patsflab_stream_forall_method:
  $tmpret101 = _ats2jspre_stream_patsfun_36__closurerize($arg0);
  return $tmpret101;
} // end-of-function


function
_ats2jspre_stream_patsfun_36($env0, $arg0)
{
//
  $tmpret102 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_36:
  $tmpret102 = ats2phppre_stream_forall_cloref($env0, $arg0);
  return $tmpret102;
} // end-of-function


function
ats2phppre_stream_exists_cloref($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret103 = NULL;
  $tmp104 = NULL;
  $tmp105 = NULL;
  $tmp106 = NULL;
  $tmp107 = NULL;
//
  __patsflab_stream_exists_cloref:
  $tmp104 = ATSPMVlazyval_eval($arg0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab52:
    if(ATSCKptriscons($tmp104)) goto __atstmplab55;
    __atstmplab53:
    $tmpret103 = false;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab54:
    __atstmplab55:
    $tmp105 = $tmp104[0];
    $tmp106 = $tmp104[1];
    $tmp107 = $arg1[0]($arg1, $tmp105);
    if($tmp107) {
      $tmpret103 = true;
    } else {
      // ATStailcalseq_beg
      $apy0 = $tmp106;
      $apy1 = $arg1;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab_stream_exists_cloref;
      // ATStailcalseq_end
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret103;
} // end-of-function


function
ats2phppre_stream_exists_method($arg0)
{
//
  $tmpret108 = NULL;
//
  __patsflab_stream_exists_method:
  $tmpret108 = _ats2jspre_stream_patsfun_39__closurerize($arg0);
  return $tmpret108;
} // end-of-function


function
_ats2jspre_stream_patsfun_39($env0, $arg0)
{
//
  $tmpret109 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_39:
  $tmpret109 = ats2phppre_stream_exists_cloref($env0, $arg0);
  return $tmpret109;
} // end-of-function


function
ats2phppre_stream_foreach_cloref($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmp111 = NULL;
  $tmp112 = NULL;
  $tmp113 = NULL;
//
  __patsflab_stream_foreach_cloref:
  $tmp111 = ATSPMVlazyval_eval($arg0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab56:
    if(ATSCKptriscons($tmp111)) goto __atstmplab59;
    __atstmplab57:
    // ATSINSmove_void;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab58:
    __atstmplab59:
    $tmp112 = $tmp111[0];
    $tmp113 = $tmp111[1];
    $arg1[0]($arg1, $tmp112);
    // ATStailcalseq_beg
    $apy0 = $tmp113;
    $apy1 = $arg1;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab_stream_foreach_cloref;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_foreach_method($arg0)
{
//
  $tmpret115 = NULL;
//
  __patsflab_stream_foreach_method:
  $tmpret115 = _ats2jspre_stream_patsfun_42__closurerize($arg0);
  return $tmpret115;
} // end-of-function


function
_ats2jspre_stream_patsfun_42($env0, $arg0)
{
//
//
  __patsflab__ats2jspre_stream_patsfun_42:
  ats2phppre_stream_foreach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_iforeach_cloref($arg0, $arg1)
{
//
//
  __patsflab_stream_iforeach_cloref:
  _ats2jspre_stream_loop_44($arg1, 0, $arg0);
  return/*_void*/;
} // end-of-function


function
_ats2jspre_stream_loop_44($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmp119 = NULL;
  $tmp120 = NULL;
  $tmp121 = NULL;
  $tmp123 = NULL;
//
  __patsflab__ats2jspre_stream_loop_44:
  $tmp119 = ATSPMVlazyval_eval($arg1); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab60:
    if(ATSCKptriscons($tmp119)) goto __atstmplab63;
    __atstmplab61:
    // ATSINSmove_void;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab62:
    __atstmplab63:
    $tmp120 = $tmp119[0];
    $tmp121 = $tmp119[1];
    $env0[0]($env0, $arg0, $tmp120);
    $tmp123 = ats2phppre_add_int1_int1($arg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp123;
    $apy1 = $tmp121;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2jspre_stream_loop_44;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_iforeach_method($arg0)
{
//
  $tmpret124 = NULL;
//
  __patsflab_stream_iforeach_method:
  $tmpret124 = _ats2jspre_stream_patsfun_46__closurerize($arg0);
  return $tmpret124;
} // end-of-function


function
_ats2jspre_stream_patsfun_46($env0, $arg0)
{
//
//
  __patsflab__ats2jspre_stream_patsfun_46:
  ats2phppre_stream_iforeach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_tabulate_cloref($arg0)
{
//
  $tmpret126 = NULL;
//
  __patsflab_stream_tabulate_cloref:
  $tmpret126 = _ats2jspre_stream_auxmain_48($arg0, 0);
  return $tmpret126;
} // end-of-function


function
_ats2jspre_stream_auxmain_48($env0, $arg0)
{
//
  $tmpret127 = NULL;
//
  __patsflab__ats2jspre_stream_auxmain_48:
  $tmpret127 = ATSPMVlazyval(_ats2jspre_stream_patsfun_49__closurerize($env0, $arg0));
  return $tmpret127;
} // end-of-function


function
_ats2jspre_stream_patsfun_49($env0, $env1)
{
//
  $tmpret128 = NULL;
  $tmp129 = NULL;
  $tmp130 = NULL;
  $tmp131 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_49:
  $tmp129 = $env0[0]($env0, $env1);
  $tmp131 = ats2phppre_add_int1_int1($env1, 1);
  $tmp130 = _ats2jspre_stream_auxmain_48($env0, $tmp131);
  $tmpret128 = array($tmp129, $tmp130);
  return $tmpret128;
} // end-of-function


function
ats2phppre_cross_stream_list($arg0, $arg1)
{
//
  $tmpret132 = NULL;
//
  __patsflab_cross_stream_list:
  $tmpret132 = ATSPMVlazyval(_ats2jspre_stream_patsfun_53__closurerize($arg0, $arg1));
  return $tmpret132;
} // end-of-function


function
_ats2jspre_stream_auxmain_51($arg0, $arg1, $arg2, $arg3)
{
//
  $tmpret133 = NULL;
//
  __patsflab__ats2jspre_stream_auxmain_51:
  $tmpret133 = ATSPMVlazyval(_ats2jspre_stream_patsfun_52__closurerize($arg0, $arg1, $arg2, $arg3));
  return $tmpret133;
} // end-of-function


function
_ats2jspre_stream_patsfun_52($env0, $env1, $env2, $env3)
{
//
  $tmpret134 = NULL;
  $tmp135 = NULL;
  $tmp136 = NULL;
  $tmp137 = NULL;
  $tmp138 = NULL;
  $tmp139 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_52:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab64:
    if(ATSCKptriscons($env3)) goto __atstmplab67;
    __atstmplab65:
    $tmp137 = ats2phppre_cross_stream_list($env1, $env2);
    $tmpret134 = ATSPMVlazyval_eval($tmp137); 
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab66:
    __atstmplab67:
    $tmp135 = $env3[0];
    $tmp136 = $env3[1];
    $tmp138 = array($env0, $tmp135);
    $tmp139 = _ats2jspre_stream_auxmain_51($env0, $env1, $env2, $tmp136);
    $tmpret134 = array($tmp138, $tmp139);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret134;
} // end-of-function


function
_ats2jspre_stream_patsfun_53($env0, $env1)
{
//
  $tmpret140 = NULL;
  $tmp141 = NULL;
  $tmp142 = NULL;
  $tmp143 = NULL;
  $tmp144 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_53:
  $tmp141 = ATSPMVlazyval_eval($env0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab68:
    if(ATSCKptriscons($tmp141)) goto __atstmplab71;
    __atstmplab69:
    $tmpret140 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab70:
    if(ATSCKptrisnull($tmp141)) ATSINScaseof_fail("/home/hwxi/Research/ATS-Postiats/contrib/libatscc/ATS2-0.3.2/DATS/stream.dats: 6907(line=451, offs=1) -- 6999(line=453, offs=50)");
    __atstmplab71:
    $tmp142 = $tmp141[0];
    $tmp143 = $tmp141[1];
    $tmp144 = _ats2jspre_stream_auxmain_51($tmp142, $tmp143, $env1, $env1);
    $tmpret140 = ATSPMVlazyval_eval($tmp144); 
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret140;
} // end-of-function


function
ats2phppre_cross_stream_list0($arg0, $arg1)
{
//
  $tmpret145 = NULL;
//
  __patsflab_cross_stream_list0:
  $tmpret145 = ats2phppre_cross_stream_list($arg0, $arg1);
  return $tmpret145;
} // end-of-function


function
ats2phppre_stream2cloref_exn($arg0)
{
//
  $tmpret146 = NULL;
  $tmp147 = NULL;
//
  __patsflab_stream2cloref_exn:
  $tmp147 = ats2phppre_ref($arg0);
  $tmpret146 = _ats2jspre_stream_patsfun_56__closurerize($tmp147);
  return $tmpret146;
} // end-of-function


function
_ats2jspre_stream_patsfun_56($env0)
{
//
  $tmpret148 = NULL;
  $tmp149 = NULL;
  $tmp150 = NULL;
  $tmp151 = NULL;
  $tmp152 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_56:
  $tmp149 = ats2phppre_ref_get_elt($env0);
  $tmp150 = ATSPMVlazyval_eval($tmp149); 
  if(ATSCKptrisnull($tmp150)) ATSINScaseof_fail("/home/hwxi/Research/ATS-Postiats/contrib/libatscc/ATS2-0.3.2/DATS/stream.dats: 7300(line=479, offs=5) -- 7324(line=479, offs=29)");
  $tmp151 = $tmp150[0];
  $tmp152 = $tmp150[1];
  ats2phppre_ref_set_elt($env0, $tmp152);
  $tmpret148 = $tmp151;
  return $tmpret148;
} // end-of-function


function
ats2phppre_stream2cloref_opt($arg0)
{
//
  $tmpret154 = NULL;
  $tmp155 = NULL;
//
  __patsflab_stream2cloref_opt:
  $tmp155 = ats2phppre_ref($arg0);
  $tmpret154 = _ats2jspre_stream_patsfun_58__closurerize($tmp155);
  return $tmpret154;
} // end-of-function


function
_ats2jspre_stream_patsfun_58($env0)
{
//
  $tmpret156 = NULL;
  $tmp157 = NULL;
  $tmp158 = NULL;
  $tmp159 = NULL;
  $tmp160 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_58:
  $tmp157 = ats2phppre_ref_get_elt($env0);
  $tmp158 = ATSPMVlazyval_eval($tmp157); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab72:
    if(ATSCKptriscons($tmp158)) goto __atstmplab75;
    __atstmplab73:
    $tmpret156 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab74:
    __atstmplab75:
    $tmp159 = $tmp158[0];
    $tmp160 = $tmp158[1];
    ats2phppre_ref_set_elt($env0, $tmp160);
    $tmpret156 = array($tmp159);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret156;
} // end-of-function


function
ats2phppre_stream2cloref_last($arg0, $arg1)
{
//
  $tmpret162 = NULL;
  $tmp163 = NULL;
  $tmp164 = NULL;
//
  __patsflab_stream2cloref_last:
  $tmp163 = ats2phppre_ref($arg0);
  $tmp164 = ats2phppre_ref($arg1);
  $tmpret162 = _ats2jspre_stream_patsfun_60__closurerize($tmp163, $tmp164);
  return $tmpret162;
} // end-of-function


function
_ats2jspre_stream_patsfun_60($env0, $env1)
{
//
  $tmpret165 = NULL;
  $tmp166 = NULL;
  $tmp167 = NULL;
  $tmp168 = NULL;
  $tmp169 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_60:
  $tmp166 = ats2phppre_ref_get_elt($env0);
  $tmp167 = ATSPMVlazyval_eval($tmp166); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab76:
    if(ATSCKptriscons($tmp167)) goto __atstmplab79;
    __atstmplab77:
    $tmpret165 = ats2phppre_ref_get_elt($env1);
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab78:
    __atstmplab79:
    $tmp168 = $tmp167[0];
    $tmp169 = $tmp167[1];
    ats2phppre_ref_set_elt($env0, $tmp169);
    ats2phppre_ref_set_elt($env1, $tmp168);
    $tmpret165 = $tmp168;
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret165;
} // end-of-function


function
ats2phppre_stream_take_while_cloref($arg0, $arg1)
{
//
  $tmpret172 = NULL;
  $tmp173 = NULL;
  $tmp174 = NULL;
  $tmp175 = NULL;
  $tmp176 = NULL;
//
  __patsflab_stream_take_while_cloref:
  $tmp173 = ats2phppre_stream_rtake_while_cloref($arg0, $arg1);
  $tmp174 = $tmp173[0];
  $tmp175 = $tmp173[1];
  $tmp176 = ats2phppre_list_reverse($tmp175);
  $tmpret172 = array($tmp174, $tmp176);
  return $tmpret172;
} // end-of-function


function
ats2phppre_stream_rtake_while_cloref($arg0, $arg1)
{
//
  $tmpret177 = NULL;
  $tmp185 = NULL;
//
  __patsflab_stream_rtake_while_cloref:
  $tmp185 = NULL;
  $tmpret177 = _ats2jspre_stream_loop_63($arg1, $arg0, 0, $tmp185);
  return $tmpret177;
} // end-of-function


function
_ats2jspre_stream_loop_63($env0, $arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmpret178 = NULL;
  $tmp179 = NULL;
  $tmp180 = NULL;
  $tmp181 = NULL;
  $tmp182 = NULL;
  $tmp183 = NULL;
  $tmp184 = NULL;
//
  __patsflab__ats2jspre_stream_loop_63:
  $tmp179 = ATSPMVlazyval_eval($arg0); 
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab80:
    if(ATSCKptriscons($tmp179)) goto __atstmplab83;
    __atstmplab81:
    $tmpret178 = array($arg0, $arg2);
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab82:
    __atstmplab83:
    $tmp180 = $tmp179[0];
    $tmp181 = $tmp179[1];
    $tmp182 = $env0[0]($env0, $arg1, $tmp180);
    if($tmp182) {
      $tmp183 = ats2phppre_add_int1_int1($arg1, 1);
      $tmp184 = array($tmp180, $arg2);
      // ATStailcalseq_beg
      $apy0 = $tmp181;
      $apy1 = $tmp183;
      $apy2 = $tmp184;
      $arg0 = $apy0;
      $arg1 = $apy1;
      $arg2 = $apy2;
      goto __patsflab__ats2jspre_stream_loop_63;
      // ATStailcalseq_end
    } else {
      $tmpret178 = array($arg0, $arg2);
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret178;
} // end-of-function


function
ats2phppre_stream_take_until_cloref($arg0, $arg1)
{
//
  $tmpret186 = NULL;
//
  __patsflab_stream_take_until_cloref:
  $tmpret186 = ats2phppre_stream_take_while_cloref($arg0, _ats2jspre_stream_patsfun_65__closurerize($arg1));
  return $tmpret186;
} // end-of-function


function
_ats2jspre_stream_patsfun_65($env0, $arg0, $arg1)
{
//
  $tmpret187 = NULL;
  $tmp188 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_65:
  $tmp188 = $env0[0]($env0, $arg0, $arg1);
  $tmpret187 = atspre_neg_bool0($tmp188);
  return $tmpret187;
} // end-of-function


function
ats2phppre_stream_rtake_until_cloref($arg0, $arg1)
{
//
  $tmpret189 = NULL;
//
  __patsflab_stream_rtake_until_cloref:
  $tmpret189 = ats2phppre_stream_rtake_while_cloref($arg0, _ats2jspre_stream_patsfun_67__closurerize($arg1));
  return $tmpret189;
} // end-of-function


function
_ats2jspre_stream_patsfun_67($env0, $arg0, $arg1)
{
//
  $tmpret190 = NULL;
  $tmp191 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_67:
  $tmp191 = $env0[0]($env0, $arg0, $arg1);
  $tmpret190 = atspre_neg_bool0($tmp191);
  return $tmpret190;
} // end-of-function


function
ats2phppre_stream_list_xprod2($arg0, $arg1)
{
//
  $tmpret192 = NULL;
//
  __patsflab_stream_list_xprod2:
  $tmpret192 = _ats2jspre_stream_auxlst_71($arg0, $arg1);
  return $tmpret192;
} // end-of-function


function
_ats2jspre_stream_aux_69($arg0, $arg1)
{
//
  $tmpret193 = NULL;
//
  __patsflab__ats2jspre_stream_aux_69:
  $tmpret193 = ATSPMVlazyval(_ats2jspre_stream_patsfun_70__closurerize($arg0, $arg1));
  return $tmpret193;
} // end-of-function


function
_ats2jspre_stream_patsfun_70($env0, $env1)
{
//
  $tmpret194 = NULL;
  $tmp195 = NULL;
  $tmp196 = NULL;
  $tmp197 = NULL;
  $tmp198 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_70:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab84:
    if(ATSCKptriscons($env1)) goto __atstmplab87;
    __atstmplab85:
    $tmpret194 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab86:
    __atstmplab87:
    $tmp195 = $env1[0];
    $tmp196 = $env1[1];
    $tmp197 = array($env0, $tmp195);
    $tmp198 = _ats2jspre_stream_aux_69($env0, $tmp196);
    $tmpret194 = array($tmp197, $tmp198);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret194;
} // end-of-function


function
_ats2jspre_stream_auxlst_71($arg0, $arg1)
{
//
  $tmpret199 = NULL;
//
  __patsflab__ats2jspre_stream_auxlst_71:
  $tmpret199 = ATSPMVlazyval(_ats2jspre_stream_patsfun_72__closurerize($arg0, $arg1));
  return $tmpret199;
} // end-of-function


function
_ats2jspre_stream_patsfun_72($env0, $env1)
{
//
  $tmpret200 = NULL;
  $tmp201 = NULL;
  $tmp202 = NULL;
  $tmp203 = NULL;
  $tmp204 = NULL;
  $tmp205 = NULL;
//
  __patsflab__ats2jspre_stream_patsfun_72:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab88:
    if(ATSCKptriscons($env0)) goto __atstmplab91;
    __atstmplab89:
    $tmpret200 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab90:
    __atstmplab91:
    $tmp201 = $env0[0];
    $tmp202 = $env0[1];
    $tmp204 = _ats2jspre_stream_aux_69($tmp201, $env1);
    $tmp205 = _ats2jspre_stream_auxlst_71($tmp202, $env1);
    $tmp203 = ats2phppre_stream_append($tmp204, $tmp205);
    $tmpret200 = ATSPMVlazyval_eval($tmp203); 
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret200;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/
function
_ats2phppre_stream_vt_patsfun_7__closurerize($env0)
{
  return array(function($cenv) { return _ats2phppre_stream_vt_patsfun_7($cenv[1]); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_10__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_10($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_stream_vt_patsfun_19__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_19($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_stream_vt_patsfun_22__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_22($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_25__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_25($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_stream_vt_patsfun_27__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_27($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_30__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_30($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_stream_vt_patsfun_32__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_32($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_36__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_36($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_40__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_40($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_44__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_44($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_48__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_48($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_52__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_52($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_stream_vt_patsfun_55__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_stream_vt_patsfun_55($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}


function
ats2phppre_stream_vt_free($arg0)
{
//
//
  __patsflab_stream_vt_free:
  atspre_lazy_vt_free($arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_vt2t($arg0)
{
//
  $tmpret6 = NULL;
//
  __patsflab_stream_vt2t:
  $tmpret6 = _ats2phppre_stream_vt_aux_6($arg0);
  return $tmpret6;
} // end-of-function


function
_ats2phppre_stream_vt_aux_6($arg0)
{
//
  $tmpret7 = NULL;
//
  __patsflab__ats2phppre_stream_vt_aux_6:
  $tmpret7 = ATSPMVlazyval(_ats2phppre_stream_vt_patsfun_7__closurerize($arg0));
  return $tmpret7;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_7($env0)
{
//
  $tmpret8 = NULL;
  $tmp9 = NULL;
  $tmp10 = NULL;
  $tmp11 = NULL;
  $tmp12 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_7:
  $tmp9 = ATSPMVllazyval_eval($env0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab0:
    if(ATSCKptriscons($tmp9)) goto __atstmplab3;
    __atstmplab1:
    $tmpret8 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab2:
    __atstmplab3:
    $tmp10 = $tmp9[0];
    $tmp11 = $tmp9[1];
    // ATSINSfreecon($tmp9);
    $tmp12 = _ats2phppre_stream_vt_aux_6($tmp11);
    $tmpret8 = array($tmp10, $tmp12);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret8;
} // end-of-function


function
ats2phppre_stream_vt_takeLte($arg0, $arg1)
{
//
  $tmpret13 = NULL;
//
  __patsflab_stream_vt_takeLte:
  $tmpret13 = _ats2phppre_stream_vt_auxmain_9($arg0, $arg1);
  return $tmpret13;
} // end-of-function


function
_ats2phppre_stream_vt_auxmain_9($arg0, $arg1)
{
//
  $tmpret14 = NULL;
//
  __patsflab__ats2phppre_stream_vt_auxmain_9:
  $tmpret14 = ATSPMVllazyval(_ats2phppre_stream_vt_patsfun_10__closurerize($arg0, $arg1));
  return $tmpret14;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_10($env0, $env1, $arg0)
{
//
  $tmpret15 = NULL;
  $tmp16 = NULL;
  $tmp17 = NULL;
  $tmp18 = NULL;
  $tmp19 = NULL;
  $tmp20 = NULL;
  $tmp21 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_10:
  if($arg0) {
    $tmp16 = ats2phppre_gt_int1_int1($env1, 0);
    if($tmp16) {
      $tmp17 = ATSPMVllazyval_eval($env0);
      // ATScaseofseq_beg
      do {
        // ATSbranchseq_beg
        __atstmplab4:
        if(ATSCKptriscons($tmp17)) goto __atstmplab7;
        __atstmplab5:
        $tmpret15 = NULL;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        __atstmplab6:
        __atstmplab7:
        $tmp18 = $tmp17[0];
        $tmp19 = $tmp17[1];
        // ATSINSfreecon($tmp17);
        $tmp21 = ats2phppre_sub_int1_int1($env1, 1);
        $tmp20 = _ats2phppre_stream_vt_auxmain_9($tmp19, $tmp21);
        $tmpret15 = array($tmp18, $tmp20);
        break;
        // ATSbranchseq_end
      } while(0);
      // ATScaseofseq_end
    } else {
      atspre_lazy_vt_free($env0);
      $tmpret15 = NULL;
    } // endif
  } else {
    atspre_lazy_vt_free($env0);
  } // endif
  return $tmpret15;
} // end-of-function


function
ats2phppre_stream_vt_length($arg0)
{
//
  $tmpret24 = NULL;
//
  __patsflab_stream_vt_length:
  $tmpret24 = _ats2phppre_stream_vt_loop_12($arg0, 0);
  return $tmpret24;
} // end-of-function


function
_ats2phppre_stream_vt_loop_12($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret25 = NULL;
  $tmp26 = NULL;
  $tmp28 = NULL;
  $tmp29 = NULL;
//
  __patsflab__ats2phppre_stream_vt_loop_12:
  $tmp26 = ATSPMVllazyval_eval($arg0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab8:
    if(ATSCKptriscons($tmp26)) goto __atstmplab11;
    __atstmplab9:
    $tmpret25 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab10:
    __atstmplab11:
    $tmp28 = $tmp26[1];
    // ATSINSfreecon($tmp26);
    $tmp29 = ats2phppre_add_int1_int1($arg1, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp28;
    $apy1 = $tmp29;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_stream_vt_loop_12;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret25;
} // end-of-function


function
ats2phppre_stream2list_vt($arg0)
{
//
  $tmpret30 = NULL;
//
  __patsflab_stream2list_vt:
  $tmpret30 = _ats2phppre_stream_vt_aux_14($arg0);
  return $tmpret30;
} // end-of-function


function
_ats2phppre_stream_vt_aux_14($arg0)
{
//
  $tmpret31 = NULL;
  $tmp32 = NULL;
  $tmp33 = NULL;
  $tmp34 = NULL;
  $tmp35 = NULL;
//
  __patsflab__ats2phppre_stream_vt_aux_14:
  $tmp32 = ATSPMVllazyval_eval($arg0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab12:
    if(ATSCKptriscons($tmp32)) goto __atstmplab15;
    __atstmplab13:
    $tmpret31 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab14:
    __atstmplab15:
    $tmp33 = $tmp32[0];
    $tmp34 = $tmp32[1];
    // ATSINSfreecon($tmp32);
    $tmp35 = _ats2phppre_stream_vt_aux_14($tmp34);
    $tmpret31 = array($tmp33, $tmp35);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret31;
} // end-of-function


function
ats2phppre_stream2list_vt_rev($arg0)
{
//
  $tmpret36 = NULL;
  $tmp42 = NULL;
//
  __patsflab_stream2list_vt_rev:
  $tmp42 = NULL;
  $tmpret36 = _ats2phppre_stream_vt_loop_16($arg0, $tmp42);
  return $tmpret36;
} // end-of-function


function
_ats2phppre_stream_vt_loop_16($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret37 = NULL;
  $tmp38 = NULL;
  $tmp39 = NULL;
  $tmp40 = NULL;
  $tmp41 = NULL;
//
  __patsflab__ats2phppre_stream_vt_loop_16:
  $tmp38 = ATSPMVllazyval_eval($arg0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab16:
    if(ATSCKptriscons($tmp38)) goto __atstmplab19;
    __atstmplab17:
    $tmpret37 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab18:
    __atstmplab19:
    $tmp39 = $tmp38[0];
    $tmp40 = $tmp38[1];
    // ATSINSfreecon($tmp38);
    $tmp41 = array($tmp39, $arg1);
    // ATStailcalseq_beg
    $apy0 = $tmp40;
    $apy1 = $tmp41;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_stream_vt_loop_16;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret37;
} // end-of-function


function
ats2phppre_stream_vt_append($arg0, $arg1)
{
//
  $tmpret43 = NULL;
//
  __patsflab_stream_vt_append:
  $tmpret43 = _ats2phppre_stream_vt_auxmain_18($arg0, $arg1);
  return $tmpret43;
} // end-of-function


function
_ats2phppre_stream_vt_auxmain_18($arg0, $arg1)
{
//
  $tmpret44 = NULL;
//
  __patsflab__ats2phppre_stream_vt_auxmain_18:
  $tmpret44 = ATSPMVllazyval(_ats2phppre_stream_vt_patsfun_19__closurerize($arg0, $arg1));
  return $tmpret44;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_19($env0, $env1, $arg0)
{
//
  $tmpret45 = NULL;
  $tmp46 = NULL;
  $tmp47 = NULL;
  $tmp48 = NULL;
  $tmp49 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_19:
  if($arg0) {
    $tmp46 = ATSPMVllazyval_eval($env0);
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab20:
      if(ATSCKptriscons($tmp46)) goto __atstmplab23;
      __atstmplab21:
      $tmpret45 = ATSPMVllazyval_eval($env1);
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab22:
      __atstmplab23:
      $tmp47 = $tmp46[0];
      $tmp48 = $tmp46[1];
      // ATSINSfreecon($tmp46);
      $tmp49 = _ats2phppre_stream_vt_auxmain_18($tmp48, $env1);
      $tmpret45 = array($tmp47, $tmp49);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
    atspre_lazy_vt_free($env0);
    atspre_lazy_vt_free($env1);
  } // endif
  return $tmpret45;
} // end-of-function


function
ats2phppre_stream_vt_concat($arg0)
{
//
  $tmpret52 = NULL;
//
  __patsflab_stream_vt_concat:
  $tmpret52 = _ats2phppre_stream_vt_auxmain_21($arg0);
  return $tmpret52;
} // end-of-function


function
_ats2phppre_stream_vt_auxmain_21($arg0)
{
//
  $tmpret53 = NULL;
//
  __patsflab__ats2phppre_stream_vt_auxmain_21:
  $tmpret53 = ATSPMVllazyval(_ats2phppre_stream_vt_patsfun_22__closurerize($arg0));
  return $tmpret53;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_22($env0, $arg0)
{
//
  $tmpret54 = NULL;
  $tmp55 = NULL;
  $tmp56 = NULL;
  $tmp57 = NULL;
  $tmp58 = NULL;
  $tmp59 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_22:
  if($arg0) {
    $tmp55 = ATSPMVllazyval_eval($env0);
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab24:
      if(ATSCKptriscons($tmp55)) goto __atstmplab27;
      __atstmplab25:
      $tmpret54 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab26:
      __atstmplab27:
      $tmp56 = $tmp55[0];
      $tmp57 = $tmp55[1];
      // ATSINSfreecon($tmp55);
      $tmp59 = _ats2phppre_stream_vt_auxmain_21($tmp57);
      $tmp58 = ats2phppre_stream_vt_append($tmp56, $tmp59);
      $tmpret54 = ATSPMVllazyval_eval($tmp58);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
    atspre_lazy_vt_free($env0);
  } // endif
  return $tmpret54;
} // end-of-function


function
ats2phppre_stream_vt_map_cloref($arg0, $arg1)
{
//
  $tmpret61 = NULL;
//
  __patsflab_stream_vt_map_cloref:
  $tmpret61 = _ats2phppre_stream_vt_auxmain_24($arg1, $arg0);
  return $tmpret61;
} // end-of-function


function
_ats2phppre_stream_vt_auxmain_24($env0, $arg0)
{
//
  $tmpret62 = NULL;
//
  __patsflab__ats2phppre_stream_vt_auxmain_24:
  $tmpret62 = ATSPMVllazyval(_ats2phppre_stream_vt_patsfun_25__closurerize($env0, $arg0));
  return $tmpret62;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_25($env0, $env1, $arg0)
{
//
  $tmpret63 = NULL;
  $tmp64 = NULL;
  $tmp65 = NULL;
  $tmp66 = NULL;
  $tmp67 = NULL;
  $tmp68 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_25:
  if($arg0) {
    $tmp64 = ATSPMVllazyval_eval($env1);
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab28:
      if(ATSCKptriscons($tmp64)) goto __atstmplab31;
      __atstmplab29:
      $tmpret63 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab30:
      __atstmplab31:
      $tmp65 = $tmp64[0];
      $tmp66 = $tmp64[1];
      // ATSINSfreecon($tmp64);
      $tmp67 = $env0[0]($env0, $tmp65);
      $tmp68 = _ats2phppre_stream_vt_auxmain_24($env0, $tmp66);
      $tmpret63 = array($tmp67, $tmp68);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
    atspre_lazy_vt_free($env1);
  } // endif
  return $tmpret63;
} // end-of-function


function
ats2phppre_stream_vt_map_method($arg0, $arg1)
{
//
  $tmpret70 = NULL;
//
  __patsflab_stream_vt_map_method:
  $tmpret70 = _ats2phppre_stream_vt_patsfun_27__closurerize($arg0);
  return $tmpret70;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_27($env0, $arg0)
{
//
  $tmpret71 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_27:
  $tmpret71 = ats2phppre_stream_vt_map_cloref($env0, $arg0);
  return $tmpret71;
} // end-of-function


function
ats2phppre_stream_vt_filter_cloref($arg0, $arg1)
{
//
  $tmpret72 = NULL;
//
  __patsflab_stream_vt_filter_cloref:
  $tmpret72 = _ats2phppre_stream_vt_auxmain_29($arg1, $arg0);
  return $tmpret72;
} // end-of-function


function
_ats2phppre_stream_vt_auxmain_29($env0, $arg0)
{
//
  $tmpret73 = NULL;
//
  __patsflab__ats2phppre_stream_vt_auxmain_29:
  $tmpret73 = ATSPMVllazyval(_ats2phppre_stream_vt_patsfun_30__closurerize($env0, $arg0));
  return $tmpret73;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_30($env0, $env1, $arg0)
{
//
  $tmpret74 = NULL;
  $tmp75 = NULL;
  $tmp76 = NULL;
  $tmp77 = NULL;
  $tmp78 = NULL;
  $tmp79 = NULL;
  $tmp80 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_30:
  if($arg0) {
    $tmp75 = ATSPMVllazyval_eval($env1);
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab32:
      if(ATSCKptriscons($tmp75)) goto __atstmplab35;
      __atstmplab33:
      $tmpret74 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab34:
      __atstmplab35:
      $tmp76 = $tmp75[0];
      $tmp77 = $tmp75[1];
      // ATSINSfreecon($tmp75);
      $tmp78 = $env0[0]($env0, $tmp76);
      if($tmp78) {
        $tmp79 = _ats2phppre_stream_vt_auxmain_29($env0, $tmp77);
        $tmpret74 = array($tmp76, $tmp79);
      } else {
        $tmp80 = _ats2phppre_stream_vt_auxmain_29($env0, $tmp77);
        $tmpret74 = ATSPMVllazyval_eval($tmp80);
      } // endif
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
  } else {
    atspre_lazy_vt_free($env1);
  } // endif
  return $tmpret74;
} // end-of-function


function
ats2phppre_stream_vt_filter_method($arg0)
{
//
  $tmpret82 = NULL;
//
  __patsflab_stream_vt_filter_method:
  $tmpret82 = _ats2phppre_stream_vt_patsfun_32__closurerize($arg0);
  return $tmpret82;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_32($env0, $arg0)
{
//
  $tmpret83 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_32:
  $tmpret83 = ats2phppre_stream_vt_filter_cloref($env0, $arg0);
  return $tmpret83;
} // end-of-function


function
ats2phppre_stream_vt_exists_cloref($arg0, $arg1)
{
//
  $tmpret84 = NULL;
//
  __patsflab_stream_vt_exists_cloref:
  $tmpret84 = _ats2phppre_stream_vt_loop_34($arg1, $arg0);
  return $tmpret84;
} // end-of-function


function
_ats2phppre_stream_vt_loop_34($env0, $arg0)
{
//
  $apy0 = NULL;
  $tmpret85 = NULL;
  $tmp86 = NULL;
  $tmp87 = NULL;
  $tmp88 = NULL;
  $tmp89 = NULL;
//
  __patsflab__ats2phppre_stream_vt_loop_34:
  $tmp86 = ATSPMVllazyval_eval($arg0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab36:
    if(ATSCKptriscons($tmp86)) goto __atstmplab39;
    __atstmplab37:
    $tmpret85 = false;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab38:
    __atstmplab39:
    $tmp87 = $tmp86[0];
    $tmp88 = $tmp86[1];
    // ATSINSfreecon($tmp86);
    $tmp89 = $env0[0]($env0, $tmp87);
    if($tmp89) {
      atspre_lazy_vt_free($tmp88);
      $tmpret85 = true;
    } else {
      // ATStailcalseq_beg
      $apy0 = $tmp88;
      $arg0 = $apy0;
      goto __patsflab__ats2phppre_stream_vt_loop_34;
      // ATStailcalseq_end
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret85;
} // end-of-function


function
ats2phppre_stream_vt_exists_method($arg0)
{
//
  $tmpret91 = NULL;
//
  __patsflab_stream_vt_exists_method:
  $tmpret91 = _ats2phppre_stream_vt_patsfun_36__closurerize($arg0);
  return $tmpret91;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_36($env0, $arg0)
{
//
  $tmpret92 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_36:
  $tmpret92 = ats2phppre_stream_vt_exists_cloref($env0, $arg0);
  return $tmpret92;
} // end-of-function


function
ats2phppre_stream_vt_forall_cloref($arg0, $arg1)
{
//
  $tmpret93 = NULL;
//
  __patsflab_stream_vt_forall_cloref:
  $tmpret93 = _ats2phppre_stream_vt_loop_38($arg1, $arg0);
  return $tmpret93;
} // end-of-function


function
_ats2phppre_stream_vt_loop_38($env0, $arg0)
{
//
  $apy0 = NULL;
  $tmpret94 = NULL;
  $tmp95 = NULL;
  $tmp96 = NULL;
  $tmp97 = NULL;
  $tmp98 = NULL;
//
  __patsflab__ats2phppre_stream_vt_loop_38:
  $tmp95 = ATSPMVllazyval_eval($arg0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab40:
    if(ATSCKptriscons($tmp95)) goto __atstmplab43;
    __atstmplab41:
    $tmpret94 = true;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab42:
    __atstmplab43:
    $tmp96 = $tmp95[0];
    $tmp97 = $tmp95[1];
    // ATSINSfreecon($tmp95);
    $tmp98 = $env0[0]($env0, $tmp96);
    if($tmp98) {
      // ATStailcalseq_beg
      $apy0 = $tmp97;
      $arg0 = $apy0;
      goto __patsflab__ats2phppre_stream_vt_loop_38;
      // ATStailcalseq_end
    } else {
      atspre_lazy_vt_free($tmp97);
      $tmpret94 = false;
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret94;
} // end-of-function


function
ats2phppre_stream_vt_forall_method($arg0)
{
//
  $tmpret100 = NULL;
//
  __patsflab_stream_vt_forall_method:
  $tmpret100 = _ats2phppre_stream_vt_patsfun_40__closurerize($arg0);
  return $tmpret100;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_40($env0, $arg0)
{
//
  $tmpret101 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_40:
  $tmpret101 = ats2phppre_stream_vt_forall_cloref($env0, $arg0);
  return $tmpret101;
} // end-of-function


function
ats2phppre_stream_vt_foreach_cloref($arg0, $arg1)
{
//
//
  __patsflab_stream_vt_foreach_cloref:
  _ats2phppre_stream_vt_loop_42($arg1, $arg0);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_stream_vt_loop_42($env0, $arg0)
{
//
  $apy0 = NULL;
  $tmp104 = NULL;
  $tmp105 = NULL;
  $tmp106 = NULL;
//
  __patsflab__ats2phppre_stream_vt_loop_42:
  $tmp104 = ATSPMVllazyval_eval($arg0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab44:
    if(ATSCKptriscons($tmp104)) goto __atstmplab47;
    __atstmplab45:
    // ATSINSmove_void;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab46:
    __atstmplab47:
    $tmp105 = $tmp104[0];
    $tmp106 = $tmp104[1];
    // ATSINSfreecon($tmp104);
    $env0[0]($env0, $tmp105);
    // ATStailcalseq_beg
    $apy0 = $tmp106;
    $arg0 = $apy0;
    goto __patsflab__ats2phppre_stream_vt_loop_42;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_vt_foreach_method($arg0)
{
//
  $tmpret108 = NULL;
//
  __patsflab_stream_vt_foreach_method:
  $tmpret108 = _ats2phppre_stream_vt_patsfun_44__closurerize($arg0);
  return $tmpret108;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_44($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_stream_vt_patsfun_44:
  ats2phppre_stream_vt_foreach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_vt_iforeach_cloref($arg0, $arg1)
{
//
//
  __patsflab_stream_vt_iforeach_cloref:
  _ats2phppre_stream_vt_loop_46($arg1, 0, $arg0);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_stream_vt_loop_46($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmp112 = NULL;
  $tmp113 = NULL;
  $tmp114 = NULL;
  $tmp116 = NULL;
//
  __patsflab__ats2phppre_stream_vt_loop_46:
  $tmp112 = ATSPMVllazyval_eval($arg1);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab48:
    if(ATSCKptriscons($tmp112)) goto __atstmplab51;
    __atstmplab49:
    // ATSINSmove_void;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab50:
    __atstmplab51:
    $tmp113 = $tmp112[0];
    $tmp114 = $tmp112[1];
    // ATSINSfreecon($tmp112);
    $env0[0]($env0, $arg0, $tmp113);
    $tmp116 = ats2phppre_add_int1_int1($arg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp116;
    $apy1 = $tmp114;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_stream_vt_loop_46;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_vt_iforeach_method($arg0)
{
//
  $tmpret117 = NULL;
//
  __patsflab_stream_vt_iforeach_method:
  $tmpret117 = _ats2phppre_stream_vt_patsfun_48__closurerize($arg0);
  return $tmpret117;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_48($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_stream_vt_patsfun_48:
  ats2phppre_stream_vt_iforeach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_vt_rforeach_cloref($arg0, $arg1)
{
//
//
  __patsflab_stream_vt_rforeach_cloref:
  _ats2phppre_stream_vt_auxmain_50($arg1, $arg0);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_stream_vt_auxmain_50($env0, $arg0)
{
//
  $tmp121 = NULL;
  $tmp122 = NULL;
  $tmp123 = NULL;
//
  __patsflab__ats2phppre_stream_vt_auxmain_50:
  $tmp121 = ATSPMVllazyval_eval($arg0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab52:
    if(ATSCKptriscons($tmp121)) goto __atstmplab55;
    __atstmplab53:
    // ATSINSmove_void;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab54:
    __atstmplab55:
    $tmp122 = $tmp121[0];
    $tmp123 = $tmp121[1];
    // ATSINSfreecon($tmp121);
    _ats2phppre_stream_vt_auxmain_50($env0, $tmp123);
    $env0[0]($env0, $tmp122);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_vt_rforeach_method($arg0)
{
//
  $tmpret125 = NULL;
//
  __patsflab_stream_vt_rforeach_method:
  $tmpret125 = _ats2phppre_stream_vt_patsfun_52__closurerize($arg0);
  return $tmpret125;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_52($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_stream_vt_patsfun_52:
  ats2phppre_stream_vt_rforeach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_stream_vt_tabulate_cloref($arg0)
{
//
  $tmpret127 = NULL;
//
  __patsflab_stream_vt_tabulate_cloref:
  $tmpret127 = _ats2phppre_stream_vt_auxmain_54($arg0, 0);
  return $tmpret127;
} // end-of-function


function
_ats2phppre_stream_vt_auxmain_54($env0, $arg0)
{
//
  $tmpret128 = NULL;
//
  __patsflab__ats2phppre_stream_vt_auxmain_54:
  $tmpret128 = ATSPMVllazyval(_ats2phppre_stream_vt_patsfun_55__closurerize($env0, $arg0));
  return $tmpret128;
} // end-of-function


function
_ats2phppre_stream_vt_patsfun_55($env0, $env1, $arg0)
{
//
  $tmpret129 = NULL;
  $tmp130 = NULL;
  $tmp131 = NULL;
  $tmp132 = NULL;
//
  __patsflab__ats2phppre_stream_vt_patsfun_55:
  if($arg0) {
    $tmp130 = $env0[0]($env0, $env1);
    $tmp132 = ats2phppre_add_int1_int1($env1, 1);
    $tmp131 = _ats2phppre_stream_vt_auxmain_54($env0, $tmp132);
    $tmpret129 = array($tmp130, $tmp131);
  } else {
  } // endif
  return $tmpret129;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/
function
_ats2phppre_intrange_patsfun_4__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_4($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_9__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_9($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_11__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_11($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_13__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_13($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_16__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_16($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_intrange_patsfun_20__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_20($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_23__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_23($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_26__closurerize($env0, $env1, $env2)
{
  return array(function($cenv) { return _ats2phppre_intrange_patsfun_26($cenv[1], $cenv[2], $cenv[3]); }, $env0, $env1, $env2);
}

function
_ats2phppre_intrange_patsfun_28__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_28($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_31__closurerize($env0, $env1, $env2)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_31($cenv[1], $cenv[2], $cenv[3], $arg0); }, $env0, $env1, $env2);
}

function
_ats2phppre_intrange_patsfun_33__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_33($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_40__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_40($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_44__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_44($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_48__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_48($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_52__closurerize($env0, $env1, $env2)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_52($cenv[1], $cenv[2], $cenv[3], $arg0); }, $env0, $env1, $env2);
}


function
ats2phppre_int_repeat_lazy($arg0, $arg1)
{
//
  $tmp1 = NULL;
//
  __patsflab_int_repeat_lazy:
  $tmp1 = ats2phppre_lazy2cloref($arg1);
  ats2phppre_int_repeat_cloref($arg0, $tmp1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_repeat_cloref($arg0, $arg1)
{
//
//
  __patsflab_int_repeat_cloref:
  _ats2phppre_intrange_loop_2($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_intrange_loop_2($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmp4 = NULL;
  $tmp6 = NULL;
//
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
ats2phppre_int_repeat_method($arg0)
{
//
  $tmpret7 = NULL;
//
  __patsflab_int_repeat_method:
  $tmpret7 = _ats2phppre_intrange_patsfun_4__closurerize($arg0);
  return $tmpret7;
} // end-of-function


function
_ats2phppre_intrange_patsfun_4($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_intrange_patsfun_4:
  ats2phppre_int_repeat_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_exists_cloref($arg0, $arg1)
{
//
  $tmpret9 = NULL;
//
  __patsflab_int_exists_cloref:
  $tmpret9 = ats2phppre_intrange_exists_cloref(0, $arg0, $arg1);
  return $tmpret9;
} // end-of-function


function
ats2phppre_int_forall_cloref($arg0, $arg1)
{
//
  $tmpret10 = NULL;
//
  __patsflab_int_forall_cloref:
  $tmpret10 = ats2phppre_intrange_forall_cloref(0, $arg0, $arg1);
  return $tmpret10;
} // end-of-function


function
ats2phppre_int_foreach_cloref($arg0, $arg1)
{
//
//
  __patsflab_int_foreach_cloref:
  ats2phppre_intrange_foreach_cloref(0, $arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_exists_method($arg0)
{
//
  $tmpret12 = NULL;
//
  __patsflab_int_exists_method:
  $tmpret12 = _ats2phppre_intrange_patsfun_9__closurerize($arg0);
  return $tmpret12;
} // end-of-function


function
_ats2phppre_intrange_patsfun_9($env0, $arg0)
{
//
  $tmpret13 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_9:
  $tmpret13 = ats2phppre_int_exists_cloref($env0, $arg0);
  return $tmpret13;
} // end-of-function


function
ats2phppre_int_forall_method($arg0)
{
//
  $tmpret14 = NULL;
//
  __patsflab_int_forall_method:
  $tmpret14 = _ats2phppre_intrange_patsfun_11__closurerize($arg0);
  return $tmpret14;
} // end-of-function


function
_ats2phppre_intrange_patsfun_11($env0, $arg0)
{
//
  $tmpret15 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_11:
  $tmpret15 = ats2phppre_int_forall_cloref($env0, $arg0);
  return $tmpret15;
} // end-of-function


function
ats2phppre_int_foreach_method($arg0)
{
//
  $tmpret16 = NULL;
//
  __patsflab_int_foreach_method:
  $tmpret16 = _ats2phppre_intrange_patsfun_13__closurerize($arg0);
  return $tmpret16;
} // end-of-function


function
_ats2phppre_intrange_patsfun_13($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_intrange_patsfun_13:
  ats2phppre_int_foreach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_foldleft_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret18 = NULL;
//
  __patsflab_int_foldleft_cloref:
  $tmpret18 = ats2phppre_intrange_foldleft_cloref(0, $arg0, $arg1, $arg2);
  return $tmpret18;
} // end-of-function


function
ats2phppre_int_foldleft_method($arg0, $arg1)
{
//
  $tmpret19 = NULL;
//
  __patsflab_int_foldleft_method:
  $tmpret19 = _ats2phppre_intrange_patsfun_16__closurerize($arg0, $arg1);
  return $tmpret19;
} // end-of-function


function
_ats2phppre_intrange_patsfun_16($env0, $env1, $arg0)
{
//
  $tmpret20 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_16:
  $tmpret20 = ats2phppre_int_foldleft_cloref($env0, $env1, $arg0);
  return $tmpret20;
} // end-of-function


function
ats2phppre_int_list_map_cloref($arg0, $arg1)
{
//
  $tmpret21 = NULL;
//
  __patsflab_int_list_map_cloref:
  $tmpret21 = _ats2phppre_intrange_aux_18($arg0, $arg1, 0);
  return $tmpret21;
} // end-of-function


function
_ats2phppre_intrange_aux_18($env0, $env1, $arg0)
{
//
  $tmpret22 = NULL;
  $tmp23 = NULL;
  $tmp24 = NULL;
  $tmp25 = NULL;
  $tmp26 = NULL;
//
  __patsflab__ats2phppre_intrange_aux_18:
  $tmp23 = ats2phppre_lt_int1_int1($arg0, $env0);
  if($tmp23) {
    $tmp24 = $env1[0]($env1, $arg0);
    $tmp26 = ats2phppre_add_int1_int1($arg0, 1);
    $tmp25 = _ats2phppre_intrange_aux_18($env0, $env1, $tmp26);
    $tmpret22 = array($tmp24, $tmp25);
  } else {
    $tmpret22 = NULL;
  } // endif
  return $tmpret22;
} // end-of-function


function
ats2phppre_int_list_map_method($arg0, $arg1)
{
//
  $tmpret27 = NULL;
//
  __patsflab_int_list_map_method:
  $tmpret27 = _ats2phppre_intrange_patsfun_20__closurerize($arg0);
  return $tmpret27;
} // end-of-function


function
_ats2phppre_intrange_patsfun_20($env0, $arg0)
{
//
  $tmpret28 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_20:
  $tmpret28 = ats2phppre_int_list_map_cloref($env0, $arg0);
  return $tmpret28;
} // end-of-function


function
ats2phppre_int_list0_map_cloref($arg0, $arg1)
{
//
  $tmpret29 = NULL;
  $tmp30 = NULL;
  $tmp31 = NULL;
//
  __patsflab_int_list0_map_cloref:
  $tmp30 = ats2phppre_gte_int1_int1($arg0, 0);
  if($tmp30) {
    $tmp31 = ats2phppre_int_list_map_cloref($arg0, $arg1);
    $tmpret29 = $tmp31;
  } else {
    $tmpret29 = NULL;
  } // endif
  return $tmpret29;
} // end-of-function


function
ats2phppre_int_list0_map_method($arg0, $arg1)
{
//
  $tmpret32 = NULL;
//
  __patsflab_int_list0_map_method:
  $tmpret32 = _ats2phppre_intrange_patsfun_23__closurerize($arg0);
  return $tmpret32;
} // end-of-function


function
_ats2phppre_intrange_patsfun_23($env0, $arg0)
{
//
  $tmpret33 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_23:
  $tmpret33 = ats2phppre_int_list0_map_cloref($env0, $arg0);
  return $tmpret33;
} // end-of-function


function
ats2phppre_int_stream_map_cloref($arg0, $arg1)
{
//
  $tmpret34 = NULL;
//
  __patsflab_int_stream_map_cloref:
  $tmpret34 = _ats2phppre_intrange_aux_25($arg0, $arg1, 0);
  return $tmpret34;
} // end-of-function


function
_ats2phppre_intrange_aux_25($env0, $env1, $arg0)
{
//
  $tmpret35 = NULL;
//
  __patsflab__ats2phppre_intrange_aux_25:
  $tmpret35 = ATSPMVlazyval(_ats2phppre_intrange_patsfun_26__closurerize($env0, $env1, $arg0));
  return $tmpret35;
} // end-of-function


function
_ats2phppre_intrange_patsfun_26($env0, $env1, $env2)
{
//
  $tmpret36 = NULL;
  $tmp37 = NULL;
  $tmp38 = NULL;
  $tmp39 = NULL;
  $tmp40 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_26:
  $tmp37 = ats2phppre_lt_int1_int1($env2, $env0);
  if($tmp37) {
    $tmp38 = $env1[0]($env1, $env2);
    $tmp40 = ats2phppre_add_int1_int1($env2, 1);
    $tmp39 = _ats2phppre_intrange_aux_25($env0, $env1, $tmp40);
    $tmpret36 = array($tmp38, $tmp39);
  } else {
    $tmpret36 = NULL;
  } // endif
  return $tmpret36;
} // end-of-function


function
ats2phppre_int_stream_map_method($arg0, $arg1)
{
//
  $tmpret41 = NULL;
//
  __patsflab_int_stream_map_method:
  $tmpret41 = _ats2phppre_intrange_patsfun_28__closurerize($arg0);
  return $tmpret41;
} // end-of-function


function
_ats2phppre_intrange_patsfun_28($env0, $arg0)
{
//
  $tmpret42 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_28:
  $tmpret42 = ats2phppre_int_stream_map_cloref($env0, $arg0);
  return $tmpret42;
} // end-of-function


function
ats2phppre_int_stream_vt_map_cloref($arg0, $arg1)
{
//
  $tmpret43 = NULL;
//
  __patsflab_int_stream_vt_map_cloref:
  $tmpret43 = _ats2phppre_intrange_aux_30($arg0, $arg1, 0);
  return $tmpret43;
} // end-of-function


function
_ats2phppre_intrange_aux_30($env0, $env1, $arg0)
{
//
  $tmpret44 = NULL;
//
  __patsflab__ats2phppre_intrange_aux_30:
  $tmpret44 = ATSPMVllazyval(_ats2phppre_intrange_patsfun_31__closurerize($env0, $env1, $arg0));
  return $tmpret44;
} // end-of-function


function
_ats2phppre_intrange_patsfun_31($env0, $env1, $env2, $arg0)
{
//
  $tmpret45 = NULL;
  $tmp46 = NULL;
  $tmp47 = NULL;
  $tmp48 = NULL;
  $tmp49 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_31:
  if($arg0) {
    $tmp46 = ats2phppre_lt_int1_int1($env2, $env0);
    if($tmp46) {
      $tmp47 = $env1[0]($env1, $env2);
      $tmp49 = ats2phppre_add_int1_int1($env2, 1);
      $tmp48 = _ats2phppre_intrange_aux_30($env0, $env1, $tmp49);
      $tmpret45 = array($tmp47, $tmp48);
    } else {
      $tmpret45 = NULL;
    } // endif
  } else {
  } // endif
  return $tmpret45;
} // end-of-function


function
ats2phppre_int_stream_vt_map_method($arg0, $arg1)
{
//
  $tmpret50 = NULL;
//
  __patsflab_int_stream_vt_map_method:
  $tmpret50 = _ats2phppre_intrange_patsfun_33__closurerize($arg0);
  return $tmpret50;
} // end-of-function


function
_ats2phppre_intrange_patsfun_33($env0, $arg0)
{
//
  $tmpret51 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_33:
  $tmpret51 = ats2phppre_int_stream_vt_map_cloref($env0, $arg0);
  return $tmpret51;
} // end-of-function


function
ats2phppre_int2_exists_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret52 = NULL;
//
  __patsflab_int2_exists_cloref:
  $tmpret52 = ats2phppre_intrange2_exists_cloref(0, $arg0, 0, $arg1, $arg2);
  return $tmpret52;
} // end-of-function


function
ats2phppre_int2_forall_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret53 = NULL;
//
  __patsflab_int2_forall_cloref:
  $tmpret53 = ats2phppre_intrange2_forall_cloref(0, $arg0, 0, $arg1, $arg2);
  return $tmpret53;
} // end-of-function


function
ats2phppre_int2_foreach_cloref($arg0, $arg1, $arg2)
{
//
//
  __patsflab_int2_foreach_cloref:
  ats2phppre_intrange2_foreach_cloref(0, $arg0, 0, $arg1, $arg2);
  return/*_void*/;
} // end-of-function


function
ats2phppre_intrange_exists_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret55 = NULL;
//
  __patsflab_intrange_exists_cloref:
  $tmpret55 = _ats2phppre_intrange_loop_38($arg0, $arg1, $arg2);
  return $tmpret55;
} // end-of-function


function
_ats2phppre_intrange_loop_38($arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmpret56 = NULL;
  $tmp57 = NULL;
  $tmp58 = NULL;
  $tmp59 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_38:
  $tmp57 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp57) {
    $tmp58 = $arg2[0]($arg2, $arg0);
    if($tmp58) {
      $tmpret56 = true;
    } else {
      $tmp59 = ats2phppre_add_int0_int0($arg0, 1);
      // ATStailcalseq_beg
      $apy0 = $tmp59;
      $apy1 = $arg1;
      $apy2 = $arg2;
      $arg0 = $apy0;
      $arg1 = $apy1;
      $arg2 = $apy2;
      goto __patsflab__ats2phppre_intrange_loop_38;
      // ATStailcalseq_end
    } // endif
  } else {
    $tmpret56 = false;
  } // endif
  return $tmpret56;
} // end-of-function


function
ats2phppre_intrange_exists_method($arg0)
{
//
  $tmpret60 = NULL;
//
  __patsflab_intrange_exists_method:
  $tmpret60 = _ats2phppre_intrange_patsfun_40__closurerize($arg0);
  return $tmpret60;
} // end-of-function


function
_ats2phppre_intrange_patsfun_40($env0, $arg0)
{
//
  $tmpret61 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_40:
  $tmpret61 = ats2phppre_intrange_exists_cloref($env0[0], $env0[1], $arg0);
  return $tmpret61;
} // end-of-function


function
ats2phppre_intrange_forall_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret62 = NULL;
//
  __patsflab_intrange_forall_cloref:
  $tmpret62 = _ats2phppre_intrange_loop_42($arg0, $arg1, $arg2);
  return $tmpret62;
} // end-of-function


function
_ats2phppre_intrange_loop_42($arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmpret63 = NULL;
  $tmp64 = NULL;
  $tmp65 = NULL;
  $tmp66 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_42:
  $tmp64 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp64) {
    $tmp65 = $arg2[0]($arg2, $arg0);
    if($tmp65) {
      $tmp66 = ats2phppre_add_int0_int0($arg0, 1);
      // ATStailcalseq_beg
      $apy0 = $tmp66;
      $apy1 = $arg1;
      $apy2 = $arg2;
      $arg0 = $apy0;
      $arg1 = $apy1;
      $arg2 = $apy2;
      goto __patsflab__ats2phppre_intrange_loop_42;
      // ATStailcalseq_end
    } else {
      $tmpret63 = false;
    } // endif
  } else {
    $tmpret63 = true;
  } // endif
  return $tmpret63;
} // end-of-function


function
ats2phppre_intrange_forall_method($arg0)
{
//
  $tmpret67 = NULL;
//
  __patsflab_intrange_forall_method:
  $tmpret67 = _ats2phppre_intrange_patsfun_44__closurerize($arg0);
  return $tmpret67;
} // end-of-function


function
_ats2phppre_intrange_patsfun_44($env0, $arg0)
{
//
  $tmpret68 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_44:
  $tmpret68 = ats2phppre_intrange_forall_cloref($env0[0], $env0[1], $arg0);
  return $tmpret68;
} // end-of-function


function
ats2phppre_intrange_foreach_cloref($arg0, $arg1, $arg2)
{
//
//
  __patsflab_intrange_foreach_cloref:
  _ats2phppre_intrange_loop_46($arg0, $arg1, $arg2);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_intrange_loop_46($arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmp71 = NULL;
  $tmp73 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_46:
  $tmp71 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp71) {
    $arg2[0]($arg2, $arg0);
    $tmp73 = ats2phppre_add_int0_int0($arg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp73;
    $apy1 = $arg1;
    $apy2 = $arg2;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    goto __patsflab__ats2phppre_intrange_loop_46;
    // ATStailcalseq_end
  } else {
    // ATSINSmove_void;
  } // endif
  return/*_void*/;
} // end-of-function


function
ats2phppre_intrange_foreach_method($arg0)
{
//
  $tmpret74 = NULL;
//
  __patsflab_intrange_foreach_method:
  $tmpret74 = _ats2phppre_intrange_patsfun_48__closurerize($arg0);
  return $tmpret74;
} // end-of-function


function
_ats2phppre_intrange_patsfun_48($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_intrange_patsfun_48:
  ats2phppre_intrange_foreach_cloref($env0[0], $env0[1], $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_intrange_foldleft_cloref($arg0, $arg1, $arg2, $arg3)
{
//
  $tmpret76 = NULL;
//
  __patsflab_intrange_foldleft_cloref:
  $tmpret76 = _ats2phppre_intrange_loop_50($arg3, $arg0, $arg1, $arg2, $arg3);
  return $tmpret76;
} // end-of-function


function
_ats2phppre_intrange_loop_50($env0, $arg0, $arg1, $arg2, $arg3)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $tmpret77 = NULL;
  $tmp78 = NULL;
  $tmp79 = NULL;
  $tmp80 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_50:
  $tmp78 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp78) {
    $tmp79 = ats2phppre_add_int0_int0($arg0, 1);
    $tmp80 = $arg3[0]($arg3, $arg2, $arg0);
    // ATStailcalseq_beg
    $apy0 = $tmp79;
    $apy1 = $arg1;
    $apy2 = $tmp80;
    $apy3 = $env0;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    goto __patsflab__ats2phppre_intrange_loop_50;
    // ATStailcalseq_end
  } else {
    $tmpret77 = $arg2;
  } // endif
  return $tmpret77;
} // end-of-function


function
ats2phppre_intrange_foldleft_method($arg0, $arg1)
{
//
  $tmp81 = NULL;
  $tmp82 = NULL;
  $tmpret83 = NULL;
//
  __patsflab_intrange_foldleft_method:
  $tmp81 = $arg0[0];
  $tmp82 = $arg0[1];
  $tmpret83 = _ats2phppre_intrange_patsfun_52__closurerize($tmp81, $tmp82, $arg1);
  return $tmpret83;
} // end-of-function


function
_ats2phppre_intrange_patsfun_52($env0, $env1, $env2, $arg0)
{
//
  $tmpret84 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_52:
  $tmpret84 = ats2phppre_intrange_foldleft_cloref($env0, $env1, $env2, $arg0);
  return $tmpret84;
} // end-of-function


function
ats2phppre_intrange2_exists_cloref($arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $tmpret85 = NULL;
//
  __patsflab_intrange2_exists_cloref:
  $tmpret85 = _ats2phppre_intrange_loop1_54($arg2, $arg3, $arg4, $arg0, $arg1, $arg2, $arg3, $arg4);
  return $tmpret85;
} // end-of-function


function
_ats2phppre_intrange_loop1_54($env0, $env1, $env2, $arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $apy4 = NULL;
  $tmpret86 = NULL;
  $tmp87 = NULL;
  $a2rg0 = NULL;
  $a2rg1 = NULL;
  $a2rg2 = NULL;
  $a2rg3 = NULL;
  $a2rg4 = NULL;
  $a2py0 = NULL;
  $a2py1 = NULL;
  $a2py2 = NULL;
  $a2py3 = NULL;
  $a2py4 = NULL;
  $tmpret88 = NULL;
  $tmp89 = NULL;
  $tmp90 = NULL;
  $tmp91 = NULL;
  $tmp92 = NULL;
//
  __patsflab__ats2phppre_intrange_loop1_54:
  $tmp87 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp87) {
    // ATStailcalseq_beg
    $a2py0 = $arg0;
    $a2py1 = $arg1;
    $a2py2 = $arg2;
    $a2py3 = $arg3;
    $a2py4 = $env2;
    $a2rg0 = $a2py0;
    $a2rg1 = $a2py1;
    $a2rg2 = $a2py2;
    $a2rg3 = $a2py3;
    $a2rg4 = $a2py4;
    goto __patsflab__ats2phppre_intrange_loop2_55;
    // ATStailcalseq_end
  } else {
    $tmpret86 = false;
  } // endif
  return $tmpret86;
//
  __patsflab__ats2phppre_intrange_loop2_55:
  $tmp89 = ats2phppre_lt_int0_int0($a2rg2, $a2rg3);
  if($tmp89) {
    $tmp90 = $a2rg4[0]($a2rg4, $a2rg0, $a2rg2);
    if($tmp90) {
      $tmpret88 = true;
    } else {
      $tmp91 = ats2phppre_add_int0_int0($a2rg2, 1);
      // ATStailcalseq_beg
      $a2py0 = $a2rg0;
      $a2py1 = $a2rg1;
      $a2py2 = $tmp91;
      $a2py3 = $a2rg3;
      $a2py4 = $a2rg4;
      $a2rg0 = $a2py0;
      $a2rg1 = $a2py1;
      $a2rg2 = $a2py2;
      $a2rg3 = $a2py3;
      $a2rg4 = $a2py4;
      goto __patsflab__ats2phppre_intrange_loop2_55;
      // ATStailcalseq_end
    } // endif
  } else {
    $tmp92 = ats2phppre_add_int0_int0($a2rg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp92;
    $apy1 = $a2rg1;
    $apy2 = $env0;
    $apy3 = $env1;
    $apy4 = $a2rg4;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    $arg4 = $apy4;
    goto __patsflab__ats2phppre_intrange_loop1_54;
    // ATStailcalseq_end
  } // endif
  return $tmpret88;
} // end-of-function


function
ats2phppre_intrange2_forall_cloref($arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $tmpret93 = NULL;
//
  __patsflab_intrange2_forall_cloref:
  $tmpret93 = _ats2phppre_intrange_loop1_57($arg2, $arg3, $arg0, $arg1, $arg2, $arg3, $arg4);
  return $tmpret93;
} // end-of-function


function
_ats2phppre_intrange_loop1_57($env0, $env1, $arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $apy4 = NULL;
  $tmpret94 = NULL;
  $tmp95 = NULL;
  $a2rg0 = NULL;
  $a2rg1 = NULL;
  $a2rg2 = NULL;
  $a2rg3 = NULL;
  $a2rg4 = NULL;
  $a2py0 = NULL;
  $a2py1 = NULL;
  $a2py2 = NULL;
  $a2py3 = NULL;
  $a2py4 = NULL;
  $tmpret96 = NULL;
  $tmp97 = NULL;
  $tmp98 = NULL;
  $tmp99 = NULL;
  $tmp100 = NULL;
//
  __patsflab__ats2phppre_intrange_loop1_57:
  $tmp95 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp95) {
    // ATStailcalseq_beg
    $a2py0 = $arg0;
    $a2py1 = $arg1;
    $a2py2 = $arg2;
    $a2py3 = $arg3;
    $a2py4 = $arg4;
    $a2rg0 = $a2py0;
    $a2rg1 = $a2py1;
    $a2rg2 = $a2py2;
    $a2rg3 = $a2py3;
    $a2rg4 = $a2py4;
    goto __patsflab__ats2phppre_intrange_loop2_58;
    // ATStailcalseq_end
  } else {
    $tmpret94 = true;
  } // endif
  return $tmpret94;
//
  __patsflab__ats2phppre_intrange_loop2_58:
  $tmp97 = ats2phppre_lt_int0_int0($a2rg2, $a2rg3);
  if($tmp97) {
    $tmp98 = $a2rg4[0]($a2rg4, $a2rg0, $a2rg2);
    if($tmp98) {
      $tmp99 = ats2phppre_add_int0_int0($a2rg2, 1);
      // ATStailcalseq_beg
      $a2py0 = $a2rg0;
      $a2py1 = $a2rg1;
      $a2py2 = $tmp99;
      $a2py3 = $a2rg3;
      $a2py4 = $a2rg4;
      $a2rg0 = $a2py0;
      $a2rg1 = $a2py1;
      $a2rg2 = $a2py2;
      $a2rg3 = $a2py3;
      $a2rg4 = $a2py4;
      goto __patsflab__ats2phppre_intrange_loop2_58;
      // ATStailcalseq_end
    } else {
      $tmpret96 = false;
    } // endif
  } else {
    $tmp100 = ats2phppre_add_int0_int0($a2rg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp100;
    $apy1 = $a2rg1;
    $apy2 = $env0;
    $apy3 = $env1;
    $apy4 = $a2rg4;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    $arg4 = $apy4;
    goto __patsflab__ats2phppre_intrange_loop1_57;
    // ATStailcalseq_end
  } // endif
  return $tmpret96;
} // end-of-function


function
ats2phppre_intrange2_foreach_cloref($arg0, $arg1, $arg2, $arg3, $arg4)
{
//
//
  __patsflab_intrange2_foreach_cloref:
  _ats2phppre_intrange_loop1_60($arg2, $arg3, $arg0, $arg1, $arg2, $arg3, $arg4);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_intrange_loop1_60($env0, $env1, $arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $apy4 = NULL;
  $tmp103 = NULL;
  $a2rg0 = NULL;
  $a2rg1 = NULL;
  $a2rg2 = NULL;
  $a2rg3 = NULL;
  $a2rg4 = NULL;
  $a2py0 = NULL;
  $a2py1 = NULL;
  $a2py2 = NULL;
  $a2py3 = NULL;
  $a2py4 = NULL;
  $tmp105 = NULL;
  $tmp107 = NULL;
  $tmp108 = NULL;
//
  __patsflab__ats2phppre_intrange_loop1_60:
  $tmp103 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp103) {
    // ATStailcalseq_beg
    $a2py0 = $arg0;
    $a2py1 = $arg1;
    $a2py2 = $arg2;
    $a2py3 = $arg3;
    $a2py4 = $arg4;
    $a2rg0 = $a2py0;
    $a2rg1 = $a2py1;
    $a2rg2 = $a2py2;
    $a2rg3 = $a2py3;
    $a2rg4 = $a2py4;
    goto __patsflab__ats2phppre_intrange_loop2_61;
    // ATStailcalseq_end
  } else {
    // ATSINSmove_void;
  } // endif
  return/*_void*/;
//
  __patsflab__ats2phppre_intrange_loop2_61:
  $tmp105 = ats2phppre_lt_int0_int0($a2rg2, $a2rg3);
  if($tmp105) {
    $a2rg4[0]($a2rg4, $a2rg0, $a2rg2);
    $tmp107 = ats2phppre_add_int0_int0($a2rg2, 1);
    // ATStailcalseq_beg
    $a2py0 = $a2rg0;
    $a2py1 = $a2rg1;
    $a2py2 = $tmp107;
    $a2py3 = $a2rg3;
    $a2py4 = $a2rg4;
    $a2rg0 = $a2py0;
    $a2rg1 = $a2py1;
    $a2rg2 = $a2py2;
    $a2rg3 = $a2py3;
    $a2rg4 = $a2py4;
    goto __patsflab__ats2phppre_intrange_loop2_61;
    // ATStailcalseq_end
  } else {
    $tmp108 = ats2phppre_succ_int0($a2rg0);
    // ATStailcalseq_beg
    $apy0 = $tmp108;
    $apy1 = $a2rg1;
    $apy2 = $env0;
    $apy3 = $env1;
    $apy4 = $a2rg4;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    $arg4 = $apy4;
    goto __patsflab__ats2phppre_intrange_loop1_60;
    // ATStailcalseq_end
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
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/
function
_ats2phppre_arrayref_patsfun_8__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_arrayref_patsfun_8($cenv[1], $arg0); }, $env0);
}


function
ats2phppre_arrayref_exists_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret0 = NULL;
//
  __patsflab_arrayref_exists_cloref:
  $tmpret0 = ats2phppre_int_exists_cloref($arg1, $arg2);
  return $tmpret0;
} // end-of-function


function
ats2phppre_arrayref_forall_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret1 = NULL;
//
  __patsflab_arrayref_forall_cloref:
  $tmpret1 = ats2phppre_int_forall_cloref($arg1, $arg2);
  return $tmpret1;
} // end-of-function


function
ats2phppre_arrayref_foreach_cloref($arg0, $arg1, $arg2)
{
//
//
  __patsflab_arrayref_foreach_cloref:
  ats2phppre_int_foreach_cloref($arg1, $arg2);
  return/*_void*/;
} // end-of-function


function
ats2phppre_arrszref_make_elt($arg0, $arg1)
{
//
  $tmpret3 = NULL;
  $tmp4 = NULL;
//
  __patsflab_arrszref_make_elt:
  $tmp4 = ats2phppre_arrayref_make_elt($arg0, $arg1);
  $tmpret3 = ats2phppre_arrszref_make_arrayref($tmp4, $arg0);
  return $tmpret3;
} // end-of-function


function
ats2phppre_arrszref_exists_cloref($arg0, $arg1)
{
//
  $tmpret5 = NULL;
  $tmp6 = NULL;
//
  __patsflab_arrszref_exists_cloref:
  $tmp6 = ats2phppre_arrszref_size($arg0);
  $tmpret5 = ats2phppre_int_exists_cloref($tmp6, $arg1);
  return $tmpret5;
} // end-of-function


function
ats2phppre_arrszref_forall_cloref($arg0, $arg1)
{
//
  $tmpret7 = NULL;
  $tmp8 = NULL;
//
  __patsflab_arrszref_forall_cloref:
  $tmp8 = ats2phppre_arrszref_size($arg0);
  $tmpret7 = ats2phppre_int_forall_cloref($tmp8, $arg1);
  return $tmpret7;
} // end-of-function


function
ats2phppre_arrszref_foreach_cloref($arg0, $arg1)
{
//
  $tmp10 = NULL;
//
  __patsflab_arrszref_foreach_cloref:
  $tmp10 = ats2phppre_arrszref_size($arg0);
  ats2phppre_int_foreach_cloref($tmp10, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_arrszref_foreach_method($arg0)
{
//
  $tmpret11 = NULL;
//
  __patsflab_arrszref_foreach_method:
  $tmpret11 = _ats2phppre_arrayref_patsfun_8__closurerize($arg0);
  return $tmpret11;
} // end-of-function


function
_ats2phppre_arrayref_patsfun_8($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_arrayref_patsfun_8:
  ats2phppre_arrszref_foreach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_arrayref_make_elt($arg0, $arg1)
{
//
  $tmpret13 = NULL;
  $tmp14 = NULL;
//
  __patsflab_arrayref_make_elt:
  $tmp14 = ats2phppre_PHParref_make_elt($arg0, $arg1);
  $tmpret13 = $tmp14;
  return $tmpret13;
} // end-of-function


function
ats2phppre_arrayref_get_at($arg0, $arg1)
{
//
  $tmpret15 = NULL;
//
  __patsflab_arrayref_get_at:
  $tmpret15 = ats2phppre_PHParref_get_at($arg0, $arg1);
  return $tmpret15;
} // end-of-function


function
ats2phppre_arrayref_set_at($arg0, $arg1, $arg2)
{
//
//
  __patsflab_arrayref_set_at:
  ats2phppre_PHParref_set_at($arg0, $arg1, $arg2);
  return/*_void*/;
} // end-of-function


function
ats2phppre_arrszref_make_arrayref($arg0, $arg1)
{
//
  $tmpret17 = NULL;
//
  __patsflab_arrszref_make_arrayref:
  $tmpret17 = $arg0;
  return $tmpret17;
} // end-of-function


function
ats2phppre_arrszref_size($arg0)
{
//
  $tmpret18 = NULL;
//
  __patsflab_arrszref_size:
  $tmpret18 = ats2phppre_PHParref_length($arg0);
  return $tmpret18;
} // end-of-function


function
ats2phppre_arrszref_get_at($arg0, $arg1)
{
//
  $tmpret19 = NULL;
//
  __patsflab_arrszref_get_at:
  $tmpret19 = ats2phppre_PHParref_get_at($arg0, $arg1);
  return $tmpret19;
} // end-of-function


function
ats2phppre_arrszref_set_at($arg0, $arg1, $arg2)
{
//
//
  __patsflab_arrszref_set_at:
  ats2phppre_PHParref_set_at($arg0, $arg1, $arg2);
  return/*_void*/;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/

function
ats2phppre_ref($arg0)
{
//
  $tmpret0 = NULL;
//
  __patsflab_ref:
  $tmpret0 = ats2phppre_ref_make_elt($arg0);
  return $tmpret0;
} // end-of-function


function
ats2phppre_ref_make_elt($arg0)
{
//
  $tmpret1 = NULL;
  $tmp2 = NULL;
//
  __patsflab_ref_make_elt:
  $tmp2 = ats2phppre_PHPref_new($arg0);
  $tmpret1 = $tmp2;
  return $tmpret1;
} // end-of-function


function
ats2phppre_ref_get_elt($arg0)
{
//
  $tmpret3 = NULL;
//
  __patsflab_ref_get_elt:
  $tmpret3 = ats2phppre_PHPref_get_elt($arg0);
  return $tmpret3;
} // end-of-function


function
ats2phppre_ref_set_elt($arg0, $arg1)
{
//
//
  __patsflab_ref_set_elt:
  ats2phppre_PHPref_set_elt($arg0, $arg1);
  return/*_void*/;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/

function
slistref_make_nil()
{
//
  $tmpret0 = NULL;
  $tmp1 = NULL;
//
  __patsflab_slistref_make_nil:
  $tmp1 = NULL;
  $tmpret0 = ats2phppre_ref($tmp1);
  return $tmpret0;
} // end-of-function


function
slistref_length($arg0)
{
//
  $tmpret2 = NULL;
  $tmp3 = NULL;
//
  __patsflab_slistref_length:
  $tmp3 = ats2phppre_ref_get_elt($arg0);
  $tmpret2 = ats2phppre_list_length($tmp3);
  return $tmpret2;
} // end-of-function


function
slistref_push($arg0, $arg1)
{
//
  $tmp5 = NULL;
  $tmp6 = NULL;
//
  __patsflab_slistref_push:
  $tmp6 = ats2phppre_ref_get_elt($arg0);
  $tmp5 = array($arg1, $tmp6);
  ats2phppre_ref_set_elt($arg0, $tmp5);
  return/*_void*/;
} // end-of-function


function
slistref_pop_opt($arg0)
{
//
  $tmpret7 = NULL;
  $tmp8 = NULL;
  $tmp9 = NULL;
  $tmp10 = NULL;
//
  __patsflab_slistref_pop_opt:
  $tmp8 = ats2phppre_ref_get_elt($arg0);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab0:
    if(ATSCKptriscons($tmp8)) goto __atstmplab3;
    __atstmplab1:
    $tmpret7 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab2:
    __atstmplab3:
    $tmp9 = $tmp8[0];
    $tmp10 = $tmp8[1];
    ats2phppre_ref_set_elt($arg0, $tmp10);
    $tmpret7 = array($tmp9);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret7;
} // end-of-function


function
slistref_foldleft($arg0, $arg1, $arg2)
{
//
  $tmpret12 = NULL;
  $tmp13 = NULL;
//
  __patsflab_slistref_foldleft:
  $tmp13 = ats2phppre_ref_get_elt($arg0);
  $tmpret12 = ats2phppre_list_foldleft($tmp13, $arg1, $arg2);
  return $tmpret12;
} // end-of-function


function
slistref_foldright($arg0, $arg1, $arg2)
{
//
  $tmpret14 = NULL;
  $tmp15 = NULL;
//
  __patsflab_slistref_foldright:
  $tmp15 = ats2phppre_ref_get_elt($arg0);
  $tmpret14 = ats2phppre_list_foldright($tmp15, $arg1, $arg2);
  return $tmpret14;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/

function
ats2phppre_qlistref_make_nil()
{
//
  $tmpret0 = NULL;
  $tmp1 = NULL;
  $tmp2 = NULL;
  $tmp3 = NULL;
  $tmp4 = NULL;
//
  __patsflab_qlistref_make_nil:
  $tmp2 = NULL;
  $tmp1 = ats2phppre_ref($tmp2);
  $tmp4 = NULL;
  $tmp3 = ats2phppre_ref($tmp4);
  $tmpret0 = array($tmp1, $tmp3);
  return $tmpret0;
} // end-of-function


function
ats2phppre_qlistref_length($arg0)
{
//
  $tmpret5 = NULL;
  $tmp6 = NULL;
  $tmp7 = NULL;
  $tmp8 = NULL;
  $tmp9 = NULL;
  $tmp10 = NULL;
  $tmp11 = NULL;
//
  __patsflab_qlistref_length:
  $tmp6 = $arg0[0];
  $tmp7 = $arg0[1];
  $tmp9 = ats2phppre_ref_get_elt($tmp6);
  $tmp8 = ats2phppre_list_length($tmp9);
  $tmp11 = ats2phppre_ref_get_elt($tmp7);
  $tmp10 = ats2phppre_list_length($tmp11);
  $tmpret5 = ats2phppre_add_int1_int1($tmp8, $tmp10);
  return $tmpret5;
} // end-of-function


function
ats2phppre_qlistref_enqueue($arg0, $arg1)
{
//
  $tmp13 = NULL;
  $tmp14 = NULL;
  $tmp15 = NULL;
  $tmp16 = NULL;
//
  __patsflab_qlistref_enqueue:
  $tmp13 = $arg0[0];
  $tmp14 = $arg0[1];
  $tmp16 = ats2phppre_ref_get_elt($tmp13);
  $tmp15 = array($arg1, $tmp16);
  ats2phppre_ref_set_elt($tmp13, $tmp15);
  return/*_void*/;
} // end-of-function


function
ats2phppre_qlistref_dequeue_opt($arg0)
{
//
  $tmpret17 = NULL;
  $tmp18 = NULL;
  $tmp19 = NULL;
  $tmp20 = NULL;
  $tmp21 = NULL;
  $tmp22 = NULL;
  $tmp23 = NULL;
  $tmp25 = NULL;
  $tmp26 = NULL;
  $tmp27 = NULL;
//
  __patsflab_qlistref_dequeue_opt:
  $tmp18 = $arg0[0];
  $tmp19 = $arg0[1];
  $tmp20 = ats2phppre_ref_get_elt($tmp19);
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab0:
    if(ATSCKptriscons($tmp20)) goto __atstmplab3;
    __atstmplab1:
    $tmp23 = ats2phppre_ref_get_elt($tmp18);
    $tmp25 = NULL;
    ats2phppre_ref_set_elt($tmp18, $tmp25);
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab4:
      if(ATSCKptriscons($tmp23)) goto __atstmplab7;
      __atstmplab5:
      $tmpret17 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab6:
      __atstmplab7:
      $tmp26 = $tmp23[0];
      $tmp27 = $tmp23[1];
      ats2phppre_ref_set_elt($tmp19, $tmp27);
      $tmpret17 = array($tmp26);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab2:
    __atstmplab3:
    $tmp21 = $tmp20[0];
    $tmp22 = $tmp20[1];
    ats2phppre_ref_set_elt($tmp19, $tmp22);
    $tmpret17 = array($tmp21);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret17;
} // end-of-function


function
ats2phppre_qlistref_foldleft($arg0, $arg1, $arg2)
{
//
  $tmpret30 = NULL;
  $tmp31 = NULL;
  $tmp32 = NULL;
  $tmp41 = NULL;
  $tmp42 = NULL;
  $tmp43 = NULL;
//
  __patsflab_qlistref_foldleft:
  $tmp31 = $arg0[0];
  $tmp32 = $arg0[1];
  $tmp41 = ats2phppre_ref_get_elt($tmp31);
  $tmp43 = ats2phppre_ref_get_elt($tmp32);
  $tmp42 = _ats2phppre_qlistref_auxl_5($arg2, $arg1, $tmp43);
  $tmpret30 = _ats2phppre_qlistref_auxr_6($arg2, $tmp41, $tmp42);
  return $tmpret30;
} // end-of-function


function
_ats2phppre_qlistref_auxl_5($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret33 = NULL;
  $tmp34 = NULL;
  $tmp35 = NULL;
  $tmp36 = NULL;
//
  __patsflab__ats2phppre_qlistref_auxl_5:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab8:
    if(ATSCKptriscons($arg1)) goto __atstmplab11;
    __atstmplab9:
    $tmpret33 = $arg0;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab10:
    __atstmplab11:
    $tmp34 = $arg1[0];
    $tmp35 = $arg1[1];
    $tmp36 = $env0[0]($env0, $arg0, $tmp34);
    // ATStailcalseq_beg
    $apy0 = $tmp36;
    $apy1 = $tmp35;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_qlistref_auxl_5;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret33;
} // end-of-function


function
_ats2phppre_qlistref_auxr_6($env0, $arg0, $arg1)
{
//
  $tmpret37 = NULL;
  $tmp38 = NULL;
  $tmp39 = NULL;
  $tmp40 = NULL;
//
  __patsflab__ats2phppre_qlistref_auxr_6:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab12:
    if(ATSCKptriscons($arg0)) goto __atstmplab15;
    __atstmplab13:
    $tmpret37 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab14:
    __atstmplab15:
    $tmp38 = $arg0[0];
    $tmp39 = $arg0[1];
    $tmp40 = _ats2phppre_qlistref_auxr_6($env0, $tmp39, $arg1);
    $tmpret37 = $env0[0]($env0, $tmp40, $tmp38);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret37;
} // end-of-function


function
ats2phppre_qlistref_foldright($arg0, $arg1, $arg2)
{
//
  $tmpret44 = NULL;
  $tmp45 = NULL;
  $tmp46 = NULL;
  $tmp55 = NULL;
  $tmp56 = NULL;
  $tmp57 = NULL;
//
  __patsflab_qlistref_foldright:
  $tmp45 = $arg0[0];
  $tmp46 = $arg0[1];
  $tmp55 = ats2phppre_ref_get_elt($tmp46);
  $tmp57 = ats2phppre_ref_get_elt($tmp45);
  $tmp56 = _ats2phppre_qlistref_auxl_8($arg1, $arg2, $tmp57);
  $tmpret44 = _ats2phppre_qlistref_auxr_9($arg1, $tmp55, $tmp56);
  return $tmpret44;
} // end-of-function


function
_ats2phppre_qlistref_auxl_8($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret47 = NULL;
  $tmp48 = NULL;
  $tmp49 = NULL;
  $tmp50 = NULL;
//
  __patsflab__ats2phppre_qlistref_auxl_8:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab16:
    if(ATSCKptriscons($arg1)) goto __atstmplab19;
    __atstmplab17:
    $tmpret47 = $arg0;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab18:
    __atstmplab19:
    $tmp48 = $arg1[0];
    $tmp49 = $arg1[1];
    $tmp50 = $env0[0]($env0, $tmp48, $arg0);
    // ATStailcalseq_beg
    $apy0 = $tmp50;
    $apy1 = $tmp49;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_qlistref_auxl_8;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret47;
} // end-of-function


function
_ats2phppre_qlistref_auxr_9($env0, $arg0, $arg1)
{
//
  $tmpret51 = NULL;
  $tmp52 = NULL;
  $tmp53 = NULL;
  $tmp54 = NULL;
//
  __patsflab__ats2phppre_qlistref_auxr_9:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab20:
    if(ATSCKptriscons($arg0)) goto __atstmplab23;
    __atstmplab21:
    $tmpret51 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab22:
    __atstmplab23:
    $tmp52 = $arg0[0];
    $tmp53 = $arg0[1];
    $tmp54 = _ats2phppre_qlistref_auxr_9($env0, $tmp53, $arg1);
    $tmpret51 = $env0[0]($env0, $tmp52, $tmp54);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret51;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/
function
_ats2phppre_ML_list0_patsfun_29__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_29($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_32__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_32($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_35__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_35($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_38__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_38($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_42__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_42($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_45__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_45($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_48__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_48($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_51__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_51($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_54__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_54($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_58__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_58($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_list0_patsfun_64__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_list0_patsfun_64($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}


function
ats2phppre_ML_list0_head_opt($arg0)
{
//
  $tmpret7 = NULL;
  $tmp8 = NULL;
//
  __patsflab_list0_head_opt:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab6:
    if(ATSCKptriscons($arg0)) goto __atstmplab9;
    __atstmplab7:
    $tmpret7 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab8:
    __atstmplab9:
    $tmp8 = $arg0[0];
    $tmpret7 = array($tmp8);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret7;
} // end-of-function


function
ats2phppre_ML_list0_tail_opt($arg0)
{
//
  $tmpret10 = NULL;
  $tmp12 = NULL;
//
  __patsflab_list0_tail_opt:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab10:
    if(ATSCKptriscons($arg0)) goto __atstmplab13;
    __atstmplab11:
    $tmpret10 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab12:
    __atstmplab13:
    $tmp12 = $arg0[1];
    $tmpret10 = array($tmp12);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret10;
} // end-of-function


function
ats2phppre_ML_list0_length($arg0)
{
//
  $tmpret13 = NULL;
//
  __patsflab_list0_length:
  $tmpret13 = ats2phppre_list_length($arg0);
  return $tmpret13;
} // end-of-function


function
ats2phppre_ML_list0_last_opt($arg0)
{
//
  $tmpret14 = NULL;
  $tmp18 = NULL;
  $tmp19 = NULL;
  $tmp20 = NULL;
//
  __patsflab_list0_last_opt:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab18:
    if(ATSCKptriscons($arg0)) goto __atstmplab21;
    __atstmplab19:
    $tmpret14 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab20:
    __atstmplab21:
    $tmp18 = $arg0[0];
    $tmp19 = $arg0[1];
    $tmp20 = _ats2phppre_ML_list0_loop_8($tmp18, $tmp19);
    $tmpret14 = array($tmp20);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret14;
} // end-of-function


function
_ats2phppre_ML_list0_loop_8($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret15 = NULL;
  $tmp16 = NULL;
  $tmp17 = NULL;
//
  __patsflab__ats2phppre_ML_list0_loop_8:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab14:
    if(ATSCKptriscons($arg1)) goto __atstmplab17;
    __atstmplab15:
    $tmpret15 = $arg0;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab16:
    __atstmplab17:
    $tmp16 = $arg1[0];
    $tmp17 = $arg1[1];
    // ATStailcalseq_beg
    $apy0 = $tmp16;
    $apy1 = $tmp17;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_ML_list0_loop_8;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret15;
} // end-of-function


function
ats2phppre_ML_list0_get_at_opt($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret21 = NULL;
  $tmp22 = NULL;
  $tmp23 = NULL;
  $tmp24 = NULL;
  $tmp25 = NULL;
//
  __patsflab_list0_get_at_opt:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab22:
    if(ATSCKptriscons($arg0)) goto __atstmplab25;
    __atstmplab23:
    $tmpret21 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab24:
    __atstmplab25:
    $tmp22 = $arg0[0];
    $tmp23 = $arg0[1];
    $tmp24 = ats2phppre_gt_int1_int1($arg1, 0);
    if($tmp24) {
      $tmp25 = ats2phppre_sub_int1_int1($arg1, 1);
      // ATStailcalseq_beg
      $apy0 = $tmp23;
      $apy1 = $tmp25;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab_list0_get_at_opt;
      // ATStailcalseq_end
    } else {
      $tmpret21 = array($tmp22);
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret21;
} // end-of-function


function
ats2phppre_ML_list0_make_elt($arg0, $arg1)
{
//
  $tmpret26 = NULL;
  $tmp27 = NULL;
  $tmp28 = NULL;
//
  __patsflab_list0_make_elt:
  $tmp27 = ats2phppre_gte_int1_int1($arg0, 0);
  if($tmp27) {
    $tmp28 = ats2phppre_list_make_elt($arg0, $arg1);
    $tmpret26 = $tmp28;
  } else {
    $tmpret26 = NULL;
  } // endif
  return $tmpret26;
} // end-of-function


function
ats2phppre_ML_list0_make_intrange_2($arg0, $arg1)
{
//
  $tmpret29 = NULL;
  $tmp30 = NULL;
//
  __patsflab_list0_make_intrange_2:
  $tmp30 = ats2phppre_list_make_intrange_2($arg0, $arg1);
  $tmpret29 = $tmp30;
  return $tmpret29;
} // end-of-function


function
ats2phppre_ML_list0_make_intrange_3($arg0, $arg1, $arg2)
{
//
  $tmpret31 = NULL;
  $tmp32 = NULL;
//
  __patsflab_list0_make_intrange_3:
  $tmp32 = ats2phppre_list_make_intrange_3($arg0, $arg1, $arg2);
  $tmpret31 = $tmp32;
  return $tmpret31;
} // end-of-function


function
ats2phppre_ML_list0_snoc($arg0, $arg1)
{
//
  $tmpret44 = NULL;
  $tmp45 = NULL;
//
  __patsflab_list0_snoc:
  $tmp45 = ats2phppre_list_snoc($arg0, $arg1);
  $tmpret44 = $tmp45;
  return $tmpret44;
} // end-of-function


function
ats2phppre_ML_list0_extend($arg0, $arg1)
{
//
  $tmpret46 = NULL;
  $tmp47 = NULL;
//
  __patsflab_list0_extend:
  $tmp47 = ats2phppre_list_extend($arg0, $arg1);
  $tmpret46 = $tmp47;
  return $tmpret46;
} // end-of-function


function
ats2phppre_ML_list0_append($arg0, $arg1)
{
//
  $tmpret48 = NULL;
  $tmp49 = NULL;
//
  __patsflab_list0_append:
  $tmp49 = ats2phppre_list_append($arg0, $arg1);
  $tmpret48 = $tmp49;
  return $tmpret48;
} // end-of-function


function
ats2phppre_ML_mul_int_list0($arg0, $arg1)
{
//
  $tmpret50 = NULL;
  $tmp51 = NULL;
//
  __patsflab_mul_int_list0:
  $tmp51 = ats2phppre_mul_int_list($arg0, $arg1);
  $tmpret50 = $tmp51;
  return $tmpret50;
} // end-of-function


function
ats2phppre_ML_list0_reverse($arg0)
{
//
  $tmpret52 = NULL;
  $tmp53 = NULL;
//
  __patsflab_list0_reverse:
  $tmp53 = ats2phppre_list_reverse($arg0);
  $tmpret52 = $tmp53;
  return $tmpret52;
} // end-of-function


function
ats2phppre_ML_list0_reverse_append($arg0, $arg1)
{
//
  $tmpret54 = NULL;
  $tmp55 = NULL;
//
  __patsflab_list0_reverse_append:
  $tmp55 = ats2phppre_list_reverse_append($arg0, $arg1);
  $tmpret54 = $tmp55;
  return $tmpret54;
} // end-of-function


function
ats2phppre_ML_list0_concat($arg0)
{
//
  $tmpret56 = NULL;
  $tmp57 = NULL;
//
  __patsflab_list0_concat:
  $tmp57 = ats2phppre_list_concat($arg0);
  $tmpret56 = $tmp57;
  return $tmpret56;
} // end-of-function


function
ats2phppre_ML_list0_remove_at_opt($arg0, $arg1)
{
//
  $tmpret58 = NULL;
//
  __patsflab_list0_remove_at_opt:
  $tmpret58 = _ats2phppre_ML_list0_aux_26($arg0, 0);
  return $tmpret58;
} // end-of-function


function
_ats2phppre_ML_list0_aux_26($arg0, $arg1)
{
//
  $tmpret59 = NULL;
  $tmp60 = NULL;
  $tmp61 = NULL;
  $tmp62 = NULL;
  $tmp63 = NULL;
  $tmp64 = NULL;
  $tmp65 = NULL;
  $tmp66 = NULL;
//
  __patsflab__ats2phppre_ML_list0_aux_26:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab30:
    if(ATSCKptriscons($arg0)) goto __atstmplab33;
    __atstmplab31:
    $tmpret59 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab32:
    __atstmplab33:
    $tmp60 = $arg0[0];
    $tmp61 = $arg0[1];
    $tmp62 = ats2phppre_gt_int1_int1($arg1, 0);
    if($tmp62) {
      $tmp64 = ats2phppre_sub_int1_int1($arg1, 1);
      $tmp63 = _ats2phppre_ML_list0_aux_26($tmp61, $tmp64);
      // ATScaseofseq_beg
      do {
        // ATSbranchseq_beg
        __atstmplab34:
        if(ATSCKptriscons($tmp63)) goto __atstmplab37;
        __atstmplab35:
        $tmpret59 = NULL;
        break;
        // ATSbranchseq_end
        // ATSbranchseq_beg
        __atstmplab36:
        __atstmplab37:
        $tmp65 = $tmp63[0];
        // ATSINSfreecon($tmp63);
        $tmp66 = array($tmp60, $tmp65);
        $tmpret59 = array($tmp66);
        break;
        // ATSbranchseq_end
      } while(0);
      // ATScaseofseq_end
    } else {
      $tmpret59 = array($tmp61);
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret59;
} // end-of-function


function
ats2phppre_ML_list0_exists($arg0, $arg1)
{
//
  $tmpret67 = NULL;
//
  __patsflab_list0_exists:
  $tmpret67 = ats2phppre_list_exists($arg0, $arg1);
  return $tmpret67;
} // end-of-function


function
ats2phppre_ML_list0_exists_method($arg0)
{
//
  $tmpret68 = NULL;
//
  __patsflab_list0_exists_method:
  $tmpret68 = _ats2phppre_ML_list0_patsfun_29__closurerize($arg0);
  return $tmpret68;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_29($env0, $arg0)
{
//
  $tmpret69 = NULL;
//
  __patsflab__ats2phppre_ML_list0_patsfun_29:
  $tmpret69 = ats2phppre_ML_list0_exists($env0, $arg0);
  return $tmpret69;
} // end-of-function


function
ats2phppre_ML_list0_iexists($arg0, $arg1)
{
//
  $tmpret70 = NULL;
//
  __patsflab_list0_iexists:
  $tmpret70 = ats2phppre_list_iexists($arg0, $arg1);
  return $tmpret70;
} // end-of-function


function
ats2phppre_ML_list0_iexists_method($arg0)
{
//
  $tmpret71 = NULL;
//
  __patsflab_list0_iexists_method:
  $tmpret71 = _ats2phppre_ML_list0_patsfun_32__closurerize($arg0);
  return $tmpret71;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_32($env0, $arg0)
{
//
  $tmpret72 = NULL;
//
  __patsflab__ats2phppre_ML_list0_patsfun_32:
  $tmpret72 = ats2phppre_ML_list0_iexists($env0, $arg0);
  return $tmpret72;
} // end-of-function


function
ats2phppre_ML_list0_forall($arg0, $arg1)
{
//
  $tmpret73 = NULL;
//
  __patsflab_list0_forall:
  $tmpret73 = ats2phppre_list_forall($arg0, $arg1);
  return $tmpret73;
} // end-of-function


function
ats2phppre_ML_list0_forall_method($arg0)
{
//
  $tmpret74 = NULL;
//
  __patsflab_list0_forall_method:
  $tmpret74 = _ats2phppre_ML_list0_patsfun_35__closurerize($arg0);
  return $tmpret74;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_35($env0, $arg0)
{
//
  $tmpret75 = NULL;
//
  __patsflab__ats2phppre_ML_list0_patsfun_35:
  $tmpret75 = ats2phppre_ML_list0_forall($env0, $arg0);
  return $tmpret75;
} // end-of-function


function
ats2phppre_ML_list0_iforall($arg0, $arg1)
{
//
  $tmpret76 = NULL;
//
  __patsflab_list0_iforall:
  $tmpret76 = ats2phppre_list_iforall($arg0, $arg1);
  return $tmpret76;
} // end-of-function


function
ats2phppre_ML_list0_iforall_method($arg0)
{
//
  $tmpret77 = NULL;
//
  __patsflab_list0_iforall_method:
  $tmpret77 = _ats2phppre_ML_list0_patsfun_38__closurerize($arg0);
  return $tmpret77;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_38($env0, $arg0)
{
//
  $tmpret78 = NULL;
//
  __patsflab__ats2phppre_ML_list0_patsfun_38:
  $tmpret78 = ats2phppre_ML_list0_iforall($env0, $arg0);
  return $tmpret78;
} // end-of-function


function
ats2phppre_ML_list0_app($arg0, $arg1)
{
//
//
  __patsflab_list0_app:
  ats2phppre_ML_list0_foreach($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_list0_foreach($arg0, $arg1)
{
//
//
  __patsflab_list0_foreach:
  ats2phppre_list_foreach($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_list0_foreach_method($arg0)
{
//
  $tmpret81 = NULL;
//
  __patsflab_list0_foreach_method:
  $tmpret81 = _ats2phppre_ML_list0_patsfun_42__closurerize($arg0);
  return $tmpret81;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_42($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_ML_list0_patsfun_42:
  ats2phppre_ML_list0_foreach($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_list0_iforeach($arg0, $arg1)
{
//
//
  __patsflab_list0_iforeach:
  ats2phppre_list_iforeach($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_list0_iforeach_method($arg0)
{
//
  $tmpret84 = NULL;
//
  __patsflab_list0_iforeach_method:
  $tmpret84 = _ats2phppre_ML_list0_patsfun_45__closurerize($arg0);
  return $tmpret84;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_45($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_ML_list0_patsfun_45:
  ats2phppre_ML_list0_iforeach($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_list0_rforeach($arg0, $arg1)
{
//
//
  __patsflab_list0_rforeach:
  ats2phppre_list_rforeach($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_list0_rforeach_method($arg0)
{
//
  $tmpret87 = NULL;
//
  __patsflab_list0_rforeach_method:
  $tmpret87 = _ats2phppre_ML_list0_patsfun_48__closurerize($arg0);
  return $tmpret87;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_48($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_ML_list0_patsfun_48:
  ats2phppre_ML_list0_rforeach($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_list0_filter($arg0, $arg1)
{
//
  $tmpret89 = NULL;
  $tmp90 = NULL;
//
  __patsflab_list0_filter:
  $tmp90 = ats2phppre_list_filter($arg0, $arg1);
  $tmpret89 = $tmp90;
  return $tmpret89;
} // end-of-function


function
ats2phppre_ML_list0_filter_method($arg0)
{
//
  $tmpret91 = NULL;
//
  __patsflab_list0_filter_method:
  $tmpret91 = _ats2phppre_ML_list0_patsfun_51__closurerize($arg0);
  return $tmpret91;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_51($env0, $arg0)
{
//
  $tmpret92 = NULL;
//
  __patsflab__ats2phppre_ML_list0_patsfun_51:
  $tmpret92 = ats2phppre_ML_list0_filter($env0, $arg0);
  return $tmpret92;
} // end-of-function


function
ats2phppre_ML_list0_map($arg0, $arg1)
{
//
  $tmpret93 = NULL;
  $tmp94 = NULL;
//
  __patsflab_list0_map:
  $tmp94 = ats2phppre_list_map($arg0, $arg1);
  $tmpret93 = $tmp94;
  return $tmpret93;
} // end-of-function


function
ats2phppre_ML_list0_map_method($arg0, $arg1)
{
//
  $tmpret95 = NULL;
//
  __patsflab_list0_map_method:
  $tmpret95 = _ats2phppre_ML_list0_patsfun_54__closurerize($arg0);
  return $tmpret95;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_54($env0, $arg0)
{
//
  $tmpret96 = NULL;
//
  __patsflab__ats2phppre_ML_list0_patsfun_54:
  $tmpret96 = ats2phppre_ML_list0_map($env0, $arg0);
  return $tmpret96;
} // end-of-function


function
ats2phppre_ML_list0_mapcons($arg0, $arg1)
{
//
  $tmpret97 = NULL;
  $tmp98 = NULL;
  $tmp99 = NULL;
  $tmp100 = NULL;
  $tmp101 = NULL;
//
  __patsflab_list0_mapcons:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab38:
    if(ATSCKptriscons($arg1)) goto __atstmplab41;
    __atstmplab39:
    $tmpret97 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab40:
    __atstmplab41:
    $tmp98 = $arg1[0];
    $tmp99 = $arg1[1];
    $tmp100 = array($arg0, $tmp98);
    $tmp101 = ats2phppre_ML_list0_mapcons($arg0, $tmp99);
    $tmpret97 = array($tmp100, $tmp101);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret97;
} // end-of-function


function
ats2phppre_ML_list0_find_opt($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret102 = NULL;
  $tmp103 = NULL;
  $tmp104 = NULL;
  $tmp105 = NULL;
//
  __patsflab_list0_find_opt:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab42:
    if(ATSCKptriscons($arg0)) goto __atstmplab45;
    __atstmplab43:
    $tmpret102 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab44:
    __atstmplab45:
    $tmp103 = $arg0[0];
    $tmp104 = $arg0[1];
    $tmp105 = $arg1[0]($arg1, $tmp103);
    if($tmp105) {
      $tmpret102 = array($tmp103);
    } else {
      // ATStailcalseq_beg
      $apy0 = $tmp104;
      $apy1 = $arg1;
      $arg0 = $apy0;
      $arg1 = $apy1;
      goto __patsflab_list0_find_opt;
      // ATStailcalseq_end
    } // endif
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret102;
} // end-of-function


function
ats2phppre_ML_list0_find_opt_method($arg0)
{
//
  $tmpret106 = NULL;
//
  __patsflab_list0_find_opt_method:
  $tmpret106 = _ats2phppre_ML_list0_patsfun_58__closurerize($arg0);
  return $tmpret106;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_58($env0, $arg0)
{
//
  $tmpret107 = NULL;
//
  __patsflab__ats2phppre_ML_list0_patsfun_58:
  $tmpret107 = ats2phppre_ML_list0_find_opt($env0, $arg0);
  return $tmpret107;
} // end-of-function


function
ats2phppre_ML_list0_zip($arg0, $arg1)
{
//
  $tmpret108 = NULL;
//
  __patsflab_list0_zip:
  $tmpret108 = _ats2phppre_ML_list0_aux_60($arg0, $arg1);
  return $tmpret108;
} // end-of-function


function
_ats2phppre_ML_list0_aux_60($arg0, $arg1)
{
//
  $tmpret109 = NULL;
  $tmp110 = NULL;
  $tmp111 = NULL;
  $tmp112 = NULL;
  $tmp113 = NULL;
  $tmp114 = NULL;
  $tmp115 = NULL;
//
  __patsflab__ats2phppre_ML_list0_aux_60:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab46:
    if(ATSCKptriscons($arg0)) goto __atstmplab49;
    __atstmplab47:
    $tmpret109 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab48:
    __atstmplab49:
    $tmp110 = $arg0[0];
    $tmp111 = $arg0[1];
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab50:
      if(ATSCKptriscons($arg1)) goto __atstmplab53;
      __atstmplab51:
      $tmpret109 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab52:
      __atstmplab53:
      $tmp112 = $arg1[0];
      $tmp113 = $arg1[1];
      $tmp114 = array($tmp110, $tmp112);
      $tmp115 = _ats2phppre_ML_list0_aux_60($tmp111, $tmp113);
      $tmpret109 = array($tmp114, $tmp115);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret109;
} // end-of-function


function
ats2phppre_ML_list0_zipwith($arg0, $arg1, $arg2)
{
//
  $tmpret116 = NULL;
//
  __patsflab_list0_zipwith:
  $tmpret116 = _ats2phppre_ML_list0_aux_62($arg0, $arg1, $arg2);
  return $tmpret116;
} // end-of-function


function
_ats2phppre_ML_list0_aux_62($arg0, $arg1, $arg2)
{
//
  $tmpret117 = NULL;
  $tmp118 = NULL;
  $tmp119 = NULL;
  $tmp120 = NULL;
  $tmp121 = NULL;
  $tmp122 = NULL;
  $tmp123 = NULL;
//
  __patsflab__ats2phppre_ML_list0_aux_62:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab54:
    if(ATSCKptriscons($arg0)) goto __atstmplab57;
    __atstmplab55:
    $tmpret117 = NULL;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab56:
    __atstmplab57:
    $tmp118 = $arg0[0];
    $tmp119 = $arg0[1];
    // ATScaseofseq_beg
    do {
      // ATSbranchseq_beg
      __atstmplab58:
      if(ATSCKptriscons($arg1)) goto __atstmplab61;
      __atstmplab59:
      $tmpret117 = NULL;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      __atstmplab60:
      __atstmplab61:
      $tmp120 = $arg1[0];
      $tmp121 = $arg1[1];
      $tmp122 = $arg2[0]($arg2, $tmp118, $tmp120);
      $tmp123 = _ats2phppre_ML_list0_aux_62($tmp119, $tmp121, $arg2);
      $tmpret117 = array($tmp122, $tmp123);
      break;
      // ATSbranchseq_end
    } while(0);
    // ATScaseofseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret117;
} // end-of-function


function
ats2phppre_ML_list0_zipwith_method($arg0, $arg1)
{
//
  $tmpret124 = NULL;
//
  __patsflab_list0_zipwith_method:
  $tmpret124 = _ats2phppre_ML_list0_patsfun_64__closurerize($arg0, $arg1);
  return $tmpret124;
} // end-of-function


function
_ats2phppre_ML_list0_patsfun_64($env0, $env1, $arg0)
{
//
  $tmpret125 = NULL;
//
  __patsflab__ats2phppre_ML_list0_patsfun_64:
  $tmpret125 = ats2phppre_ML_list0_zipwith($env0, $env1, $arg0);
  return $tmpret125;
} // end-of-function


function
ats2phppre_ML_list0_foldleft($arg0, $arg1, $arg2)
{
//
  $tmpret126 = NULL;
//
  __patsflab_list0_foldleft:
  $tmpret126 = _ats2phppre_ML_list0_aux_66($arg2, $arg1, $arg0);
  return $tmpret126;
} // end-of-function


function
_ats2phppre_ML_list0_aux_66($env0, $arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmpret127 = NULL;
  $tmp128 = NULL;
  $tmp129 = NULL;
  $tmp130 = NULL;
//
  __patsflab__ats2phppre_ML_list0_aux_66:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab62:
    if(ATSCKptriscons($arg1)) goto __atstmplab65;
    __atstmplab63:
    $tmpret127 = $arg0;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab64:
    __atstmplab65:
    $tmp128 = $arg1[0];
    $tmp129 = $arg1[1];
    $tmp130 = $env0[0]($env0, $arg0, $tmp128);
    // ATStailcalseq_beg
    $apy0 = $tmp130;
    $apy1 = $tmp129;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_ML_list0_aux_66;
    // ATStailcalseq_end
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret127;
} // end-of-function


function
ats2phppre_ML_list0_foldright($arg0, $arg1, $arg2)
{
//
  $tmpret131 = NULL;
//
  __patsflab_list0_foldright:
  $tmpret131 = _ats2phppre_ML_list0_aux_68($arg1, $arg2, $arg0, $arg2);
  return $tmpret131;
} // end-of-function


function
_ats2phppre_ML_list0_aux_68($env0, $env1, $arg0, $arg1)
{
//
  $tmpret132 = NULL;
  $tmp133 = NULL;
  $tmp134 = NULL;
  $tmp135 = NULL;
//
  __patsflab__ats2phppre_ML_list0_aux_68:
  // ATScaseofseq_beg
  do {
    // ATSbranchseq_beg
    __atstmplab66:
    if(ATSCKptriscons($arg0)) goto __atstmplab69;
    __atstmplab67:
    $tmpret132 = $arg1;
    break;
    // ATSbranchseq_end
    // ATSbranchseq_beg
    __atstmplab68:
    __atstmplab69:
    $tmp133 = $arg0[0];
    $tmp134 = $arg0[1];
    $tmp135 = _ats2phppre_ML_list0_aux_68($env0, $env1, $tmp134, $env1);
    $tmpret132 = $env0[0]($env0, $tmp133, $tmp135);
    break;
    // ATSbranchseq_end
  } while(0);
  // ATScaseofseq_end
  return $tmpret132;
} // end-of-function


function
ats2phppre_ML_list0_sort_2($arg0, $arg1)
{
//
  $tmpret138 = NULL;
  $tmp139 = NULL;
//
  __patsflab_list0_sort_2:
  $tmp139 = ats2phppre_list_sort_2($arg0, $arg1);
  $tmpret138 = $tmp139;
  return $tmpret138;
} // end-of-function


function
ats2phppre_ML_streamize_list0_zip($arg0, $arg1)
{
//
  $tmpret140 = NULL;
//
  __patsflab_streamize_list0_zip:
  $tmpret140 = ats2phppre_streamize_list_zip($arg0, $arg1);
  return $tmpret140;
} // end-of-function


function
ats2phppre_ML_streamize_list0_cross($arg0, $arg1)
{
//
  $tmpret141 = NULL;
//
  __patsflab_streamize_list0_cross:
  $tmpret141 = ats2phppre_streamize_list_cross($arg0, $arg1);
  return $tmpret141;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2017-5-18:  9h:11m
**
*/
function
_ats2phppre_ML_array0_patsfun_7__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_array0_patsfun_7($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_array0_patsfun_10__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_array0_patsfun_10($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_ML_array0_patsfun_14__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_ML_array0_patsfun_14($cenv[1], $arg0); }, $env0);
}


function
ats2phppre_ML_array0_make_elt($arg0, $arg1)
{
//
  $tmpret0 = NULL;
//
  __patsflab_array0_make_elt:
  $tmpret0 = ats2phppre_arrszref_make_elt($arg0, $arg1);
  return $tmpret0;
} // end-of-function


function
ats2phppre_ML_array0_size($arg0)
{
//
  $tmpret1 = NULL;
//
  __patsflab_array0_size:
  $tmpret1 = ats2phppre_arrszref_size($arg0);
  return $tmpret1;
} // end-of-function


function
ats2phppre_ML_array0_get_at($arg0, $arg1)
{
//
  $tmpret2 = NULL;
//
  __patsflab_array0_get_at:
  $tmpret2 = ats2phppre_arrszref_get_at($arg0, $arg1);
  return $tmpret2;
} // end-of-function


function
ats2phppre_ML_array0_set_at($arg0, $arg1, $arg2)
{
//
//
  __patsflab_array0_set_at:
  ats2phppre_arrszref_set_at($arg0, $arg1, $arg2);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_array0_exch_at($arg0, $arg1, $arg2)
{
//
  $tmpret4 = NULL;
//
  __patsflab_array0_exch_at:
  $tmpret4 = ats2phppre_arrszref_exch_at($arg0, $arg1, $arg2);
  return $tmpret4;
} // end-of-function


function
ats2phppre_ML_array0_exists_cloref($arg0, $arg1)
{
//
  $tmpret5 = NULL;
//
  __patsflab_array0_exists_cloref:
  $tmpret5 = ats2phppre_arrszref_exists_cloref($arg0, $arg1);
  return $tmpret5;
} // end-of-function


function
ats2phppre_ML_array0_exists_method($arg0)
{
//
  $tmpret6 = NULL;
//
  __patsflab_array0_exists_method:
  $tmpret6 = _ats2phppre_ML_array0_patsfun_7__closurerize($arg0);
  return $tmpret6;
} // end-of-function


function
_ats2phppre_ML_array0_patsfun_7($env0, $arg0)
{
//
  $tmpret7 = NULL;
//
  __patsflab__ats2phppre_ML_array0_patsfun_7:
  $tmpret7 = ats2phppre_ML_array0_exists_cloref($env0, $arg0);
  return $tmpret7;
} // end-of-function


function
ats2phppre_ML_array0_forall_cloref($arg0, $arg1)
{
//
  $tmpret8 = NULL;
//
  __patsflab_array0_forall_cloref:
  $tmpret8 = ats2phppre_arrszref_forall_cloref($arg0, $arg1);
  return $tmpret8;
} // end-of-function


function
ats2phppre_ML_array0_forall_method($arg0)
{
//
  $tmpret9 = NULL;
//
  __patsflab_array0_forall_method:
  $tmpret9 = _ats2phppre_ML_array0_patsfun_10__closurerize($arg0);
  return $tmpret9;
} // end-of-function


function
_ats2phppre_ML_array0_patsfun_10($env0, $arg0)
{
//
  $tmpret10 = NULL;
//
  __patsflab__ats2phppre_ML_array0_patsfun_10:
  $tmpret10 = ats2phppre_ML_array0_forall_cloref($env0, $arg0);
  return $tmpret10;
} // end-of-function


function
ats2phppre_ML_array0_app_cloref($arg0, $arg1)
{
//
//
  __patsflab_array0_app_cloref:
  ats2phppre_ML_array0_foreach_cloref($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_array0_foreach_cloref($arg0, $arg1)
{
//
//
  __patsflab_array0_foreach_cloref:
  ats2phppre_arrszref_foreach_cloref($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_ML_array0_foreach_method($arg0)
{
//
  $tmpret13 = NULL;
//
  __patsflab_array0_foreach_method:
  $tmpret13 = _ats2phppre_ML_array0_patsfun_14__closurerize($arg0);
  return $tmpret13;
} // end-of-function


function
_ats2phppre_ML_array0_patsfun_14($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_ML_array0_patsfun_14:
  ats2phppre_ML_array0_foreach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
<?php
/*
** end of [output/libatscc2php_all.php]
*/
?>

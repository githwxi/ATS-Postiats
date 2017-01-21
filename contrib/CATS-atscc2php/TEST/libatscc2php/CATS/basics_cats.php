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

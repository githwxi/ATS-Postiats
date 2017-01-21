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

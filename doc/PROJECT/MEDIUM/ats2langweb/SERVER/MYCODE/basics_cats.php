<?php

/* ****** ****** */

/*
// For building TUTORATS
*/

/* ****** ****** */

/*
// Author: Hongwei Xi
// Start time: September, 2014
*/

/* ****** ****** */
//
function
atslangweb_fname_dats_c
  ($fname) { return $fname . "_dats.c"; }
function
atslangweb_fname_dats_js
  ($fname) { return $fname . "_dats.js"; }
function
atslangweb_fname_dats_php
  ($fname) { return $fname . "_dats.php"; }
//
/* ****** ****** */

function
atslangweb_exec_retval
  ($command)
{
  $retval = 0;
  $output = array();
  exec($command, $output, $retval);
  return $retval;
}

/* ****** ****** */
//
$atslangweb_patsopt_tcats_preamble = "
#include
\"share/atspre_define.hats\"
#include
\"share/HATS/atspre_staload_libats_ML.hats\"
" ; // end of [$atslangweb_patsopt_tcats_preamble]
//
$atslangweb_patsopt_tcats_postamble = "" ;
//
/* ****** ****** */
//
$atslangweb_patsopt_ccats_preamble = "
#include
\"share/atspre_define.hats\"
#include
\"share/HATS/atspre_staload_libats_ML.hats\"
" ; // end of [$atslangweb_patsopt_ccats_preamble]
//
$atslangweb_patsopt_ccats_postamble = "" ;
//
/* ****** ****** */
//
$atslangweb_patsopt_atscc2js_preamble = "
#include
\"share/atspre_define.hats\"
#include
\"{\$LIBATSCC2JS}/staloadall.hats\"
//
staload \"{\$LIBATSCC2JS}/SATS/print.sats\"
//
#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME \"my_dynload\"
//
" ; // end of [$atslangweb_patsopt_atscc2js_preamble]
//
$atslangweb_patsopt_atscc2js_postamble = "
%{\$
//
ats2jspre_the_print_store_clear();
my_dynload();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{\$}
" ; // end of [$atslangweb_patsopt_atscc2js_postamble]
//
/* ****** ****** */

/* end of [basics_cats.php] */

?>

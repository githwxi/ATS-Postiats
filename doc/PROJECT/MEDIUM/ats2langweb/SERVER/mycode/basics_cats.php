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
atslangweb__fname_dats_c($fname) { return $fname . "_dats.c"; }
function
atslangweb__fname_dats_js($fname) { return $fname . "_dats.js"; }
function
atslangweb__fname_dats_php($fname) { return $fname . "_dats.php"; }
//
/* ****** ****** */

function
atslangweb__exec_retval
  ($command)
{
  $retval = 0;
  $output = array();
  exec($command, $output, $retval);
  return $retval;
}

/* ****** ****** */
//
$atslangweb__patsopt_code_preamble = "
#include
\"share/atspre_define.hats\"
staload\"{\$LIBATSCC2JS}/staloadall.hats\"
#define ATS_MAINATSFLAG 1
#define ATS_DYNFLAGNAME \"my_dynload\"
" ; // end of [$atslangweb__patsopt_code_preamble]
//
$atslangweb__patsopt_code_postamble = "
%{\$
//
function
my_main()
{
ats2jspre_the_print_store_clear();
my_dyload();
alert(ats2jspre_the_print_store_join());
}
//
%} // end of [%{\001]
" ; // end of [$atslangweb__patsopt_code_postamble]
//
/* ****** ****** */

/* end of [basics_cats.php] */

?>

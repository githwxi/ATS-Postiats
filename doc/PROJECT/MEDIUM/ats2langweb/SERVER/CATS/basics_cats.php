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
atslangweb_fname_dats_c($fname) { return $fname . "_dats.c"; }
function
atslangweb_fname_dats_js($fname) { return $fname . "_dats.js"; }
function
atslangweb_fname_dats_php($fname) { return $fname . "_dats.php"; }
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

/* end of [basics_cats.php] */

?>

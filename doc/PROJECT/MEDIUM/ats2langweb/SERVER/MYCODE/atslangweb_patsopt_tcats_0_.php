<?php
//
$MYPHPDIR = "";
/*
$MYPHPDIR = "SERVER/MYCODE"; // for testing
*/
//
header(
"Access-Control-Allow-Origin: *"
); /* header */
//
include
"./$MYPHPDIR/libatscc2php_all.php";
//
include "./$MYPHPDIR/basics_cats.php";
//
include "./$MYPHPDIR/basics_dats.php";
include "./$MYPHPDIR/atslangweb_utils_dats.php";
//
$HOME = getenv("HOME");
$PATH = getenv("PATH");
//
$PATSHOME = "$HOME/ats2-lang";
$PATSCONTRIB = "$HOME/ats2-lang-contrib";
//
putenv("PATSHOME=$PATSHOME");
putenv("PATSCONTRIB=$PATSCONTRIB");
putenv("PATH=$PATH:$PATSHOME/bin");
//
$mycode =
rawurldecode($_REQUEST["mycode"]);
$mycode_res =
atslangweb_patsopt_tcats_code_0_($mycode);
//
echo rawurlencode(json_encode($mycode_res));
//
/* end of [atslangweb_patsopt_tcats_0_.php] */
//
?>

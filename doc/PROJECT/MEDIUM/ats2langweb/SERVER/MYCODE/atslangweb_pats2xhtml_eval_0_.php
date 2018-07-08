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
$stadyn =
rawurldecode($_REQUEST["stadyn"]);
//
$stadyn = intval($stadyn); // HX: FIXED!!!
//
$mycode =
rawurldecode($_REQUEST["mycode"]);
$mycode_res =
atslangweb_pats2xhtml_eval_code_0_($stadyn, $mycode);
//
echo rawurlencode(json_encode($mycode_res));
//
/* end of [atslangweb_pats2xhtml_eval_0_.php] */
//
?>

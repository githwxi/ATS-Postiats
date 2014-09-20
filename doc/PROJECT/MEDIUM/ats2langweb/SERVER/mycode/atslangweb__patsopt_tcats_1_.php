<?php
//
$MYPHPDIR = "SERVER/mycode";
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
putenv("PATSHOME=$HOME/app-root/repo/ats2-lang");
putenv("PATSHOMERELOC=$HOME/app-root/repo/ats2-lang-contrib");
//
$mycode =
rawurldecode($_REQUEST["mycode"]);
$mycode_res = atslangweb__patsopt_tcats_code_1_($mycode);
echo rawurldecode(json_encode($mycode_res));
//
?>

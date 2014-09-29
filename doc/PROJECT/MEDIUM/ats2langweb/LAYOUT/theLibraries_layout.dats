(*
** For
** atslangweb_Libraries
*)

(* ****** ****** *)

#include "./mylayout.dats"

(* ****** ****** *)

val () =
thePageLeft.content(
"\
<?php\n\
include './thePageLeft/Libraries.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRHeaderTop.content
("\
<?php\n\
include './thePageRHeaderTop/Home.php';\n\
?>\n\
") (* end of [val] *)

val () =
thePageRHeaderSep.content
("\
<?php\n\
include './thePageRHeaderSep/Libraries.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRBodyLHeader.content
("\
<?php\n\
include './thePageRBodyLHeader/Libraries.php';\n\
?>\n\
") (* end of [val] *)

val () =
thePageRBodyLContent.content
("\
<?php\n\
include './thePageRBodyLContent/Libraries.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRBodyRight.content
("\
<?php\n\
include './thePageRBodyRight/Libraries.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRFooterRest.content
("\
<?php include './thePageRFooterRest/Home.php'; ?>\n\
") (* end of [val] *)

(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
//
val () =
  fprint_webox_html_all (out, theBodyProp)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [theLibraries_layout.dats] *)

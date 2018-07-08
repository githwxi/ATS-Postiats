(*
** For
** atslangweb_Community
*)

(* ****** ****** *)
//
#include
"./mylayout1.dats"
//
(* ****** ****** *)

val () =
thePageLeft.content(
"\
<?php\n\
include './thePageLeft/Community.php';\n\
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
include './thePageRHeaderSep/Community.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRBodyLHeader.content
("\
<?php\n\
include './thePageRBodyLHeader/Community.php';\n\
?>\n\
") (* end of [val] *)

val () =
thePageRBodyLContent.content
("\
<?php\n\
include './thePageRBodyLContent/Community.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRBodyRight.content
("\
<?php\n\
include './thePageRBodyRight/Community.php';\n\
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
implement
gprint$out<>
(
// argless
) = stdout_ref
//
val () = gprint_webox_html_all<>(theBodyProp)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [theCommunity_layout.dats] *)

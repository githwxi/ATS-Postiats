(*
** For
** atslangweb_Documents
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
include './thePageLeft/Documents.php';\n\
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
include './thePageRHeaderSep/Documents.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRBodyLHeader.content
("\
<?php\n\
include './thePageRBodyLHeader/Documents.php';\n\
?>\n\
") (* end of [val] *)

val () =
thePageRBodyLContent.content
("\
<?php\n\
include './thePageRBodyLContent/Documents.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRBodyRight.content
("\
<?php\n\
include './thePageRBodyRight/Documents.php';\n\
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

(* end of [theDocuments_layout.dats] *)

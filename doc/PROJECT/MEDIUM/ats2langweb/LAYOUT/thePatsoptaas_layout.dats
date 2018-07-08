(*
** HX-2014-10:
** Patsopt-as-a-Service (PATSOPTAAS)
*)

(* ****** ****** *)
//
#include
"./mylayout2.dats"
//
(* ****** ****** *)
  
val () =
thePage2.content
(
"\
<?php\n\
include './thePage2/Patsoptaas_seed.php';\n\
?><!--php-->\n\
") (* end of [thePage2.content] *)

(* ****** ****** *)

val () =
thePage2Left.content
(
"\
<?php\n\
include './thePage2Left/Patsoptaas_seed.php';\n\
?><!--php-->\n\
") (* end of [thePage2Left.content] *)

(* ****** ****** *)

val () =
thePage2RTop.content
(
"\
<?php\n\
include './thePage2RTop/Patsoptaas_seed.php';\n\
?><!--php-->\n\
") (* end of [thePage2RTop.content] *)
  
(* ****** ****** *)

val () =
thePage2RBody.content
(
"\
<?php\n\
include './thePage2RBody/Patsoptaas_seed.php';\n\
?><!--php-->\n\
") (* end of [thePage2RBody.content] *)
  
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
val () =
gprintln!(
"\
<?php
echo \"<?php\\n\";
echo \"header(\\n\";
echo \"\\\"Access-Control-Allow-Origin: *\\\"\\n\";
echo \"); /* header */\\n\";
echo \"?>\\n\";
?><!--php-->
") (* fprintln! *)
//
val () = gprint_webox_html_all<>(theBodyProp)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [thePatsoptaas_layout.dats] *)

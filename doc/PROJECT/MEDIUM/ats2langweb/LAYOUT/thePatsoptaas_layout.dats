(*
** HX-2014-10:
** Patsopt-as-a-Service (PATSOPTAAS)
*)

(* ****** ****** *)

#include "./mylayout2.dats"

(* ****** ****** *)
  
val () =
thePage2.content
(
"\
<?php\n\
include './thePage2/Patsoptaas.php';\n\
?><!--php-->\n\
") (* end of [thePage2.content] *)

(* ****** ****** *)

val () =
thePage2Left.content
(
"\
<?php\n\
include './thePage2Left/Patsoptaas.php';\n\
?><!--php-->\n\
") (* end of [thePage2Left.content] *)

(* ****** ****** *)

val () =
thePage2RTop.content
(
"\
<?php\n\
include './thePage2RTop/Patsoptaas.php';\n\
?><!--php-->\n\
") (* end of [thePage2RTop.content] *)
  
(* ****** ****** *)

val () =
thePage2RBody.content
(
"\
<?php\n\
include './thePage2RBody/Patsoptaas.php';\n\
?><!--php-->\n\
") (* end of [thePage2RBody.content] *)
  
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

(* end of [thePatsopt_layout.dats] *)

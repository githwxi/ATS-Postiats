(*
** Testing weboxy
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload "{$LIBATSHWXI}/weboxy/SATS/weboxy.sats"
staload _ = "{$LIBATSHWXI}/weboxy/DATS/weboxy.dats"
//
(* ****** ****** *)

local

val webox_make_ = webox_make<>

in (* in-of-local *)

implement
{}(*tmp*)
webox_make
  () = wbx where
{
  val wbx = webox_make_ ()
  val () = wbx.bgcolor(randcolor())
} (* end of [webox_make] *)

end // end of [local]

(* ****** ****** *)
//
val () =
  randcolor_initize ()
//
(* ****** ****** *)
//
val thePage =
  webox_make_name ("thePage")
//
(* ****** ****** *)
//
val thePageLeft =
  webox_make_name ("thePageLeft")
val thePageRight =
  webox_make_name ("thePageRight")
val () =
  thePage.tabstyle(TShbox)
val () =
  thePage.percentlst ($list(15, ~1))
val () =
  thePage.children (thePageLeft, thePageRight)
//
(* ****** ****** *)

val () =
thePageLeft.content(
"\
<?php\n\
include './thePageLeft/main.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)
//
val thePageRHeader =
  webox_make_name ("thePageRHeader")
val thePageRHeaderTop =
  webox_make_name ("thePageRHeaderTop")
val thePageRHeaderSep =
  webox_make_name ("thePageRHeaderSep")
//
val () =
  thePageRHeader.children (thePageRHeaderTop, thePageRHeaderSep)
//
(* ****** ****** *)

val () =
thePageRHeaderTop.content
("\
<?php\n\
include './thePageRHeaderTop/main.php';\n\
?>\n\
") (* end of [val] *)

val () =
thePageRHeaderSep.content
("\
<?php\n\
include './thePageRHeaderSep/main.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val thePageRBody =
  webox_make_name ("thePageRBody")
val thePageRBodyLeft =
  webox_make_name ("thePageRBodyLeft")
val thePageRBodyRight =
  webox_make_name ("thePageRBodyRight")
//
val () =
  thePageRBody.tabstyle (TShbox)
val () =
  thePageRBody.percentlst ($list(72, 28))
val () =
  thePageRBody.children (thePageRBodyLeft, thePageRBodyRight)
//
(* ****** ****** *)
//
val thePageRBodyLHeader =
 webox_make_name ("thePageRBodyLHeader")
val thePageRBodyLContent =
 webox_make_name ("thePageRBodyLContent")
val () =
  thePageRBodyLeft.children (thePageRBodyLHeader, thePageRBodyLContent)
//
(* ****** ****** *)

val () =
thePageRBodyLHeader.content
("\
<?php\n\
include './thePageRBodyLHeader/Home.php';\n\
?>\n\
") (* end of [val] *)

val () =
thePageRBodyLContent.content
("\
<?php\n\
include './thePageRBodyLContent/Home.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)

val () =
thePageRBodyRight.content
("\
<?php\n\
include './thePageRBodyRight/Home.php';\n\
?>\n\
") (* end of [val] *)

(* ****** ****** *)
//
val thePageRFooter =
  webox_make_name ("thePageRFooter")
val thePageRFooterSep =
  webox_make_name ("thePageRFooterSep")
val thePageRFooterRest =
  webox_make_name ("thePageRFooterRest")
//
val () =
thePageRFooterRest.content
  ("This page is created with help from ATS/weboxy")
//
val () =
  thePageRFooter.children (thePageRFooterSep, thePageRFooterRest)
//      
(* ****** ****** *)
//
val () =
  thePageRight.children (thePageRHeader, thePageRBody, thePageRFooter)
//
(* ****** ****** *)
//
val theBodyProp =
  webox_make_name ("theBodyProp")
//
val () = theBodyProp.bgcolor("")
//
val () = theBodyProp.children(thePage)
//
(* ****** ****** *)

implement
fprint_css_preamble<>
  (out) = let
//
val () =
fprint (out, "\
.center {\n\
  margin-left: auto;\n\
  margin-right: auto;\n\
}\n\
") (* end of [fprint] *)
//
in
  // nothing
end // end of [fprint_css_preamble]

(* ****** ****** *)

implement
fprint_css_postamble<>
  (out) = let
//
val () =
fprint (out, "\
body {
font-family: sans-serif;
background-color: #213449; /* dark blue */
}\n\
") (* end of [fprint] *)
// 
val () =
fprint (out, "\
#thePage {\n\
  width: 85%;\n\
  margin-left: auto;\n\
  margin-right: auto;\n\
}\n\
") (* end of [fprint] *)
//
val () =
fprint (out, "\
#thePageRHeader {\n\
  text-align: center;
}\n\
") (* end of [fprint] *)
//
val () =
fprint (out, "\
#thePageRFooter {\n\
  text-align: center;\n\
}\n\
") (* end of [fprint] *)
//
in
  // nothing
end // end of [fprint_css_postamble]

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

(* end of [test01.dats] *)

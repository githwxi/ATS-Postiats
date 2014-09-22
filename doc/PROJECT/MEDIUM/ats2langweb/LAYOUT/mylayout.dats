(*
** For atslangweb
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

(*
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
*)

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
val () = thePage.bgcolor("#d6f0fd")
//
(* ****** ****** *)
//
val thePageLeft =
  webox_make_name ("thePageLeft")
val thePageRight =
  webox_make_name ("thePageRight")
//
val () = thePageLeft.pheight(100)
val () = thePageRight.pheight(100)
//
val () =
  thePage.tabstyle(TShbox)
val () =
  thePage.percentlst ($list(15, ~1))
val () =
  thePage.children (thePageLeft, thePageRight)
//
(* ****** ****** *)
//
val thePageRHeader =
  webox_make_name ("thePageRHeader")
//
val thePageRHeaderTop =
  webox_make_name ("thePageRHeaderTop")
val thePageRHeaderSep =
  webox_make_name ("thePageRHeaderSep")
val () = thePageRHeaderSep.bgcolor("#8f0222")
//
val () =
  thePageRHeader.children (thePageRHeaderTop, thePageRHeaderSep)
//
(* ****** ****** *)

val thePageRBody =
  webox_make_name ("thePageRBody")
//
val thePageRBodyLeft =
  webox_make_name ("thePageRBodyLeft")
val thePageRBodyRight =
  webox_make_name ("thePageRBodyRight")
//
val () = thePageRBodyLeft.pheight(100)
val () = thePageRBodyRight.pheight(100)
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
(*
val () =
  thePageRBodyLeft.tabstyle (TSvbox)
*)
val () =
  thePageRBodyLeft.children (thePageRBodyLHeader, thePageRBodyLContent)
//
(* ****** ****** *)
//
val thePageRFooter =
  webox_make_name ("thePageRFooter")
//
val thePageRFooterSep =
  webox_make_name ("thePageRFooterSep")
val () = thePageRFooterSep.bgcolor("#8f0222")
//
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
val () =
fprint (out, "\
#thePageLeft {\n\
  background-color: #1e5799;\n\
  background-image: linear-gradient(to right, #1e5799, #7db9e8);\n\
}\n\
") (* end of [fprint] *)
//
in
  // nothing
end // end of [fprint_css_postamble]

(* ****** ****** *)

implement
fprint_webox_head_end<>
  (out) = let
//
val () =
fprint (out
, "<script src=\"./CLIENT/mycode/libatscc2js_all.js\"></script>\n"
) (* end of [val] *)
val () =
fprint (out
, "<script src=\"./CLIENT/mycode/libatscc2js_print_store.js\"></script>\n"
) (* end of [val] *)
val () =
fprint (out
, "<script src=\"./CLIENT/mycode/atslangweb_utils_dats.js\"></script>\n"
) (* end of [val] *)
//
in
  // nothing
end // end of [fprint_webox_head_end]

(* ****** ****** *)

(* end of [mylayout.dats] *)

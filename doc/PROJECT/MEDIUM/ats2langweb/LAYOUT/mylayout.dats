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
//
val () = randcolor_initize ()
//
val webox_make_ = webox_make<>
//
in (* in-of-local *)
//
implement
{}(*tmp*)
webox_make
  () = wbx where
{
  val wbx = webox_make_ ()
  val () = wbx.bgcolor(randcolor())
} (* end of [webox_make] *)
//
end // end of [local]
*)

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
  thePage.percentlst ($list(15, 85))
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
val () = thePageRHeaderSep.bgcolor("rgb(143,2,34)")
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
  thePageRBody.percentlst ($list(68, 32))
val () =
  thePageRBody.children (thePageRBodyLeft, thePageRBodyRight)
//
(* ****** ****** *)
//
val
thePageRBodyLHeader =
  webox_make_name ("thePageRBodyLHeader")
val
thePageRBodyLContent =
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
val
thePageRFooter =
  webox_make_name ("thePageRFooter")
//
val
thePageRFooterSep =
  webox_make_name ("thePageRFooterSep")
val () = thePageRFooterSep.bgcolor("#8f0222")
//
val
thePageRFooterRest =
  webox_make_name ("thePageRFooterRest")
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
val () =
fprint (out, "\
.command_line {\n\
  width:96%;\n\
  margin:auto;\n\
  padding:10px;\n\
  color: #000000;\n\
  background-color: #FFFFFF;\n\
  border-radius:6px\n\
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
\n\
body {\n\
  font-family: Helvetica, Arial, sans-serif;\n\
  background-color: #213449; /* dark blue */\n\
}\n\
") (* end of [fprint] *)
// 
val () =
fprint (out, "\
\n\
#thePage {\n\
  width: 90%;\n\
  margin-left: auto;\n\
  margin-right: auto;\n\
}\n\
") (* end of [fprint] *)
//
val () =
fprint (out, "\
\n\
#thePageRHeader {\n\
  text-align: center;
}\n\
") (* end of [fprint] *)
//
val () =
fprint (out, "\
\n\
#thePageRFooter {\n\
  text-align: center;\n\
}\n\
") (* end of [fprint] *)
//
val () =
fprint (out, "\
\n\
#thePageLeft {\n\
  background-color: #1e5799;\n\
  background-image: linear-gradient(to right, #1e5799, #7db9e8);\n\
}\n\
") (* end of [fprint] *)
//
val () =
fprint (out, "\
\n\
#thePageRBodyRight\n\
{\n\
  font-size: 88%;\n\
  background: #d1d360;\n\
  border-top-left-radius:12px;\n\
  border-bottom-left-radius:12px;\n\
}\n\
") (* end of [fprint] *)
//
val () =
fprint (out, "\
\n\
.thePageRBodyLContent\n\
{\n\
  margin-left: 8px;\n\
  margin-right: 8px;\n\
  padding-top: 12px;\n\
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
(*
val () =
fprint (out, "\
<link\n\
 rel=\"shortcut icon\"\n\
 href=\"./MYDATA/favicon.ico\">\n\
</link>\n"
) (* end of [val] *)
*)
//
val () =
fprint (out, "\
<link\n\
 rel=\"icon\" type=\"image/gif\"\n\
 href=\"./MYDATA/favicon_animated.gif\">\n\
</link>\n"
) (* end of [val] *)
//
val () =
fprint (out, "\
<script\n\
 src=\"./SCRIPT/jquery-2.1.1.min.js\">\n\
</script>\n"
) (* end of [val] *)
//
(*
val () =
fprint (out, "\
<script\n\
 src=\"//cdn.jsdelivr.net/jquery/2.1.1/jquery.min.js\">\n\
</script>\n"
) (* end of [val] *)
*)
//
val () =
fprint (out, "\
<script\n\
 src=\"./CLIENT/MYCODE/libatscc2js_all.js\">\n\
</script>\n"
) (* end of [val] *)
val () =
fprint (out, "\
<script\n\
 src=\"./CLIENT/MYCODE/libatscc2js_print_store.js\">\n\
</script>\n"
) (* end of [val] *)
val () =
fprint (out, "\
<script\n\
 src=\"./CLIENT/MYCODE/atslangweb_utils_dats.js\">\n\
</script>\n"
) (* end of [val] *)
//
val () =
fprint (out
, "<?php include './thePage/share.php'; ?>"
) (* end of [val] *)
val () =
fprint (out
, "<?php include './thePageLeft/share.php'; ?>"
) (* end of [val] *)
val () =
fprint (out
, "<?php include './thePageRHeaderSep/share.php'; ?>"
) (* end of [val] *)
val () =
fprint (out
, "<?php include './thePageRBodyLHeader/share.php'; ?>"
) (* end of [val] *)
//
in
  // nothing
end // end of [fprint_webox_head_end]

(* ****** ****** *)

(* end of [mylayout.dats] *)

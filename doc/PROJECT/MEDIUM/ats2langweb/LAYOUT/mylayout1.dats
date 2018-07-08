(*
** For atslangweb
*)

(* ****** ****** *)
//
#define
PATSHOME_targetloc
"$PATSHOME"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include
"{$PATSHOME}/npm-utils\
/contrib/libats-hwxi/weboxy/DATS/weboxy.dats"
//
(* ****** ****** *)
//
(*
implement
randcolor<>() = let
//
val M = 256
//
val r = randint<>(M)
val b = randint<>(M)
val g = randint<>(M)
//
val bsz = 16
val (pf,pfgc|p) = malloc_gc (i2sz(bsz))
val
(
(*void*)
) =
$extfcall
(
  void
, "snprintf", p, bsz, "#%02x%02x%02x", i2u(r), i2u(b), i2u(g)
) (* end of [$extfcall] *)
//
in
  $UN.castvwtp0{string}((pf, pfgc | p))
end // end of [randcolor]
//
implement
randcolor_initize<>() = srandom_with_time<>()
*)
//
(* ****** ****** *)
//
val thePage =
  webox_make_name ("thePage")
//
val () = thePage.pheight(100)
//
(*
val () = thePage.bgcolor("#d6f0fd")
val () = thePage.bgcolor("#fffff0")
*)
val () = thePage.bgcolor("#ffffff")
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
  thePage.pcentlst
    (g0ofg1($list(PChard(14), PChard(86))))
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
  thePageRBody.tabstyle(TShbox)
val () =
  thePageRBody.pcentlst
    (g0ofg1($list(PChard(68), PCsoft(32))))
val () =
  thePageRBody.children(thePageRBodyLeft, thePageRBodyRight)
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
val () = theBodyProp.pheight(100)
val () = theBodyProp.children(thePage)
//
(* ****** ****** *)

implement
gprint_webox_head_beg<>
  ((*void*)) = let
//
val () =
gprint (
"\
<meta charset=\"utf-8\">\n\
<title>ATS-PL-SYS</title>\n\
") (* end of [gprint] *)
//
in
  // nothing
end // end of [gprint_webox_head_beg<>]

(* ****** ****** *)

implement
gprint_css_preamble<>
  ((*void*)) = let
//
val () =
gprint (
"\
.center {\n\
  margin-left: auto;\n\
  margin-right: auto;\n\
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
.command_line {\n\
  width:96%;\n\
  margin:auto;\n\
  padding:10px;\n\
  color: #000000;\n\
  background-color: #D0D0D0;\n\
  border-radius:6px\n\
}\n\
") (* end of [gprint] *)
//
in
  // nothing
end // end of [gprint_css_preamble]

(* ****** ****** *)

implement
gprint_css_postamble<>
  ((*void*)) = let
//
val () =
gprint (
"\
\n\
body {\n\
  margin-top: 8px;\n\
  margin-bottom: 8px;\n\
  margin-left: 0px;\n\
  margin-right: 0px;\n\
  font-family: Helvetica, Arial, sans-serif;\n\
  background-color: #213449; /* dark blue */\n\
}\n\
") (* end of [gprint] *)
//
(*
val () =
gprint (
\"
\n\
#thePage {\n\
  width: 90%;\n\
  margin-left: auto;\n\
  margin-right: auto;\n\
}\n\
") (* end of [gprint] *)
*)
//
val () =
gprint (
"\
\n\
#thePageRHeader {\n\
  text-align: center;
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
\n\
#thePageRFooter {\n\
  text-align: center;\n\
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
\n\
#thePageLeft {\n\
/*\n\
  background-color: #1e5799;\n\
  background-image: linear-gradient(to right, #1e5799, #7db9e8);\n\
*/\n\
  background-color: rgba(30, 87, 153, 0.750);\n\
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
\n\
#thePageRBodyRight\n\
{\n\
  font-size: 88%;\n\
  background: #d1d360;\n\
  overflow-y: auto;\n\
  border-top-left-radius:12px;\n\
/*
  border-bottom-left-radius:12px;\n\
*/
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
\n\
.thePageRBodyLContent\n\
{\n\
  margin-left: 8px;\n\
  margin-right: 8px;\n\
  padding-top: 12px;\n\
}\n\
") (* end of [gprint] *)
//
in
  // nothing
end // end of [gprint_css_postamble]

(* ****** ****** *)

implement
gprint_webox_head_end<>
  ((*void*)) = let
//
(*
val () =
gprint (
\"
<link\n\
 rel=\"shortcut icon\"\n\
 href=\"./MYDATA/favicon.ico\">\n\
</link>\n"
) (* end of [val] *)
*)
//
val () =
gprint (
"\
<link\n\
 rel=\"icon\" type=\"image/gif\"\n\
 href=\"./MYDATA/favicon_animated.gif\">\n\
</link>\n"
) (* end of [val] *)
//
val () =
gprint (
"\
<script\n\
 src=\"./SCRIPT/jquery-2.1.1.min.js\">\n\
</script>\n"
) (* end of [val] *)
//
(*
val () =
gprint (
\"
<script\n\
 src=\"//cdn.jsdelivr.net/jquery/2.1.1/jquery.min.js\">\n\
</script>\n"
) (* end of [val] *)
*)
//
val () =
gprint (
"\
<script\n\
 src=\"./CLIENT/MYCODE/libatscc2js_all.js\">\n\
</script>\n"
) (* end of [val] *)
val () =
gprint (
"\
<script\n\
 src=\"./CLIENT/MYCODE/libatscc2js_print_store_cats.js\">\n\
</script>\n"
) (* end of [val] *)
val () =
gprint (
"\
<script\n\
 src=\"./CLIENT/MYCODE/atslangweb_utils_dats.js\">\n\
</script>\n"
) (* end of [val] *)
//
val () =
gprint
(
"<?php include './thePage/share.php'; ?>"
) (* end of [val] *)
val () =
gprint
(
"<?php include './thePageLeft/share.php'; ?>"
) (* end of [val] *)
val () =
gprint
(
"<?php include './thePageRHeaderSep/share.php'; ?>"
) (* end of [val] *)
val () =
gprint
(
"<?php include './thePageRBodyLHeader/share.php'; ?>"
) (* end of [val] *)
//
in
  // nothing
end // end of [gprint_webox_head_end]

(* ****** ****** *)

(* end of [mylayout1.dats] *)

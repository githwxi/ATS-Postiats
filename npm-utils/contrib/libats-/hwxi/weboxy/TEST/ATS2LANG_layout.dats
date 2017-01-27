(*
** Testing weboxy
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload
"{$LIBATSHWXI}\
/teaching/BUCS/DATS/BUCS320.dats"
//
(* ****** ****** *)
//
#include "./../DATS/weboxy.dats"
//
(* ****** ****** *)
//
implement
randcolor<>
((*void*)) = let
//
val M = 256
//
val r = randint<>(M)
val b = randint<>(M)
val g = randint<>(M)
//
val bsz = 16
val (pf,pfgc|p) = malloc_gc(i2sz(bsz))
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
  thePage.pcentlst
    (g0ofg1($list(PChard(15), PCnone())))
val () =
  thePage.children(thePageLeft, thePageRight)
//
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
<theHeaderLine1>The ATS Programming Language</theHeaderLine1><br>
<theHeaderLine2>Unleashing the Potentials of Types and Templates</theHeaderLine2><br>
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
  thePageRBodyLeft.height (600)
val () =
  thePageRBodyRight.height (600)
//
val () =
  thePageRBody.tabstyle(TShbox)
val () =
  thePageRBody.pcentlst
    (g0ofg1($list(PChard(75), PChard(25))))
val () =
  thePageRBody.children(thePageRBodyLeft, thePageRBodyRight)
//
(* ****** ****** *)
//
val
thePageRBodyLHeader =
webox_make_name("thePageRBodyLHeader")
val
thePageRBodyLContent =
webox_make_name("thePageRBodyLContent")
//
val () =
  thePageRBodyLeft.children (thePageRBodyLHeader, thePageRBodyLContent)
//
(* ****** ****** *)
//
val
thePageRFooter =
webox_make_name("thePageRFooter")
val
thePageRFooterSep =
webox_make_name("thePageRFooterSep")
val
thePageRFooterRest =
webox_make_name("thePageRFooterRest")
//
val () =
thePageRFooterRest.content
  ("This page is created with help from ATS/weboxy")
//
val () =
  thePageRFooter.children(thePageRFooterSep, thePageRFooterRest)
//      
(* ****** ****** *)
//
val () =
  thePageRight.children(thePageRHeader, thePageRBody, thePageRFooter)
//
(* ****** ****** *)
//
val
theBodyProp =
webox_make_name("theBodyProp")
//
val () = theBodyProp.bgcolor("")
//
val () = theBodyProp.children(thePage)
//
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
body {
font-family: sans-serif;
background-color: #213449; /* dark blue */
}\n\
") (* end of [gprint] *)
// 
val () =
gprint (
"\
#thePage {\n\
  width: 85%;\n\
  margin-left: auto;\n\
  margin-right: auto;\n\
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
#thePageRHeader {\n\
  text-align: center;
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
#thePageRBodyLHeader\n\
{\n\
  text-align: center;\n\
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
#thePageRFooter {\n\
  text-align: center;\n\
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
theHeaderLine1 {\n\
  font-size: 225%;\n\
  font-weight: bold;\n\
}\n\
theHeaderLine2 {\n\
  font-size: 150%;\n\
  font-weight: bold;\n\
}\n\
") (* end of [gprint] *)
//
in
  // nothing
end // end of [gprint_css_postamble]

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

(* end of [ATS2LANG_layout.dats] *)

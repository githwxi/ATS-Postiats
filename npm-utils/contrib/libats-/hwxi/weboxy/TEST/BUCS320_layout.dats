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

val
webox_make_ = webox_make<>

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
// end of [thePage]

(* ****** ****** *)
//
val thePageHeader =
  webox_make_name ("thePageHeader")
val thePageHeaderTop =
  webox_make_name ("thePageHeaderTop")
val thePageHeaderSep =
  webox_make_name ("thePageHeaderSep")
//
val () =
  thePageHeader.children (thePageHeaderTop, thePageHeaderSep)
//
(* ****** ****** *)

val () =
thePageHeaderTop.content
("\
<theHeaderLine1>BU CAS CS320</theHeaderLine1><br>
<theHeaderLine1>Concepts of Programming Languages</theHeaderLine1><br>
<theHeaderLine2>Semester</theHeaderLine2><br>
") (* end of [val] *)

(* ****** ****** *)

val
thePageBody =
webox_make_name("thePagebody")
val
thePageBodyL =
webox_make_name("thePagebodyL")
val
thePageBodyR =
webox_make_name("thePagebodyR")
//
val () =
  thePageBodyL.height(600)
val () =
  thePageBodyR.height(600)
//
val () =
  thePageBody.tabstyle(TShbox)
val () =
  thePageBody.pcentlst
    (g0ofg1($list(PChard(80), PChard(20))))
val () =
  thePageBody.children(thePageBodyL, thePageBodyR)
//
(* ****** ****** *)
//
val
thePageFooter =
webox_make_name("thePageFooter")
val
thePageFooterSep =
webox_make_name("thePageFooterSep")
val
thePageFooterRest =
webox_make_name("thePageFooterRest")
//
val () =
thePageFooterRest.content
  ("This page is created with help from ATS/weboxy")
//
val () =
  thePageFooter.children(thePageFooterSep, thePageFooterRest)
//      
(* ****** ****** *)
//
val
thePage =
webox_make_name("thePage")
//
val () =
  thePage.children(thePageHeader, thePageBody, thePageFooter)
//
(* ****** ****** *)
//  
val
theBodyProp =
webox_make_name ("theBodyProp")
// end of [theBodyProp]
//      
val () = theBodyProp.children(thePage)
//
(* ****** ****** *)

implement
gprint_webox_head_beg<>
  () = let
//
val () =
gprint (
"\
<meta charset=\"utf-8\">\n\
<title>BUCS320-layout</title>\n\
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
  width: 72%;\n\
  margin-left: auto;\n\
  margin-right: auto;\n\
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
#thePageHeader {\n\
  text-align: center;
}\n\
") (* end of [gprint] *)
//
val () =
gprint (
"\
#thePageFooter {\n\
  text-align: center;
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

(* end of [BUCS320_layout.dats] *)

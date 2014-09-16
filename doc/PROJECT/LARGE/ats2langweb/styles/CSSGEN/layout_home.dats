(*
** HX-2014-09-14:
** For generating CSS used
** by the ats2langweb_home page
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
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

#include "./layout_params.hats"

(* ****** ****** *)

#define RANDCOLOR 1

(* ****** ****** *)

#ifdef
RANDCOLOR
#then
#else
#define RANDCOLOR 0
#endif

(* ****** ****** *)

#if
RANDCOLOR
#then
//
local
//
val () = randcolor_initize()
//
val webox_make_ = webox_make<>
//
(* ****** ****** *)
//
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
//
#endif // end of [RANDCOLOR]

(* ****** ****** *)
//
val thePageHeader =
  webox_make_name ("thePageHeader")
//  
val thePageHeaderTop =
  webox_make_name ("thePageHeaderTop")
val thePageHeaderSep =
  webox_make_name ("thePageHeaderSep")
//
val () =
thePageHeaderTop.content
("\
<p>thePageHeaderTop</p>\n\
<p>thePageHeaderTop</p>\n\
<p>thePageHeaderTop</p>\n\
") (* end of [val] *)
//
val () = (
  thePageHeader.children(thePageHeaderTop, thePageHeaderSep)
) (* end of [val] *)

(* ****** ****** *)
//
val thePageBody =
  webox_make_name_width ("thePageBody", thePageBody_width)
val thePageBodyHead =
  webox_make_name_width ("thePageBodyHead", thePageBody_width)
val thePageBodyContent =
  webox_make_name_width ("thePageBodyContent", thePageBody_width)
//
val () =
thePageBodyHead.content
("\
<p>thePageBodyHead</p>\n\
<p>thePageBodyHead</p>\n\
<p>thePageBodyHead</p>\n\
") (* end of [val] *)
val () =
thePageBodyContent.content
("\
<p>thePageBodyContent</p>\n\
<p>thePageBodyContent</p>\n\
<p>thePageBodyContent</p>\n\
<p>thePageBodyContent</p>\n\
<p>thePageBodyContent</p>\n\
") (* end of [val] *)
//
val () = thePageBody.tabstyle(TSvbox)
val () = thePageBody.children(thePageBodyHead, thePageBodyContent)
//        
(* ****** ****** *)
//
val thePageLSBar = webox_make_name ("thePageLSBar")
val ((*void*)) = thePageLSBar.width(thePageLSBar_width)
val () =
thePageLSBar.content
("\
<p>thePageLSBar</p>\n\
<p>thePageLSBar</p>\n\
<p>thePageLSBar</p>\n\
<p>thePageLSBar</p>\n\
<p>thePageLSBar</p>\n\
") (* end of [val] *)
//  
(* ****** ****** *)
//
val thePageFooter =
  webox_make_name ("thePageFooter")
val thePageFooterSep =
  webox_make_name ("thePageFooterSep")
val thePageFooterRest =
  webox_make_name ("thePageFooterRest")
//
val () =
thePageFooterRest.content
("\
<p>thePageFooterRest</p>\n\
<p>thePageFooterRest</p>\n\
<p>thePageFooterRest</p>\n\
") (* end of [val] *)
//
val () = (
  thePageFooter.children(thePageFooterSep, thePageFooterRest)
) (* end of [val] *)
//
(* ****** ****** *)
//
val thePageBody2 = webox_make_name ("thePageBody2")
val thePageBodyRSBar = webox_make_name ("thePageBodyRSBar")
//
val () = thePageBody2.tabstyle (TShbox)
val () = thePageBody2.children (thePageBody, thePageBodyRSBar)
val () = thePageBody2.percentlst ($list{int}(~1, 100))
//
(* ****** ****** *)
//
val thePage = webox_make_name ("thePage")
//
val () =
  thePage.children(thePageHeader, thePageBody2, thePageFooter)
//      
(* ****** ****** *)
//
val theBodyProp =
  webox_make_name ("theBodyProp")
//  
val () = theBodyProp.tabstyle(TShbox())
val () = theBodyProp.children (thePageLSBar, thePage)
val () = theBodyProp.percentlst ($list{int}(~1, 100))
//
(* ****** ****** *)

implement
fprint_css_postamble<> (out) =
{
//
val () =
fprint (out, "#theBodyProp { width: 90%; margin: auto; }\n")
//
} (* end of [fprint_css_post] *)

(* ****** ****** *)

implement
main0 () =
{
//
val () =
  fprint_webox_html_all (stdout_ref, theBodyProp)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [layout_home.dats] *)

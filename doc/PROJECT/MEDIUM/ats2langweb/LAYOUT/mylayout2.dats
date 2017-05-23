(*
** HX-2014-10:
** Patsopt-as-a-Service (PATSOPTAAS)
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

(* ****** ****** *)
//
val
thePage2 =
webox_make_name ("thePage2")
//
val () = thePage2.pheight(100)
//
(* ****** ****** *)
//
val
thePage2Left =
webox_make_name ("thePage2Left")
val
thePage2Right =
webox_make_name ("thePage2Right")
//
val () =
  thePage2Left.pheight(100)
val () =
  thePage2Right.pheight(100)
//
val () =
  thePage2.tabstyle(TShbox)
val () =
  thePage2.pcentlst
    (g0ofg1($list(PChard(15), PChard(85))))
val () =
  thePage2.children(thePage2Left, thePage2Right)
//
(* ****** ****** *)
//
val thePage2RTop =
  webox_make_name ("thePage2RTop")
//
val () = thePage2RTop.pheight(100)
val () = thePage2RTop.bgcolor("rgb(143,2,34)")
//
val thePage2RBody =
  webox_make_name ("thePage2RBody")
(*
val thePage2RFooter =
  webox_make_name ("thePage2RFooter")
*)
//
val () =
  thePage2RBody.pheight(100)
//
val () =
  thePage2Right.tabstyle(TSvbox)
val () =
  thePage2Right.pcentlst
    (g0ofg1($list(PChard(6), PChard(94))))
val () =
  thePage2Right.children(thePage2RTop, thePage2RBody)
//
(* ****** ****** *)
//
val theBodyProp =
  webox_make_name ("theBodyProp")
//
val () = theBodyProp.bgcolor("")
val () = theBodyProp.pheight(100)
//
val () = theBodyProp.children(thePage2)
//
(* ****** ****** *)
//
implement
gprint_webox_head_beg<>
  ((*void*)) = let
//
val () =
gprint (
"\
<meta charset=\"utf-8\">\n\
<title>Try-ATS-on-line</title>\n\
<base\n\
 href=\"http://www.ats-lang.org\">\n\
</base>\n\
") (* end of [val] *)
//
in
  // nothing
end // end of [gprint_webox_head_beg]

(* ****** ****** *)

implement
gprint_webox_head_end<>
  ((*void*)) = let
//
val () =
gprint (
"\
<link\n\
 rel=\"icon\" type=\"image/gif\"\n\
 href=\"./MYDATA/favicon_animated.gif\">\n\
</link>\n\
") (* end of [val] *)
//
val () =
gprint (
"\
<script\n\
 src=\"./SCRIPT/jquery-2.1.1.min.js\">\n\
</script>\n"
) (* end of [val] *)
//
val () =
gprint (
"\
<script\n\
 src=\"//cdn.jsdelivr.net/ace/1.1.7/min/ace.js\">\n\
</script>\n\
") (* end of [val] *)
//
val () =
gprint (
"\
<script\n\
 src=\"./CLIENT/MYCODE/ace-mode-ats2-by-hwwu.js\">\n\
</script>\n\
") (* end of [val] *)
//
val () =
gprint (
"\
<script\n\
  src=\"//cdn.jsdelivr.net/filesaver.js/0.2/FileSaver.min.js\">\n\
</script>\n\
") (* end of [val] *)
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
 src=\"./CLIENT/MYCODE/libatscc2js_canvas2d_all.js\">\n\
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
val () =
gprint (
"\
<script\n\
 src=\"./CLIENT/MYCODE/patsoptaas_utils_dats.js\">\n\
</script>\n"
) (* end of [val] *)
val () =
gprint (
"\
<script\n\
 src=\"./CLIENT/MYCODE/patsoptaas_examples_dats.js\">\n\
</script>\n"
) (* end of [val] *)
val () =
gprint (
"\
<script\n\
 src=\"./CLIENT/MYCODE/patsoptaas_templates_dats.js\">\n\
</script>\n"
) (* end of [val] *)
//
in
  // nothing
end // end of [gprint_webox_head_end]

(* ****** ****** *)

implement
gprint_css_preamble<>
  ((*void*)) = let
//
val () =
gprint (
"\
html {\n\
  height: 100%;\n\
}\n\
body {\n\
  margin: 0px;\n\
  height: 100%;\n\
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
  font-family: Helvetica, Arial, sans-serif;\n\
  background-color: #213449; /* dark blue */\n\
}\n\
") (* end of [gprint] *)
// 
(*
val () =
gprint (
"\
\n\
#thePage2\n\
{\n\
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
#thePage2Left\n\
{\n\
/*\n\
  background-color: #1e5799;\n\
  background-image: linear-gradient(to right, #1e5799, #7db9e8);\n\
*/\n\
  background-color: rgba(30, 87, 153, 0.750);\n\
}\n\
") (* end of [gprint] *)
//
in
  // nothing
end // end of [gprint_css_postamble]

(* ****** ****** *)

implement
gprint_webox_body_after<>
  ((*void*)) = let
//
(*
val () =
gprint (
"\
<script>\n\
(\n\
function()\n\
{\n\
var\n\
height =\n\
window.innerHeight - 16;\n\
height =\n\
height -\n\
$('#thePage2RTop').outerHeight(true);\n\
jQuery('#thePage2RBody').css({height:height});\n\
}(/*void*/)\n\
)\n\
</script>\n\
") (* end of [val] *)
*)
//
val () =
gprint (
"\
<script>\n\
$(document).ready(Patsoptaas_thePage2_initize);
</script>\n\
") (* end of [val] *)
//
val () =
gprint (
"\
\n\
<?php\n\
if($theScriptKind >= 1)\n\
{\n\
echo <<<EOT\n\
<?php\n\
  echo \"<script>\\\\n\";\n\
  echo \"\\\\$(document).ready(function(){Patsoptaas_thePage2_initize2('\".\\$mycode.\"','\".\\$mycode_fil.\"','\".\\$mycode_url.\"');});\\\\n\";\n\
  echo \"</script>\\\\n\";\n\
?>\n\
EOT;\n\
}\n\
?><!--php-->\n\
\n\
") (* end of [val] *)
//
in
  // nothing
end // end of [gprint_webox_body_after]

(* ****** ****** *)

(* end of [mylayout2.dats] *)

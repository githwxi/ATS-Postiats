(*
//
// Templates for PATSOPTAAS
//
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: October, 2014
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

%{^
//
var
Patsoptaas_File_newfile_blank = ""
//
var
Patsoptaas_File_newfile_template1 =
"\
(*\n\
** Template-1 for\n\
** Patsoptaas + Print\n\
*)\n\
\n\
(* ****** ****** *)\n\
\n\
//\n\
#define\n\
LIBATSCC2JS_targetloc\n\
\"$PATSHOME\\\n\
/contrib/libatscc2js/ATS2-0.3.2\"\n\
//\n\
#include\n\
\"{$LIBATSCC2JS}/staloadall.hats\"\n\
\n\
(* ****** ****** *)\n\
\n\
#staload\n\
\"{$LIBATSCC2JS}/SATS/print.sats\"\n\
#staload _(*anon*) =\n\
\"{$LIBATSCC2JS}/DATS/print.dats\"\n\
\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
\n\
\045{$\n\
//\n\
ats2jspre_the_print_store_clear();\n\
my_dynload();\n\
alert(ats2jspre_the_print_store_join());\n\
//\n\
\045} // end of [%{$]\n\
\n\
(* ****** ****** *)\n\
//\n\
// Please write your code below:\n\
//\n\
(* ****** ****** *)\n\
\n\
\n\
\n\
\n\
\n\
\n\
" // end of [Patsoptaas_File_newfile_template1]
//
var
Patsoptaas_File_newfile_template2 =
"\
(*\n\
** Template-2 for\n\
** Patsoptaas + Canvas-2d\n\
*)\n\
\n\
(* ****** ****** *)\n\
\n\
//\n\
#define\n\
LIBATSCC2JS_targetloc\n\
\"$PATSHOME\\\n\
/contrib/libatscc2js/ATS2-0.3.2\"\n\
//\n\
#include\n\
\"{$LIBATSCC2JS}/staloadall.hats\"\n\
\n\
(* ****** ****** *)\n\
//\n\
#staload\n\
\"{$LIBATSCC2JS}/SATS/HTML/canvas-2d/canvas2d.sats\"\n\
//\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
\n\
\045{$\n\
//\n\
my_dynload();\n\
//\n\
var\n\
canvas =\n\
document.getElementById\n\
(\n\
  \"Patsoptaas-Evaluate-canvas\"\n\
);\n\
//\n\
var\n\
ctx2d = canvas.getContext('2d');\n\
//\n\
function\n\
theCtx2d_get() { return ctx2d; }\n\
//\n\
function\n\
theCtx2d_clear()\n\
{\n\
  return ctx2d.clearRect(0, 0, canvas.width, canvas.height);\n\
}\n\
//\n\
\045} // end of [%{$]\n\
\n\
(* ****** ****** *)\n\
//\n\
// Please write your code below:\n\
//\n\
(* ****** ****** *)\n\
\n\
\n\
\n\
\n\
\n\
\n\
" // end of [Patsoptaas_File_newfile_template2]
//
%} // end of [%{^]

(* ****** ****** *)

(* end of [patsoptaas_templates.dats] *)

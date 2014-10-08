(*
//
// Examples for PATSOPTAAS
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
#include
"share/atspre_define.hats"
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_hello =
"\
(*\n\
** Hello, world!\n\
*)\n\
\n\
(* ****** ****** *)\n\
\n\
#include\n\
\"share/atspre_define.hats\"\n\
#include\n\
\"{$LIBATSCC2JS}/staloadall.hats\"\n\
\n\
(* ****** ****** *)\n\
\n\
staload\n\
\"{$LIBATSCC2JS}/SATS/print.sats\"\n\
\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
//\n\
extern\n\
fun\n\
hello(): void = \"mac#\"\n\
implement\n\
hello() = print(\"Hello, world!\")\n\
//\n\
(* ****** ****** *)\n\
//\n\
val () = hello()\n\
//\n\
(* ****** ****** *)\n\
\n\
\045{$\n\
//\n\
ats2jspre_the_print_store_clear();\n\
my_dynload();\n\
alert(ats2jspre_the_print_store_join());\n\
//\n\
\045} // end of [%{$]\n\
" // end of [Patsoptaas_File_examples_hello]
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_factrec =
"\
(*\n\
** Factorial(rec)\n\
** The given implementation is of recursive style\n\
*)\n\
\n\
(* ****** ****** *)\n\
\n\
#include\n\
\"share/atspre_define.hats\"\n\
#include\n\
\"{$LIBATSCC2JS}/staloadall.hats\"\n\
\n\
(* ****** ****** *)\n\
\n\
staload\n\
\"{$LIBATSCC2JS}/SATS/print.sats\"\n\
\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
//\n\
extern\n\
fun\n\
fact: int -> int = \"mac#\"\n\
implement\n\
fact(n) = if n > 0 then n * fact(n-1) else 1\n\
//\n\
(* ****** ****** *)\n\
//\n\
val N = 10\n\
val () = println! (\"fact(\", N, \") = \", fact(N))\n\
//\n\
(* ****** ****** *)\n\
\n\
\045{$\n\
//\n\
ats2jspre_the_print_store_clear();\n\
my_dynload();\n\
alert(ats2jspre_the_print_store_join());\n\
//\n\
\045} // end of [%{$]\n\
" // end of [Patsoptaas_File_examples_factrec]
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_factiter =
"\
(*\n\
** Factorial(iter)\n\
** The given implementation is of iterative style\n\
*)\n\
\n\
(* ****** ****** *)\n\
\n\
#include\n\
\"share/atspre_define.hats\"\n\
#include\n\
\"{$LIBATSCC2JS}/staloadall.hats\"\n\
\n\
(* ****** ****** *)\n\
\n\
staload\n\
\"{$LIBATSCC2JS}/SATS/print.sats\"\n\
\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
//\n\
extern\n\
fun\n\
fact: int -> int = \"mac#\"\n\
implement\n\
fact(n) = let\n\
//\n\
fun\n\
loop\n\
(\n\
  n: int, res: int\n\
) : int =\n\
  if n > 0 then loop (n-1, n*res) else res\n\
//\n\
in\n\
  loop (n, 1)\n\
end // end of [fact]\n\
//\n\
(* ****** ****** *)\n\
//\n\
val N = 10\n\
val () = println! (\"fact(\", N, \") = \", fact(N))\n\
//\n\
(* ****** ****** *)\n\
\n\
\045{$\n\
//\n\
ats2jspre_the_print_store_clear();\n\
my_dynload();\n\
alert(ats2jspre_the_print_store_join());\n\
//\n\
\045} // end of [%{$]\n\
" // end of [Patsoptaas_File_examples_factiter]
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_factverify =
"\
(*\n\
** Factorial(verify)\n\
** The given implementation is of a particular\n\
** programming style in ATS, combining programming with\n\
** theorem-proving in a syntactically intertwined manner\n\
*)\n\
\n\
(* ****** ****** *)\n\
\n\
#include\n\
\"share/atspre_define.hats\"\n\
#include\n\
\"{$LIBATSCC2JS}/staloadall.hats\"\n\
\n\
(* ****** ****** *)\n\
\n\
staload\n\
\"{$LIBATSCC2JS}/SATS/print.sats\"\n\
\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
\n\
dataprop\n\
FACT (int, int) =\n\
| FACTbas (0, 1) of ()\n\
| {n:nat}{r:int}\n\
  FACTind(n+1, (n+1)*r) of FACT(n, r)\n\
  \n\
(* ****** ****** *)\n\
//\n\
extern\n\
fun fact{n:nat}\n\
  : int(n) -> [r:int] (FACT(n, r) | int(r)) = \"mac#\"\n\
//\n\
(* ****** ****** *)\n\
\n\
implement\n\
fact (n) = let\n\
//\n\
fun\n\
loop\n\
{n:nat}{r0:int} .<n>.\n\
(\n\
  n: int(n), r0: int(r0)\n\
) : [r:int]\n\
(\n\
  FACT(n, r) | int(r*r0)\n\
) = (\n\
if n > 0\n\
then let\n\
  val (pf1 | r1) = loop(n-1, n*r0) in (FACTind(pf1) | r1)\n\
end // end of [then]\n\
else (FACTbas() | r0)\n\
// end of [if]\n\
) (* end of [loop] *)\n\
//\n\
in\n\
  loop (n, 1)\n\
end // end of [fact]\n\
\n\
(* ****** ****** *)\n\
\n\
val N = 10\n\
val () = let\n\
  val res = fact(N) in println! (\"fact(\", N, \") = \", res.1)\n\
end // end of [val]\n\
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
" // end of [Patsoptaas_File_examples_factverify]
//
%} // end of [%{^]

(* ****** ****** *)

(* end of [patsoptaas_examples.dats] *)

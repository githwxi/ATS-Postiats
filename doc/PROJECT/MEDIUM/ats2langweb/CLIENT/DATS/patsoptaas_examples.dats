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
Patsoptaas_File_examples_fact_verify =
"\
(*\n\
**\n\
** Factorial(verify)\n\
**\n\
** The given implementation is of a particular\n\
** programming style in ATS, combining programming with\n\
** theorem-proving in a syntactically intertwined manner\n\
**\n\
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
" // end of [Patsoptaas_File_examples_fact_verify]
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_fibats_verify =
"\
(*\n\
**\n\
** Fibonacci(verify)\n\
**\n\
** The given implementation is of a particular\n\
** programming style in ATS, combining programming with\n\
** theorem-proving in a syntactically intertwined manner\n\
**\n\
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
FIB (int, int) =\n\
  | FIB0 (0, 0)\n\
  | FIB1 (1, 1)\n\
  | {n:nat}\n\
    {r0,r1:int}\n\
    FIB2 (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))\n\
// end of [FIB] // end of [dataprop]\n\
\n\
(* ****** ****** *)\n\
//\n\
fun\n\
fibats{n:nat}\n\
  (n: int (n))\n\
: [r:int] (FIB (n, r) | int r) = let\n\
  fun loop\n\
    {i:nat | i <= n}{r0,r1:int}\n\
  (\n\
    pf0: FIB (i, r0), pf1: FIB (i+1, r1)\n\
  | ni: int (n-i), r0: int r0, r1: int r1\n\
  ) : [r:int] (FIB (n, r) | int r) =\n\
    if (ni > 0)\n\
      then loop{i+1}(pf1, FIB2 (pf0, pf1) | ni - 1, r1, r0 + r1)\n\
      else (pf0 | r0)\n\
    // end of [if]\n\
  // end of [loop]\n\
in\n\
  loop {0} (FIB0 (), FIB1 () | n, 0, 1)\n\
end // end of [fibats]\n\
//\n\
(* ****** ****** *)\n\
//\n\
val N = 10\n\
val (pf | res) = fibats(N)\n\
val () = println! (\"fibats(\", N, \") = \", res)\n\
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
" // end of [Patsoptaas_File_examples_fibats_verify]
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_list_append =
"\
(* ****** ****** *)\n\
\n\
(*\n\
** Concatenating two lists\n\
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
//\n\
staload\n\
\"{$LIBATSCC2JS}/SATS/print.sats\"\n\
staload _(*anon*) =\n\
\"{$LIBATSCC2JS}/DATS/print.dats\"\n\
//\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
//\n\
extern\n\
fun\n\
{a:t@ype}\n\
list_append{m,n:nat}\n\
  (xs: list(a, m), ys: list(a, n)): list(a, m+n)\n\
//\n\
(* ****** ****** *)\n\
\n\
implement\n\
{a}(*tmp*)\n\
list_append\n\
  (xs, ys) =\n\
(\n\
  case+ xs of\n\
  | list_nil() => ys\n\
  | list_cons(x, xs) => list_cons(x, list_append(xs, ys))\n\
) (* end of [list_append] *)\n\
\n\
(* ****** ****** *)\n\
//\n\
#define :: list_cons\n\
//\n\
(* ****** ****** *)\n\
//\n\
val xs =\n\
(\n\
  0 :: 1 :: 2 :: 3 :: 4 :: list_nil()\n\
) : List0(int)\n\
val ys =\n\
(\n\
  5 :: 6 :: 7 :: 8 :: 9 :: list_nil()\n\
) : List0(int)\n\
//\n\
val () = println! (\"xs = \", xs)\n\
val () = println! (\"ys = \", ys)\n\
val () = println! (\"append(xs, ys) = \", list_append<int>(xs, ys))\n\
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
" // end of [Patsoptaas_File_examples_list_append]
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_list_reverse =
"\
(* ****** ****** *)\n\
\n\
(*\n\
** Reversing a list\n\
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
//\n\
staload\n\
\"{$LIBATSCC2JS}/SATS/print.sats\"\n\
staload _(*anon*) =\n\
\"{$LIBATSCC2JS}/DATS/print.dats\"\n\
//\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
//\n\
extern\n\
fun\n\
{a:t@ype}\n\
list_reverse{n:nat}(list(a, n)): list(a, n)\n\
//\n\
(* ****** ****** *)\n\
//\n\
implement\n\
{a}(*tmp*)\n\
list_reverse\n\
  (xs) = let\n\
//\n\
fun\n\
loop{m,n:nat}\n\
(\n\
  xs: list(a, m), ys: list(a, n)\n\
) : list(a, m+n) =\n\
(\n\
  case+ xs of\n\
  | list_nil() => ys\n\
  | list_cons(x, xs) => loop(xs, list_cons(x, ys))\n\
) (* end of [list_reverse] *)\n\
//\n\
in\n\
  loop (xs, list_nil)\n\
end // end of [list_reverse]\n\
\n\
(* ****** ****** *)\n\
//\n\
#define :: list_cons\n\
//\n\
(* ****** ****** *)\n\
//\n\
val xs =\n\
(\n\
  0 :: 1 :: 2 :: 3 :: 4 :: list_nil()\n\
) : List0(int)\n\
//\n\
val () = println! (\"xs = \", xs)\n\
val () = println! (\"reverse(xs) = \", list_reverse<int>(xs))\n\
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
" // end of [Patsoptaas_File_examples_list_reverse]
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_list_sort_insert =
"\
(* ****** ****** *)\n\
\n\
(*\n\
** Insertion-sort for lists\n\
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
staload _(*anon*) =\n\
\"{$LIBATSCC2JS}/DATS/print.dats\"\n\
\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
\n\
typedef lte (a:t@ype) = (a, a) -> bool\n\
\n\
(* ****** ****** *)\n\
\n\
extern\n\
fun{\n\
a:t0p\n\
} sort{n:nat}\n\
(\n\
  xs: list(a, n), lte: lte(a)\n\
) : list(a, n)\n\
\n\
(* ****** ****** *)\n\
\n\
implement\n\
{a}(*tmp*)\n\
sort (xs0, lte) = let\n\
//\n\
fun\n\
insord\n\
{n:nat}\n\
(\n\
  xs: list(a, n), x0: a\n\
) : list(a, n+1) =\n\
//\n\
case+ xs of\n\
| list_nil () =>\n\
  list_cons (x0, list_nil)\n\
| list_cons (x, xs2) =>\n\
  if lte(x0, x)\n\
    then list_cons (x0, xs)\n\
    else list_cons (x, insord(xs2, x0))\n\
  // end of [if]\n\
//\n\
in\n\
//\n\
case+ xs0 of\n\
| list_nil () => list_nil ()\n\
| list_cons (x0, xs) => insord (sort(xs, lte), x0)\n\
//\n\
end // end of [sort]\n\
\n\
(* ****** ****** *)\n\
//\n\
val xs =\n\
(\n\
cons (5,\n\
cons (3,\n\
cons (4,\n\
cons (6,\n\
cons (8,\n\
cons (0,\n\
cons (7,\n\
cons (1,\n\
cons (9,\n\
cons (2,\n\
nil()))))))))))\n\
) : list (int, 10)\n\
//\n\
val () = println! (\"xs = \", xs)\n\
val () = println! (\"sort(xs) = \", sort<int> (xs, lam (x, y) => x <= y))\n\
//\n\
(* ****** ****** *)\n\
//\n\
val xs =\n\
(\n\
cons (\"5\",\n\
cons (\"3\",\n\
cons (\"4\",\n\
cons (\"6\",\n\
cons (\"8\",\n\
cons (\"0\",\n\
cons (\"7\",\n\
cons (\"1\",\n\
cons (\"9\",\n\
cons (\"2\",\n\
nil()))))))))))\n\
) : list (string, 10)\n\
//\n\
implement\n\
print_val<string> (x) = print! (\"\\\"\", x, \"\\\"\")\n\
//\n\
val () = println! (\"xs = \", xs)\n\
val () = println! (\"sort(xs) = \", sort<string> (xs, lam (x, y) => x <= y))\n\
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
" // end of [Patsoptaas_File_examples_list_sort_insert]
//
%} // end of [%{^]

(* ****** ****** *)

%{^
//
var
Patsoptaas_File_examples_list_sort_quick =
"\
(* ****** ****** *)\n\
\n\
(*\n\
** Quick-sort for lists\n\
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
staload _(*anon*) =\n\
\"{$LIBATSCC2JS}/DATS/print.dats\"\n\
\n\
(* ****** ****** *)\n\
\n\
#define ATS_MAINATSFLAG 1\n\
#define ATS_DYNLOADNAME \"my_dynload\"\n\
\n\
(* ****** ****** *)\n\
\n\
typedef lte (a:t@ype) = (a, a) -> bool\n\
\n\
(* ****** ****** *)\n\
\n\
extern\n\
fun{\n\
a:t0p\n\
} sort{n:nat}\n\
(\n\
  xs: list(a, n), lte: lte(a)\n\
) : list(a, n)\n\
\n\
(* ****** ****** *)\n\
\n\
implement\n\
{a}(*tmp*)\n\
sort (xs0, lte) = let\n\
//\n\
fun\n\
part\n\
{n:nat}{p,q:nat}\n\
(\n\
  xs: list(a, n), x0: a\n\
, ys: list(a, p), zs: list(a, q)\n\
) : list(a, n+1+p+q) =\n\
//\n\
case+ xs of\n\
| list_nil () =>\n\
  list_append\n\
  (\n\
    sort(ys, lte)\n\
  , list_cons (x0, sort(zs, lte))\n\
  )\n\
| list_cons (x, xs) =>\n\
  if lte(x, x0)\n\
    then part (xs, x0, list_cons(x, ys), zs)\n\
    else part (xs, x0, ys, list_cons(x, zs))\n\
  // end of [if]\n\
//\n\
in\n\
//\n\
case+ xs0 of\n\
| list_nil () => list_nil ()\n\
| list_cons (x0, xs) => part (xs, x0, list_nil, list_nil)\n\
//\n\
end // end of [sort]\n\
\n\
(* ****** ****** *)\n\
//\n\
val xs =\n\
(\n\
cons (5,\n\
cons (3,\n\
cons (4,\n\
cons (6,\n\
cons (8,\n\
cons (0,\n\
cons (7,\n\
cons (1,\n\
cons (9,\n\
cons (2,\n\
nil()))))))))))\n\
) : list (int, 10)\n\
//\n\
val () = println! (\"xs = \", xs)\n\
val () = println! (\"sort(xs) = \", sort<int> (xs, lam (x, y) => x <= y))\n\
//\n\
(* ****** ****** *)\n\
//\n\
val xs =\n\
(\n\
cons (\"5\",\n\
cons (\"3\",\n\
cons (\"4\",\n\
cons (\"6\",\n\
cons (\"8\",\n\
cons (\"0\",\n\
cons (\"7\",\n\
cons (\"1\",\n\
cons (\"9\",\n\
cons (\"2\",\n\
nil()))))))))))\n\
) : list (string, 10)\n\
//\n\
implement\n\
print_val<string> (x) = print! (\"\\\"\", x, \"\\\"\")\n\
//\n\
val () = println! (\"xs = \", xs)\n\
val () = println! (\"sort(xs) = \", sort<string> (xs, lam (x, y) => x <= y))\n\
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
" // end of [Patsoptaas_File_examples_list_sort_quick]\n\
//\n\
%} // end of [%{^]\n\

(* ****** ****** *)

(* end of [patsoptaas_examples.dats] *)

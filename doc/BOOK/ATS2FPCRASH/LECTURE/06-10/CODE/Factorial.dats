(* ****** ****** *)
(*
** Factorial
*)
(* ****** ****** *)
(*
##myatsccdef=\
patsopt -d $1 | atscc2js -o $fname($1)_dats.js -i -
*)
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"Factorial__dynload"
//
#define
ATS_STATIC_PREFIX "Factorial__"
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib\
/libatscc2js/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
"{$LIBATSCC2JS}/SATS/print.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
#include "./../../MYLIB/mylib.dats"
//
(* ****** ****** *)
//
abstype xmldoc
//
%{^
//
function
document_getElementById
  (id)
{
  return document.getElementById(id);
}
//
function
xmldoc_set_innerHTML
  (xmldoc, text)
  { xmldoc.innerHTML = text; return; }
//
%} // end of [%{^] 
//
extern
fun
document_getElementById
  (id: string): xmldoc = "mac#"
//
extern
fun
xmldoc_set_innerHTML
(xmldoc, text: string): void = "mac#"
//
(* ****** ****** *)
//
fun fact(n: int): int =
  if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)
//
extern
fun
funarg1_get(): int = "mac#"
//
%{^
function
funarg1_get()
{
  return parseInt(document.getElementById("funarg1").value);
}
%} (* end of [%{^] *)
//
(* ****** ****** *)
//
extern
fun
Factorial__evaluate
  ((*void*)): void = "mac#"
//
(* ****** ****** *)

implement
Factorial__evaluate
  ((*void*)) = let
  val () =
  the_print_store_clear()
  val arg = funarg1_get()
  val () =
  println!
  ("The factorial of ", arg, " is ", fact(arg))
  // end of [val]
  val theOutput =
    document_getElementById("theOutput")
  // end of [val]
in
  xmldoc_set_innerHTML(theOutput, the_print_store_join())
end // end of [Factorial__evaluate]

(* ****** ****** *)

%{$
//
function
Factorial__initize()
{
//
Factorial__dynload(); return;
//
} // end of [Factorial_initize]
%}

(* ****** ****** *)

%{$
//
jQuery(document).ready(function(){Factorial__initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [Factorial.dats] *)

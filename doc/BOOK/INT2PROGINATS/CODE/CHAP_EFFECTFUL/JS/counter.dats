(*
** Some code used
** in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

staload
"{$LIBATSCC2JS}/SATS/print.sats"

(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

(* ****** ****** *)

%{$
//
ats2jspre_the_print_store_clear();
my_dynload();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]

(* ****** ****** *)

typedef
counter = '{
  get= () -<cloref1> int
, inc= () -<cloref1> void
, reset= () -<cloref1> void
} // end of [counter]

(* ****** ****** *)

fun newCounter
(
// argumentless
) : counter = let
  val count = ref{int}(0)
in '{
  get= lam () => count[]
, inc= lam () => count[] := count[] + 1
, reset= lam () => count[] := 0
} end // end of [newCounter]

(* ****** ****** *)

symelim .get // HX: avoid potential overloading

(* ****** ****** *)

val () =
{
//
val
mycntr = newCounter()
//
val () = println! ("mycntr.count = ", mycntr.get())
//
val () = mycntr.inc()
//
val () = println! ("mycntr.count = ", mycntr.get())
//
val () = mycntr.inc()
//
val () = println! ("mycntr.count = ", mycntr.get())
//
} (* end of [val] *)

(* ****** ****** *)

(* end of [counter.dats] *)

(* ****** ****** *)
//
// HX-2014-05-06
//
(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)
//
%{^
#define my_pragma_beg(tid) \
  { fprintf (stdout, "my_pragma_beg: tid = %i\n", tid) ;
#define my_pragma_end(tid) \
  fprintf (stdout, "my_pragma_end: tid = %i\n", tid) ; }
%}
extern
fun my_pragma_beg (tid: int?): void = "mac#"
extern
fun my_pragma_end (tid: int?): void = "mac#"
//
(* ****** ****** *)

fun foo (): void =
{
  var tid: int = 0
  val () = my_pragma_beg (tid)
  val () = tid := tid + 1
  val () = my_pragma_end (tid)
}

(* ****** ****** *)

implement main0 () = ignoret (foo())

(* ****** ****** *)

(* end of [qa-list-262.dats] *)

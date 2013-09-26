(* ****** ****** *)
//
// HX-2013-09
// An example of large flat type
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)
//
// HX-2013-09:
// a large flat type
//
%{^
typedef char buf_t[124] ;
%}
typedef buf_t = $extype"buf_t"
//
(* ****** ****** *)
//
// intialization done externally
//
extern
fun buf_init
  (buf: &buf_t? >> buf_t): void = "ext#"
// end of [buf_init]

(* ****** ****** *)

implement
main0 () =
{
//
var intbuf
  : @(int, buf_t)
val () = intbuf.0 := 1
val () = buf_init (intbuf.1)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-73.dats] *)

(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef
abc_tup = '(int, int, string) // for tuples
typedef
abc_rec = '{a=int, b=int, c=string} // for records

(* ****** ****** *)
//
val x_tup = '(0, 1, "2") : abc_tup
val x_rec = '{a=0, b=1, c="2"} : abc_rec
//
val () = assertloc(x_tup.0 = x_rec.a)
val () = assertloc(x_tup.1 = x_rec.b)
val () = assertloc(x_tup.2 = x_rec.c)
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_tuprec_1.dats] *)

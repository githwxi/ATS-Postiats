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

typedef
abc_tup = $tup(int, int, string) // for tuples
typedef
abc_rec = $rec{a=int, b=int, c=string} // for records

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

(*
val () = x_tup.0 := 100 // *ERROR*: x_tup.0 not a left-value
val () = x_rec.a := 100 // *ERROR*: x_rec.a not a left-value
*)

(* ****** ****** *)
//
typedef
abc_tup_ = @(int, int, string)
typedef
abc_rec_ = @{a=int, b=int, c=string}
//
typedef abc_tup_r = ref(abc_tup_) // for tuples
typedef abc_rec_r = ref(abc_rec_) // for records
//
(* ****** ****** *)

val x_tup_r = ref<abc_tup_>(@(0, 1, "2"))
val x_rec_r = ref<abc_rec_>(@{a=0, b=1, c="2"})

(* ****** ****** *)
//
val () = assertloc(x_tup_r->0 = x_rec_r->a)
val () = assertloc(x_tup_r->1 = x_rec_r->b)
val () = assertloc(x_tup_r->2 = x_rec_r->c)
//
(* ****** ****** *)

val () = x_tup_r->0 := 100 // *OKAY*: x_tup_r.0 is a left-value
val () = x_rec_r->a := 100 // *OKAY*: x_rec_r.a is a left-value

(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_tuprec_1.dats] *)

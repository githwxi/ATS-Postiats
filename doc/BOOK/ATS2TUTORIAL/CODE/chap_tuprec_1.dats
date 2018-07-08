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

typedef
abc_tup = $tuple(int, int, string) // for tuples
typedef
abc_rec = $record{a=int, b=int, c=string} // for records

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

abstype myrec = ptr  

(* ****** ****** *)
//
extern
fun{}
myrec_make
(
  a: int, b: int, c: string
) : myrec // end-of-function
//
extern
fun{}
myrec_get_a : myrec -> int
extern
fun{}
myrec_set_a : (myrec, int) -> void
extern
fun{}
myrec_get_b : myrec -> int
extern
fun{}
myrec_set_b : (myrec, int) -> void
extern
fun{}
myrec_get_c : myrec -> string
//
overload .a with myrec_get_a
overload .a with myrec_set_a
overload .b with myrec_get_b
overload .b with myrec_set_b
overload .c with myrec_get_c
//
(* ****** ****** *)

local
//
assume myrec = abc_rec_r
//
in (* in-of-local *)
//
implement
{}(*tmp*)
myrec_make
  (a, b, c) = ref(@{a=a, b=b, c=c})
//
implement{} myrec_get_a(x) = x->a
implement{} myrec_set_a(x, a) = x->a := a
//
implement{} myrec_get_b(x) = x->b
implement{} myrec_set_b(x, b) = x->b := b
//
implement{} myrec_get_c(x) = x->c
(*
//
// there is no update for the c-field:
//
implement{} myrec_set_a(x, c) = x->c := c
*)
//
end // end of [local]

(* ****** ****** *)
//
val x_abc = myrec_make(0, 1, "2")
//
val ((*void*)) = assertloc(x_abc.a() = 0)
val ((*void*)) = assertloc(x_abc.b() = 1)
val ((*void*)) = assertloc(x_abc.c() = "2")
//
val ((*void*)) = x_abc.a(100)
val ((*void*)) = assertloc(x_abc.a() = 100)
//
val ((*void*)) = x_abc.b(101)
val ((*void*)) = assertloc(x_abc.b() = 101)
//
(*
val ((*void*)) = x_abc.c("102")
val ((*void*)) = assertloc(x_abc.c() = "102")
*)
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_tuprec_1.dats] *)

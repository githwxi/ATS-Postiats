(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define :: list0_cons

(* ****** ****** *)

macdef
list0_sing(x) =
list0_cons(,(x), list0_nil())

(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

implement
fprint_val<int> = fprint_int
implement
fprint_val<bool> = fprint_bool
implement
fprint_val<string> = fprint_string

(* ****** ****** *)

implement
{a}(*tmp*)
list0_forall
  (xs, test) = let
//
exception False of ()
//
in
//
try let
//
val () =
list0_foreach<a>
( xs
, lam(x) => if not(test(x)) then $raise False()
)
//
in
  true
end with ~False() => false
//
end // end of [list0_forall]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_exists
  (xs, test) = let
//
exception True of ()
//
in
//
try let
//
val () =
list0_foreach<a>
( xs
, lam(x) => if test(x) then $raise True()
)
//
in
  false
end with ~True() => true
//
end // end of [list0_exists]

(* ****** ****** *)

val xs =
g0ofg1($list{int}(1, 2, 3))

(* ****** ****** *)
//
val () =
println!
("exists_isevn(", xs, ") = ", list0_exists(xs, lam(x) => x%2 = 0))
val () =
println!
("forall_isevn(", xs, ") = ", list0_forall(xs, lam(x) => x%2 = 0))
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture09.dats] *)

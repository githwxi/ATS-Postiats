(* ****** ****** *)
//
// Generic
// Divide-and-Conquer
// for libatscc
//
(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Start time: March, 2017 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)
//
(*
#staload
"libats/ML/SATS/basis.sats"
#staload
"libats/ML/SATS/list0.sats"
*)
//
(* ****** ****** *)
//
abst@ype input_t0ype
abst@ype output_t0ype
//
(* ****** ****** *)
//
typedef input = input_t0ype
typedef output = output_t0ype
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$solve(input): output
and
DivideConquer$solve_rec(input): output
//
extern
fun{}
DivideConquer$solve$eval : (input) -> output
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$base_test(x0: input): bool
//
extern
fun{}
DivideConquer$base_solve(x0: input): output
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$divide(x0: input): list0(input)
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$conquer
  (x0: input, xs: list0(input)): output
//
extern
fun{}
DivideConquer$conquer$combine
  (x0: input, rs: list0(output)): output
//
(* ****** ****** *)
//
extern
fun{}
DivideConquer$solve$memo_get : (input) -> Option_vt(output)
extern
fun{}
DivideConquer$solve$eval$memo_set : (input, output) -> void
//
(* ****** ****** *)

implement
{}(*tmp*)
DivideConquer$solve
  (x0) = let
//
val opt =
  DivideConquer$solve$memo_get<>(x0)
//
in
  case+ opt of
  | ~Some_vt(r0) => r0
  | ~None_vt((*void*)) =>
     DivideConquer$solve$eval<>(x0)
end // end of [DivideConquer$solve]

(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquer$solve_rec
  (x0) = DivideConquer$solve<>(x0)
//
(* ****** ****** *)

implement
{}(*tmp*)
DivideConquer$solve$eval
  (x0) = let
//
val
test =
DivideConquer$base_test<>(x0)
//
in (* in-of-let *)
//
if
(test)
then
DivideConquer$base_solve<>(x0)
else r0 where
{
  val xs = DivideConquer$divide<>(x0)
  val r0 = DivideConquer$conquer<>(x0, xs)
  val () = DivideConquer$solve$eval$memo_set<>(x0, r0)
} (* end of [else] *)
//
end // end of [DivideConquer$solve$eval]

(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquer$solve$memo_get
  (x0) = None_vt()
//
implement
{}(*tmp*)
DivideConquer$solve$eval$memo_set
  (x0, r0) = ((*void*))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquer$conquer
  (x0, xs) = r0 where
{
//
val rs =
list0_map{input}{output}
( xs
, lam(x) => DivideConquer$solve_rec<>(x)
) (* end of [val] *)
//
val r0 = DivideConquer$conquer$combine<>(x0, rs)
//
} (* end of [DivideConquer$conquer] *)
//
(* ****** ****** *)

(* end of [DivideConquer.dats] *)

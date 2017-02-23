(*
For Effective ATS
*)

(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
staload
"libats/ML/SATS/list0.sats"
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
DC_solve(input): output
//
extern
fun{}
DC_base_test(x0: input): bool
//
extern
fun{}
DC_base_solve(x0: input): output
//
(* ****** ****** *)
//
extern
fun{}
DC_divide(x0: input): list0(input)
//
(* ****** ****** *)
//
extern
fun{}
DC_conquer
  (x0: input, xs: list0(input)): output
//
extern
fun{}
DC_conquer_combine
  (x0: input, rs: list0(output)): output
//
(* ****** ****** *)

implement
{}(*tmp*)
DC_solve
  (x0) = let
//
val
test =
DC_base_test<>(x0)
//
in (* in-of-let *)
//
if
(test)
then
DC_base_solve<>(x0)
else r0 where
{
  val xs = DC_divide<>(x0)
  val r0 = DC_conquer<>(x0, xs)
} (* end of [else] *)
//
end // end of [DC_solve]

(* ****** ****** *)
//
implement
{}(*tmp*)
DC_conquer
  (x0, xs) = r0 where
{
//
val rs =
list0_map<input><output>
( xs
, lam(x) => DC_solve<>(x)
) (* end of [val] *)
//
val r0 = DC_conquer_combine<>(x0, rs)
//
} (* end of [DC_conquer] *)
//
(* ****** ****** *)

(* end of [DivideConquer.dats] *)

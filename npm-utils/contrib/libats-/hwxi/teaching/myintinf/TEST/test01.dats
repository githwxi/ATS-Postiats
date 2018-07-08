(* ****** ****** *)
(*
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
*)
(* ****** ****** *)

#include "./../DATS/myintinf_t.dats"

(* ****** ****** *)

implement
main0() = () where
{
//
(*
val () =
println!("DIGITMAX = ", DIGITMAX)
val () =
println!("DIGITMAX+1 = ", DIGITMAX+1u)
*)
//
val u1 =
uint2uintinf(DIGITMAX)
prval () =
lemma_uintinf_param(u1)
//
val () =
(
print("u1 = ");
fprint_uintinf_raw(stdout_ref, u1); println!()
)
val u2 = succ(u1)
val u3 = pred(u2)
//
val () =
(
print("u2 = ");
fprint_uintinf_raw(stdout_ref, u2); println!()
)
val () =
(
print("u3 = ");
fprint_uintinf_raw(stdout_ref, u3); println!()
)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)


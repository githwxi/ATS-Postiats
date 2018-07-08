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

#staload
"./../../BUCS/DATS/BUCS320.dats"

(* ****** ****** *)

#include "./../DATS/myintinf_t.dats"

(* ****** ****** *)
//
extern
fun
myfact{n:nat}(n: int(n)): uintinf
//
implement
myfact(n) =
loop(0, int2uintinf(1)) where
{
//
fun
loop{i:nat}
(i: int(i), res: uintinf): uintinf =
if i < n then loop(i+1, res*i2u(i+1)) else res
//
} (* end of [myfact] *)
//
(* ****** ****** *)

implement
main0() = () where
{
//
val u1 = int2uintinf(1024)
val u2 = ((u1 * 1024u) * 1024u) * 1024u
//
val () =
(
print("u1 = ");
fprint_uintinf_raw(stdout_ref, u1); println!()
)
val () =
(
print("u2 = ");
fprint_uintinf_raw(stdout_ref, u2); println!()
)
//
val () =
(
print("myfact(100) = ");
fprint_uintinf_raw(stdout_ref, myfact(100)); println!()
)
//
val N = 100
val ntime = 10000
val _ =
time_spent_cloref<int>
(
lam() => 0 where
{
val () =
(ntime).repeat()
(lam()=>ignoret($UN.castvwtp0{ptr}(myfact(N))))
}
)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)


(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

#staload "./../DATS/BUCS320.dats"

(* ****** ****** *)
//
#include
"contrib/atscntrb-hx-intinf/mydepies.hats"
#include
"contrib/atscntrb-hx-intinf/mylibies.hats"
//
#staload $INTINF_vt // opening the package
//
(* ****** ****** *)
//
fun
factorial0
{n:nat} .<n>.
(k: int(n)) : int =
(
  case+ k of
  | 0 => 1
  | k =>> k * factorial0(k - 1)
)
//
(* ****** ****** *)
//
fun
factorial1
{n:nat} .<n>.
(k: int(n)) : Intinf =
(
  case+ k of
  | 0 => int2intinf(1)
  | k =>> mul_int_intinf0(k, factorial1(k - 1))
)
//
(* ****** ****** *)
//
fun
factorial2
{n:nat} .<n>.
(n: int(n)): Intinf = let
//
vtypedef mpz = $GMP.mpz

//
fun
loop
{ i:nat
| i <= n}
( i: int(i), x: &mpz >> _): void =
(
  if (i < n)
  then
  loop(i+1, x) where
  {
    val () = $GMP.mpz_mul2_uint(x, g0i2u(i+1))
  } else ((*void*))
)
//
val
( pfat
, pfgc | p0) = ptr_alloc<mpz>()
//
val ((*init*)) = $GMP.mpz_init_set(!p0, 1)
//
in
  let val () = loop(0, !p0) in $UN.castvwtp0((pfat, pfgc | p0)) end
end // end of [factorial2]
//
(* ****** ****** *)

fun
factorial3_gmp
{n:nat} .<n>.
(n: int(n)) : Intinf = let
//
vtypedef mpz = $GMP.mpz
//
val
( pfat
, pfgc | p0) = ptr_alloc<mpz>()
//
val ((*init*)) = $GMP.mpz_init(!p0)
//
in
  $GMP.mpz_fac_uint(!p0, g0i2u(n)); $UN.castvwtp0((pfat, pfgc | p0))
end // end of [factorial_gmp

(* ****** ****** *)

implement
main0() = () where
{
//
val N = 100
val ntime = 1000000
//
val _ =
time_spent_cloref<int>
(
lam() => 0 where
{
val () =
(ntime).repeat()
(lam()=>ignoret($UN.castvwtp0{ptr}(factorial0(N))))
}
)
//
val _ =
time_spent_cloref<int>
(
lam() => 0 where
{
val () =
(ntime).repeat()
(lam()=>ignoret($UN.castvwtp0{ptr}(factorial1(N))))
}
)
//
val _ =
time_spent_cloref<int>
(
lam() => 0 where
{
val () =
(ntime).repeat()
(lam()=>ignoret($UN.castvwtp0{ptr}(factorial2(N))))
}
)
//
val _ =
time_spent_cloref<int>
(
lam() => 0 where
{
val () =
(ntime).repeat()
(lam()=>ignoret($UN.castvwtp0{ptr}(factorial3_gmp(N))))
}
)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_intinf.dats] *)

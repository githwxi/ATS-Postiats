//
// ProjectEuler: Problem 16
// Finding the sum of all the digits of 2^1000
//

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxi AT cs DOT bu DOT edu
// Time: August, 2010
//
(* ****** ****** *)
//
// HX-2013-04: this one is ported from ATS to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN="prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libgmp/SATS/gmp.sats"

(* ****** ****** *)

fun digitsum
  (x: &mpz): int = let
//
val str =
  mpz_get_str_null (10, x)
//
typedef tenv = int
var env : tenv = 0
//
local
//
implement
string_foreach$fwork<tenv> (c, env) = env := env + (c - '0')
//
in (* in of [local] *)
//
val _ = string_foreach_env<tenv> ($UN.strptr2string(str), env)
//
end (* end of [local] *)
//
val () = strptr_free (str)
//
in
  env
end // end of [digitsum]

(* ****** ****** *)

implement
main0 () =
{
//
var p15: mpz
var base: mpz
val () = mpz_init_set (p15, 2)
val () = mpz_init_set (base, 2)
val () = mpz_pow_uint (p15, base, 15U)
val sum15 = digitsum (p15)
val () = mpz_clear (p15)
val () = assertloc (sum15 = 26)
//
var p1000: mpz
val () = mpz_init_set (p1000, 2)
val () = mpz_pow_uint (p1000, base, 1000U)
val sum1000 = digitsum (p1000)
val () = mpz_clear (p1000)
val () = assertloc (sum1000 = 1366)
val () = (print "the sum of all the digits of 2^1000 is "; print sum1000; print_newline ())
//
val () = mpz_clear (base)
//
} // end of [main]

(* ****** ****** *)

(* end of [problem16-hwxi.dats] *)

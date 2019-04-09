(* ****** ****** *)
(*
**
** HX-2017-11-04:
** Supporting variadicity
**
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
stadef tnil = types_nil
stadef tcons = types_cons
//
(* ****** ****** *)
//
(*
datatype
ints(types) =
| ints_nil(tnil) of () 
| {ts:types}
  ints_cons(tcons(int, ts)) of ints(ts)
*)
abst@ype
ints(types) = int
//
extern
fun
ints_nil:
((*void*)) -> ints(tnil) = "mac#ints_nil"
extern
fun
ints_cons:
{ts:types}
(ints(ts)) -> ints(tcons(int, ts)) = "mac#ints_cons"
//
(* ****** ****** *)
//
(*
val Z = ints_nil()
val SZ = ints_cons(Z)
val SSZ = ints_cons(SZ)
val SSSZ = ints_cons(SSZ)
*)
//
stadef z = tnil
stadef sz = tcons(int, z)
stadef ssz = tcons(int, sz)
stadef sssz = tcons(int, ssz)
//
typedef
ints_z = ints(z)
typedef
ints_sz = ints(sz)
typedef
ints_ssz = ints(ssz)
typedef
ints_sssz = ints(sssz)
//
val
Z = $extval(ints_z, "0")
val
SZ = $extval(ints_sz, "1")
val
SSZ = $extval(ints_ssz, "2")
val
SSSZ = $extval(ints_sssz, "3")
//
(* ****** ****** *)
//
extern
fun
tally_ints
{ts:types}(ints(ts), ts): int = "ext#"
//
%{^
//
#include <stdarg.h>
//
int
tally_ints(int narg, ...)
{
   int i;
   int sum = 0;
   va_list args;
   va_start(args, narg);
   for(i = 0; i < narg; i += 1) sum += va_arg(args, int);
   va_end(args); return sum;
}
//
%} (* end of %{^ *)
//
(* ****** ****** *)
//
fun
tally_int0
((*nil*)): int =
tally_ints(Z, $vararg())
fun
tally_int1
(i0: int): int =
tally_ints(SZ, $vararg(i0))
fun
tally_int2
(i0: int, i1: int): int =
tally_ints(SSZ, $vararg(i0, i1))
fun
tally_int3
(i0: int, i1: int, i2: int): int =
tally_ints(SSSZ, $vararg(i0, i1, i2))
//
(* ****** ****** *)

implement
main0() =
{
//
val sum0 = tally_int0()
val sum1 = tally_int1(1)
val sum12 = tally_int2(1, 2)
val sum123 = tally_int3(1, 2, 3)
//
val- 0 = sum0
val ((*void*)) = println! ("sum0 = ", sum0)
val- 1 = sum1
val ((*void*)) = println! ("sum1 = ", sum1)
val- 3 = sum12
val ((*void*)) = println! ("sum12 = ", sum12)
val- 6 = sum123
val ((*void*)) = println! ("sum123 = ", sum123)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [variadic.dats] *)

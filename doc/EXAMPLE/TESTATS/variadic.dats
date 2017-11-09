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
(* ****** ****** *)
//
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

(* end of [variadic.dats] *)

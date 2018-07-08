//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
//
// Computing the Fibonacci numbers
//
// Author: Hongwei Xi (June 2015)
//
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern fun{} fib(int): int
extern fun{} fib_memo_get(int): Option_vt(int)
extern fun{} fib_memo_set(n: int, res: int): int

(* ****** ****** *)

implement
{}(*tmp*)
fib(n) =
if n >= 2 then let
  val opt = fib_memo_get(n)
in
  case+ opt of
  | ~Some_vt(res) => res
  | ~None_vt((*void*)) => fib_memo_set(n, fib(n-2) + fib(n-1))
end else n // end of [if]

(* ****** ****** *)
//
implement
{}(*tmp*)
fib_memo_get(n) = None_vt()
//
implement
{}(*tmp*)
fib_memo_set(n, res) = res
//
(* ****** ****** *)

local
//
typedef
key = int and itm = int
//
in (* in-of-local *)
//
#include "libats/ML/HATS/myhashtblref.hats"
//
end // end of [local]

(* ****** ****** *)

fun
myfib{n:nat}
  (n: int(n)): int = let
//
val map = myhashtbl_make_nil(n+n+1)
//
implement
fib_memo_get<> (n) = map.search(n)
//
implement
fib_memo_set<> (n, res) = let
(*
  val () = println! ("fib_memo_set: n = ", n)
  val () = println! ("fib_memo_set: res = ", res)
*)
  val-~None_vt() = map.insert(n, res) in res end
//
in
  fib(n)
end // end of [myfib]

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val N = 40
//
val N =
(
  if argc >= 2 then g0string2int(argv[1]) else N
) : int // end of [val]
//
val N = g1ofg0(N)
val () = assertloc(N >= 0)
//
val () = println! ("myfib(", N, ") = ", myfib(N))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fib_memo.dats] *)

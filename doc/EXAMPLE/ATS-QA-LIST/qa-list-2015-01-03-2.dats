(* ****** ****** *)
//
// A linear stream of characters
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
//
absvtype // for char streams
sstream_vtype // m/n: capacity/position
  (l:addr,m:int,n:int) = ptr(l)
//
stadef sstream = sstream_vtype
//
(* ****** ****** *)
//
extern
fun
sstream_create
  {m:nat}
(
  init: string(m)
) : [l:addr] sstream(l,m,0)
//
(* ****** ****** *)
//
extern
fun
sstream_cap
  {l:addr}{m,n:int}
  (cs: !sstream(l,m,n)): size_t(m)
extern
fun
sstream_pos
  {l:addr}{m,n:int}
  (cs: !sstream(l,m,n)): size_t(n)
//
(* ****** ****** *)
//
extern
fun
sstream_is_atend
  {l:addr}{m,n:int}
  (cs: !sstream(l,m,n)): bool(m==n)
and
sstream_isnot_atend
  {l:addr}{m,n:int}
  (cs: !sstream(l,m,n)): bool(m > n)
//  
(* ****** ****** *)
//
extern
fun
sstream_get
  {l:addr}{m,n:nat | m > n}
  (cs: !sstream(l,m,n)): charNZ
extern
fun
sstream_inc
  {l:addr}{m,n:nat | m > n}
  (cs: !sstream(l,m,n) >> sstream(l,m,n+1)): void
extern
fun
sstream_getinc
  {l:addr}{m,n:nat | m > n}
  (cs: !sstream(l,m,n) >> sstream(l,m,n+1)): charNZ
//
(* ****** ****** *)
//
extern
fun
sstream_free{l:addr}{m,n:int}(cs: sstream(l,m,n)): void
//
(* ****** ****** *)

local

datavtype
sstream(l:addr, m:int, n:int) =
  SSTREAM of (strnptr(m), size_t(m), size_t(n))

assume
sstream_vtype(l, m, n) = sstream(l, m, n)

in (* in-of-local *)

implement
sstream_create
  (init) = let
  val init2 = string1_copy(init)
in
  SSTREAM (init2, length(init), i2sz(0))
end // end of [sstream_create]

implement
sstream_cap
  (cs) = let
//
val+SSTREAM(data, cap, pos) = cs in cap
//
end // end of [sstream_cap]
implement
sstream_pos
  (cs) = let
//
val+SSTREAM(data, cap, pos) = cs in pos
//
end // end of [sstream_pos]

implement
sstream_is_atend
  (cs) = let
//
val+SSTREAM(data, cap, pos) = cs in cap = pos
//
end // end of [sstream_is_atend]
implement
sstream_isnot_atend
  (cs) = let
//
val+SSTREAM(data, cap, pos) = cs in cap > pos
//
end // end of [sstream_isnot_atend]

implement
sstream_get
  (cs) = let
//
val+SSTREAM(data, cap, pos) = cs in data[pos]
//
end // end of [sstream_get]

implement
sstream_inc
  (cs) = () where
{
//
val+@SSTREAM(data, cap, pos) = cs
//
val () = pos := succ(pos); prval () = fold@(cs)
//
} (* end of [sstream_get] *)

implement
sstream_getinc
  (cs) = c0 where
{
//
val+@SSTREAM(data, cap, pos) = cs
//
val c0 = data[pos]
//
val () = pos := succ(pos); prval () = fold@(cs)
//
} (* end of [sstream_get] *)

implement
sstream_free(cs) = let
//
val+~SSTREAM(data, _, _) = cs in strnptr_free(data)
//
end // end of [sstream_free]

end // end of [local]

(* ****** ****** *)

implement
main0(argc, argv) =
{
  val cs =
    sstream_create("Hello!")
  // end of [val]
  val c0 = sstream_getinc(cs)
  val c1 = sstream_getinc(cs)
  val c2 = sstream_getinc(cs)
  val c3 = sstream_getinc(cs)
  val c4 = sstream_getinc(cs)
  val c5 = sstream_getinc(cs)
  val ((*freed*)) = sstream_free(cs)
  val () = println! (c0, c1, c2, c3, c4, c5)
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-2015-01-03-2.dats] *)

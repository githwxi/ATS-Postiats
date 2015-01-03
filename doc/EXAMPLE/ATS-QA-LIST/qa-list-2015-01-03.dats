(* ****** ****** *)
//
// A linear stream of characters
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
staload UN = "prelude/SATS/unsafe.sats"
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
sstream_is_atend
  {l:addr}{m,n:nat | m > n}
  (cs: !sstream(l,m,n)): bool(m==n)
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

vtypedef
sstream_struct
  (m,n:int) = @{
  data= strnptr(m)
, cap= size_t(m), pos= size_t(n)
} (* end of [sstream_struct] *)

typedef sstream_struct0 = sstream_struct(0,0)?

assume
sstream_vtype(l, m, n) =
(
  sstream_struct(m,n)@l, mfree_gc_v(l) | ptr(l)
)

in (* in-of-local *)

implement
sstream_create
  (init) = let
//
val (pf, pfgc | p) =
  ptr_alloc<sstream_struct0>()
//
val () =
  p->data := string1_copy(init)
//
val () = p->cap := length(init)
//
val () = p->pos := i2sz(0)
//
in
  $UN.castvwtp0((pf, pfgc | p))
end // end of [sstream_create]

implement
sstream_cap (cs) = (cs.2)->cap
implement
sstream_pos (cs) = (cs.2)->pos

implement
sstream_get
  (cs) = let
  val p = cs.2
in
  strnptr_get_at(p->data, p->pos)
end // end of [sstream_get]

implement
sstream_inc(cs) =
{
  val p = cs.2; val () = p->pos := succ(p->pos)
}

implement
sstream_getinc
  (cs) = c where
{
  val p = cs.2
  val c =
  strnptr_get_at(p->data, p->pos)
  val () = p->pos := succ(p->pos)
} (* end of [sstream_getinc] *)

implement
sstream_free(cs) = let
  val p = cs.2
  val () = strnptr_free (p->data)
in
  ptr_free{sstream_struct0}(cs.1, cs.0 | p)
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

(* end of [qa-list-2015-01-03.dats] *)

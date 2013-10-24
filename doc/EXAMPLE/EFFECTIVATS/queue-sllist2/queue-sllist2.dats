(* ****** ****** *)
//
// HX-2013-05:
// Effective ATS: Amortized Queue Implementation
//
(* ****** ****** *)
//
// How to test:
// ./queue-sllist2
// How to compile:
// patscc -DATS_MEMALLOC_LIBC -o queue-sllist2 queue-sllist2.dats
//
(* ****** ****** *)

absvtype
queue_vtype (a:viewt@ype+, n:int) = ptr

(* ****** ****** *)

vtypedef
queue (a:vt0p, n:int) = queue_vtype (a, n)

(* ****** ****** *)

extern
praxi
lemma_queue_param
  {a:vt0p}{n:int} (x: !queue (INV(a), n)): [n >= 0] void
// end of [lemma_queue_param]

(* ****** ****** *)

extern
fun{} queue_make_nil {a:vt0p} (): queue (a, 0)
extern
fun{} queue_free_nil {a:vt0p} (que: queue (a, 0)): void

(* ****** ****** *)
//
extern
fun{} queue_is_empty
  {a:vt0p}{n:int} (que: !queue (INV(a), n)): bool (n==0)
extern
fun{} queue_isnot_empty
  {a:vt0p}{n:int} (que: !queue (INV(a), n)): bool (n > 0)
//
(* ****** ****** *)

extern
fun{a:vt0p}
queue_insert_atend{n:int}
  (que: !queue (INV(a), n) >> queue (a, n+1), x: a): void
// end of [queue_insert_atend]

extern
fun{a:vt0p}
queue_takeout_atbeg
  {n:pos} (que: !queue (INV(a), n) >> queue (a, n-1)): (a)

(* ****** ****** *)

local

staload "libats/SATS/sllist.sats"

dataviewtype
queue (a:viewt@ype+, n:int) =
  {f,r:nat | f+r==n} QUEUE of (sllist (a, f), sllist (a, r))
// end of [queue]

assume queue_vtype (a, n) = queue (a, n)

in (* in of [local] *)

implement{}
queue_make_nil () = QUEUE (sllist_nil (), sllist_nil ())

implement{}
queue_free_nil (que) = let
//
val+~QUEUE (f, r) = que
//
prval () = lemma_sllist_param (f)
prval () = lemma_sllist_param (r)
//
prval () = sllist_free_nil (f)
prval () = sllist_free_nil (r)
//
in
  // nothing
end // end of [queue_free_nil]

implement{}
queue_is_empty (que) = let
  val+QUEUE (f, r) = que
in
  if sllist_is_nil (f) then sllist_is_nil (r) else false
end // end of [queue_is_empty]

implement{}
queue_isnot_empty (que) = let
  val+QUEUE (f, r) = que
in
  if sllist_is_cons (f) then true else sllist_is_cons (r)
end // end of [queue_isnot_empty]

implement{a}
queue_insert_atend
  (que, x) = let
//
val+@QUEUE (f, r) = que
val () = r := sllist_cons (x, r)
prval () = fold@ (que)
//
in
  // nothing
end // end of [queue_insert_atend]

implement{a}
queue_takeout_atbeg
  (que) = let
//
val+@QUEUE (f, r) = que
//
prval () = lemma_sllist_param (f)
prval () = lemma_sllist_param (r)
//
val iscons = sllist_is_cons (f)
//
in
//
if iscons then let
  val x = sllist_uncons (f)
  prval () = fold@ (que)
in
  x
end else let
  prval () = sllist_free_nil (f)
  val () = f := sllist_reverse (r)
  val () = r := sllist_nil {a} ()
  val x = sllist_uncons (f)
  prval () = fold@ (que)
in
  x
end // end of [if]
//
end // end of [queue_takeout_atbeg]

end // end of [local]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/sllist.dats"

(* ****** ****** *)

implement
main0 () =
{
//
typedef T = int
//
val Q = queue_make_nil {T} ()
//
val () = queue_insert_atend (Q, 0)
val () = queue_insert_atend (Q, 1)
val () = println! ("Q[hd] = ", queue_takeout_atbeg (Q))
val () = println! ("Q[hd] = ", queue_takeout_atbeg (Q))
//
val () = queue_insert_atend (Q, 2)
val () = queue_insert_atend (Q, 3)
val () = queue_insert_atend (Q, 4)
val () = println! ("Q[hd] = ", queue_takeout_atbeg (Q))
val () = println! ("Q[hd] = ", queue_takeout_atbeg (Q))
val () = println! ("Q[hd] = ", queue_takeout_atbeg (Q))
//
val () = queue_free_nil (Q)
//
} // end of [main0]

(* ****** ****** *)

(* end of [queue-sllist2.dats] *)

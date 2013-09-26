(* ****** ****** *)
//
// Fourslot algorithm for fully asynchrous read/write by Simpson
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: May, 2013
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

abst@ype bit = int

extern
castfn bit2int (i: bit): natLt(2)
extern
castfn int2bit (i: natLt(2)): bit

extern
fun{} not_bit (i: bit): bit
overload not with not_bit

implement{}
not_bit (i) = int2bit (1 - bit2int (i))

(* ****** ****** *)

absvtype data_vtype (a:t@ype) = ptr
vtypedef data (a:t0p) = data_vtype (a)

extern
fun{a:t0p}
data_make_elt (x: a): data (a)
extern
fun{} data_free {a:t0p} (A: data (a)): void

extern
fun{a:t0p}
data_read (A: !data (a), i: bit, j: bit): a
extern
fun{a:t0p}
data_write (A: !data (a), i: bit, j: bit, x: a): void

local

assume
data_vtype (a:t0p) = arrayptr (a, 4)

in (* in of [local] *)

implement{a}
data_make_elt (x) = arrayptr_make_elt<a> (i2sz(4), x)

implement{}
data_free (A) = arrayptr_free (A)

implement{a}
data_read (A, i, j) = A[2 * bit2int (i) + bit2int (j)]
implement{a}
data_write (A, i, j, x) = A[2 * bit2int (i) + bit2int (j)] := x

end // end of [local]

(* ****** ****** *)

absvtype slot_vtype = ptr
vtypedef slot = slot_vtype

extern
fun{} slot_make (): slot
extern
fun{} slot_free (S: slot): void

extern
fun{} slot_get (S: !slot, i: bit): bit
extern
fun{} slot_set (S: !slot, i: bit, j: bit): void

local

assume
slot_vtype = arrayptr (bit, 2)

in (* in of [local] *)

implement{}
slot_make () =
  arrayptr_make_elt<bit> (i2sz(2), int2bit(0))
// end of [slot_make]

implement{}
slot_free (S) = arrayptr_free (S)

implement{}
slot_get (S, i) = S[bit2int(i)]
implement{}
slot_set (S, i, j) = S[bit2int(i)] := j

end // end of [local]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
extern fun{} latest_get (): bit
extern fun{} latest_set (i: bit): void
extern fun{} reading_get (): bit
extern fun{} reading_set (i: bit): void
//
(* ****** ****** *)

fun{a:t0p}
fourslot_read
(
  A: !data (a), S: !slot
) : a = let
  val pair = latest_get ()
  val () = reading_set (pair)
  val index = slot_get (S, pair)
in
  data_read (A, pair, index)
end // end of [fourslot_read]

(* ****** ****** *)

fun{a:t0p}
fourslot_write
(
  A: !data (a), S: !slot, x: a
) : void = let
  val pair = not (reading_get ())
  val index = not (slot_get (S, pair))
  val () = data_write (A, pair, index, x)
  val () = slot_set (S, pair, index)
  val () = latest_set (pair)
in
  // nothing
end // end of [fourslot_write]

(* ****** ****** *)

implement
main0 () =
{
//
local
var latest: int = 0
in
implement{}
latest_get () = $UN.ptr1_get<bit> (addr@(latest))
implement{}
latest_set (i) = $UN.ptr1_set<bit> (addr@(latest), i)
end // end of [local]
//
local
var reading: int = 0
in
implement{}
reading_get () = $UN.ptr1_get<bit> (addr@(reading))
implement{}
reading_set (i) = $UN.ptr1_set<bit> (addr@(reading), i)
end // end of [local]
//
typedef T = int
//
val out = stdout_ref
//
val A = data_make_elt<T> (0)
//
val S = slot_make ()
//
val x0 = fourslot_read<T> (A, S)
val () = fprintln! (out, "x0 = ", x0)
val () = assertloc (x0 = 0)
//
val () = fourslot_write<T> (A, S, 1)
val () = fourslot_write<T> (A, S, ~1)
//
val x1 = fourslot_read<T> (A, S)
val () = fprintln! (out, "x1 = ", x1)
val () = assertloc (x1 = ~1)
//
val () = slot_free (S)
//
val () = data_free (A)
//
} // end of [main0]

(* ****** ****** *)

(* end of [fourslot.dats] *)

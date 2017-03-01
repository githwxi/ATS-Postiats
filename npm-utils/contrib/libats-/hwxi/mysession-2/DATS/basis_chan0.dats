(*
** Channel pairs
*)

(* ****** ****** *)

staload "./basis_uchan.dats"

(* ****** ****** *)

absvtype
channel0_vtype(a:vt@ype) = ptr
vtypedef
channel0(a:vt@ype) = channel0_vtype(a)

(* ****** ****** *)
//
extern
fun
{a:vt0p}
channel0_make_pair
(
  capacity: intGt(0)
) : (channel0(a), channel0(a))
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
channel0_free (chan0: channel0(a)): void
//
(* ****** ****** *)

extern
fun{a:vt0p}
channel0_send (!channel0(a), a): void
extern
fun{a:vt0p}
channel0_recv (!channel0(a), &a? >> a): void
extern
fun{a:vt0p}
channel0_recv_val (!channel0(a)): (a)

(* ****** ****** *)
//
extern
fun
{a:vt0p}
channel0_link(channel0(a), channel0(a)): void
//
(* ****** ****** *)
//
datavtype
channel0_(a:vt@ype) =
  CHAN0 of (uchannel(a), uchannel(a))
//
(* ****** ****** *)

assume channel0_vtype(a:vt0p) = channel0_(a)

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_make_pair
  (cap) = let
//
val chx1 =
  uchannel_make<a> (cap)
and chy1 =
  uchannel_make<a> (cap)
//
val chx2 = uchannel_ref (chx1)
and chy2 = uchannel_ref (chy1)
//
in
  (CHAN0(chx1, chy2), CHAN0(chy1, chx2))
end // end of [channel0_make_pair]

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_free
  (chan0) = let
//
val~CHAN0(ch0, ch1) = chan0
//
in
  uchannel_unref(ch0); uchannel_unref(ch1)
end // end of [channel0_free]

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_send
  (chan0, x) = let
//
val+CHAN0(ch0, ch1) = chan0
//
in
  uchannel_insert<a> (ch0, x)
end // end of [channel0_send]

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_recv
  (chan0, x0) = let
//
val+@CHAN0(ch0, ch1) = chan0
//
val () = x0 := uchannel_remove<a> (ch1)
//
prval ((*folded*)) = fold@chan0
//
in
  // nothing
end // end of [channel0_recv]

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_recv_val
  (chan0) = x0 where
{
//
val+@CHAN0(ch0, ch1) = chan0
//
val x0 = uchannel_remove<a> (ch1)
//
prval ((*folded*)) = fold@chan0
//
} (* end of [channel0_recv_val] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channel0_link
  (chan0x, chan0y) = let
//
val~CHAN0(chx1, chx2) = chan0x
and~CHAN0(chy1, chy2) = chan0y
//
val () = uchannel_qinsert(chx1, chy2)
and () = uchannel_qinsert(chy1, chx2)
//
val ((*void*)) = uchannel_unref(chx1)
and ((*void*)) = uchannel_unref(chy1)
//
(*
val () =
fprintln! (stdout_ref, "channel0_link: leave")
*)
//
in
  // nothing
end // end of [channel0_link]

(* ****** ****** *)

(* end of [basic_chan0.dats] *)

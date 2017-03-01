(*
** Session-typed channels
*)

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"./../SATS/basis.sats"
//
staload "./basis_chan0.dats"
//
(* ****** ****** *)
//
datavtype
boxed (a:vt@ype) = BOX of (a)
//
(* ****** ****** *)

implement
{a}(*tmp*)
chanpos_send
  (chpos, x) = let
  vtypedef bxa = boxed(a)
  val chan0 =
    $UN.castvwtp1{channel0(bxa)}(chpos)
  val ((*void*)) = channel0_send (chan0, BOX(x))
  prval ((*void*)) = $UN.cast2void(chan0)
  prval ((*void*)) = $UN.castview2void(chpos)
in
  // nothing
end // end of [chanpos_send]

(* ****** ****** *)

implement
{a}(*tmp*)
channeg_recv
  (chneg, x) = let
  vtypedef bxa = boxed(a)
  val chan0 =
    $UN.castvwtp1{channel0(bxa)}(chneg)
  val ((*void*)) = channel0_send (chan0, BOX(x))
  prval ((*void*)) = $UN.cast2void(chan0)
  prval ((*void*)) = $UN.castview2void(chneg)
in
  // nothing
end // end of [channeg_recv]

(* ****** ****** *)

implement
{a}(*tmp*)
chanpos_recv
  (chpos, x0) =
(
x0 := chanpos_recv_val(chpos)
) (* end of [chanpos_recv] *)

implement
{a}(*tmp*)
chanpos_recv_val
  (chpos) = (x) where
{
//
  vtypedef bxa = boxed(a)
//
  val chan0 =
    $UN.castvwtp1{channel0(bxa)}(chpos)
  // end of [val]
//
  val~BOX(x) = channel0_recv_val(chan0)
//
  prval ((*void*)) = $UN.cast2void(chan0)
  prval ((*void*)) = $UN.castview2void(chpos)
//
} (* end of [chanpos_recv_val] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channeg_send
  (chneg, x0) =
(
x0 := channeg_send_val(chneg)
) (* end of [channeg_send] *)

implement
{a}(*tmp*)
channeg_send_val
  (chneg) = (x) where
{
//
vtypedef bxa = boxed(a)
//
val chan0 =
  $UN.castvwtp1{channel0(bxa)}(chneg)
  // end of [val]
//
val~BOX(x) = channel0_recv_val(chan0)
//
prval ((*void*)) = $UN.cast2void(chan0)
prval ((*void*)) = $UN.castview2void(chneg)
//
} (* end of [channeg_send_val] *)

(* ****** ****** *)

(*
fun{}
chanpos_nil_wait(chanpos(nil)): void
*)

implement
{}(*tmp*)
chanpos_nil_wait
  (chpos) = () where
{
//
vtypedef
chan0 = channel0(ptr)
//
val chan0 =
  $UN.castvwtp0{chan0}(chpos)
//
val tag = channel0_recv_val (chan0)
//
val ((*void*)) = assertloc (iseqz(tag))
//
val ((*freed*)) = channel0_free (chan0)
//
} (* end of [chanpos_nil_wait] *)

(* ****** ****** *)

implement
{}(*tmp*)
channeg_nil_close
  (chneg) = () where
{
//
vtypedef
chan0 = channel0(ptr)
//
val
chan0 =
$UN.castvwtp0{chan0}(chneg)
//
val () =
channel0_send (chan0, $UN.int2ptr(0))
//
val ((*freed*)) = channel0_free (chan0)
//
} (* end of [channeg_nil_close] *)

(* ****** ****** *)
//
implement
{}(*tmp*)
chanposneg_link
  {ss}(chp, chn) = let
//
vtypedef
chan0 = channel0(ptr)
//
val
chx = $UN.castvwtp0{chan0}(chp)
val
chy = $UN.castvwtp0{chan0}(chn)
//
in
  channel0_link<ptr> (chx, chy)
end // end of [chanposneg_link]
//
(* ****** ****** *)

staload "libats/SATS/athread.sats"

(* ****** ****** *)

implement{} channel_cap ((*void*)) = 1

(* ****** ****** *)
//
(*
fun{}
channeg_create_exn{ss:type}
  (fserv: chanpos(ss) -<lincloptr1> void): channeg(ss)
*)
//
implement
{}(*tmp*)
channeg_create_exn
  {ss}(fserv) = let
//
val CAP = channel_cap()
//
val
(chx, chy) =
  channel0_make_pair<ptr>(CAP)
//
val chpos =
  $UN.castvwtp0{chanpos(ss)}(chx)
//
val tid =
athread_create_cloptr_exn
(
//
llam (
) => let
  val () = fserv(chpos)
in
  cloptr_free($UN.castvwtp0{cloptr(void)}(fserv))
end // end of [let]
//
) (* end of [val] *)
//
in
  $UN.castvwtp0{channeg(ss)}(chy)
end // end of [channeg_create_exn]
//
(* ****** ****** *)

(*
//
(*
fun{}
channeg2_create_exn
  {ss1,ss2:type}
  (fserv: (chanpos(ss1), chanpos(ss2)) -<lincloptr1> void): (channeg(ss1), channeg(ss2))
*)
//
implement
{}(*tmp*)
channeg2_create_exn
  {ss1,ss2}(fserv) = let
//
val CAP = channel_cap()
//
val
(chx1, chy1) =
  channel0_make_pair<ptr>(CAP)
val
(chx2, chy2) =
  channel0_make_pair<ptr>(CAP)
//
val chp1 =
  $UN.castvwtp0{chanpos(ss1)}(chx1)
val chp2 =
  $UN.castvwtp0{chanpos(ss2)}(chx2)
//
val tid =
athread_create_cloptr_exn
(
//
llam (
) => let
  val () = fserv(chp1, chp2)
in
  cloptr_free($UN.castvwtp0{cloptr(void)}(fserv))
end // end of [let]
//
) (* end of [val] *)
//
in
(
$UN.castvwtp0{channeg(ss1)}(chy1)
,
$UN.castvwtp0{channeg(ss2)}(chy2)
)
end // end of [channeg2_create_exn]
//
*)

(* ****** ****** *)

(* end of [basis_ssntyp.dats] *)

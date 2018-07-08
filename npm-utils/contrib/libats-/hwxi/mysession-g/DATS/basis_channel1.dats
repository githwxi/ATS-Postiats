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
"./../SATS/basis_intset.sats"
staload
"./../SATS/basis_ssntype.sats"
//
staload "./basis_channel0.dats"
//
(* ****** ****** *)
//
datavtype
boxed (a:vt@ype) = BOX of (a)
//
(* ****** ****** *)

implement
{}(*tmp*)
channel1_get_nrole
  {n}(tchan) = n where
{
//
vtypedef
channel0_ = channel0_(ptr, n)
//
val chan0 =
  $UN.castvwtp1{channel0_}(tchan)
//
val+CHANNEL0(n, _, _) = chan0
//
prval () = $UN.cast2void(chan0)
//
} (* end of [channel1_get_nrole] *)

(* ****** ****** *)

implement
{}(*tmp*)
channel1_get_group
  {n}(tchan) =
  $UN.cast(G) where
{
//
vtypedef
channel0_ = channel0_(ptr, n)
//
val chan0 =
  $UN.castvwtp1{channel0_}(tchan)
//
val+CHANNEL0(_, G, _) = chan0
//
prval () = $UN.cast2void(chan0)
//
} (* end of [channel1_get_group] *)

(* ****** ****** *)

implement
{a}(*tmp*)
channel1_close
  {n}(tchan) = let
//
vtypedef bxa = boxed(a)
vtypedef chan0 = channel0(bxa, n)
//
in
  channel0_free($UN.castvwtp0{chan0}(tchan))
end // end of [channel1_close]

(* ****** ****** *)
//
implement
{}(*tmp*)
channel1_skipin(chan) =
{
  prval () = lemma_channel1_skipin(chan)
}
//
implement
{}(*tmp*)
channel1_skipex(chan) =
{
  prval () = lemma_channel1_skipex(chan)
}
//
(* ****** ****** *)

implement
{a}(*tmp*)
channel1_send
  {n}(tchan, i, j, x0) = let
//
vtypedef bxa = boxed(a)
vtypedef chan0 = channel0(bxa, n)
//
val chan0 = $UN.castvwtp1{chan0}(tchan)
val ((*void*)) = channel0_send(chan0, i, j, BOX(x0))
//
prval ((*void*)) = $UN.cast2void(chan0)
prval ((*void*)) = $UN.castview2void(tchan)
//
in
  // nothing
end // end of [channel1_send]

(* ****** ****** *)

implement
{a}(*tmp*)
channel1_recv
  (tchan, i, j, x0) =
(
  x0 := channel1_recv_val(tchan, i, j)
) (* end of [channel1_recv] *)

implement
{a}(*tmp*)
channel1_recv_val
  {n}(tchan, i, j) = (x0) where
{
//
vtypedef bxa = boxed(a)
vtypedef chan0 = channel0(bxa, n)
//
val chan0 = $UN.castvwtp1{chan0}(tchan)
//
val~BOX(x0) = channel0_recv_val(chan0, i, j)
//
prval ((*void*)) = $UN.cast2void(chan0)
prval ((*void*)) = $UN.castview2void(tchan)
//
} (* end of [channel1_recv_val] *)

(* ****** ****** *)

implement
{}(*tmp*)
channel1_append
  {n}(tchan, fserv) =
{
//
val
fserv =
$UN.castvwtp0{(ptr)-<cloref1>void}(fserv)
//
val () = fserv($UN.castvwtp1{ptr}(tchan))
//
prval ((*void*)) = $UN.castview2void(tchan)
//
} (* end of [channel1_append] *)

(* ****** ****** *)

implement
{}(*tmp*)
channel1_choose_l
  {n}(tchan, i0) =
{
//
vtypedef
chan0 = channel0(ptr, n)
//
val n = channel1_get_nrole(tchan)
val G = channel1_get_group(tchan)
//
val
chan0 = $UN.castvwtp1{ptr}(tchan)
//
var
fwork = 
lam@ (
  j: natLt(n)
) : void => let
  val
  tag =
  $UN.cast2ptr(choosetag_l)
  val
  chan0 =
  $UN.castvwtp0{chan0}(chan0)
  val () = channel0_send<ptr>(chan0, i0, j, tag)
  prval () = $UN.cast2void(chan0)
in
  // nothing
end // end of [lam@]
val () = 
  cintset_foreach_cloref(n, G, $UN.cast(addr@fwork))
//
prval ((*void*)) = $UN.castview2void(tchan)
//
} (* end of [channel1_choose_l] *)

(* ****** ****** *)

implement
{}(*tmp*)
channel1_choose_r
  {n}(tchan, i0) =
{
//
vtypedef
chan0 = channel0(ptr, n)
//
val n = channel1_get_nrole(tchan)
val G = channel1_get_group(tchan)
val
chan0 = $UN.castvwtp1{ptr}(tchan)
//
var
fwork = 
lam@ (
  j: natLt(n)
) : void => let
  val
  tag =
  $UN.cast2ptr(choosetag_r)
  val
  chan0 =
  $UN.castvwtp0{chan0}(chan0)
  val () = channel0_send<ptr>(chan0, i0, j, tag)
  prval () = $UN.cast2void(chan0)
in
  // nothing
end // end of [lam@]
val () = 
  cintset_foreach_cloref(n, G, $UN.cast(addr@fwork))
//
prval ((*void*)) = $UN.castview2void(tchan)
//
} (* end of [channel1_choose_r] *)

(* ****** ****** *)

implement
{}(*tmp*)
channel1_choose_tag
  {n}(tchan, i0) = let
//
vtypedef
chan0 = channel0(ptr, n)
//
var
tag0 : ptr = the_null_ptr
//
val G = channel1_get_group(tchan)
//
val
chan0 = $UN.castvwtp1{ptr}(tchan)
//
var
fwork = 
lam@ (
  j: natLt(n)
) : void => let
  val
  chan0 =
  $UN.castvwtp0{chan0}(chan0)
  val
  tval =
  channel0_recv_val<ptr>(chan0, i0, j)
  // end of [val]
  val () = $UN.ptr0_set<ptr>(addr@tag0, tval)
  prval () = $UN.cast2void(chan0)
in
  // nothing
end // end of [lam@]
val () = 
  intset_foreach_cloref(G, $UN.cast(addr@fwork))
//
prval ((*void*)) = $UN.castview2void(tchan)
//
in
  $UN.cast(tag0)
end (* end of [channel1_choosetag] *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
channel1_link{n}
  (tchan0, tchan1) = let
//
val cap = channel_cap<>()
//
vtypedef
channel0 = channel0(ptr, n)
//
val
chan0 =
$UN.castvwtp0{channel0}(tchan0)
val
chan1 =
$UN.castvwtp0{channel0}(tchan1)
//
in
  $UN.castvwtp0(channel0_link{ptr}(cap, chan0, chan1))
end // end of [channel1_link]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
channel1_link_elim
  {n}(tchan0, tchan1) = let
//
vtypedef
channel0 = channel0(ptr, n)
//
val
chan0 =
$UN.castvwtp0{channel0}(tchan0)
val
chan1 =
$UN.castvwtp0{channel0}(tchan1)
//
in
  channel0_link_elim{ptr}(chan0, chan1)
end // end of [channel1_link_elim]
//
(* ****** ****** *)

staload "libats/SATS/athread.sats"

(* ****** ****** *)
//
implement
{}(*tmp*)
channel_cap ((*void*)) = 2
//
(*
implement
{}(*tmp*)
channel_cap ((*void*)) = 1024
*)
//
(* ****** ****** *)
//
(*
//
fun{}
cchannel1_create_exn
  {n:int}{ssn:type}{G:iset}
  (fserv: channel1(G, n, ssn) -<lincloptr1> void): cchannel1(G, n, ssn)
//
*)
//
implement
{}(*tmp*)
cchannel1_create_exn
  {n}{ssn}{G}
  (nrole, G, fserv) = let
//
val cap = channel_cap()
//
val
(chan0, chan1) =
channel0_posneg<ptr>(cap, nrole, G)
//
val
tchan =
$UN.castvwtp0{channel1(G, n, ssn)}(chan0)
//
val tid =
athread_create_cloptr_exn
(
//
llam () => let
  val () = fserv(tchan)
in
  cloptr_free($UN.castvwtp0{cloptr(void)}(fserv))
end // end of [let]
//
) (* end of [val] *)
//
in
  $UN.castvwtp0{cchannel1(G, n, ssn)}(chan1)
end // end of [channeg_create_exn]
//
(* ****** ****** *)

(* end of [basis_channel1.dats] *)

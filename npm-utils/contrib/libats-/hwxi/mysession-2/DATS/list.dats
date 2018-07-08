(*
** List-sessions
*)

(* ****** ****** *)
//
staload
"./../SATS/basis.sats"
//
(* ****** ****** *)
//
staload
  "./../SATS/list.sats"
//
(* ****** ****** *)
//
staload "./basis_chan0.dats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

implement
{}(*tmp*)
chanpos_list_nil
  (chpos) = () where
{
//
vtypedef
chan0 = channel0(ptr)
//
val
chan0 =
$UN.castvwtp1{chan0}(chpos)
//
val () =
channel0_send(chan0, $UN.int2ptr(0))
//
prval () = $UN.cast2void(chan0)
//
prval () = $UN.castview2void(chpos)
//
} (* end of [chanpos_list_nil] *)

(* ****** ****** *)

implement
{}(*tmp*)
chanpos_list_cons
  (chpos) = () where
{
//
vtypedef
chan0 = channel0(ptr)
//
val
chan0 =
$UN.castvwtp1{chan0}(chpos)
//
val ((*void*)) =
  channel0_send (chan0, $UN.int2ptr(1))
//
prval () = $UN.cast2void(chan0)
//
prval () = $UN.castview2void(chpos)
//
} (* end of [chanpos_list_cons] *)

(* ****** ****** *)

implement
{}(*tmp*)
channeg_list
  (chneg) = let
//
vtypedef
chan0 = channel0(ptr)
//
val
chan0 =
$UN.castvwtp1{chan0}(chneg)
//
val tag = channel0_recv_val (chan0)
//
prval () = $UN.cast2void(chan0)
//
in
//
if
iseqz(tag)
then let
  prval () = $UN.castview2void(chneg) in channeg_list_nil()
end // end of [then]
else let
  prval () = $UN.castview2void(chneg) in channeg_list_cons()
end // end of [else]
//
end // end of [channeg_list]

(* ****** ****** *)

implement
{a}(*tmp*)
list2sslist(xs) = let
//
fun
fserv
(
  chp: chanpos(sslist(a)), xs: List(a)
) : void =
(
case+ xs of
| list_nil () => let
    val () =
    chanpos_list_nil(chp) in chanpos_nil_wait(chp)
  end // end of [list_nil]
| list_cons (x, xs) => let
    val () =
    chanpos_list_cons(chp) in chanpos_send(chp, x); fserv(chp, xs)
  end // end of [list_cons]
)
//
in
//
channeg_create_exn(llam(chp) => fserv(chp, xs))
//
end // end of [list2sslist]

(* ****** ****** *)

implement
{a}(*tmp*)
sslist2list(chn) = list_vt2t(sslist2list_vt(chn))

(* ****** ****** *)

implement
{a}(*tmp*)
list2sslist_vt(xs) = let
//
fun
fserv
(
  chp: chanpos(sslist(a)), xs: List_vt(a)
) : void =
(
case+ xs of
| ~list_vt_nil () => let
    val () =
    chanpos_list_nil(chp) in chanpos_nil_wait(chp)
  end // end of [list_nil]
| ~list_vt_cons (x, xs) => let
    val () =
    chanpos_list_cons(chp) in chanpos_send(chp, x); fserv(chp, xs)
  end // end of [list_cons]
)
//
in
//
channeg_create_exn(llam(chp) => fserv(chp, xs))
//
end // end of [list2sslist_vt]

(* ****** ****** *)

implement
{a}(*tmp*)
sslist2list_vt
  (chn) = let
//
fun
loop
(
  chn: channeg(sslist(a))
, res: &ptr? >> List0_vt(a)
) : void = let
//
val opt = channeg_list(chn)
//
in
//
case+ opt of
| channeg_list_nil() =>
  (
    res := list_vt_nil();
    channeg_nil_close(chn)
  ) (* end of [channeg_list_nil] *)
| channeg_list_cons() =>
  {
    val x =
      channeg_send_val(chn)
    // end of [val]
    val () =
      res :=
      list_vt_cons{a}{0}(x, _)
    // end of [val]
    val+list_vt_cons(_, res1) = res
    val ((*void*)) = loop (chn, res1)
    prval ((*folded*)) = fold@res
  } (* end of [channeg_list_cons] *)
//
end // end of [loop]
//
var res: ptr // uninitialized
//
in
  let val () = loop(chn, res) in res end
end // end of [sslist2list_vt]

(* ****** ****** *)

(* end of [list.dats] *)

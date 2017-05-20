(*
** Session List
*)

(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "libats2erl_session_"
#define
ATS_STATIC_PREFIX "_libats2erl_session_sslist_"
//
(* ****** ****** *)
//
#define
LIBATSCC2ERL_targetloc
"$PATSHOME\
/contrib/libatscc2erl/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
#include
"{$LIBATSCC2ERL}/staloadall.hats"
//
(* ****** ****** *)
//
staload
"./../SATS/basis.sats"
//
(* ****** ****** *)
//
staload
"./../SATS/list.sats" // session-typed
//
staload "./basis_chan2.dats" // un-session-typed
//
(* ****** ****** *)

implement
chanpos_list_nil
  (chpos) = () where
{
//
val
chpos2 =
$UN.castvwtp1{chanpos2}(chpos)
//
val () = chanpos2_send{int}(chpos2, 0)
//
prval () = $UN.cast2void(chpos2)
prval () = $UN.castview2void(chpos)
//
} (* end of [chanpos_list_nil] *)

(* ****** ****** *)

implement
chanpos_list_cons
  (chpos) = () where
{
//
val
chpos2 =
$UN.castvwtp1{chanpos2}(chpos)
//
val () = chanpos2_send{int}(chpos2, 1)
//
prval () = $UN.cast2void(chpos2)
prval () = $UN.castview2void(chpos)
//
} (* end of [chanpos_list_cons] *)

(* ****** ****** *)

implement
channeg_list
  (chneg) = let
//
val
chneg2 =
$UN.castvwtp1{channeg2}(chneg)
//
val tag = channeg2_send{int}(chneg2)
//
prval () = $UN.cast2void(chneg2)
//
in
//
if
(tag=0)
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
list2sslist{a}(xs) = let
//
fun
fserv
(
  chp: chanpos(sslist(a)), xs: List(a)
) : void =
(
case+ xs of
| list_nil() => let
    val () =
    chanpos_list_nil(chp) in chanpos_nil_wait(chp)
  end // end of [list_nil]
| list_cons(x, xs) => let
    val () =
    chanpos_list_cons(chp)
    val () = chanpos_send{a}(chp, x) in fserv(chp, xs)
  end // end of [list_cons]
)
//
in
  channeg_create(llam(chp) => fserv(chp, xs))
end // end of [list2sslist]

(* ****** ****** *)

implement
sslist2list
  {a}(chn) = let
//
fun
loop
(
  chn: channeg(sslist(a)), xs: List0(a)
) : List0(a) = let
//
val opt = channeg_list(chn)
//
in
//
case+ opt of
| channeg_list_nil() => (channeg_nil_close(chn); xs)
| channeg_list_cons() => let
    val x = channeg_send(chn) in loop(chn, list_cons(x, xs))
  end // end of [channeg_list_cons]
//
end // end of [loop]
//
in
  list_reverse(loop(chn, list_nil(*void*)))
end // end of [sslist2list]

(* ****** ****** *)

(* end of [list.dats] *)

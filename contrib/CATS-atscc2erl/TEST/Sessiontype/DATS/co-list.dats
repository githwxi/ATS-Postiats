(*
** Session Co-List
*)

(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "libats2erl_session_"
#define
ATS_STATIC_PREFIX "_libats2erl_session_list_"
//
(* ****** ****** *)
//
//
#define
LIBATSCC2ERL_targetloc
"$PATSHOME\
/contrib/libatscc2erl/ATS2-0.3.2"
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
#include
"{$LIBATSCC2ERL}/staloadall.hats"
//
(* ****** ****** *)
//
//
staload
"./../SATS/basis.sats"
//
(* ****** ****** *)
//
staload
"./../SATS/co-list.sats" // session-typed
//
staload "./basis_chan2.dats" // un-session-typed
//
(* ****** ****** *)

implement
chanpos_list
  (chpos) = let
//
val
chpos2 =
$UN.castvwtp1{chanpos2}(chpos)
//
val tag = chanpos2_recv{int}(chpos2)
//
prval () = $UN.cast2void(chpos2)
//
in
//
if
(tag=0)
then let
  prval () = $UN.castview2void(chpos) in chanpos_list_nil()
end // end of [then]
else let
  prval () = $UN.castview2void(chpos) in chanpos_list_cons()
end // end of [else]
//
end // end of [chanpos_list]

(* ****** ****** *)

implement
channeg_list_nil
  (chneg) = () where
{
//
val
chneg2 =
$UN.castvwtp1{channeg2}(chneg)
//
val () =
  channeg2_recv{int}(chneg2, 0)
//
prval () = $UN.cast2void(chneg2)
//
prval () = $UN.castview2void(chneg)
//
} (* end of [channeg_list_nil] *)

(* ****** ****** *)

implement
channeg_list_cons
  (chneg) = () where
{
//
val
chneg2 =
$UN.castvwtp1{channeg2}(chneg)
//
val () =
  channeg2_recv{int}(chneg2, 1)
//
prval () = $UN.cast2void(chneg2)
//
prval () = $UN.castview2void(chneg)
//
} (* end of [channeg_list_cons] *)

(* ****** ****** *)

(* end of [co-list.dats] *)

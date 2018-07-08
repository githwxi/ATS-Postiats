(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME\
/contrib/libatscc2js/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
"{$LIBATSCC2JS}/SATS/Worker/channel.sats"
//
(* ****** ****** *)
//
typedef
sstest1 =
chrcv(int) ::
chsnd(bool) ::
chnil(*sstest1*)
//
typedef
sstest2 =
chsnd(int) ::
chsnd(int) :: sstest1
//
typedef
sstest3 =
chrcv(int) :: ssdisj(ssrepeat(sstest2))
//
(* ****** ****** *)

(* end of [test2_prot.sats] *)


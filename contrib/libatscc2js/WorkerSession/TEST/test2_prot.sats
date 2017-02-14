(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload "./../SATS/channel.sats"
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


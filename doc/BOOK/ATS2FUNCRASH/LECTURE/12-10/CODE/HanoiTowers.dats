(* ****** ****** *)
(*
** HanoiTowers
*)
(* ****** ****** *)
(*
##myatsccdef=\
patsopt -d $1 | atscc2js -o $fname($1)_dats.js -i -
*)
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
//
#define
ATS_DYNLOADNAME
"HanoiTowers__dynload"
//
#define
ATS_STATIC_PREFIX "HanoiTowers__"
//
(* ****** ****** *)
//
// HX: for accessing LIBATSCC2JS 
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib\
/libatscc2js/ATS2-0.3.2" // latest stable release
//
#include
"{$LIBATSCC2JS}/staloadall.hats" // for prelude stuff
#staload
"{$LIBATSCC2JS}/SATS/print.sats" // for print into a store
//
(* ****** ****** *)

abstype pole

(* ****** ****** *)
//
extern
fun
move(src: pole, dst: pole): void
//
extern
fun
nmove(n: int, src: pole, dst: pole, tmp: pole): void
//
(* ****** ****** *)
//
implement
nmove
(n, src, dst, tmp) =
if
(n > 0)
then
(
nmove(n-1, src, tmp, dst);
move(src, dst);
nmove(n-1, tmp, dst, src);
)
// end of [if] // end of [nmove]
//
(* ****** ****** *)
//
typedef cont() = cfun(void)
//
extern
fun
k_move(src: pole, dst: pole, k: cont()): void
//
extern
fun
k_nmove(n: int, src: pole, dst: pole, tmp: pole, k: cont()): void
//
(* ****** ****** *)
//
implement
k_nmove
(n, src, dst, tmp, k0) =
if
(n > 0)
then
(
k_nmove
( n-1, src, tmp, dst
, lam () => k_move(src, dst, lam () => k_nmove(n-1, tmp, dst, src, k0)))
)
// end of [if] // end of [k_nmove]
//
(* ****** ****** *)

(* end of [HanoiTowers.dats] *)

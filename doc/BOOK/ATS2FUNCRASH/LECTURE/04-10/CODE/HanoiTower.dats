(* ****** ****** *)
(*
** Animating Hanoi Tower
*)
(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0

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
//
(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

#define N 1000(*ms*)

(* ****** ****** *)
//
extern
fun
sleep(ms: int): void
extern
fun
animate(fwork: cfun(void)): void
extern
fun
sleep_animate
  (ms: int, fwork: cfun(void)): void
//
implement
animate(fwork) =
{
  val () = fwork()
  val () = sleep(N)
  val () = animate(fwork)
}
//
implement
animate(fwork) =
{
  val () = fwork()
  val () = sleep_animate(N, fwork)
}
//
(* ****** ****** *)
//
extern
fun
setTimeout : (int, cfun(void)) -> void
//
implement
sleep_animate(ms, fwork) =
  setTimeout(ms, lam() => animate(fwork))
//
(* ****** ****** *)

(* end of [HanoiTower.dats] *)

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
(* ****** ****** *)
//
(*
implement
animate(fwork) =
{
  val () = fwork()
  val () = sleep(N)
  val () = animate(fwork)
}
*)
//
(*
implement
animate(fwork) =
{
  val () = fwork()
  val () = sleep_animate(N, fwork)
}
*)
//
(* ****** ****** *)
//
extern
fun
execute_after
  : (cfun(void), int(*ms*)) -> void = "mac#"
//
(* ****** ****** *)

(*
%{^
//
function
execute_after(fwork, ms)
{
  return \
  setTimeout
  (ats2jspre_cloref2fun0(fwork), ms);
}
//
%} (* [%{^] *)
*)

(* ****** ****** *)
//
implement
execute_after
  (fwork, ms) = (
//
$extfcall
(void, "setTimeout", cloref2fun0(fwork), ms)
//
) (* end of [execute_after] *)
//
(* ****** ****** *)
(*
//
implement
sleep_animate(ms, fwork) =
  execute_after(lam() => animate(fwork), ms)
//
*)
(* ****** ****** *)

implement
animate(fwork) =
{
  val () = fwork()
  val () = execute_after(lam() => animate(fwork), N)
}

(* ****** ****** *)

(* end of [DigitClock.dats] *)

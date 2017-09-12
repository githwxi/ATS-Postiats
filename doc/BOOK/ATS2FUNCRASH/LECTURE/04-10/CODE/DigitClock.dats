(* ****** ****** *)
(*
** Digital Clock
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
staload
"{$LIBATSCC2JS}/SATS/print.sats"
//
staload
_ = "{$LIBATSCC2JS}/DATS/print.dats"
//
(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

#define N 500(*ms*)

(* ****** ****** *)
//
extern
fun
sleep(ms: int): void
extern
fun
animate(fwork: cfun(void)): void
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
(* ****** ****** *)
//
extern
fun
sleep_animate
  (ms: int, fwork: cfun(void)): void
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
(fwork: cfun(void), ms: int): void
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
( void
, "setTimeout", cloref2fun0(fwork), ms)
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
//
abstype xmldoc
//
%{^
//
function
document_getElementById
  (id)
{
  return document.getElementById(id);
}
//
function
xmldoc_set_innerHTML
  (xmldoc, text)
  { xmldoc.innerHTML = text; return; }
//
%} // end of [%{^] 
//
extern
fun
document_getElementById
  (id: string): xmldoc = "mac#"
//
extern
fun
xmldoc_set_innerHTML
(xmldoc, text: string): void = "mac#"
//
(* ****** ****** *)
//
extern
fun
button_enable
  (button: xmldoc): void = "mac#"
extern
fun
button_disable
  (button: xmldoc): void = "mac#"
//
%{^
//
function
button_enable(button)
{
  button.disabled=false; return;
}
function
button_disable(button)
{
  button.disabled = true; return;
}
%}
//
(* ****** ****** *)
//
%{^
//
function
time_display()
{
//
var date = new Date() ;
//
var hh = date.getHours()
var mm = date.getMinutes()
var ss = date.getSeconds()
//
return print_hhmmss(hh, mm, ss);
//
} // end of [time_display]
//
%}
//
extern
fun
print_hhmmss
(
hh: int, mm: int, ss: int
) : void = "mac#"
//
implement
print_hhmmss
  (hh, mm, ss) =
{
//
  val () = print!(hh/10, hh%10)
//
  val () = print!(":")
//
  val () = print!(mm/10, mm%10)
//
  val () = print!(":")
//
  val () = print!(ss/10, ss%10)
//
  val () = println!( (*void*) )
//
}
//
(* ****** ****** *)
//
extern
fun
DigitClock__evaluate
  (): void = "mac#"
//
implement
DigitClock__evaluate
  ((*void*)) = let
//
val
theOutput =
document_getElementById("theOutput")
//
val
theButton =
document_getElementById("button_evaluate")
//
fun
fwork(): void =
{
//
val () =
the_print_store_clear()
//
val () =
$extfcall(void, "time_display")
//
val () =
xmldoc_set_innerHTML
  (theOutput, the_print_store_join())
//
}
//
val () = button_disable(theButton)
//
in
  animate(lam() => fwork())
end // end of [DigitClock__evaluate]

(* ****** ****** *)

(* end of [DigitClock.dats] *)

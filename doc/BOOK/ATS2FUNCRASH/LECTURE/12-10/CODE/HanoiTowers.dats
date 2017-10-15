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
nmove
(n: int, src: pole, dst: pole, tmp: pole): void
//
(* ****** ****** *)
//
implement
nmove
( n
, src, dst, tmp) =
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
k_nmove
(n: int, src: pole, dst: pole, tmp: pole, k: cont()): void
//
(* ****** ****** *)
//
implement
k_nmove
( n
, src, dst, tmp
, k0) =
if
(n > 0)
then
(
k_nmove
( n-1, src, tmp, dst
, lam() => k_move(src, dst, lam() => k_nmove(n-1, tmp, dst, src, k0)))
) 
else k0((*void*))
// end of [if] // end of [k_nmove]
//
(* ****** ****** *)
//
(*
#define N 8
*)
extern
fun N_get(): int
extern
fun N_set(int): void
//
extern
fun theDelayTime_get(): int
extern
fun theDelayTime_set(int): void
//
(* ****** ****** *)

local

val N = ref{int}(8)
val theDelayTime = ref{int}(500)

in (* in-of-local *)
//
implement N_get() = N[]
implement N_set(n) = (N[] := n)

implement theDelayTime_get() = theDelayTime[]
implement theDelayTime_set(n) = (theDelayTime[] := n)
//
end // end of [local]

(* ****** ****** *)
//
extern
fun
height_get(): int = "mac#"
extern
fun
delay_time_get(): int = "mac#"
//
%{^
function
height_get()
{
  return parseInt(document.getElementById("param_height").value);
}
function
delay_time_get()
{
  return parseInt(document.getElementById("param_delay_time").value);
}
%}
//
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
val
theDocument =
$extval(xmldoc, "document")
//
val
theButton_start =
document_getElementById("button_start")
val
theButton_reset =
document_getElementById("button_reset")
val
theButton_pause =
document_getElementById("button_pause")
val
theButton_resume =
document_getElementById("button_resume")
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

val () = button_enable(theButton_start)
val () = button_enable(theButton_reset)
val () = button_disable(theButton_pause)
val () = button_disable(theButton_resume)

(* ****** ****** *)
//
extern
fun
param_initize(): void = "mac#"
//
implement
param_initize() =
{
val () = N_set(height_get())
val () = theDelayTime_set(delay_time_get())
}
//
val () = param_initize()
//
(* ****** ****** *)
//
typedef contopt = option0(cont())
//
(* ****** ****** *)
//
val
theHanoiTowersCont0 = ref{contopt}(None0())
val
theHanoiTowersCont1 = ref{contopt}(None0())
//
(* ****** ****** *)

(* end of [HanoiTowers.dats] *)

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

typedef pole = int

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

local

val A =
array0_make_elt{int}(0, 0)

in

val
thePoles =
array0_make_elt{array0(int)}(3, A)

end // end of [local]

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

implement
k_move
(src, dst, k0) = let
//
(*
val
() =
alert
( "kmove: "
+ String(src)
+ " -> "
+ String(dst)
) (* end of [val] *)
*)
//
in
  theHanoiTowersCont1[] := Some0(k0)  
end // end of [k_move]

(* ****** ****** *)
//
extern
fun
HanoiTowersShow_init
  ((*void*)): void
//
implement
HanoiTowersShow_init
  ((*void*)) = let
//
val
theStage =
$extmcall
( xmldoc
, theDocument
, "getElementById", "theStage")
//
val () =
the_print_store_clear()  
//
val () =
println! ("HanoiTowersShow_init()")
//
val res = the_print_store_join()
//
in
  xmldoc_set_innerHTML(theStage, res)
end // end of [HanoiTowersShow_init]
//
(* ****** ****** *)
//
extern
fun
HanoiTowersShow_loop
  ((*void*)): void
extern
fun
HanoiTowersShow_loop_delay
  ((*void*)): void
//
(* ****** ****** *)
//
implement
HanoiTowersShow_loop
  ((*void*)) = let
//
val
opt = theHanoiTowersCont1[]
//
val () =
theHanoiTowersCont1[] := None0()
//
in
  case+ opt of
  | None0() =>
    ((*void*))
  | Some0(k0) =>
    (k0(); HanoiTowersShow_loop_delay())
end // end of [HanoiTowersShow_loop]
//
implement
HanoiTowersShow_loop_delay
  ((*void*)) = let
//
val ms = theDelayTime_get()
//
in
  $extfcall(void, "setTimeout", HanoiTowersShow_loop, ms)
end // end of [HanoiTowersShow_loop_delay]
//
(* ****** ****** *)
//
extern
fun
HanoiTowersControl_start
  ((*void*)): void = "mac#"
//
implement
HanoiTowersControl_start
  ((*void*)) = let
//
(*
val () =
alert("HanoiTowersControl_start!")
*)
//
val () =
button_enable(theButton_pause)
//
val () =
button_disable(theButton_start)
val () =
button_disable(theButton_resume)
//
val N = N_get()
//
val src = 0 and dst = 1 and tmp = 2
//
val () =
theHanoiTowersCont1[] :=
Some0
(
lam
(
// argless
) =<cloref1>
  k_nmove(N, src, dst, tmp, lam() => alert("HanoiTowers: Done!"))
// end of [lam]
)
//
in
  HanoiTowersShow_loop()
end // end of [HanoiTowersControl_start]
//
(* ****** ****** *)
//
extern
fun
HanoiTowersControl_reset
  ((*void*)): void = "mac#"
//
implement
HanoiTowersControl_reset
  ((*void*)) = let
//
(*
val () =
alert("HanoiTowersControl_reset!")
*)
//
val () =
param_initize()
//
val () =
button_enable(theButton_start)
//
val () =
button_disable(theButton_pause)
val () =
button_disable(theButton_resume)
//
val () =
theHanoiTowersCont0[] := None0()
val () =
theHanoiTowersCont1[] := None0()
//
in
  HanoiTowersShow_init((*void*))
end // end of [HanoiTowersControl_reset]
//
(* ****** ****** *)
//
extern
fun
HanoiTowersControl_pause
  ((*void*)): void = "mac#"
//
implement
HanoiTowersControl_pause
  ((*void*)) = let
//
(*
val () =
alert("HanoiTowersControl_pause!")
*)
//
val () =
button_enable(theButton_resume)
//
val () =
button_disable(theButton_pause)
//
val opt =
theHanoiTowersCont1[]
//
in
//
case+ opt of
| None0 _ =>
  (
   // nothing
  )
| Some0 _ =>
  (
    theHanoiTowersCont0[] := opt;
    theHanoiTowersCont1[] := None0()
  )
//
end // end of [HanoiTowersControl_pause]
//
(* ****** ****** *)
//
extern
fun
HanoiTowersControl_resume
  ((*void*)): void = "mac#"
//
implement
HanoiTowersControl_resume
  ((*void*)) = let
//
(*
val () =
alert("HanoiTowersControl_resume!")
*)
//
val () =
button_enable(theButton_pause)
//
val () =
button_disable(theButton_resume)
//
val opt =
theHanoiTowersCont0[]
//
in
//
case+ opt of
| None0 _ => ()
| Some0 _ =>
  (
    theHanoiTowersCont1[] := opt;
    theHanoiTowersCont0[] := None0();
    HanoiTowersShow_loop();
  )
//
end // end of [HanoiTowersControl_resume]
//
(* ****** ****** *)

%{$
//
function
HanoiTowers__initize()
{
//
HanoiTowers__dynload(); return;
//
} // end of [HanoiTowers__initize]
%}

(* ****** ****** *)

%{$
//
jQuery(document).ready(function(){HanoiTowers__initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [HanoiTowers.dats] *)

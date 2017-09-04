(* ****** ****** *)
(*
** QueenPuzzle
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
"QueenPuzzle__dynload"
//
#define
ATS_STATIC_PREFIX "QueenPuzzle__"
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
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include "./../../MYLIB/mylib.dats"
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

macdef N() = N_get()

(* ****** ****** *)

abstype node = ptr

(* ****** ****** *)
//
extern
fun
node_get_children(node): list0(node)
overload .children with node_get_children
//
(* ****** ****** *)
//
extern
fun
node_dfsenum(node): list0(node)
//
implement
node_dfsenum
(nx0) =
list0_cons
(
nx0
,
list0_concat<node>
(
list0_map<node><list0(node)>
  (nx0.children(), lam(nx) => node_dfsenum(nx))
)
) (* node_dfsenum *)
//
(* ****** ****** *)

extern
fun
node_init(): node

extern
fun
node_length(node): int

(* ****** ****** *)

local

assume node = list0(int)

in (* in-of-local *)
//
implement
node_init() = list0_nil()
//
implement
node_length(nx) = list0_length(nx)
//
(* ****** ****** *)

fun
test_safety
(
x0: int,
xs: list0(int)
) : bool =
(
//
list0_iforall<int> // abs: absolute value
  (xs, lam(i, x) => (x0 != x && abs(x0-x) != (i+1)))
//
) // end of [test_safety]

(* ****** ****** *)
//
implement
node_get_children
  (nx) =
(
int_list0_mapopt<node>
( N()
, lam(x) =>
  if test_safety(x, nx)
    then Some0(cons0(x, nx)) else None0()
  // end of [if]
) (* end of [int_list0_mapopt] *)
) (* end of [node_get_children] *)
//
end // end of [local]

(* ****** ****** *)
//
(*
extern
fun
QueenPuzzleSolve(): list0(node) = "mac#"
implement
QueenPuzzleSolve() = node_dfsenum(node_init())
*)
//
(* ****** ****** *)

typedef nodelst = list0(node)
typedef nodelstopt = option0(nodelst)

(* ****** ****** *)
//
extern
fun
board_size_get(): int = "mac#"
extern
fun
delay_time_get(): int = "mac#"
//
%{^
function
board_size_get()
{
  return parseInt(document.getElementById("param_board_size").value);
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
val () = N_set(board_size_get())
val () = theDelayTime_set(delay_time_get())
}
//
val () = param_initize()
//
(* ****** ****** *)
//
val
theQueenPuzzleData0 = ref{nodelstopt}(None0())
val
theQueenPuzzleData1 = ref{nodelstopt}(None0())
//
(* ****** ****** *)
//
extern
fun
QueenPuzzleShow_node
  (node): void
extern
fun
QueenPuzzleShow_clear
  ((*void*)): void
extern
fun
QueenPuzzleShow_loop
  ((*void*)): void
extern
fun
QueenPuzzleShow_loop_delay
  ((*void*)): void
//
(* ****** ****** *)

implement
QueenPuzzleShow_node
  (nx) = let
//
reassume node
//
(*
val () =
alert("QueenPuzzleShow_node")
*)
//
val N = N()
//
fun
print_dots(n: int): void =
(n).foreach()(lam(i) => print ". ")
//
fun
println_dots(n: int): void =
(
(n).foreach()(lam(i) => print ". "); println!()
)
//
fun
println_qrow(i: int): void =
(
print_dots(i); print "Q "; print_dots(N-1-i); println!()
)
//
val nrow = node_length(nx)
//
in
//
the_print_store_clear();
//
(nx).rforeach()(lam i => println_qrow(i));
(N-nrow).foreach()(lam(_) => println_dots(N));
//
let
//
val
theStage =
$extmcall
( xmldoc
, theDocument
, "getElementById", "theStage")
//
val
res = the_print_store_join()
//
in
  xmldoc_set_innerHTML(theStage, res)
end // end of [let]
//
end // end of [QueenPuzzleShow_node]

(* ****** ****** *)
//
implement
QueenPuzzleShow_clear() =
QueenPuzzleShow_node(node_init())
//
(* ****** ****** *)
//
implement
QueenPuzzleShow_loop
  ((*void*)) = let
//
val opt = theQueenPuzzleData1[]
//
in
  case+ opt of
  | None0() => ()
  | Some0(nxs) =>
    (
      case+ nxs of
      | list0_nil() => ()
      | list0_cons(nx, nxs) => let
          val () =
          QueenPuzzleShow_node(nx)
          val () =
          theQueenPuzzleData1[] := Some0(nxs)
        in
          QueenPuzzleShow_loop_delay()
        end // end of [list0_cons]
    )
end // end of [QueenPuzzleShow_loop]
//
implement
QueenPuzzleShow_loop_delay
  ((*void*)) = let
//
val ms = theDelayTime_get()
//
in
  $extfcall(void, "setTimeout", QueenPuzzleShow_loop, ms)
end // end of [QueenPuzzleShow_loop_delay]

(* ****** ****** *)
//
extern
fun
QueenPuzzleControl_start
  ((*void*)): void = "mac#"
//
implement
QueenPuzzleControl_start
  ((*void*)) = let
//
(*
val () =
alert("QueenPuzzleControl_start!")
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
val
theNodelst = 
node_dfsenum(node_init())
//
val () =
theQueenPuzzleData1[] := Some0(theNodelst)
//
in
  QueenPuzzleShow_loop()
end // end of [QueenPuzzleControl_start]
//
(* ****** ****** *)
//
extern
fun
QueenPuzzleControl_pause
  ((*void*)): void = "mac#"
//
implement
QueenPuzzleControl_pause
  ((*void*)) = let
//
(*
val () =
alert("QueenPuzzleControl_pause!")
*)
//
val () =
button_enable(theButton_resume)
//
val () =
button_disable(theButton_pause)
//
val opt =
theQueenPuzzleData1[]
//
in
//
case+ opt of
| None0 _ => ()
| Some0 _ =>
  (
    theQueenPuzzleData0[] := opt;
    theQueenPuzzleData1[] := None0()
  )
//
end // end of [QueenPuzzleControl_pause]
//
(* ****** ****** *)
//
extern
fun
QueenPuzzleControl_resume
  ((*void*)): void = "mac#"
//
implement
QueenPuzzleControl_resume
  ((*void*)) = let
//
(*
val () =
alert("QueenPuzzleControl_resume!")
*)
//
val () =
button_enable(theButton_pause)
//
val () =
button_disable(theButton_resume)
//
val opt =
theQueenPuzzleData0[]
//
in
//
case+ opt of
| None0 _ => ()
| Some0 _ =>
  (
    theQueenPuzzleData1[] := opt;
    theQueenPuzzleData0[] := None0();
    QueenPuzzleShow_loop();
  )
//
end // end of [QueenPuzzleControl_resume]
//
(* ****** ****** *)
//
extern
fun
QueenPuzzleControl_reset
  ((*void*)): void = "mac#"
//
implement
QueenPuzzleControl_reset
  ((*void*)) = let
//
(*
val () =
alert("QueenPuzzleControl_reset!")
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
theQueenPuzzleData0[] := None0()
val () =
theQueenPuzzleData1[] := None0()
//
in
  QueenPuzzleShow_clear((*void*))
end // end of [QueenPuzzleControl_reset]
//
(* ****** ****** *)

%{$
//
function
QueenPuzzle__initize()
{
//
QueenPuzzle__dynload(); return;
//
} // end of [QueenPuzzle__initize]
%}

(* ****** ****** *)

%{$
//
jQuery(document).ready(function(){QueenPuzzle__initize();});
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [QueenPuzzle.dats] *)

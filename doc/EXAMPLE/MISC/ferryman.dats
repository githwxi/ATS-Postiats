(*
** This is a verified implementation of a solution to the famous
** ferryman puzzle:
**
** A ferryman tries to move a cabbage, a goat and a wolf across
** a river; at the start, F, C, G and W are all on one side of the
** river, and at the finish, they will be all on the other side of
** the river. A correct solution must satisfy the following rules:
**
** F and at most one additional item can ferry across the river at
** one time; C and G cannot be on the same side unless F is also on
** that side; the same also applies to G and W.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: 2012-05-05 // Cinco de Mayo :)
//
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)

absview
STATE0 ( // for all states
  f: bool, c: bool, g: bool, w: bool
) // end of [STATE0]

absview
STATE1 ( // for safe states
  f: bool, c: bool, g: bool, w: bool
) // end of [STATE1]

(* ****** ****** *)

stadef safecond1
  (f: bool, c: bool, g: bool) = (f == c || c != g)
stadef safecond2
  (f: bool, g: bool, w: bool) = (f == g || g != w)

(* ****** ****** *)

extern
praxi
stateTrans01
{
  f,c,g,w:bool
| safecond1 (f, c, g)
; safecond2 (f, g, w)
} (
  pf: !STATE0 (f, c, g, w) >> STATE1 (f, c, g, w)
) : void // end of [stateTrans01]

extern
praxi stateTrans10
  {f,c,g,w:bool} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (f, c, g, w)
) : void // end of [stateTrans10]

(* ****** ****** *)

absvtype F (f:bool) = ptr
absvtype C (c:bool) = ptr
absvtype G (g:bool) = ptr
absvtype W (w:bool) = ptr

(* ****** ****** *)

extern praxi nF (f: F (true)): void
extern praxi nC (f: C (true)): void
extern praxi nG (f: G (true)): void
extern praxi nW (f: W (true)): void

(* ****** ****** *)

fun F (): F (false) = $extval (F (false), "0")
fun C (): C (false) = $extval (C (false), "0")
fun G (): G (false) = $extval (G (false), "0")
fun W (): W (false) = $extval (W (false), "0")

(* ****** ****** *)

extern
fun move_f_ (ptr): void = "mac#move_f"
implement move_f_ (_) = println! ("move_f: ferryman alone")
extern
fun move_fc_ (ptr, ptr): void = "mac#move_fc"
implement move_fc_ (_, _) = println! ("move_fc: ferryman with cabbage")
extern
fun move_fg_ (ptr, ptr): void = "mac#move_fg"
implement move_fg_ (_, _) = println! ("move_fg: ferryman with goat")
extern
fun move_fw_ (ptr, ptr): void = "mac#move_fw"
implement move_fw_ (_, _) = println! ("move_fw: ferryman with wolf")

(* ****** ****** *)

extern
fun move_f
  {f,c,g,w:bool} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (~f, c, g, w)
| f: !F(f) >> F(~f)
) : void = "mac#move_f" // end of [move_f]

extern
fun move_fc
  {f,c,g,w:bool | f == c} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (~f, ~c, g, w)
| f: !F(f) >> F(~f)
, c: !C(c) >> C(~c)
) : void = "mac#move_fc" // end of [move_fc]

extern
fun move_fg
  {f,c,g,w:bool | f == g} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (~f, c, ~g, w)
| f: !F(f) >> F(~f)
, g: !G(g) >> G(~g)
) : void = "mac#move_fg" // end of [move_fg]

extern
fun move_fw
  {f,c,g,w:bool | f == w} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (~f, c, g, ~w)
| f: !F(f) >> F(~f)
, w: !W(w) >> W(~w)
) : void = "mac#move_fw" // end of [move_fw]

(* ****** ****** *)

extern
fun solvePuzzle
(
  pf: !STATE0 (false, false, false, false) >> STATE0 (true, true, true, true)
| f: !F (false) >> F (true)
, c: !C (false) >> C (true)
, g: !G (false) >> G (true)
, w: !W (false) >> W (true)
) : void // end of [solvePuzzle]

(* ****** ****** *)

implement
solvePuzzle
  (pf | f, c, g, w) = let
  prval () = stateTrans01 (pf)
  val () = move_fg (pf | f, g)
  prval () = stateTrans01 (pf)
  val () = move_f (pf | f)
  prval () = stateTrans01 (pf)
  val () = move_fc (pf | f, c)
  prval () = stateTrans01 (pf)
  val () = move_fg (pf | f, g)
  prval () = stateTrans01 (pf)
  val () = move_fw (pf | f, w)
  prval () = stateTrans01 (pf)
  val () = move_f (pf | f)
  prval () = stateTrans01 (pf)
  val () = move_fg (pf | f, g)
in
  // nothing
end // end of [solvePuzzle]

(* ****** ****** *)

implement
main0 () = let
//
val f = F ()
val c = C ()
val g = G ()
val w = W ()
//
prval (
  pf, fpf
) = __assert () where
{
extern
praxi __assert : () -<prf>
  (STATE0 (false, false, false, false), STATE0 (true, true, true, true) -<lin> void)
// end of [extern]
} (* end of [prval] *)
//
val () = solvePuzzle (pf | f, c, g, w)
//
prval () = nF (f)
prval () = nC (c)
prval () = nG (g)
prval () = nW (w)
//
prval () = fpf (pf)
//
in
  // nothing  
end // end of [main0]

(* ****** ****** *)

(* end of [ferryman.dats] *)

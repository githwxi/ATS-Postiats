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
// Author: Hongwei Xi (2012-05-05) // Cinco de Mayo :)
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
stateTrans01 {
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

absvtype F (f:bool)
absvtype C (c:bool)
absvtype G (g:bool)
absvtype W (w:bool)

(* ****** ****** *)

extern
fun move_f
  {f,c,g,w:bool} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (~f, c, g, w)
| f: !F(f) >> F(~f)
) : void // end of [move_f]

extern
fun move_fc
  {f,c,g,w:bool | f == c} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (~f, ~c, g, w)
| f: !F(f) >> F(~f)
, c: !C(c) >> C(~c)
) : void // end of [move_fc]

extern
fun move_fg
  {f,c,g,w:bool | f == g} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (~f, c, ~g, w)
| f: !F(f) >> F(~f)
, g: !G(g) >> G(~g)
) : void // end of [move_fg]

extern
fun move_fw
  {f,c,g,w:bool | f == w} (
  pf: !STATE1 (f, c, g, w) >> STATE0 (~f, c, g, ~w)
| f: !F(f) >> F(~f)
, w: !W(w) >> W(~w)
) : void // end of [move_fw]

(* ****** ****** *)

extern
fun solvePuzzle (
  pf: !STATE0 (
    false, false, false, false
  ) >> STATE0 (true, true, true, true)
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

(* end of [ferryman.dats] *)

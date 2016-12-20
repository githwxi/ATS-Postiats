(*
** Hangman:
** A simple word game
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)
//
#staload"./../GamePlay_single.dats"
//
(* ****** ****** *)
//
assume
state_type = gvhashtbl
//
(* ****** ****** *)
//
extern
fun
state_make_word
  (given: string): state
//
(* ****** ****** *)

implement
state_make_word
(
  given
) = state where
{
//
val
state =
gvhashtbl_make_nil(8)
//
val () =
state["word"] := GVstring(given)
//
val () =
state["bword"] :=
GVptr($UN.cast{ptr}(array0_make_elt(length(given), false)))
//
val () = state["ntime"] := GVint(0)
//
} // end of [state_make_word]

(* ****** ****** *)
//
extern
fun
state_get_word(state): string
extern
fun
state_get_bword(state): array0(bool)
//
(* ****** ****** *)
//
implement
state_get_word(state) =
  GVstring_uncons(state["word"])
implement
state_get_bword(state) =
  $UN.cast(GVptr_uncons(state["bword"]))
//
(* ****** ****** *)
//
extern
fun
state_get_ntime(state): int
extern
fun
state_set_ntime(state, int): void
extern
fun
state_incby_ntime(state, int): void
extern
fun
state_decby_ntime(state, int): void
//
overload .ntime with state_get_ntime
overload .ntime with state_set_ntime
//
implement
state_get_ntime
  (state) =
  GVint_uncons(state["ntime"])
implement
state_set_ntime
  (state, n0) =
  (state["ntime"] := GVint(n0))
implement
state_incby_ntime
  (state, n0) =
  state.ntime(state.ntime() + n0)
implement
state_decby_ntime
  (state, n0) =
  state.ntime(state.ntime() - n0)
//
(* ****** ****** *)
//
#define NTIME 6
//
(* ****** ****** *)
//
fun
word_choose(): string = "camouflage"
//
(* ****** ****** *)
//
implement
{}(*tmp*)
GamePlay$is_over
  (state) =
(
if state.ntime() > 0 then false else true
)
//
(* ****** ****** *)

implement
main0() = () where
{
//
val given = word_choose()
val state = state_make_word(given)
val ((*void*)) = state.ntime(NTIME)
//
val ((*void*)) = GamePlay$main_loop(state)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [hangman_single.dats] *)

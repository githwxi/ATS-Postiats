(*
** Generic single-player game
*)

(* ****** ****** *)
//
staload UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
abstype state_type = ptr
typedef state = state_type
//
absvtype input_vtype = ptr
vtypedef input = input_vtype
//
(* ****** ****** *)
//
extern
fun{}
GamePlay$is_over
(
  state: state
) : bool // GamePlay$is_over
extern
fun{}
GamePlay$do_over
(
  state: state
) : void // GamePlay$do_over
//
(* ****** ****** *)
//
extern
fun{}
GamePlay$main_loop
(
  state: state
) : void // end of [GamePlay$main_loop]
//
(* ****** ****** *)
extern
fun{}
GamePlay$show(state): void
//
extern
fun{}
GamePlay$input(state): input
extern
fun{}
GamePlay$update(state, input): state
//
(* ****** ****** *)
//
implement
{}(*tmp*)
GamePlay$is_over
  (state) = true
//
(* ****** ****** *)
//
implement
{}(*tmp*)
GamePlay$do_over
  (state) = () where
{
//
val () = println!("Game Over!")
//
} (* end of [GamePlay$do_over] *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
GamePlay$show
  (_) = () where
{
//
val () =
prerrln!
(
"GamePlay$show: not-yet-implemented!"
)
//
val () = exit(1){void}
//
} (* end of [GamePlay$show] *)
//
implement
{}(*tmp*)
GamePlay$input
  (_) = res where
{
//
val () =
prerrln!
(
"GamePlay$input: not-yet-implemented!"
) (* prerrln! *)
//
val res = $UN.castvwtp0{input}(exit(1){ptr})
//
} (* end of [GamePlay$input] *)
//
implement
{}(*tmp*)
GamePlay$update
  (_, _) = res where
{
//
val () =
prerrln!("GamePlay$update: not-yet-implemented!")
//
val res = exit(1){state}
//
} (* end of [GamePlay$update] *)
//
(* ****** ****** *)

implement
{}(*tmp*)
GamePlay$main_loop
  (state) =
  loop(state) where
{
//
fun
loop
(
  state: state
) : void = let
//
val
test =
GamePlay$is_over(state)
//
in
//
if
test
then
(
  GamePlay$do_over(state)
) (* end-of-then *)
else loop(state) where
{
//
  val () = GamePlay$show(state)
//
  val input = GamePlay$input(state)
//
  val state = GamePlay$update(state, input)
} (* end-of-else *)
//
end // end of [loop]
//
} (* end of [GamePlay$main_loop] *)
//
(* ****** ****** *)

(* end of [GamePlay_single.dats] *)

(*
** Generic single-player game
*)

(* ****** ****** *)
//
abstype input_type = ptr
abstype state_type = ptr
//
typedef input = input_type
typedef state = state_type
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
//
extern
fun{}
GamePlay$input(state): input
extern
fun{}
GamePlay$update(input, state): state
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
GamePlay$input
  (_) = res where
{
//
val () =
prerrln!("GamePlay$input: not-yet-implemented!")
//
val res = exit(1){input}
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
  val input = GamePlay$input(state)
  val state = GamePlay$update(input, state)
} (* end-of-else *)
//
end // end of [loop]
//
} (* end of [GamePlay$main_loop] *)
//
(* ****** ****** *)

(* end of [GamePlay_single.dats] *)

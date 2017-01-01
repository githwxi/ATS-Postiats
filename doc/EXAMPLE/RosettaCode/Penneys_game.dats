(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: Somewhere in December, 2016
//
(* ****** ****** *)
(*
//
Penney's game is a game where two players bet on being the first to
see a particular sequence of heads or tails in consecutive tosses of a
fair coin.
//
*)
(* ****** ****** *)
(*
//
Task
//
Create a program that tosses the coin, keeps score and plays Penney's
game against a human opponent.
//
Who chooses and shows their sequence of three should be chosen
randomly.  If going first, the computer should randomly choose its
sequence of three.  If going second, the computer should automatically
play the optimum sequence.  Successive coin tosses should be shown.
//                                      
Show output of a game where the computer chooses first and a game
where the user goes first here on this page.
//
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
#include
"share/HATS/atslib_staload_libats_libc.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
extern
fun{
a,b:t@ype
} stream_prefix_test
(
xs: stream(a), ys: list0(b), test: (a, b) -<cloref1> bool
) : stream_vt(bool)
//
(* ****** ****** *)

implement
{a,b}
stream_prefix_test
(
  xs0, ys0, test
) = auxmain(xs0) where
{
//
fun
auxmain
(
  xs:stream(a)
) : stream_vt(bool) = $ldelay
(
case+ !xs of
| stream_nil() =>
  stream_vt_nil()
| stream_cons(x1, xs2) =>
  stream_vt_cons(auxtest(xs, ys0), auxmain(xs2))
)
//
and
auxtest
(
xs:stream(a), ys:list0(b)
) : bool =
(
case+ ys of
| list0_nil() => true
| list0_cons(y, ys) =>
  (
    case+ !xs of
    | stream_nil() => false
    | stream_cons(x, xs) =>
        if test(x, y) then auxtest(xs, ys) else false
      // end of [stream_cons]
  )
) (* end of [auxtest] *)
//
} (* end of [stream_prefix_test] *)

(* ****** ****** *)

extern
fun
Penneys_game
(
  dice: stream(natLt(2))
, key0: string, key2: string
) : (intGte(0), natLt(2))

(* ****** ****** *)

implement
Penneys_game
  (xs, k0, k1) = let
//
val ys0 = string_explode(k0)
val ys1 = string_explode(k1)
//
val bs0 = stream_prefix_test<natLt(2),char>(xs, ys0, lam(x, y) => if x = 0 then (y = 'H') else (y = 'T'))
val bs1 = stream_prefix_test<natLt(2),char>(xs, ys1, lam(x, y) => if x = 0 then (y = 'H') else (y = 'T'))
//
fun
loop
(
n: intGte(0)
,
bs0:
stream_vt(bool)
,
bs1:
stream_vt(bool)
) :
(
intGte(0), natLt(2)
) = let
//
val-~stream_vt_cons(b0, bs0) = !bs0
val-~stream_vt_cons(b1, bs1) = !bs1
//
in
  if b0
    then (~bs0; ~bs1; @(n, 0))
    else (if b1 then (~bs0; ~bs1; @(n, 1)) else loop(n+1, bs0, bs1))
  // end of [if]
end // end of [loop]
//
in
  loop(0, bs0, bs1)
end // end of [Penneys_game]
//
(* ****** ****** *)

implement
main0(argc, argv) = let
//
val () =
$STDLIB.srandom
(
$UN.cast{uint}($TIME.time_get())
) (* $STDLIB.srandom *)
//
val dice =
  streamize_randint(2)
//
val dice = stream_vt2t(dice)
//
val key0 =
  (if argc >= 2 then argv[1] else ""): string
val key1 =
  (if argc >= 3 then argv[2] else ""): string
//
val (ntime, winner) = Penneys_game(dice, key0, key1)
//
val () =
fprint_stream<int>
(
  stdout_ref
, dice, ntime+sz2i(string0_length(if(winner=0)then(key0)else(key1)))
) (* fprint_stream *)
//
val () = fprint_newline(stdout_ref)
//
in
  println!("The winner is player(", winner, ")")
end (* end of [main0] *)
//
(* ****** ****** *)

(* end of [Penneys_game.dats] *)

(* ****** ****** *)
//
// Trying libatscc2py3/PYgame
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Starting time: May 23, 2016
//
(* ****** ****** *)
//
#include"./../../staloadall.hats"
//
(* ****** ****** *)
//
staload "./../../SATS/PYGAME/pygame.sats"
//
(* ****** ****** *)
//
extern
fun
test01_main
(
// argless
) : void = "mac#"
//
implement
test01_main() =
{
//
val npnf = pygame_init_ret()
val ((*void*)) = println! ("np = ", npnf.0)
val ((*void*)) = println! ("nf = ", npnf.1)
//
val res = $tup(500,500)
val screen = display_set_mode(res)
val _(*Rect*) = screen.fill(Color(0, 0, 0))
//
val screen2 = Surface(screen.get_size(), SRCALPHA, 32)
//
(*
val () = println! ("screen2_width = ", screen2.get_width())
val () = println! ("screen2_height = ", screen2.get_height())
*)
//
val c1 = Color(200, 200, 200)
//
val r0 = Rect(100, 100, 300, 300)
//
val _rect_ = screen2.fill(c1, r0, 0)
//
val _rect_ =
  draw_circle(screen2, Color(0,0,0), $tup(250,250), 100)
//
val _rect_ =
  screen.blit(screen2, $tup(0, 0))
//
val ((*void*)) = display_flip((*void*))
//
val () = loop() where
{
  fun
  loop(): void = let
    val e = event_wait()
    val t = e.type()
  in
    ifcase
      | t = QUIT => ()
      | t = KEYDOWN => ()
      | _(*else*) => loop()
  end // end of [loop]
}
//
val ((*void*)) = pygame_quit((*void*))
//
} (* end of [test01_main] *)
//
(* ****** ****** *)

%{^
######
from libatscc2py3_all import *
######
from ats2py_pygame_pyame_cats import *
######
sys.setrecursionlimit(1000000)
######
%} // end of [%{^]

(* ****** ****** *)

%{$
if __name__ == '__main__': test01_main()
%} // end of [%{$]

(* ****** ****** *)

(* end of [test01.dats] *)

(*
** Testing the ATS API for SDL2
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/SDL.sats"

(* ****** ****** *)

#define NULL the_null_ptr

(* ****** ****** *)

implement
main0 () = () where
{
//
val err = SDL_Init (SDL_INIT_VIDEO)
val ((*void*)) = assertloc (err >= 0)
//
val xpos = SDL_WINDOWPOS_UNDEFINED
val ypos = SDL_WINDOWPOS_UNDEFINED
val window =
SDL_CreateWindow ("SDL2/test01", xpos, ypos, 640, 480, SDL_WINDOW_SHOWN)
val () = assertloc (ptrcast(window) > 0)
//
val (fpf | screen) = SDL_GetWindowSurface (window)
val ((*void*)) = assertloc (ptrcast(screen) > 0)
//
val image = SDL_LoadBMP ("DATA/hello_world.bmp")
val ((*void*)) = assertloc (ptrcast(image) > 0)
val err =
SDL_BlitSurface(image, $UN.cptrof_ptr(NULL), screen, $UN.cptrof_ptr(NULL))
val () = SDL_FreeSurface (image)
//
prval ((*void*)) = fpf (screen)
//
val err = SDL_UpdateWindowSurface (window)
//
val () = SDL_Delay (Uint32(2000))
//
val () = SDL_DestroyWindow (window)
//
val () = SDL_Quit ((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(*
int main(int argc, char* argv[])
{
    SDL_Surface *screen; // even with SDL2, we can still bring ancient code back
    SDL_Window *window;
    SDL_Surface *image;

    SDL_Init(SDL_INIT_VIDEO); // init video

    // create the window like normal
    window =
    SDL_CreateWindow
    (
      "SDL2 Example", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, SDL_WINDOW_SHOWN
    ) ;

    // but instead of creating a renderer, we can draw directly to the screen
    screen = SDL_GetWindowSurface(window);

    // let's just show some classic code for reference
    image = SDL_LoadBMP("box.bmp"); // loads image
    SDL_BlitSurface(image, NULL, screen, NULL); // blit it to the screen
    SDL_FreeSurface(image);

    // this works just like SDL_Flip
    SDL_UpdateWindowSurface(window);

    // show image for 2 seconds
    SDL_Delay(2000);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
*)

(* ****** ****** *)

(* end of [test01.dats] *)

/* ****** ****** */
//
// API in ATS for SDL2
//
/* ****** ****** */

/*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

/* ****** ****** */

/*
** Author: Hongwei Xi
** Authoremail: gmhwxiDOTgmailDOTcom
*/

/* ****** ****** */

#ifndef SDL2_SDL_CATS
#define SDL2_SDL_CATS

/* ****** ****** */

#include <SDL.h>

/* ****** ****** */

#include \
"atscntrb-libsdl2/CATS/SDL_error.cats"
#include \
"atscntrb-libsdl2/CATS/SDL_events.cats"
#include \
"atscntrb-libsdl2/CATS/SDL_render.cats"
#include \
"atscntrb-libsdl2/CATS/SDL_rwops.cats"
#include \
"atscntrb-libsdl2/CATS/SDL_surface.cats"
#include \
"atscntrb-libsdl2/CATS/SDL_timer.cats"
#include \
"atscntrb-libsdl2/CATS/SDL_version.cats"
#include \
"atscntrb-libsdl2/CATS/SDL_video.cats"

/* ****** ****** */

#define \
atscntrb_SDL2_SDL_Init SDL_Init
#define \
atscntrb_SDL2_SDL_InitSubSystem SDL_InitSubSystem

/* ****** ****** */
//
#define atscntrb_SDL2_SDL_WasInit SDL_WasInit
//
/* ****** ****** */

#define \
atscntrb_SDL2_SDL_Quit SDL_Quit
#define \
atscntrb_SDL2_SDL_QuitSubSystem SDL_QuitSubSystem

/* ****** ****** */

#endif // ifndef SDL2_SDL_CATS

/* ****** ****** */

/* end of [SDL.cats] */

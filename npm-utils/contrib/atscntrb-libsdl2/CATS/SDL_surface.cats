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

#ifndef SDL2_SDL_SURFACE_CATS
#define SDL2_SDL_SURFACE_CATS

/* ****** ****** */

#define \
atscntrb_SDL2_SDL_CreateSurface SDL_CreateSurface
#define \
atscntrb_SDL2_SDL_CreateSurfaceFrom SDL_CreateSurfaceFrom
#define atscntrb_SDL2_SDL_FreeSurface SDL_FreeSurface

/* ****** ****** */

#define atscntrb_SDL2_SDL_LoadBMP SDL_LoadBMP
#define atscntrb_SDL2_SDL_SaveBMP SDL_SaveBMP

/* ****** ****** */

#define atscntrb_SDL2_SDL_SetSurfaceColorMod SDL_SetSurfaceColorMod
#define atscntrb_SDL2_SDL_GetSurfaceColorMod SDL_GetSurfaceColorMod

/* ****** ****** */

#define atscntrb_SDL2_SDL_UpperBlit SDL_UpperBlit
#define atscntrb_SDL2_SDL_UpperBlit2 SDL2_SDL_UpperBlit

/* ****** ****** */

#endif // ifndef SDL2_SDL_SURFACE_CATS

/* end of [SDL_surface.cats] */

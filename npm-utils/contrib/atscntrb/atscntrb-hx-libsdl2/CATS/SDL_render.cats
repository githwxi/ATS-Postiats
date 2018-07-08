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

#ifndef SDL2_SDL_RENDER_CATS
#define SDL2_SDL_RENDER_CATS

/* ****** ****** */

#define \
atscntrb_SDL2_SDL_GetNumRenderDrivers SDL_GetNumRenderDrivers
#define \
atscntrb_SDL2_SDL_GetRenderDriverInfo SDL_GetRenderDriverInfo

/* ****** ****** */

#define atscntrb_SDL2_SDL_CreateRenderer SDL_CreateRenderer
#define \
atscntrb_SDL2_SDL_CreateSoftwareRenderer CreateSoftwareRenderer

/* ****** ****** */

#define atscntrb_SDL2_SDL_DestroyRenderer SDL_DestroyRenderer

/* ****** ****** */

#define atscntrb_SDL2_SDL_GetRenderer SDL_GetRenderer

/* ****** ****** */

#define atscntrb_SDL2_SDL_GetRendererInfo SDL_GetRendererInfo
#define \
atscntrb_SDL2_SDL_GetRendererOutputSize SDL_GetRendererOutputSize

/* ****** ****** */

#define atscntrb_SDL2_SDL_CreateTexture SDL_CreateTexture
#define \
atscntrb_SDL2_SDL_CreateTextureFromSurface SDL_CreateTextureFromSurface

/* ****** ****** */

#define atscntrb_SDL2_SDL_DestroyTexture SDL_DestroyTexture

/* ****** ****** */

#define atscntrb_SDL2_SDL_QueryTexture SDL_QueryTexture

/* ****** ****** */

#define atscntrb_SDL2_SDL_SetTextureColorMod SDL_SetTextureColorMod
#define atscntrb_SDL2_SDL_GetTextureColorMod SDL_GetTextureColorMod

/* ****** ****** */

#define atscntrb_SDL2_SDL_SetTextureAlphaMod SDL_SetTextureAlphaMod
#define atscntrb_SDL2_SDL_GetTextureAlphaMod SDL_GetTextureAlphaMod

/* ****** ****** */

#define atscntrb_SDL2_SDL_SetRenderDrawColor SDL_SetRenderDrawColor
#define atscntrb_SDL2_SDL_GetRenderDrawColor SDL_GetRenderDrawColor

/* ****** ****** */

#define atscntrb_SDL2_SDL_RenderClear SDL_RenderClear

/* ****** ****** */

#define atscntrb_SDL2_SDL_RenderPresent SDL_RenderPresent

/* ****** ****** */

#endif // ifndef SDL2_SDL_RENDER_CATS

/* end of [SDL_render.cats] */

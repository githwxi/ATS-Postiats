/* ****** ****** */
//
// API in ATS for SDL2_image
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

#ifndef SDL2IMG_IMAGE_CATS
#define SDL2IMG_IMAGE_CATS

/* ****** ****** */

#include <SDL_image.h>

/* ****** ****** */

#define atscntrb_SDL2IMG_IMG_Load IMG_Load

/* ****** ****** */

#define atscntrb_SDL2IMG_IMG_Load_RW(src) IMG_Load_RW(src, 0)
#define atscntrb_SDL2IMG_IMG_Load_RW_free(src) IMG_Load_RW(src, 1)

/* ****** ****** */

#define atscntrb_SDL2IMG_IMG_LoadTyped_RW(src) IMG_LoadTyped_RW(src, 0)
#define atscntrb_SDL2IMG_IMG_LoadTyped_RW_free(src) IMG_LoadTyped_RW(src, 1)

/* ****** ****** */

#define atscntrb_SDL2IMG_IMG_isICO IMG_isICO
#define atscntrb_SDL2IMG_IMG_isCUR IMG_isCUR
#define atscntrb_SDL2IMG_IMG_isBMP IMG_isBMP
#define atscntrb_SDL2IMG_IMG_isGIF IMG_isGIF
#define atscntrb_SDL2IMG_IMG_isJPG IMG_isJPG
#define atscntrb_SDL2IMG_IMG_isLBM IMG_isLBM
#define atscntrb_SDL2IMG_IMG_isPCX IMG_isPCX
#define atscntrb_SDL2IMG_IMG_isPNG IMG_isPNG
#define atscntrb_SDL2IMG_IMG_isPNM IMG_isPNM
#define atscntrb_SDL2IMG_IMG_isTIF IMG_isTIF
#define atscntrb_SDL2IMG_IMG_isXCF IMG_isXCF
#define atscntrb_SDL2IMG_IMG_isXPM IMG_isXPM
#define atscntrb_SDL2IMG_IMG_isXV IMG_isXV 
#define atscntrb_SDL2IMG_IMG_isWEBP IMG_isWEBP
  
/* ****** ****** */

#define atscntrb_SDL2IMG_IMG_LoadICO_RW IMG_LoadICO_RW
#define atscntrb_SDL2IMG_IMG_LoadCUR_RW IMG_LoadCUR_RW
#define atscntrb_SDL2IMG_IMG_LoadBMP_RW IMG_LoadBMP_RW
#define atscntrb_SDL2IMG_IMG_LoadGIF_RW IMG_LoadGIF_RW
#define atscntrb_SDL2IMG_IMG_LoadJPG_RW IMG_LoadJPG_RW
#define atscntrb_SDL2IMG_IMG_LoadLBM_RW IMG_LoadLBM_RW
#define atscntrb_SDL2IMG_IMG_LoadPCX_RW IMG_LoadPCX_RW
#define atscntrb_SDL2IMG_IMG_LoadPNG_RW IMG_LoadPNG_RW
#define atscntrb_SDL2IMG_IMG_LoadPNM_RW IMG_LoadPNM_RW
#define atscntrb_SDL2IMG_IMG_LoadTGA_RW IMG_LoadTGA_RW
#define atscntrb_SDL2IMG_IMG_LoadTIF_RW IMG_LoadTIF_RW
#define atscntrb_SDL2IMG_IMG_LoadXCF_RW IMG_LoadXCF_RW
#define atscntrb_SDL2IMG_IMG_LoadXPM_RW IMG_LoadXPM_RW
#define atscntrb_SDL2IMG_IMG_LoadXV_RW IMG_LoadXV_RW
#define atscntrb_SDL2IMG_IMG_LoadWEBP_RW IMG_LoadWEBP_RW

/* ****** ****** */

#define atscntrb_SDL2IMG_IMG_SavePNG IMG_SavePNG
#define atscntrb_SDL2IMG_IMG_SavePNG_RW(sf, dst) IMG_SavePNG_RW(sf, dst, 0)
#define atscntrb_SDL2IMG_IMG_SavePNG_RW_free(sf, dst) IMG_SavePNG_RW(sf, dst, 1)

/* ****** ****** */

#endif // ifndef SDL2IMG_IMAGE_CATS

/* end of [SDL_image.cats] */

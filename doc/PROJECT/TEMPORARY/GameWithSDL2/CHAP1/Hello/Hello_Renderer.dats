(*
** Game Development with SDL2
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "{$SDL2}/SATS/SDL.sats"

(* ****** ****** *)

local
//
vtypedef
objptr(l:addr) = SDL_Renderer_ptr(l)
//
in (* in of [local] *)

#include "{$LIBATSHWXI}/globals/HATS/gobjptr.hats"

end // end of [local]

(* ****** ****** *)

(* end of [Hello_Renderer.dats] *)

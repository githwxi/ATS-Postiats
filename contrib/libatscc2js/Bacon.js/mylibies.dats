(* ****** ****** *)
(*
** HX-2017-01-30:
** For downstream static loading
*)
(* ****** ****** *)
//
#ifdef
LIBATSCC2JS_BACONJS_NONE
#then
#else
local
#include "./DATS/baconjs.dats"
in (* nothing *) end // end of [local]
#endif // #ifdef(LIBATSCC2JS_BACONJS_NONE)
//
(* ****** ****** *)
//
#ifdef
LIBATSCC2JS_BACONJS_EXT_NONE
#then
#else
local
#include "./DATS/baconjs_ext.dats"
in (* nothing *) end // end of [local]
#endif // #ifdef(LIBATSCC2JS_BACONJS_EXT_NONE)
//
(* ****** ****** *)

(* end of [mylibies.dats] *)

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

local
//
typedef T = bool
//
fun initize (x: &T? >> T): void = x := false
//
in (* in of [local] *)

#include "{$LIBATSHWXI}/globals/HATS/globvar.hats"

end // end of [local]

(* ****** ****** *)

(* end of [Hello_isRunning.dats] *)

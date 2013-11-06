(*
** Bug in handling
** arrays in structs
*)
(*
** Source: reported by Will Blair
*)

(* ****** ****** *)

(*
** Status: Fixed by HX-2013-11-01
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
typedef
struct { double xy[2]; } point_t;
%}

typedef
point =
$extype_struct "point_t" of { xy= @[double][2] }

(* ****** ****** *)

fun point_get_x (pt: point): double = pt.xy.[0]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2013-11-01.dats] *)

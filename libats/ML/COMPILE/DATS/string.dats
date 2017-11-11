(* ****** ****** *)
//
// HX-2017-10-28:
// For supporting
// "unityped" programming
//
(* ****** ****** *)
//
(*
#define
ATS_DYNLOADFLAG 1
*)
#define
ATS_PACKNAME
"ATSLIB.libats.ML.COMPILE"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)
//
#staload
"libats/ML/SATS/string.sats"
#staload _(*anon*) =
"libats/ML/DATS/string.dats"
//
(* ****** ****** *)
//
// HX: Interface
//
(* ****** ****** *)
//
extern
fun
string_tolower(string): string
and
string_toupper(string): string
//
overload tolower with string_tolower
overload toupper with string_toupper
//
(* ****** ****** *)
//
// HX: Implementation
//
(* ****** ****** *)

implement
string_tolower
(cs) =
string_copywith
( cs
, lam(c) =>
  $UN.cast{charNZ}(tolower(c))
) (* end of [string_tolower] *)

(* ****** ****** *)

implement
string_toupper
(cs) =
string_copywith
( cs
, lam(c) =>
  $UN.cast{charNZ}(toupper(c))
) (* end of [string_toupper] *)

(* ****** ****** *)

(* end of [string.dats] *)

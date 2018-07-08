(*
** For writing ATS code
** that translates into Javascript
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_string_"
//
(* ****** ****** *)
//
#staload "./../basics_js.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/char.sats"
#staload "./../SATS/integer.sats"
//
//
(* ****** ****** *)
//
implement
char_isalpha(c0) =
(
  ifcase
    | (65(*A*) <= c0 && c0 <= 90(*Z*)) => true
    | (97(*a*) <= c0 && c0 <= 122(*z*)) => true
    | _(*else*) => false
  // end of [ifcase]
) (* end of [char_isalpha] *)
//
(* ****** ****** *)
//
implement
char_isalnum(c0) =
(
  ifcase
    | (48(*0*) <= c0 && c0 <= 57(*9*)) => true
    | (65(*A*) <= c0 && c0 <= 90(*Z*)) => true
    | (97(*a*) <= c0 && c0 <= 122(*z*)) => true
    | _(*else*) => false
  // end of [ifcase]
) (* end of [char_isalnum] *)
//
(* ****** ****** *)
//
implement
char_isdigit(c0) =
(
  ifcase
    | (48(*0*) <= c0 && c0 <= 57(*9*)) => true
    | _(*else*) => false
  // end of [ifcase]
) (* end of [char_isdigit] *)
//
(* ****** ****** *)

implement
char_isspace(c0) =
(
  ifcase
    | c0 = 9(*\t*) => true
    | c0 = 10(*\n*) => true
    | c0 = 11(*\v*) => true
    | c0 = 12(*\f*) => true
    | c0 = 13(*\r*) => true
    | c0 = 32(*' '*) => true
    | _(*else*) => false
  // end of [ifcase]
) (* end of [char_isspace] *)
//
(* ****** ****** *)

(* end of [char.dats] *)

(*
//
// Various utilities
//
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

#define ATS_EXTERN_PREFIX "atslangweb__"

(* ****** ****** *)
//
#include
"{$LIBATSCC2PHP}/staloadall.hats"
//
(* ****** ****** *)
//
staload "./../SATS/atslangweb.sats"
//
(* ****** ****** *)
//
staload _(*anon*) = "./patsopt_tcats.dats"
//
(* ****** ****** *)
//
implement
patsopt_command<> () = "patsopt"
//
(* ****** ****** *)
//
extern
fun
patsopt_tcats_code_0_
  (code: string): compres = "mac#%"
//
implement
patsopt_tcats_code_0_ (code) = patsopt_tcats_code<> (code)
//
(* ****** ****** *)
//
extern
fun
patsopt_tcats_code_1_
  (code: string): compres = "mac#%"
//
implement
patsopt_tcats_code_1_
  (code) = let
//
val preamble =
  $extval(string, "$GLOBALS['atslangweb__patsopt_code_preamble']")
val postamble =
  $extval(string, "$GLOBALS['atslangweb__patsopt_code_postamble']")
//
val code2 =
  $extfcall(string, "sprintf", "%s\n%s\n%s\n", preamble, code, postamble)
//
(*
val () = println! ("code2 = ", code2)
*)
//
in
  patsopt_tcats_code_0_(code2)
end // end of [patsopt_tcats_code_1_]

(* ****** ****** *)

(* end of [atslangweb_utils.dats] *)

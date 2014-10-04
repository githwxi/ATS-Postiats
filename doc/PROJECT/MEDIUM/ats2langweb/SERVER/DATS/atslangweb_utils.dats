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

#define ATS_EXTERN_PREFIX "atslangweb_"

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
staload _(*anon*) = "./pats2xhtml.dats"
//
staload _(*anon*) = "./patsopt_tcats.dats"
staload _(*anon*) = "./patsopt_ccats.dats"
//
staload _(*anon*) = "./atscc2js_comp.dats"
//
(* ****** ****** *)
//
implement
{}(*tmp*)
pats2xhtml_command
  ((*void*)) = "pats2xhtml"
//
(* ****** ****** *)
//
implement
{}(*tmp*)
patsopt_command () = "patsopt"
//
(*
implement
patsopt_command<> () = let
  val PATSHOME =
    getenv("PATSHOME") where
  {
    extern fun getenv : string -> string = "mac#"
  } (* end of [val] *)
in
  if $UN.cast{bool}(PATSHOME) then PATSHOME . "/bin/patsopt" else "patsopt"
end // end of [patsopt_command]
*)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
atscc2js_command () = "atscc2js"
//
(* ****** ****** *)
//
extern
fun
pats2xhtml_static_code_0_
  (code: string): compres = "mac#%"
extern
fun
pats2xhtml_dynamic_code_0_
  (code: string): compres = "mac#%"
//
(* ****** ****** *)
//
implement
pats2xhtml_static_code_0_ (code) =
(
  pats2xhtml_comp_code<> (0(*stadyn*), code)
) (* end of [pats2xhtml_static_code_0_] *)
//
implement
pats2xhtml_dynamic_code_0_ (code) =
(
  pats2xhtml_comp_code<> (1(*stadyn*), code)
) (* end of [pats2xhtml_dynamic_code_0_] *)
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
  $extval(string, "$GLOBALS['atslangweb_patsopt_tcats_preamble']")
val postamble =
  $extval(string, "$GLOBALS['atslangweb_patsopt_tcats_postamble']")
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
//
extern
fun
patsopt_ccats_code_0_
  (code: string): compres = "mac#%"
//
implement
patsopt_ccats_code_0_ (code) = patsopt_ccats_code<> (code)
//
(* ****** ****** *)
//
extern
fun
patsopt_ccats_code_1_
  (code: string): compres = "mac#%"
//
implement
patsopt_ccats_code_1_
  (code) = let
//
val preamble =
  $extval(string, "$GLOBALS['atslangweb_patsopt_ccats_preamble']")
val postamble =
  $extval(string, "$GLOBALS['atslangweb_patsopt_ccats_postamble']")
//
val code2 =
  $extfcall(string, "sprintf", "%s\n%s\n%s\n", preamble, code, postamble)
//
(*
val () = println! ("code2 = ", code2)
*)
//
in
  patsopt_ccats_code_0_(code2)
end // end of [patsopt_ccats_code_1_]

(* ****** ****** *)
//
extern
fun
patsopt_atscc2js_code_0_
  (code: string): compres = "mac#%"
//
implement
patsopt_atscc2js_code_0_ (code) = let
//
implement
patsopt_ccats_cont<> (fname) = atscc2js_comp_file<> (fname)
//
in
  patsopt_ccats_code<> (code)
end // end of [patsopt_atscc2js_code_0_]
//
(* ****** ****** *)
//
extern
fun
patsopt_atscc2js_code_1_
  (code: string): compres = "mac#%"
//
implement
patsopt_atscc2js_code_1_
  (code) = let
//
val preamble =
  $extval(string, "$GLOBALS['atslangweb_patsopt_atscc2js_preamble']")
val postamble =
  $extval(string, "$GLOBALS['atslangweb_patsopt_atscc2js_postamble']")
//
val code2 =
  $extfcall(string, "sprintf", "%s\n%s\n%s\n", preamble, code, postamble)
//
(*
val () = println! ("code2 = ", code2)
*)
//
in
  patsopt_atscc2js_code_0_(code2)
end // end of [patsopt_ccats_code_1_]

(* ****** ****** *)

(* end of [atslangweb_utils.dats] *)

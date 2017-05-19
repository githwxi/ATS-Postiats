(* ****** ****** *)

(*
//
// Utilities for atslangweb
//
*)

(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

#define ATS_EXTERN_PREFIX "atslangweb_"

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define
LIBATSCC2PHP_targetloc
"$PATSHOME\
/contrib/libatscc2php/ATS2-0.3.2"
//
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
staload
_(*anon*) = "./patsopt_tcats.dats"
staload
_(*anon*) = "./patsopt_ccats.dats"
//
staload _(*anon*) = "./atscc2js_comp.dats"
//
staload _(*anon*) = "./pats2xhtml_eval.dats"
//
(* ****** ****** *)
//
implement
{}(*tmp*)
patsopt_command
  ((*void*)) = "patsopt"
//
(*
implement
patsopt_command<>
(
// argumentless
) = let
//
val
PATSHOME =
getenv("PATSHOME") where
{
  extern fun getenv : string -> string = "mac#"
} (* end of [val] *)
//
in
//
if
$UN.cast{bool}(PATSHOME)
  then PATSHOME + "/bin/patsopt" else "patsopt"
//
end // end of [patsopt_command]
*)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
atscc2js_command() = "atscc2js"
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
extern
fun
patsopt_tcats_code_0_
  (code: string): compres = "mac#%"
extern
fun
patsopt_tcats_code_1_
  (code: string): compres = "mac#%"
//
(* ****** ****** *)
//
implement
patsopt_tcats_code_0_
  (code) =
(
  patsopt_tcats_code<>(1(*dyn*), code)
) (* patsopt_tcats_code_0_ *)
//
(* ****** ****** *)
//
implement
patsopt_tcats_code_1_(code) = let
//
val
preamble =
$extval (
  string
, "$GLOBALS['atslangweb_patsopt_tcats_preamble']"
) (* $extval *)
val
postamble =
$extval (
  string
, "$GLOBALS['atslangweb_patsopt_tcats_postamble']"
) (* $extval *)
//
val
code2 =
$extfcall (
  string
, "sprintf", "%s\n%s\n%s\n", preamble, code, postamble
) (* $extfcall *)
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
extern
fun
patsopt_ccats_code_1_
  (code: string): compres = "mac#%"
//
(* ****** ****** *)
//
implement
patsopt_ccats_code_0_
  (code) =
  patsopt_ccats_code<> (1(*dyn*), code)
//
(* ****** ****** *)
//
implement
patsopt_ccats_code_1_(code) = let
//
val
preamble =
$extval (
  string
, "$GLOBALS['atslangweb_patsopt_ccats_preamble']"
) (* $extval *)
val
postamble =
$extval (
  string
, "$GLOBALS['atslangweb_patsopt_ccats_postamble']"
) (* $extval *)
//
val
code2 =
$extfcall (
  string
, "sprintf", "%s\n%s\n%s\n", preamble, code, postamble
) (* $extfcall *)
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
extern
fun
patsopt_atscc2js_code_1_
  (code: string): compres = "mac#%"
//
(* ****** ****** *)
//
implement
patsopt_atscc2js_code_0_
  (code) = let
//
implement
patsopt_ccats_cont<>
  (fname) = atscc2js_comp_file<>(fname)
//
in
  patsopt_ccats_code<> (1(*dyn*), code)
end // end of [patsopt_atscc2js_code_0_]
//
(* ****** ****** *)
//
implement
patsopt_atscc2js_code_1_
  (code) = let
//
val
preamble =
$extval (
  string
, "$GLOBALS['atslangweb_patsopt_atscc2js_preamble']"
) (* $extval *)
val
postamble =
$extval (
  string
, "$GLOBALS['atslangweb_patsopt_atscc2js_postamble']"
) (* $extval *)
//
val
code2 =
$extfcall (
  string
, "sprintf", "%s\n%s\n%s\n", preamble, code, postamble
) (* $extfcall *)
//
(*
val () = println!("code2 = ", code2)
*)
//
in
  patsopt_atscc2js_code_0_(code2)
end // end of [patsopt_ccats_code_1_]

(* ****** ****** *)
//
extern
fun
pats2xhtml_eval_code_0_
(
  flag: int(*stadyn*), code: string
) : compres = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
implement
pats2xhtml_eval_code_0_
  (stadyn, code) =
(
  pats2xhtml_eval_code<> (stadyn, code)
) (* end of [pats2xhtml_eval_code_0_] *)
//
(* ****** ****** *)

(* end of [atslangweb_utils.dats] *)

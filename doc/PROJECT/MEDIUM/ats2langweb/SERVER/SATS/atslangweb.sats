(*
//
// For server-side actions
//
*)

(* ****** ****** *)
//
#define ATS_PACKNAME "atslangweb"
#define ATS_EXTERN_PREFIX "atslangweb_"
//
(* ****** ****** *)
//
// HX: implemented in CATS/basics_cats.php
//
fun fname_dats_c (fname: string): string = "mac#%"
fun fname_dats_js (fname: string): string = "mac#%"
fun fname_dats_php (fname: string): string = "mac#%"
//
(* ****** ****** *)
//
fun exec_retval (command: string): int(*ret*) = "mac#%"
//
(* ****** ****** *)
//
absvtype tmpfile
//
fun tmpfile_unlink (tmpfile): bool
//
fun tmpfile2string (fname: !tmpfile): string
//
fun tmpfile_make_nil (pfx: string): tmpfile
fun tmpfile_make_string (pfx: string, content: string): tmpfile
//
(* ****** ****** *)
//
datatype compres =
//
// HX-2014-09:
// the order must be maintained!!!
//
  | COMPRES0_succ of (string(*target*)) // success
  | COMPRES1_fail of (string(*target*)) // failure1
  | COMPRES2_fail of (string(*source*), string(*errmsg*)) // failure2
//
(* ****** ****** *)
//
fun{}
pats2xhtml_command (): string
fun{}
pats2xhtml_comp_command
(
  stadyn: int
, !tmpfile(*inp*), !tmpfile(*out*), !tmpfile(*stderr*)
) : string // end of [pats2xhtml_comp_command]
//
fun{}
pats2xhtml_comp_code (stadyn: int, code: string): compres
fun{}
pats2xhtml_comp_file (stadyn: int, fname: !tmpfile): compres
//
(* ****** ****** *)
//
fun{}
patsopt_command (): string
//
fun{}
patsopt_tcats_command
  (!tmpfile(*inp*), !tmpfile(*stderr*)): string
fun{}
patsopt_ccats_command
  (!tmpfile(*inp*), !tmpfile(*out*), !tmpfile(*stderr*)): string
//
(* ****** ****** *)
//
fun{}
patsopt_tcats_code (ptext: string): compres
fun{}
patsopt_tcats_file (fname: !tmpfile): compres
//
(* ****** ****** *)
//
// HX-2014-09-20:
// this one may be re-implemented to process
// the output from [patsopt-ccats]
//
fun{}
patsopt_ccats_cont (fname: !tmpfile): compres
//
fun{}
patsopt_ccats_code (ptext: string): compres
fun{}
patsopt_ccats_file (fname: !tmpfile): compres
//
(* ****** ****** *)
//
fun{}
atscc2js_command (): string
//
fun{}
atscc2js_comp_command
(
  !tmpfile(*inp*), !tmpfile(*out*), !tmpfile(*stderr*)
) : string // end of [atscc2js_comp_command]
//
(* ****** ****** *)
//
fun{}
atscc2js_comp_file (fname: !tmpfile): compres
//
(* ****** ****** *)

(* end of [atslangweb.sats] *)

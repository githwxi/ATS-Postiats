(* ****** ****** *)
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
fun fname_dats_c(fname: string): string = "mac#%"
fun fname_dats_js(fname: string): string = "mac#%"
fun fname_dats_php(fname: string): string = "mac#%"
//
(* ****** ****** *)
//
fun exec_retval(command: string): int(*ret*) = "mac#%"
//
(* ****** ****** *)
//
absvtype
tmpfile_vtype
vtypedef
tmpfile = tmpfile_vtype
//
fun tmpfile_unlink(tmpfile): bool
//
fun tmpfile2string(fname: !tmpfile): string
//
fun tmpfile_make_nil(pfx: string): tmpfile
fun tmpfile_make_string(pfx: string, content: string): tmpfile
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
patsopt_command(): string
//
fun{}
patsopt_tcats_command
(
  stadyn: int
, !tmpfile(*inp*), !tmpfile(*stderr*)
) : string // end-of-function
fun{}
patsopt_ccats_command
(
  stadyn: int
, !tmpfile(*inp*), !tmpfile(*out*), !tmpfile(*stderr*)
) : string // end-of-function
//
(* ****** ****** *)
//
fun{}
patsopt_tcats_code
  (stadyn: int, ptext: string): compres
fun{}
patsopt_tcats_file
  (stadyn: int, fname: !tmpfile): compres
//
(* ****** ****** *)
//
// HX-2014-09-20:
// this one may be re-implemented to process
// the output from [patsopt-ccats]
//
fun{}
patsopt_ccats_cont
  (fname: !tmpfile): compres
//
fun{}
patsopt_ccats_code
  (stadyn: int, ptext: string): compres
fun{}
patsopt_ccats_file
  (stadyn: int, fname: !tmpfile): compres
//
(* ****** ****** *)
//
fun{}
atscc2js_command(): string
//
fun{}
atscc2js_comp_command
(
  inp: !tmpfile
, out: !tmpfile, err: !tmpfile(*stderr*)
) : string // end of [atscc2js_comp_command]
//
fun{}
atscc2js_comp_file(fname: !tmpfile): compres
//
(* ****** ****** *)
//
fun{}
pats2xhtml_command
  ((*void*)): string
//
fun{}
pats2xhtml_eval_command
(
  stadyn: int
, !tmpfile(*inp*)
, !tmpfile(*out*), !tmpfile(*stderr*)
) : string // end of [pats2xhtml_eval_command]
//
fun{}
pats2xhtml_eval_code
  (stadyn: int, code: string): compres
fun{}
pats2xhtml_eval_file
  (stadyn: int, fname: !tmpfile): compres
//
(* ****** ****** *)

(* end of [atslangweb.sats] *)

(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN =
"prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./utfpl.sats"
staload "./utfpleval.sats"

(* ****** ****** *)

staload "./parsing/parsing.sats"
staload "./evaluating/eval.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json.sats"
staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

implement
utfpleval_fileref
  (inp) = let
//
val dp = 1024 // depth
val tkr = json_tokener_new_ex (dp)
val () = assertloc (json_tokener2ptr (tkr) > 0)
//
val cs =
  fileref_get_file_string (inp)
//
val jso = let
//
val cs2 = $UN.strptr2string(cs)
val len = g1u2i(string_length(cs2))
//
in
  json_tokener_parse_ex (tkr, cs2, len)
end // end of [val]
//
val ((*void*)) = strptr_free (cs)
val ((*void*)) = json_tokener_free (tkr)
//
val jsv = json_object2val0 (jso)
//
(*
val () =
  fprint! (stdout_ref, "jsv=", jsv)
val () = fprint_newline (stdout_ref)
*)
//
val d2cs = parse_d2eclist (jsv)
//
(*
val () =
  fprint! (stdout_ref, "d2cs=\n", d2cs)
val () = fprint_newline (stdout_ref)
*)
//
val env = eval0_d2eclist (d2cs)
//
in
  // nothing
end // end of [utfpleval_fileref]

(* ****** ****** *)
//
dynload
"./utfpl_dynloadall.dats"
dynload
"./parsing/dynloadall.dats"
dynload
"./evaluating/dynloadall.dats"
//
dynload "./utfpleval_symenv.dats"
//
(* ****** ****** *)

%{^
//
#include <sys/resource.h>
//
int
stacksize_set (int bsz)
{
  struct rlimit rl0 ; 
  rl0.rlim_cur = (rlim_t)bsz ;
  return setrlimit(RLIMIT_STACK, &rl0) ;
}
//
%}
//
extern
fun stacksize_set (bsz: int): int(*err*) = "mac#"
//
(* ****** ****** *)

implement
main0 (argc, argv) = let
//
val () =
println! ("Hello from UTFPL0!")
//
val err =
  stacksize_set (32*1024*1024)
val ((*void*)) =
if (err != 0)
  then println! ("warning(ATS): stacksize failed to reset!")
// end of [if]
//
val () = the_d2symmap_init ()
//
var fopen: int = 0
//
var inpref: FILEref = stdin_ref
//
val () =
if argc >= 2 then let
//
val opt =
  fileref_open_opt (argv[1], file_mode_r)
//
in
  case+ opt of
  | ~None_vt () => ()
  | ~Some_vt (inp) => (fopen := 1; inpref := inp)
end // end of [if]
//
val () = utfpleval_fileref (inpref)
//
val () = if fopen > 0 then fileref_close (inpref)
//
in
  // nothing
end (* end of [main0] *)

(* ****** ****** *)

(* end of [utfpleval.dats] *)

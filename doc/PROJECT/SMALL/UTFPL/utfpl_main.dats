(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "utfpl_eval.sats"

(* ****** ****** *)

dynload
"./utfpl_dynloadall.dats"
dynload
"./parsing/dynloadall.dats"
dynload
"./evaluating/dynloadall.dats"

(* ****** ****** *)
  
dynload "./utfpl_eval.dats"
  
(* ****** ****** *)

implement
main0 (argc, argv) = let
//
var fopen: int = 0
//
var inpref: FILEref = stdin_ref
//
val () = println! ("Welcome from UTFPL!")
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
val () = utfpl_eval_fileref (inpref)
//
val () = if fopen > 0 then fileref_close (inpref)
//
in
  // nothing
end (* end of [main0] *)

(* ****** ****** *)

(* end of [utfpl_main.dats] *)

(*
** A simple implementation
** of tokenization based on jsonats
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
#define \
atstyarr_field_undef(fname) fname[]
%} // end of [%{]

(* ****** ****** *)
//
#include "./../mylibies.hats"
#include "./../mylibies_link.hats"
#staload $JSONATS // opening it!
//
(* ****** ****** *)
//
#define
HX_CSTREAM_targetloc
"\
$PATSHOME/contrib\
/atscntrb/atscntrb-hx-cstream"
//
(* ****** ****** *)
//
#staload _ =
"libats/DATS/stringbuf.dats"
//
#include
"{$HX_CSTREAM}/mylibies.hats"
#include
"{$HX_CSTREAM}/mylibies_link.hats"
//
#staload $CSTREAM // opening it
#staload $CSTOKENER // opening it
//
(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val inp = stdin_ref
//
val jsvs =
  jsonats_parsexnlst_fileref (inp)
//
val () = print! ("jsvs = ")
local
implement
fprint_val<jsonval>
  (out, x) = fprint_jsonval (out, x)
in (*in-of-local*)
val () = fprint_list_sep (stdout_ref, jsvs, "\n")
end // end of [local]
val () = fprint_newline (stdout_ref)
//
val ((*void*)) = fileref_close (inp)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)

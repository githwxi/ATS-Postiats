(*
** stream of characters
*)

(* ****** ****** *)
//
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
staload
STDLIB =
"libats/libc/SATS/stdio.sats"
//
(* ****** ****** *)

staload "./../SATS/cstream.sats"
staload _ = "./../DATS/cstream.dats"

(* ****** ****** *)

implement
main0
(
  argc, argv
) = // main0
{
//
val fname =
(
  if argc >= 2
    then argv[1] else "test03.dats"
  // end of [if]
) : string // end of [val]
//
val-~Some_vt(inp) =
  fileref_open_opt (fname, file_mode_r)
//
val cs0 =
cstream_make_cloref
  (lam () => $STDLIB.fgetc0 (inp))
//
val xs = cstream_get_charlst (cs0, ~1)
//
val ((*void*)) = cstream_free (cs0)
//
val ((*void*)) = fileref_close (inp)
//
local
implement
fprint_list_vt$sep<> (out) = ()
in(*in-of-local*)
val () = fprint_list_vt (stdout_ref, xs)
end // end of [local]
//
val ((*void*)) = list_vt_free (xs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test03.dats] *)

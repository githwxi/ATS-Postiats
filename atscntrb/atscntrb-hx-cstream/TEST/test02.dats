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

staload "./../SATS/cstream.sats"
staload _ = "./../DATS/cstream.dats"

(* ****** ****** *)

implement
main0 ((*void*)) =
{
//
val Hello = string0_copy "Hello"
//
val cs =
cstream_make_strptr (Hello)
val res = cstream_get_charlst (cs, ~1)
val ((*void*)) = cstream_free (cs)
//
local
implement
fprint_list_vt$sep<> (out) = ()
in(*in-of-local*)
val () = fprintln! (stdout_ref, "Hello = ", res)
end // end of [local]
//
val ((*void*)) = list_vt_free (res)
//
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)

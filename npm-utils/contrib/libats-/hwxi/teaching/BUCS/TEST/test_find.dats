(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)
//
#include
"./../DATS/BUCS520-2016-Fall.dats"
//
(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val
out = stdout_ref
//
val () =
assertloc(argc >= 2)
//
val cs =
stream_by_command<>
( "find"
, $list{string}
  (argv[1], "-type", "f")
) (* stream_by_command *)
//
local
implement
stream_vt_fprint$beg<>(out) = ()
implement
stream_vt_fprint$end<>(out) = ()
implement
stream_vt_fprint$sep<>(out) = ()
in
val () = stream_vt_fprint(cs, out, 1024)
end // end of [local]
//
val () = fprint(out, "...")
val () = fprint_newline(out)
//
} (* end of [main0] *)
  
(* ****** ****** *)

(* end of [test_find.dats] *)

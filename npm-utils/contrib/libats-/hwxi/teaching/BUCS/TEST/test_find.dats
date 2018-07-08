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
//
#include
"share/atspre_staload_libats_ML.hats"
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
val
css =
stream_vt_delim_cloptr
  (cs, lam(c) => c = '\n')
val
lines =
stream_vt_map_cloptr<List_vt(char)><string>
( css
, lam(cs) => string_make_list(list_vt2t(cs))
)
//
local
implement
stream_vt_fprint$beg<>(out) = ()
implement
stream_vt_fprint$end<>(out) = ()
implement
stream_vt_fprint$sep<>(out) = fprint(out, "\n")
in
val () =
stream_vt_fprint(lines, out, 100)
end // end of [local]
//
val () = fprintln!(out, "\n...")
//
} (* end of [main0] *)
  
(* ****** ****** *)

(* end of [test_find.dats] *)

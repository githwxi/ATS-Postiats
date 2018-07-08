(* ****** ****** *)
//
// Author: Hongwei Xi
//
// A stream of keyboard inputs
// that may be terminated due to a
// chosen number of seconds of inactivity.
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload
"libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
extern
fun{}
kbstream
(
  inp: FILEref, nwait: intGte(0)
) : stream_vt(Strptr1)
//
implement
{}(*tmp*)
kbstream(
  inp, nwait
) = aux() where
{
fun
aux
(
// argless
): stream_vt(Strptr1) =
(
if fileref_is_eof(inp)
  then stream_vt_make_nil() else aux_main()
) (* end of [aux] *)

and
aux_main
(
// argless
) : stream_vt(Strptr1) = $ldelay
(
let
//
var
nlen: int
val
nbyte = i2sz(1024)
//
val
(pf | _) =
alarm_set(g1i2u(nwait))
//
val
[l:addr,n:int]
line =
$extfcall
(
  Strnptr0
, "atspre_fileref_get_line_string_main2"
, nbyte, inp, addr@(nlen)
)
val line = strnptr2strptr(line)
//
val leftover = alarm_cancel(pf | (*void*))
//
in
//  
if
strptr_isnot_null(line)
then
(
  stream_vt_cons(line, aux()) 
) (* end of [then] *)
else let
  prval () =
  strptr_free_null(line) in stream_vt_nil()
end // end of [else]
//
end
) (* end of [aux_main] *)
} (* end of [kbstream] *)
//
(* ****** ****** *)

(* end of [kbstream.dats] *)

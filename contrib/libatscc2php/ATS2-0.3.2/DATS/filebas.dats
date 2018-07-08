(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
#define
ATS_STATIC_PREFIX "_ats2phppre_filebas_"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../basics_php.sats"
#staload "./../SATS/bool.sats"
#staload "./../SATS/filebas.sats"
//
(* ****** ****** *)

implement
streamize_fileref_line
  (inp) = auxmain(inp) where
{
//
fun
auxmain
(
  inp: PHPfilr
) : stream_vt(string) = $ldelay
(
let
//
  val
  line = $extfcall(string, "fgets", inp)
//
in
  if boolize(line)
    then stream_vt_cons(line, auxmain(inp)) else stream_vt_nil()
  // end of [if]
end // end of [let]
)
//
} // end of [streamize_fileptr_line]

(* ****** ****** *)

implement
streamize_fileptr_line
  (inp) = auxmain(inp) where
{
//
fun
auxmain
(
  inp: PHPfilp1
) : stream_vt(string) = $ldelay
(
let
//
  val inp2 = $UN.castvwtp1{PHPfilr}(inp)
  val line = $extfcall(string, "fgets", inp2)
//
in
  if boolize(line)
    then stream_vt_cons(line, auxmain(inp))
    else let val _ = fclose(inp) in stream_vt_nil() end
  // end of [if]
end
,
ignoret(fclose(inp))
)
//
} // end of [streamize_fileptr_line]

(* ****** ****** *)

(* end of [filebas.dats] *)

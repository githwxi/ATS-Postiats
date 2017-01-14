(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
DA = "libats/SATS/dynarray.sats"
staload
_(*DA*) = "libats/DATS/dynarray.dats"
//
(* ****** ****** *)

staload "./../SATS/catsparse.sats"

(* ****** ****** *)

assume tokbuf_vt0ype = _tokbuf_vt0ype

(* ****** ****** *)

implement
tokbuf_initize_string
  (buf, inp) = let
//
#define TOKBUFSZ 1024
//
val () = buf.tokbuf_ntok := i2sz(0)
val () = buf.tokbuf_tkbf := $DA.dynarray_make_nil(i2sz(TOKBUFSZ))
val () = lexbuf_initize_string (buf.tokbuf_lxbf, inp)
//
in
  // nothing
end // end of [tokbuf_initize_string]

(* ****** ****** *)

implement
tokbuf_initize_fileref
  (buf, inp) = let
//
#define TOKBUFSZ 1024
//
val () = buf.tokbuf_ntok := i2sz(0)
val () = buf.tokbuf_tkbf := $DA.dynarray_make_nil(i2sz(TOKBUFSZ))
val () = lexbuf_initize_fileref (buf.tokbuf_lxbf, inp)
//
in
  // nothing
end // end of [tokbuf_initize_fileref]

(* ****** ****** *)

implement
tokbuf_reset
  (buf) = () where
{
  val ntok = buf.tokbuf_ntok
  val ((*void*)) = buf.tokbuf_ntok := i2sz(0)
  val ntok2 = $DA.dynarray_removeseq_at (buf.tokbuf_tkbf, i2sz(0), ntok)
} (* end of [tokbuf_reset] *)

(* ****** ****** *)

implement
tokbuf_uninitize
  (buf) = () where
{
//
val () =
  $DA.dynarray_free (buf.tokbuf_tkbf)
//
val (
) = lexbuf_uninitize (buf.tokbuf_lxbf)
//
} (* end of [tokbuf_uninitize] *)

(* ****** ****** *)

implement
tokbuf_get_ntok (buf) = buf.tokbuf_ntok
implement
tokbuf_set_ntok (buf, ntok) = buf.tokbuf_ntok := ntok

(* ****** ****** *)
//
implement
tokbuf_incby1
  (buf) = buf.tokbuf_ntok := succ(buf.tokbuf_ntok)
implement
tokbuf_incby_count
  (buf, n) = buf.tokbuf_ntok := buf.tokbuf_ntok + n
//
(* ****** ****** *)

implement
tokbuf_get_token
  (buf) = let
//
val ntok = buf.tokbuf_ntok
val ptok =
  $DA.dynarray_getref_at (buf.tokbuf_tkbf, ntok)
//
in
//
if
isneqz(ptok)
then $UN.cptr_get (ptok)
else let
//
val tok = lexbuf_get_token_skip (buf.tokbuf_lxbf)
val ((*void*)) =
  $DA.dynarray_insert_atend_exn (buf.tokbuf_tkbf, tok)
//
in
  tok
end // end of [else]
//
end // end of [tokbuf_get_token]

(* ****** ****** *)

implement
tokbuf_get_token_any
  (buf) = let
//
val ntok = buf.tokbuf_ntok
val ptok =
  $DA.dynarray_getref_at (buf.tokbuf_tkbf, ntok)
//
in
//
if
isneqz(ptok)
then $UN.cptr_get<token>(ptok)
else let
//
val tok = lexbuf_get_token_any(buf.tokbuf_lxbf)
val ((*void*)) =
  $DA.dynarray_insert_atend_exn(buf.tokbuf_tkbf, tok)
//
in
  tok
end // end of [else]
//
end // end of [tokbuf_get_token_any]

(* ****** ****** *)

implement
tokbuf_getinc_token
  (buf) = tok where
{
  val tok = tokbuf_get_token(buf)
  val ((*void*)) = tokbuf_incby1(buf)
} (* end of [tokbuf_getinc_token] *)

(* ****** ****** *)

implement
tokbuf_get_location (buf) =
  let val tok = tokbuf_get_token(buf) in tok.token_loc end
// end of [tokbuf_get_location]

(* ****** ****** *)

(* end of [catsparse_tokbuf.dats] *)

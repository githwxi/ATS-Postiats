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

#staload UN = $UNSAFE

(* ****** ****** *)

#staload
"./../SATS/catsparse.sats"

(* ****** ****** *)
//
#staload _ =
"libats/DATS/stringbuf.dats"
#staload _ =
"{$HX_CSTREAM}/DATS/cstream.dats"
//
(* ****** ****** *)

%{^
#define \
atstyarr_field_undef(fname) fname[]
%} // end of [%{]

(* ****** ****** *)

assume
lexbuf_vt0ype = _lexbuf_vt0ype

(* ****** ****** *)

implement
lexbuf_initize_string
  (buf, inp) = () where
{
//
#define BUFCAP 1024
//
val cs0 =
$CS0.cstream_make_string (inp)
val sbf =
$SBF.stringbuf_make_nil (i2sz(BUFCAP))
//
val () = buf.lexbuf_ntot := 0
val () = buf.lexbuf_nrow := 0
val () = buf.lexbuf_ncol := 0
//
val () = buf.lexbuf_nspace := 0
//
val () = buf.lexbuf_cstream := cs0
//
val () = buf.lexbuf_nback := 0
val () = buf.lexbuf_stringbuf := sbf
//
} (* end of [lexbuf_initize_string] *)

(* ****** ****** *)

implement
lexbuf_initize_fileref
  (buf, inp) = () where
{
//
#define BUFCAP 1024
//
val cs0 =
$CS0.cstream_make_fileref (inp)
val sbf =
$SBF.stringbuf_make_nil (i2sz(BUFCAP))
//
val () = buf.lexbuf_ntot := 0
val () = buf.lexbuf_nrow := 0
val () = buf.lexbuf_ncol := 0
//
val () = buf.lexbuf_nspace := 0
//
val () = buf.lexbuf_cstream := cs0
//
val () = buf.lexbuf_nback := 0
val () = buf.lexbuf_stringbuf := sbf
//
} (* end of [lexbuf_initize_fileref] *)

(* ****** ****** *)

implement
lexbuf_uninitize
  (buf) = () where
{
//
val () =
$CS0.cstream_free (buf.lexbuf_cstream)
val () =
$SBF.stringbuf_free (buf.lexbuf_stringbuf)
//
} (* end of [lexbuf_uninitize] *)

(* ****** ****** *)

implement
lexbuf_get_position
  (buf, pos) = () where
{
  val () = pos.pos_ntot := buf.lexbuf_ntot
  val () = pos.pos_nrow := buf.lexbuf_nrow
  val () = pos.pos_ncol := buf.lexbuf_ncol
}

implement
lexbuf_set_position
  (buf, pos) = () where
{
  val () = buf.lexbuf_ntot := pos.pos_ntot
  val () = buf.lexbuf_nrow := pos.pos_nrow
  val () = buf.lexbuf_ncol := pos.pos_ncol
}

(* ****** ****** *)
//
implement
lexbuf_set_nback
  (buf, nb) = buf.lexbuf_nback := nb
//
implement
lexbuf_incby_nback
  (buf, nb) = buf.lexbuf_nback := buf.lexbuf_nback + nb
//
(* ****** ****** *)
//
implement
lexbuf_get_nspace (buf) = buf.lexbuf_nspace
implement
lexbuf_set_nspace (buf, n) = buf.lexbuf_nspace := n
//
(* ****** ****** *)

implement
lexbuf_remove
  (buf, nchr) =
{
//
val nchr = i2sz(nchr)
val () =
$SBF.stringbuf_remove (buf.lexbuf_stringbuf, nchr)
//
val nbuf =
  $SBF.stringbuf_get_size (buf.lexbuf_stringbuf)
val ((*void*)) = lexbuf_set_nback (buf, sz2i(nbuf))
//
} (* end of [lexbuf_remove] *)

(* ****** ****** *)

implement
lexbuf_remove_all
  (buf) = () where
{
//
val () = lexbuf_set_nback (buf, 0)
val () =
$SBF.stringbuf_remove_all (buf.lexbuf_stringbuf)
//
} (* end of [lexbuf_remove_all] *)

(* ****** ****** *)

implement
lexbuf_takeout
  (buf, nchr) = let
//
val nchr = i2sz(nchr)
//
val strp = 
  $SBF.stringbuf_takeout (buf.lexbuf_stringbuf, nchr)
//
val nbuf = $SBF.stringbuf_get_size (buf.lexbuf_stringbuf)
val ((*void*)) = lexbuf_set_nback (buf, sz2i(nbuf))
//
in
  strp
end (* end of [lexbuf_takeout] *)

(* ****** ****** *)

implement
lexbuf_get_char
  (buf) = let
//
val nb = g1ofg0(buf.lexbuf_nback)
//
in
//
if nb <= 0
then let
  val i =
    $CS0.cstream_get_char(buf.lexbuf_cstream)
  // end of [val]
  val () =
  if i > 0 then
  {
    val c = int2char0(i)
    val c = $UN.cast{charNZ}(c)
    val _(*1*) =
      $SBF.stringbuf_insert_char(buf.lexbuf_stringbuf, c)
    // end of [val]
  } (* end of [if] *) // end of [if]
in
  i(*inserted*)
end // end of [then]
else let
  val nb1 = pred(nb)
  val ((*void*)) = buf.lexbuf_nback := nb1
in
  $SBF.stringbuf_rget_at (buf.lexbuf_stringbuf, i2sz(nb))
end // end of [else]
//
end (* end of [lexbuf_get_char] *)

(* ****** ****** *)

implement
lexbuf_getbyrow_location
  (buf) = loc where
{
//
var pos: position
val () = lexbuf_get_position (buf, pos)
val () = position_byrow (pos) // by-1-row
val loc = lexbufpos_get_location (buf, pos)
val () = lexbuf_set_position (buf, pos)
//
} (* end of [lexbuf_getbyrow_location] *)

(* ****** ****** *)

implement
lexbuf_getincby_location
  (buf, nchr) = loc where
{
//
var pos: position
val () = lexbuf_get_position (buf, pos)
val () = position_incby (pos, nchr(*char*))
val loc = lexbufpos_get_location (buf, pos)
val () = lexbuf_set_position (buf, pos)
//
} (* end of [lexbuf_getincby_location] *)

(* ****** ****** *)

implement
lexbufpos_get_location
  (buf, pos2) = let
  var pos1: position
  val ((*void*)) = lexbuf_get_position (buf, pos1)
in
  location_make_pos_pos (pos1, pos2)
end // end of [lexbufpos_get_location]

(* ****** ****** *)

(* end of [catsparse_lexbuf.dats] *)

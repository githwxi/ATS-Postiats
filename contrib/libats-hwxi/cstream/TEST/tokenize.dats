(*
** A simple implementation
** of tokenization based on cstream
*)

(* ****** ****** *)

(*
** Author: HX-2014-01-09 (gmhwxiATgmailDOTcom)
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/cstream.sats"

(* ****** ****** *)

extern
fun the_char_get (): int
extern
fun the_char_set (c: int): void

(* ****** ****** *)

local

var the_char: int = 0
val the_char =
ref_make_viewptr{int}(view@the_char | addr@the_char)

in (* in-of-local*)

implement the_char_get () = !the_char
implement the_char_set (i) = !the_char := i

end // end of [local]

(* ****** ****** *)

extern
fun
cstream_set_char
  (cs0: !cstream): void
implement
cstream_set_char
  (cs0) = the_char_set (cstream_get_char (cs0))
// end of [cstream_set_char]

(* ****** ****** *)

extern
fun
cstream_WS_skip
  (cs0: !cstream): void
implement
cstream_WS_skip (cs0) = let
//
fun loop
  (cs0: !cstream): int = let
  val c = cstream_get_char (cs0)
in
  if isspace (c) then loop (cs0) else c
end // end of [loop]
//
val i0 = the_char_get ()
//
in
  if isspace (i0) then the_char_set (loop (cs0))
end // end of [cstream_WS_skip]

(* ****** ****** *)

datatype token =
  | TOKide of string
  | TOKint of int
  | TOKlparen of ()
  | TOKrparen of ()
  | TOKeof of ((*void*))
// end of [token]

(* ****** ****** *)

extern
fun fprint_token
  (out: FILEref, x: token): void
overload fprint with fprint_token

(* ****** ****** *)

implement
fprint_token (out, x) =
(
case+ x of
//
| TOKide (ide) => fprint! (out, "TOKide(", ide, ")")
| TOKint (int) => fprint! (out, "TOKint(", int, ")")
//
| TOKlparen () => fprint! (out, "TOKlparen(", ")")
| TOKrparen () => fprint! (out, "TOKrparen(", ")")
//
| TOKeof ((*void*)) => fprint! (out, "TOKeof(", ")")
) (* end of [fprint_token] *)

(* ****** ****** *)
//
#define c2i char2int0
#define i2c int2char0
//
fun isalnum_ (x: int): bool =
  let val x = i2c(x) in isalnum(x) || (x = '_') end
//
(* ****** ****** *)

extern
fun the_cbuf_add (c: char): void
extern
fun the_cbuf_getall ((*void*)): Strptr1

(* ****** ****** *)

local

staload "libats/SATS/stringbuf.sats"
staload _ = "libats/DATS/stringbuf.dats"

val sbf =
  stringbuf_make_nil (i2sz(1024))
val p0_sbf = $UN.castvwtp0{ptr} (sbf)

in (*in-of-local*)

implement
the_cbuf_add (c) =
{
//
val sbf =
  $UN.castvwtp1{stringbuf}(p0_sbf)
val _(*int*) = stringbuf_insert (sbf, $UN.cast{charNZ}(c))
prval ((*void*)) = $UN.cast2void (sbf)
//
} (* end of [the_cbuf_add] *)

implement
the_cbuf_getall
  ((*void*)) = res where
{
//
val sbf =
  $UN.castvwtp1{stringbuf}(p0_sbf)
val res = stringbuf_truncout_all (sbf)
prval ((*void*)) = $UN.cast2void (sbf)
//
} (* end of [the_cbuf_getall] *)

end // end of [local]

(* ****** ****** *)
//
extern
fun
tokenize_ide
  (!cstream): Strptr1
//
implement
tokenize_ide (cs0) = let
//
fun loop
  (cs0: !cstream): void = let
//
val i = cstream_get_char (cs0)
//
in
//
if i >= 0 then
(
  if isalnum_ (i) then
    (the_cbuf_add (i2c(i)); loop (cs0))
  else the_char_set (i)
) else the_char_set (i)
//
end // end of [tokenize_ide]
//
val i0 = the_char_get ()
val () = the_cbuf_add (i2c(i0))
val ((*void*)) = loop (cs0)
//
in
  the_cbuf_getall ((*void*))
end // end of [tokenize_ide]

(* ****** ****** *)

extern
fun
tokenize_int
  (!cstream): int
//
implement
tokenize_int (cs0) = let
//
fun loop
(
  cs0: !cstream, res: &int >> _
) : void = let
  val i = cstream_get_char (cs0)
in
//
if i >= 0 then
(
  if isdigit (i)
    then let
      val d = i2c(i) - '0'
      val () = res := 10*res+d
    in
      loop (cs0, res)
    end // end of [then]
    else the_char_set (i)
  // end of [if]
) else the_char_set (i)
//
end // end of [loop]
//
val i0 = the_char_get ()
var res: int = (i2c(i0) - '0')
val () = loop (cs0, res)
//
in
  res
end // end of [tokenize_int]

(* ****** ****** *)

extern
fun cstream_tokenize (!cstream): void
extern
fun cstream_tokenize2 (!cstream): void

(* ****** ****** *)

implement
cstream_tokenize
  (cs0) = let
//
val i =
  cstream_get_char (cs0)
val () = the_char_set (i)
//
in
  cstream_tokenize2 (cs0)
end // end of [cstream_tokenize]

(* ****** ****** *)

%{^
#define LPAREN '('
#define RPAREN ')'
%}
macdef LPAREN = $extval (int, "LPAREN")
macdef RPAREN = $extval (int, "RPAREN")

(* ****** ****** *)

implement
cstream_tokenize2
  (cs0) = let
//
val () =
  cstream_WS_skip (cs0)
val i0 = the_char_get ()
//
in
//
if (
i0 >= 0
) then (
case+ 0 of
| _ when
    (i0 = LPAREN) => let
    val () = cstream_set_char (cs0)
    val tok = TOKlparen ()
    val ((*void*)) = fprintln! (stdout_ref, "tok = ", tok)
  in
    cstream_tokenize2 (cs0)
  end
| _ when
    (i0 = RPAREN) => let
    val () = cstream_set_char (cs0)
    val tok = TOKrparen ()
    val ((*void*)) = fprintln! (stdout_ref, "tok = ", tok)
  in
    cstream_tokenize2 (cs0)
  end
| _ when
    isalpha (i0) => let
    val ide = tokenize_ide (cs0)
    val ide = strptr2string (ide)
    val tok = TOKide (ide)
    val ((*void*)) = fprintln! (stdout_ref, "tok = ", tok)
  in
    cstream_tokenize2 (cs0)
  end
| _ when
    isdigit (i0) => let
    val int = tokenize_int (cs0)
    val tok = TOKint (int)
    val ((*void*)) = fprintln! (stdout_ref, "tok = ", tok)
  in
    cstream_tokenize2 (cs0)
  end
| _ (*unrecogized*) =>
  (
    cstream_set_char (cs0); cstream_tokenize2 (cs0)
  )
) else let
  val tok = TOKeof(*void*)
  val ((*void*)) = fprintln! (stdout_ref, "tok = ", tok)
in
  (*exit*)
end (* end of [if] *)
//
end // end of [cstream_tokenize2]

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val fname =
(
if argc >= 2
  then argv[1] else "tokenize.dats"
// end of [if]
) : string
//
val-~Some_vt(inp) =
fileref_open_opt (fname, file_mode_r)
val cs0 = cstream_make_fileref (inp)
//
val () = cstream_tokenize (cs0)
//
val ((*void*)) = cstream_free (cs0)
val ((*void*)) = fileref_close (inp)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tokenize.dats] *)

(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libats/SATS/stringbuf.sats"
staload "{$LIBATSHWXI}/cstream/SATS/cstream.sats"
staload "{$LIBATSHWXI}/cstream/SATS/cstream_tokener.sats"
//
staload _ = "libats/DATS/stringbuf.dats"
staload _ = "{$LIBATSHWXI}/cstream/DATS/cstream.dats"
staload _ = "{$LIBATSHWXI}/cstream/DATS/cstream_tokener.dats"
//
(* ****** ****** *)
  
staload "./falcon.sats"
  
(* ****** ****** *)

%{^
#define LPAREN '('
#define RPAREN ')'
%}
macdef LPAREN = $extval (int, "LPAREN")
macdef RPAREN = $extval (int, "RPAREN")

(* ****** ****** *)

#define i2c int2char0

(* ****** ****** *)

datatype token =
  | TOKide of string
  | TOKsym of string
  | TOKlpar of () | TOKrpar of ()
  | TOKeof of ()
  | TOKerr of (int)
// end of [token]

(* ****** ****** *)

extern
fun
fprint_token : (FILEref, token) -> void
overload fprint with fprint_token

(* ****** ****** *)

implement
fprint_token
  (out, tok) = let
in
//
case+ tok of
| TOKide (str) =>
    fprint! (out, "TOKide(", str, ")")
| TOKsym (str) =>
    fprint! (out, "TOKsym(", str, ")")
//
| TOKlpar () => fprint! (out, "TOKlpar(", ")")
| TOKrpar () => fprint! (out, "TOKrpar(", ")")
//
| TOKeof () => fprint! (out, "TOKeof(", ")")
| TOKerr (int) => fprint! (out, "TOKerr(", int, ")")
//
end // end of [fprint_token]

(* ****** ****** *)

fun
cstream_gets_if
(
  cs0: !cstream, sbf: !stringbuf, f: (int) -> bool
) : int = let
//
val i = cstream_get_char (cs0)
//
in
//
if
i >= 0
then
(
if f(i)
then let
//
val c = $UNSAFE.cast{charNZ}(i)
val _ = stringbuf_insert_char(sbf, c)
//
in
  cstream_gets_if (cs0, sbf, f)
end // end of [then]
else (i)
)
else (i)
//
end // end of [cstream_gets_if]

(* ****** ****** *)

extern fun test_ide : int -> bool
extern fun test_sym : int -> bool

(* ****** ****** *)

implement
test_ide
  (i0) = let
  val c0 = i2c(i0)
in
  case+ c0 of
  | _ when
      isalpha (i0) => true
  | _ when
      isdigit (i0) => true
  | '_' => true
  | '-' => true
  | '.' => true
  | _(*rest*)  => false
end // end of [test_ide]

(* ****** ****** *)

implement
test_sym
  (i0) = let
  val c0 = i2c(i0)
in
  case+ c0 of
  | '&' => true
  | '|' => true
  | _(*rest*)  => false
end // end of [test_sym]

(* ****** ****** *)

#define EOF (~1)

(* ****** ****** *)

extern
fun
my_tokener_get_token_main
(
  cs0: !cstream, i0: &int >> _, sbf: !stringbuf
) : token // end of [my_tokener_get_token_main]
implement
my_tokener_get_token_main
  (cs0, i0, sbf) = let
//
val () = cstream_WS_skip (cs0, i0)
//
in
//
case+ i0 of
//
| _ when
    test_ide (i0) => let
    val c0 = $UNSAFE.cast{charNZ}(i0)
    val _ = stringbuf_insert (sbf, c0)
    val () = i0 :=
      cstream_gets_if (cs0, sbf, test_ide)
    val str = stringbuf_truncout_all (sbf)
  in
    TOKide (strptr2string(str))
  end // end of [_ when ...]
| _ when
    test_sym (i0) => let
    val c0 = $UNSAFE.cast{charNZ}(i0)
    val _ = stringbuf_insert (sbf, c0)
    val () = i0 :=
      cstream_gets_if (cs0, sbf, test_sym)
    val str = stringbuf_truncout_all (sbf)
  in
    TOKide (strptr2string(str))
  end // end of [_ when ...]
//
| _ when
    i0 = LPAREN => let
    val () = i0 := cstream_get_char (cs0) in TOKlpar ()
  end // end of [_ when ...]
| _ when
    i0 = RPAREN => let
    val () = i0 := cstream_get_char (cs0) in TOKrpar ()
  end // end of [_ when ...]
//
| _ when i0 = EOF => TOKeof ()
| _ (*rest*) => let
    val i1 = i0
    val () = i0 := cstream_get_char (cs0) in TOKerr (i1)
  end // end of [_ when ...]
//
end // end of [my_tokener_get_token_main]

(* ****** ****** *)

extern
fun my_tokener_get_token (!tokener): token

(* ****** ****** *)

local

implement
tokener_get_token$main<token> = my_tokener_get_token_main

in (*in-of-local*)

implement
my_tokener_get_token (tknr) = tokener_get_token<token> (tknr)

end // end of [local]

(* ****** ****** *)

(* end of [falcon_tokener.dats] *)

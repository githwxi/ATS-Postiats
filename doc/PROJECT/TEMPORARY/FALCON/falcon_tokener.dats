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

staload "./falcon_position.dats"

(* ****** ****** *)

%{^
#define LPAREN '('
#define RPAREN ')'
#define NEWLINE '\n'
%}
macdef LPAREN = $extval (int, "LPAREN")
macdef RPAREN = $extval (int, "RPAREN")
// BB: TODO: should generalize to non-system-specific newline:
macdef NEWLINE = $extval (int, "NEWLINE")

(* ****** ****** *)

#define i2c int2char0

(* ****** ****** *)

datatype token =
  | TOKlpar of ()
  | TOKrpar of ()
  | TOKrsep of ()  
  | TOKide of symbol
  | TOKerr of (int)
  | TOKeof of ((*end*))
// end of [token]

(* ****** ****** *)

vtypedef tokener2 = tokener2(token)

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
//
| TOKlpar () => fprint! (out, "TOKlpar(", ")")
| TOKrpar () => fprint! (out, "TOKrpar(", ")")
//
| TOKrsep () => fprint! (out, "TOKrsep(", ")")
//
| TOKide (str) =>
    fprint! (out, "TOKide(", str, ")")
//
| TOKerr (int) => fprint! (out, "TOKerr(", int, ")")
//
| TOKeof ((*void*)) => fprint! (out, "TOKeof(", ")")
//
end // end of [fprint_token]

(* ****** ****** *)
//
local
//
extern
fun
cstream_get_char_saved (cs0: !cstream): int
implement
cstream_get_char_saved (cs0) = cstream_get_char (cs0)
//
in
//
implement{}
cstream_get_char (cs0) = i0 where
{
  val i0 = cstream_get_char_saved (cs0)
  val ((*void*)) = the_position_incby1 (i0)
}
//
end // end of [local]
//
(* ****** ****** *)
//
fun
cstream_WS_skip
(
  cs0: !cstream, i0: &int >> _
) : void = let
//
fun loop
  (cs0: !cstream): int = let
  val c = cstream_get_char (cs0)
in
  if (c != NEWLINE) && isspace (c) then loop (cs0) else c
end // end of [loop]
//
in
  if (i0 != NEWLINE) && isspace (i0) then i0 := loop (cs0)
end // end of [cstream_WS_skip]

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

extern fun test_ide1 : int -> bool // first
extern fun test_ide2 : int -> bool // the rest

(* ****** ****** *)

implement
test_ide1
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
  | '&' => true
  | '|' => true
  | _(*rest*)  => false
end // end of [test_ide1]

implement
test_ide2 (i0) = test_ide1 (i0)

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
    test_ide1 (i0) => let
    val c0 = $UNSAFE.cast{charNZ}(i0)
    val _ = stringbuf_insert (sbf, c0)
    val () = i0 :=
      cstream_gets_if (cs0, sbf, test_ide2)
    val str = stringbuf_truncout_all (sbf)
    val sym =
      symbol_make(strptr2string(str)) in TOKide(sym)
    // end of [val]
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
| _ when
    i0 = NEWLINE => let
    val () = i0 := cstream_get_char (cs0) in TOKrsep ()
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
//
extern
fun my_tokener2_get
  (t2nkr: !tokener2): (token_v | token)
//
extern
fun my_tokener2_unget (token_v | !tokener2): void
extern
fun my_tokener2_getaft (token_v | !tokener2): void
extern
fun my_tokener2_getout (!tokener2): token
//
(* ****** ****** *)

local

implement
tokener_get_token$main<token> = my_tokener_get_token_main

in (*in-of-local*)

implement
my_tokener2_get (t2knr) = tokener2_get<token> (t2knr)
implement
my_tokener2_unget (pf | t2knr) = tokener2_unget<token> (pf | t2knr)
implement
my_tokener2_getaft (pf | t2knr) = tokener2_getaft<token> (pf | t2knr)
implement
my_tokener2_getout (t2knr) = tokener2_getout<token> (t2knr)

end // end of [local]

(* ****** ****** *)

(* end of [falcon_tokener.dats] *)

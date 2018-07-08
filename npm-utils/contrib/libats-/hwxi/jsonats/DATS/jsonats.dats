(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSCNTRB.HX.jsonats"
//
(* ****** ****** *)
//
// HX-2014-05-09:
// Convenience functions
// for parsing JSON data
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#define
HX_CSTREAM_targetloc
"\
$PATSHOME/contrib\
/atscntrb/atscntrb-hx-cstream"
//
(* ****** ****** *)
//
#staload
"{$HX_CSTREAM}/SATS/cstream.sats"
#staload
"{$HX_CSTREAM}/SATS/cstream_tokener.sats"
//
(* ****** ****** *)
//
#staload UN = $UNSAFE
//
(* ****** ****** *)

#staload "./../SATS/jsonats.sats"

(* ****** ****** *)

implement
print_token(x) = fprint_token(stdout_ref, x)
implement
prerr_token(x) = fprint_token(stderr_ref, x)

(* ****** ****** *)

implement
fprint_token
  (out, tok) = let
in
//
case+ tok of
//
| TOKint (i) => fprint! (out, "TOKint(", i, ")")
//
| TOKident (str) => fprint! (out, "TOKident(", str, ")")
//
| TOKstring (str) => fprint! (out, "TOKstring(", str, ")")
//
| TOKcolon () => fprint! (out, "TOKcolon(", ")")
| TOKcomma () => fprint! (out, "TOKcomma(", ")")
//
| TOKlbrace () => fprint! (out, "TOKlbrace(", ")")
| TOKrbrace () => fprint! (out, "TOKrbrace(", ")")
//
| TOKlbracket () => fprint! (out, "TOKlbracket(", ")")
| TOKrbracket () => fprint! (out, "TOKrbracket(", ")")
//
| TOKerr (int) => fprint! (out, "TOKerr(", int, ")")
//
| TOKeof ((*void*)) => fprint! (out, "TOKeof(", ")")
//
end // end of [fprint_token]

(* ****** ****** *)
//
implement
print_jsonval(x0) = fprint_jsonval(stdout_ref, x0)
implement
prerr_jsonval(x0) = fprint_jsonval(stderr_ref, x0)
//
(* ****** ****** *)
//
implement
fprint_jsonval
  (out, x0) =
(
case+ x0 of
//
| JSONnul() => fprint! (out, "JSONnul(", ")")
//
| JSONbool(x) => fprint! (out, "JSONbool(", x, ")")
//
| JSONint(x) => fprint! (out, "JSONint(", x, ")")
| JSONfloat(x) => fprint! (out, "JSONfloat(", x, ")")
//
| JSONstring(x) => fprint! (out, "JSONstring(", x, ")")
//
| JSONarray(xs) =>
  {
    val () =
    fprint (out, "JSONarray(")
    val () = fprint_jsonvalist (out, xs)
    val () = fprint (out, ")")
  }
| JSONobject(lxs) =>
  {
    val () =
    fprint (out, "JSONoject(")
    val () = fprint_labjsonvalist (out, lxs)
    val () = fprint (out, ")")
  } (* JSONobject *)
//
)
//
(* ****** ****** *)

implement
fprint_jsonvalist
  (out, xs) = let
//
implement
fprint_val<jsonval>
  (out, x) = fprint_jsonval(out, x)
//
in
  fprint_list<jsonval>(out, xs)
end // end of [fprint_jsonvalist]

(* ****** ****** *)

implement
fprint_labjsonvalist
  (out, lxs) = let
//
implement
fprint_val<labjsonval>
  (out, @(l, x)) =
{
  val () = fprint_string(out, l)
  val () = fprint_string(out, ": ")
  val () = fprint_jsonval(out, x)
}
//
in
  fprint_list<labjsonval> (out, lxs)
end // end of [fprint_jsonvalist]

(* ****** ****** *)

implement
{}(*tmp*)
jsonval_array_get_at
  (jsv, i0) = let
in
//
case+ jsv of
| JSONarray(xs) =>
    list_get_at_opt (xs, i0)
  // end of [JSONarray]
| _ (*non-JSONarray*) => None_vt()
//
end // end of [jsonval_array_get_at]

(* ****** ****** *)

implement
{}(*tmp*)
jsonval_object_get_key
  (jsv, k0) = let
//
typedef key = string
typedef itm = jsonval
//
implement
list_assoc$eqfn<key> (k1, k2) = k1 = k2
//
in
//
case+ jsv of
| JSONobject
    (lxs) => list_assoc_opt<key,itm> (lxs, k0)
| _ (*non-object*) => None_vt ((*void*))
//
end // end of [jsonval_object_get_key]

(* ****** ****** *)
//
extern
fun{
} cstream_WS_skip
  (cs0: !cstream, i0: &int >> _): void
//
implement
{}(*tmp*)
cstream_WS_skip
  (cs0, i0) = let
//
fun loop
  (cs0: !cstream): int = let
  val c = cstream_get_char<> (cs0)
in
  if isspace (c) then loop (cs0) else c
end // end of [loop]
//
in
  if isspace (i0) then i0 := loop (cs0)
end // end of [cstream_WS_skip]

(* ****** ****** *)

implement
tokener_get_token$main<token>
  (cs0, i0, sbf) = let
//
val () =
cstream_WS_skip<> (cs0, i0)
val c0 = int2char0 (i0)
//
macdef
incby1 () =
(
  i0 := cstream_get_char (cs0)
)
//
fun isalpha_ (i: int): bool =
  if isalpha (i) then true else (i = char2int0('_'))
//
in
//
if (
i0 >= 0
) then (
case+ c0 of
//
| '}' => (incby1 (); TOKrbrace())
| '\{' => (incby1 (); TOKlbrace())
| ']' => (incby1 (); TOKrbracket())
| '\[' => (incby1 (); TOKlbracket())
//
//
| ':' => (incby1 (); TOKcolon())
| ',' => (incby1 (); TOKcomma())
//
| _ when isdigit (i0) => let
    val u = cstream_tokenize_uint<> (cs0, i0)
  in
    TOKint ($UN.cast2int(u))
  end // end of ...
//
| _ when isalpha_ (i0) => let
    val ide = cstream_tokenize_ident<> (cs0, i0, sbf)
  in
    TOKident (strptr2string(ide))
  end // end of ...
//
| '"' => let
    val str = cstream_tokenize_string (cs0, i0, sbf)
  in
    TOKstring (strptr2string(str))
  end // end of ...
//
| _ (*rest*) => let
    val tok = TOKerr (i0); val () = incby1 () in tok
  end // end of [_]
//
) else (
  TOKeof(*void*)
) (* end of [if] *)
//
end // end of [tokener_get_token$main]

(* ****** ****** *)

vtypedef tokener2 = tokener2 (token)

(* ****** ****** *)

extern
fun{}
jsonats_parsexn (t2knr: !tokener2): jsonval
extern
fun{}
jsonats_parsexn_array (t2knr: !tokener2): jsonval
extern
fun{}
jsonats_parsexn_object (t2knr: !tokener2): jsonval

(* ****** ****** *)

extern
fun{}
jsonats_parsexnlst (t2knr: !tokener2): jsonvalist

(* ****** ****** *)

implement
{}(*tmp*)
jsonats_parsexn
  (t2knr) = let
//
val (pf | tok0) =
  tokener2_get<token> (t2knr)
//
(*
val () =
  println! ("jsonats_parsexn: tok0 = ", tok0)
*)
//
in
//
case+ tok0 of
//
| TOKint (int) => let
    val () =
    tokener2_getaft<token> (pf | t2knr)
  in
    JSONint (int)
  end // end of [JSONint]
//
| TOKident (ide) => let
    val () =
    tokener2_getaft<token> (pf | t2knr)
  in
    case+ ide of
    | "null" => JSONnul ()
    | "true" => JSONbool (true)
    | "false" => JSONbool (false)
    | _(*rest*) =>
        let val () = assertloc (false) in JSONnul () end
      // end of [_]
  end // end of [JSON...]
//
| TOKstring (str) => let
    val () =
    tokener2_getaft<token> (pf | t2knr)
  in
    JSONstring (str)
  end // end of [JSONstring]
//
| TOKlbracket
    ((*void*)) => let
    val () = tokener2_unget<token> (pf | t2knr)
  in
    jsonats_parsexn_array (t2knr)
  end // end of [JSONarray]
//
| TOKlbrace () => let
    val () = tokener2_unget<token> (pf | t2knr)
  in
    jsonats_parsexn_object (t2knr)
  end // end of [JSONoject]
//
| _ (*rest*) => let
    val () = assertloc (false) 
    val () = tokener2_unget<token> (pf | t2knr)
  in
    JSONnul ()
  end // end of [_]
//
end // end of [jsonats_parsexn]

(* ****** ****** *)

implement
{}(*tmp*)
jsonats_parsexn_array
  (t2knr) = let
//
fnx loop
(
  t2knr: !tokener2, res: jsonvalist_vt
) : jsonvalist_vt = let
  val jsv = jsonats_parsexn (t2knr)
  val res = list_vt_cons{jsonval} (jsv, res)
in
  loop2 (t2knr, res)
end // end of [loop]

and loop2
(
  t2knr: !tokener2, res: jsonvalist_vt
) : jsonvalist_vt = let
  val tok = tokener2_getout<token> (t2knr)
in
  case+ tok of
  | TOKcomma
      ((*void*)) => loop (t2knr, res)
  | TOKrbracket () => res
  | TOKeof ((*void*)) => res
  | _ (*rest*) =>
      let val () = assertloc (false) in res end
    // end of [_]
end // end of [loop]
//
val tok =
tokener2_getout<token> (t2knr)
val-TOKlbracket((*void*)) = tok
//
val res = loop (t2knr, list_vt_nil)
val res = list_vt2t (list_vt_reverse (res))
//
in
  JSONarray (res)
end // end of [jsonats_parsexn_array]

(* ****** ****** *)

implement
{}(*tmp*)
jsonats_parsexn_object
  (t2knr) = let
//
fnx loop
(
  t2knr: !tokener2, res: labjsonvalist_vt
) : labjsonvalist_vt = let
  val tok = tokener2_getout (t2knr)
  val-TOKstring(key) = tok
  val tok = tokener2_getout (t2knr)
  val-TOKcolon((*void*)) = tok
  val jsv = jsonats_parsexn (t2knr)
  val res = list_vt_cons{labjsonval} ((key, jsv), res)
in
  loop2 (t2knr, res)
end // end of [loop]

and loop2
(
  t2knr: !tokener2, res: labjsonvalist_vt
) : labjsonvalist_vt = let
  val tok = tokener2_getout<token> (t2knr)
in
  case+ tok of
  | TOKcomma
      ((*void*)) => loop (t2knr, res)
  | TOKrbrace () => res
  | TOKeof ((*void*)) => res
  | _ (*rest*) =>
      let val () = assertloc (false) in res end
    // end of [_]
end // end of [loop]
//
val tok =
tokener2_getout<token> (t2knr)
val-TOKlbrace((*void*)) = tok
//
val res = loop (t2knr, list_vt_nil)
val res = list_vt2t (list_vt_reverse (res))
//
in
  JSONobject (res)
end // end of [jsonats_parsexn_object]

(* ****** ****** *)

implement
{}(*tmp*)
jsonats_parsexnlst
  (t2knr) = let
//
fun loop
(
  t2knr: !tokener2, res: jsonvalist_vt
) : jsonvalist_vt = let
//
val (pf | tok) = tokener2_get<token> (t2knr)
val ((*void*)) = tokener2_unget<token> (pf | t2knr)
//
in
//
case+ tok of
| TOKeof () => res
| _(*non-TOKeof*) => let
    val jsv = jsonats_parsexn (t2knr)
    val res = list_vt_cons{jsonval} (jsv, res)
  in
    loop (t2knr, res)
  end // end of [_]
//  
end (* end of [loop] *)
//
val res =
  loop (t2knr, list_vt_nil(*void*))
//
in
  list_vt2t (list_vt_reverse (res))
end // end of [jsonats_parsexnlst]

(* ****** ****** *)

implement
{}(*tmp*)
jsonats_parsexn_string
  (inp) = (jsv) where
{
//
val cs0 = cstream_make_string (inp)
val tknr = tokener_make_cstream (cs0)
val t2knr = tokener2_make_tokener (tknr)
//
val jsv = jsonats_parsexn<> (t2knr)
val-TOKeof() = tokener2_getout<token> (t2knr)
//
val ((*freed*)) = tokener2_free (t2knr)
//
} // end of [jsonats_parsexn_string]

implement
{}(*tmp*)
jsonats_parsexnlst_string
  (inp) = (jsvs) where
{
//
val cs0 = cstream_make_string (inp)
val tknr = tokener_make_cstream (cs0)
val t2knr = tokener2_make_tokener (tknr)
//
val jsvs = jsonats_parsexnlst<> (t2knr)
//
val ((*freed*)) = tokener2_free (t2knr)
//
} // end of [jsonats_parsexnlst_string]

(* ****** ****** *)

implement
{}(*tmp*)
jsonats_parsexn_fileref
  (inp) = (jsv) where
{
//
val cs0 = cstream_make_fileref (inp)
val tknr = tokener_make_cstream (cs0)
val t2knr = tokener2_make_tokener (tknr)
//
val jsv = jsonats_parsexn<> (t2knr)
val-TOKeof() = tokener2_getout<token> (t2knr)
//
val ((*freed*)) = tokener2_free (t2knr)
//
} // end of [jsonats_parsexn_fileref]

implement
{}(*tmp*)
jsonats_parsexnlst_fileref
  (inp) = (jsvs) where
{
//
val cs0 = cstream_make_fileref (inp)
val tknr = tokener_make_cstream (cs0)
val t2knr = tokener2_make_tokener (tknr)
//
val jsvs = jsonats_parsexnlst<> (t2knr)
//
val ((*freed*)) = tokener2_free (t2knr)
//
} // end of [jsonats_parsexnlst_fileref]

(* ****** ****** *)

(* end of [jsonats.dats] *)

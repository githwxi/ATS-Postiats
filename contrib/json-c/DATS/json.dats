(*
** API for json-c in ATS
*)

(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
**
** Author Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start time: May, 2013
**
*)

(* ****** ****** *)
//
// HX-2013-05:
// mostly for some convenience functions
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/json.sats"
overload ptrcast with json_object2ptr
overload ptrcast with json_tokener2ptr

(* ****** ****** *)

staload "./../SATS/arraylist.sats"
overload ptrcast with array_list2ptr
  
(* ****** ****** *)

implement{}
not_json_bool (tf) =
  if tf != 0 then json_false else json_true
// end of [not_json_bool]

(* ****** ****** *)
//
implement{}
json_object_is_null
  (jso) = json_object2ptr (jso) = the_null_ptr
implement{}
json_object_isnot_null
  (jso) = json_object2ptr (jso) > the_null_ptr
//
(* ****** ****** *)
//
implement{}
print_json_object
  (jso) = fprint_json_object (stdout_ref, jso)
implement{}
print_json_object_ext
  (jso, flags) = fprint_json_object_ext (stdout_ref, jso, flags)
//
implement{}
prerr_json_object
  (jso) = fprint_json_object (stderr_ref, jso)
implement{}
prerr_json_object_ext
  (jso, flags) = fprint_json_object_ext (stderr_ref, jso, flags)
//
(* ****** ****** *)

implement{}
fprint_json_object
  (out, jso) = let
  val (fpf | str) = json_object_to_json_string (jso)
  val () = fprint_strptr (out, str)
  prval () = fpf (str)
in
  // nothing
end // end of [fprint_json_object]

implement{}
fprint_json_object_ext
  (out, jso, flags) = let
  val (fpf | str) = json_object_to_json_string_ext (jso, flags)
  val () = fprint_strptr (out, str)
  prval () = fpf (str)
in
  // nothing
end // end of [fprint_json_object_ext]

(* ****** ****** *)

implement{env}
json_object_iforeach$cont (i, v, env) = true

(*
implement{env}
json_object_iforeach$fwork (i, v, env) = ()
*)

implement{}
json_object_iforeach
  (jso) = let
  var env: void = ()
in
  json_object_iforeach_env<void> (jso, env)
end // end of [json_object_iforeach]

implement{env}
json_object_iforeach_env
  (jso, env) = let
//
stadef jso = json_object
//
fun loop
(
  alst: !array_list1
, n: int, i: intGte(0), env: &(env) >> _
) : void = let
in
//
if i < n then let
  val [l:addr]
    jsi = array_list_get_idx (alst, i)
  val jsi = $UN.castvwtp0{jso(l)}(jsi)
  val cont = json_object_iforeach$cont<env> (i, jsi, env)
  val () = if cont then json_object_iforeach$fwork<env> (i, jsi, env)
  prval () = $UN.cast2void (jsi)
in
  loop (alst, n, i+1, env)
end else () // end of [if]
//
end // end of [loop]
//
val isarr =
json_object_is_type (jso, json_type_array)
val () =
if (isarr = 0) then
{
val (
) = assertmsgloc (false
, "[json_object_iforeach] is applied to a non-array json object:\n"
) (* end of [val] *)
}
//
val (fpf | alst) = json_object_get_array (jso)
//
val () = assertloc (ptrcast (alst) > 0)
val () = loop (alst, array_list_length (alst), 0, env)
prval () = minus_addback (fpf, alst | jso)
//
in
  // nothing
end // end of [json_object_iforeach_env]

(* ****** ****** *)

implement{env}
json_object_kforeach$cont (k, v, env) = true

(*
implement{env}
json_object_kforeach$fwork (k, v, env) = ()
*)

implement{}
json_object_kforeach
  (jso) = let
  var env: void = ()
in
  json_object_kforeach_env<void> (jso, env)
end // end of [json_object_kforeach]

implement{env}
json_object_kforeach_env
  (jso, env) = let
//
stadef jso = json_object
stadef iter(l:addr) = json_object_iterator(l)
//
fun loop{l:addr}
(
  jso: !jso(l)
, jsi: &iter(l), jsiEnd: &iter(l)
, env: &env >> _
) : void = let
in
//
if jsi != jsiEnd then let
  val (fpf_k | k) = json_object_iter_peek_name (jsi)
  val (fpf_v | v) = json_object_iter_peek_value (jsi)
  val cont = json_object_kforeach$cont<env> (k, v, env)
  val () = if cont then json_object_kforeach$fwork<env> (k, v, env)
  prval () = fpf_k (k)
  prval () = fpf_v (v)
  val () = json_object_iter_next (jsi)
in
  loop (jso, jsi, jsiEnd, env)
end else () // end of [if]
//
end // end of [loop]
//
val isobj =
json_object_is_type (jso, json_type_object)
val () =
if (isobj = 0) then
{
val (
) = assertmsgloc (false
, "[json_object_kforeach] is applied to a non-object json-object:\n"
) (* end of [val] *)
}
//
var jsi = json_object_iter_begin (jso)
var jsiEnd = json_object_iter_end (jso)
//
val () = loop (jso, jsi, jsiEnd, env)
//
val () = json_object_iter_clear (jso, jsi)
val () = json_object_iter_clear (jso, jsiEnd)
//
in
  // nothing
end // end of [json_object_kforeach_env]

(* ****** ****** *)

implement{}
json_objlst_from_file
  (fname) = let
//
val opt = fileref_open_opt (fname, file_mode_r)
//
in
//
case+ opt of
| ~Some_vt (inp) => let
    val str = fileref_get_file_string (inp)
    val () = fileref_close (inp)
    val res = json_tokener_parse_list ($UN.strptr2string(str))
    val ((*void*)) = strptr_free (str)
  in
    res
  end // end of [Some_vt]
| ~None_vt ((*void*)) => list_vt_nil ()
//
end // end of [json_objlst_from_file]

implement{}
json_objlst_from_file_delim
  (fname, delim) = let
//
implement
json_tokener_parse$skip<> (inp) = let
  val nskip = strspn (inp, delim) in g1u2i(nskip)
end // end of [json_tokener_parse$skip]
//
in
  json_objlst_from_file (fname)
end // end of [json_objlst_from_file_delim]

(* ****** ****** *)

implement{}
json_tokener_parse$skip (inp) =
let prval () = lemma_string_param (inp) in 0 end

implement{}
json_tokener_parse_list
  (inp) = let
//
vtypedef jobj0 = json_object0
vtypedef res = List0_vt (jobj0)
//
overload + with add_ptr_bsz
//
fnx loop
(
  tok: !json_tokener1
, inp: string, len: intGte(0),
 res: &res? >> res
) : void = let
  val inp = g1ofg0(inp)
  val nskip = json_tokener_parse$skip (inp)
  val inp = $UN.cast{string}(string2ptr(inp) + i2sz(nskip))
  val len = $UN.cast{intGte(0)}(len - nskip)
in
  if len > 0 then
    loop2 (tok, inp, len, res) else res := list_vt_nil{jobj0}()
  // end of [if]
end // end of [loop]

and loop2
(
  tok: !json_tokener1
, inp: string, len: intGte(0)
, res: &res? >> res
) : void = let
//
val jso =
json_tokener_parse_ex (tok, inp, len)
val err = json_tokener_get_error (tok)
//
in
//
case+ 0 of
| _ when err =
    json_tokener_success => let
    val () = res := list_vt_cons{jobj0}{0}(jso, _)
    val+list_vt_cons (_, res1) = res
    val ofs = json_tokener_get_char_offset (tok)
    val inp2 = $UN.cast{string}(string2ptr(inp) + g0i2u(ofs))
    val len2 = len - ofs
    val len2 = $UN.cast{intGte(0)}(len2)
    val () = loop (tok, inp2, len2, res1)
    prval () = fold@ (res)
  in
    // nothing
  end // end of [_ when ...]
| _ => let
    val _freed = json_object_put (jso) in res := list_vt_nil{jobj0}()
  end // end of [_]
//
end // end of [loop2]
//
val tok = json_tokener_new ()
val ((*void*)) = assertloc (ptrcast(tok) > 0)
//
var res: ptr
val len = length(inp)
val len = g1ofg0(len)
val () = loop (tok, inp, g1u2i(len), res)
val () = json_tokener_free (tok)
//
in
  res
end // end of [jso_tokener_parse_list]

(* ****** ****** *)

implement{}
json_tokener_parse_list_delim
  (inp, delim) = let
//
implement
json_tokener_parse$skip<> (inp) = let
  val nskip = strspn (inp, delim) in g1u2i(nskip)
end // end of [json_tokener_parse$skip]
//
in
  json_tokener_parse_list (inp)
end // end of [json_tokener_parse_list_delim]

(* ****** ****** *)

(* end of [json.dats] *)

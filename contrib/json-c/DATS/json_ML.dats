(*
** A quasi ML-style API for json-c in ATS
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/json.sats"
staload "./../SATS/json_ML.sats"

(* ****** ****** *)

implement
print_jsonval (x) = fprint_jsonval (stdout_ref, x)
implement
prerr_jsonval (x) = fprint_jsonval (stderr_ref, x)

(* ****** ****** *)

implement
fprint_val<jsonval> = fprint_jsonval

(* ****** ****** *)

implement
fprint_jsonval
  (out, jsv) = let
in
//
case+ jsv of
| JSONnul () =>
    fprint! (out, "JSONnul(", ")")
| JSONint (lli) =>
    fprint! (out, "JSONint(", lli, ")")
| JSONbool (bool) =>
    fprint! (out, "JSONbool(", bool, ")")
| JSONfloat (dbl) =>
    fprint! (out, "JSONfloat(", dbl, ")")
| JSONstring (str) =>
    fprint! (out, "JSONstring(", str, ")")
| JSONarray (xs) =>
  {
    val () = fprint (out, "JSONarray(")
    val () = fprint_jsonvalist (out, xs)
    val () = fprint (out, ")")
  }
| JSONobject (lxs) =>
  {
    val () = fprint (out, "JSONobject(")
    val () = fprint_labjsonvalist (out, lxs)
    val () = fprint (out, ")")
  }
//
end // end of [fprint_jsonval]

(* ****** ****** *)

implement
fprint_jsonvalist
  (out, xs) = let
//
macdef SEP = "; "
//
fun loop
(
  out: FILEref, xs: jsonvalist, i: int
) : void = let
//
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () =
    if i > 0 then fprint (out, SEP)
    val () = fprint_jsonval (out, x)
  in
    loop (out, xs, i+1)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [loop]
//
in
  loop (out, xs, 0)
end // end of [fprint_jsonvalist]

(* ****** ****** *)

implement
fprint_labjsonvalist
  (out, lxs) = let
//
macdef SEP = "; "
macdef MAPTO = ": "
//
fun loop
(
  out: FILEref, lxs: labjsonvalist, i: int
) : void = let
//
in
//
case+ lxs of
| list_cons
    (lx, lxs) => let
    val (
    ) = if i > 0 then fprint (out, SEP)
    val () = fprint! (out, lx.0, MAPTO, lx.1)
  in
    loop (out, lxs, i+1)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [loop]
//
in
  loop (out, lxs, 0)
end // end of [fprint_labjsonvalist]

(* ****** ****** *)

implement
jsonval_ofstring (str) = let
  val jso = json_tokener_parse (str) in json_object2val0 (jso)
end // end of [jsonval_ofstring]

(* ****** ****** *)

implement
jsonval_tostring
  (jsv) = rep2 where
{
//
  val jso = jsonval_objectify (jsv)
//
  val (
    fpf | rep
  ) = json_object_to_json_string (jso)
  val rep2 = string0_copy ($UN.strptr2string(rep))
  prval ((*void*)) = fpf (rep)
//
  val freed(*1*) = json_object_put (jso)
//
} (* end of [jsonval_tostring] *)

(* ****** ****** *)

implement
json_object2val0
  (jso) = let
  val jsv = json_object2val1 (jso)
  val _(*int*) = json_object_put (jso) in jsv
end // end of [json_object2val0]

(* ****** ****** *)

implement
json_object2val1
  (jso) = let
//
extern
praxi __assert_agz
  {l:addr} (jso: !json_object(l)): [l > null] void
//
val type = json_object_get_type (jso)
//
in
//
case+ 0 of
| _ when type =
    json_type_null => JSONnul ()
| _ when
    type = json_type_int => let
    prval () = __assert_agz (jso) 
    val i = json_object_get_int (jso)
  in
    JSONint($UN.cast2llint(i))
  end // end of [json_type_int]
| _ when type =
    json_type_boolean => let
    prval (
    ) = __assert_agz (jso) 
    val tf = json_object_get_boolean (jso)
  in
    JSONbool(tf)
  end // end of [json_type_boolean]
| _ when type =
    json_type_double => let
    prval (
    ) = __assert_agz (jso) 
    val dbl = json_object_get_double (jso)
  in
    JSONfloat(dbl)
  end // end of [json_type_double]
| _ when type =
    json_type_string => let
    prval (
    ) = __assert_agz (jso) 
    val (
      fpf | str
    ) = json_object_get_string (jso)
    val str2 = strptr2string (strptr1_copy (str))
    prval () = fpf (str)
  in
    JSONstring(str2)
  end // end of [json_type_string]
| _ when type =
    json_type_array => let
    vtypedef tenv = ptr(*list_vt*)
    prval ((*void*)) = __assert_agz (jso) 
    val asz = json_object_array_length (jso)
    local
    implement
    json_object_iforeach$fwork<tenv>
      (i, v, env) =
    {
      val v2 = json_object2val1 (v)
      val vs2 = $UN.castvwtp0{jsonvalist_vt}(env)
      val () = env := $UN.castvwtp0{ptr}(list_vt_cons{jsonval}(v2, vs2))
    }
    in (* in of [local] *)
    var env: tenv = the_null_ptr
    val ((*void*)) = json_object_iforeach_env<tenv> (jso, env)
    val vs2 = $UN.castvwtp0{jsonvalist_vt}(env)
    end // end of [local]
  in
    JSONarray(list_vt2t(list_vt_reverse(vs2)))
  end // end of [json_type_array]
| _ when type =
    json_type_object => let
    typedef tenv = ptr
    prval () = __assert_agz (jso)
    local
    implement    
    json_object_kforeach$fwork<tenv>
      (k, v, env) =
    {
      val k2 = strptr1_copy(k)
      val k2 = strptr2string(k2)
      val v2 = json_object2val1 (v)
      val kvs = $UN.cast{labjsonvalist}(env)
      val kvs = list_cons{labjsonval}((k2, v2), kvs)
      val ((*void*)) = env := $UN.cast2ptr (kvs)
    }
    in (* in of [local] *)
    var env: tenv = the_null_ptr
    val () = json_object_kforeach_env<tenv> (jso, env)
    end // end of [local]
    val kvs = $UN.castvwtp0{List0_vt(labjsonval)}(env)
    val kvs = list_vt_reverse<labjsonval> (kvs)
  in
    JSONobject(list_vt2t(kvs))
  end // end of [json_type_object]
| _ (*deadcode*) =>
    let val () = assertloc (false) in exit(1) end
//
end // end of [json_object2val1]

(* ****** ****** *)

implement
jsonval_objectify
  (jsv0) = let
//
fun auxarr
(
  jarr: !json_object1
, jsvs: jsonvalist, i: intGte(0)
) : void =
(
  case+ jsvs of
  | list_cons
      (jsv, jsvs) => let
      val jso = jsonval_objectify (jsv)
      val err = json_object_array_add (jarr, jso)
    in
      auxarr (jarr, jsvs, succ(i))
    end // end of [list_cons]
  | list_nil ((*void*)) => ()
)
//
fun auxobj
(
  jobj: !json_object1, ljsvs: labjsonvalist
) : void =
(
  case+ ljsvs of
  | list_cons
      ((l, jsv), ljsvs) => let
      val jso = jsonval_objectify (jsv)
      val ((*void*)) = json_object_object_add (jobj, l, jso)
    in
      auxobj (jobj, ljsvs)
    end // end of [list_cons]
  | list_nil ((*void*)) => ()
)
//
in
//
case+ jsv0 of
//
| JSONnul () =>
    $UN.castvwtp0{json_object0}(the_null_ptr)
//
| JSONint (lli) =>
    json_object_new_int64($UN.cast{int64}(lli))
//
| JSONbool (tf) => json_object_new_boolean (tf)
//
| JSONfloat (dbl) => json_object_new_double (dbl)
//
| JSONstring (str) => json_object_new_string (str)
//
| JSONarray (jsvs) => let
    val jarr = json_object_new_array ()
    val isnot = json_object_isnot_null (jarr)
    val () = if isnot then auxarr (jarr, jsvs, 0)
  in
    jarr
  end // end of [JSONarray]
//
| JSONobject (ljsvs) => let
    val jobj = json_object_new_object ()
    val isnot = json_object_isnot_null (jobj)
    val ((*void*)) = if isnot then auxobj (jobj, ljsvs)
  in
    jobj
  end // end of [JSONobject]
//
end // end of [jsonval_objectify]

(* ****** ****** *)

(* end of [json_ML.dats] *)

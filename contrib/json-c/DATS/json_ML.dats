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
print_jsonVal (x) = fprint (stdout_ref, x)
implement
prerr_jsonVal (x) = fprint (stderr_ref, x)

(* ****** ****** *)

implement
fprint_val<jsonVal> = fprint_jsonVal

(* ****** ****** *)

implement
fprint_jsonVal
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
| JSONstring (str) =>
    fprint! (out, "JSONstring(", str, ")")
| JSONdouble (dbl) =>
    fprint! (out, "JSONdouble(", dbl, ")")
| JSONarray (A, n) =>
  {
    val () = fprint (out, "JSONarray(")
    val () = fprint_arrayref (out, A, n)
    val () = fprint (out, ")")
  }
| JSONobject (lxs) =>
  {
    val () = fprint (out, "JSONobject(")
    val () = fprint_labjsonValist (out, lxs)
    val () = fprint (out, ")")
  }
//
end // end of [fprint_jsonVal]

(* ****** ****** *)

implement
fprint_labjsonValist
  (out, lxs) = let
//
macdef SEP = "; "
macdef MAPTO = ":"
//
fun loop
(
  out: FILEref, lxs: labjsonValist, i: int
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
end // end of [fprint_labjsonValist]

(* ****** ****** *)

implement
jsonVal_ofstring (str) = let
  val jso = json_tokener_parse (str) in json_object2val0 (jso)
end // end of [jsonVal_ofstring]

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
    JSONdouble(dbl)
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
    prval (
    ) = __assert_agz (jso) 
    val [n:int] n = json_object_array_length (jso)
    val (pf, pfgc | p) = array_ptr_alloc<jsonVal> (i2sz(n))
    local
    implement(env)
    json_object_iforeach$fwork<env>
      (i, v, env) =
    {
      val v2 = json_object2val1 (v)
      val p_i = ptr_add<jsonVal> (p, i)
      val () = $UN.ptr0_set (p_i, v2)
    }
    in (* in of [local] *)
    val () = json_object_iforeach (jso)
    end // end of [local]
    val A = $UN.castvwtp0{arrayref(jsonVal,n)}((pf, pfgc | p))
  in
    JSONarray(A, i2sz(n))
  end // end of [json_type_array]
| _ when type =
    json_type_object => let
    prval (
    ) = __assert_agz (jso)
    typedef tenv = ptr
    local
    implement    
    json_object_kforeach$fwork<tenv>
      (k, v, env) =
    {
      val k2 = strptr1_copy(k)
      val k2 = strptr2string(k2)
      val v2 = json_object2val1 (v)
      val kvs = $UN.cast{labjsonValist}(env)
      val kvs = list_cons{labjsonVal}((k2, v2), kvs)
      val ((*void*)) = env := $UN.cast2ptr (kvs)
    }
    in (* in of [local] *)
    var env: tenv = the_null_ptr
    val () = json_object_kforeach_env<tenv> (jso, env)
    end // end of [local]
    val kvs = $UN.castvwtp0{List0_vt(labjsonVal)}(env)
    val kvs = list_vt_reverse<labjsonVal> (kvs)
  in
    JSONobject(list_vt2t(kvs))
  end // end of [json_type_object]
| _ (*deadcode*) =>
    let val () = assertloc (false) in exit(1) end
//
end // end of [json_object2val1]

(* ****** ****** *)

(* end of [json_ML.dats] *)

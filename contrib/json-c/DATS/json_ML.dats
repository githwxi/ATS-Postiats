(*
** A quasi ML-style API for json-c in ATS
*)

(* ****** ****** *)

staload "json-c/SATS/json.sats"
staload "json-c/SATS/json_ML.sats"

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
macdef MAPTO = ": "
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
    JSONint(g0i2i(i))
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
(*
| _ when type = json_type_array =>
| _ when type = json_type_object =>
*)
| _ => let val () = assertloc (false) in exit(1) end
//
end // end of [json_object2val1]

(* ****** ****** *)

(* end of [json_ML.dats] *)

(*
Here is my own attempt of writing the Python program in ATS:
http://roscidus.com/blog/blog/2013/06/09/choosing-a-python-replacement-for-0install/
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Time: June, 2013
//
(* ****** ****** *)

(*
import os, sys, json
envname = os.path.basename(sys.argv[0])
args = json.loads(os.environ["0install-runenv-" + envname])
os.execv(args[0], args + sys.argv[1:])
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
staload
STDLIB = "libc/SATS/stdlib.sats"
staload
UNISTD = "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "libats/SATS/dynarray.sats"
staload _(*anon*) = "libats/DATS/dynarray.dats"

(* ****** ****** *)

staload "json-c/SATS/json.sats"
staload _(*anon*) = "json-c/DATS/json.dats"

(* ****** ****** *)

implement
main {n} (argc, argv) = let
//
val out = stdout_ref
//
val (fpf | envname) = filename_get_base (argv[0])
val envname2 =
string_append ("0install-runenv-", $UN.strptr2string(envname))
prval () = fpf (envname)
//
val (fpf | jstr) = $STDLIB.getenv ($UN.strptr2string(envname2))
val () = strptr_free (envname2)
val () = assertloc (strptr2ptr (jstr) > 0)
//
val jso =
json_tokener_parse ($UN.strptr2string(jstr))
val () = assertloc (ptrcast(jso) > 0)
prval () = fpf (jstr)
//
val alen = json_object_array_length (jso)
//
typedef T = string
vtypedef DA = dynarray(T)
val DA = dynarray_make_nil<T> (i2sz(argc+alen+1))
val () = dynarray_insert_atend_exn (DA, argv[0])
//
val () = let
//
fun loop
(
  DA: !dynarray(T)
, jso: !json_object1, i: intGte(0)
) : void =
(
if i < alen then let
  val (fpf1 | jsi) =
    json_object_array_get_idx (jso, i)
  val (fpf2 | str) = json_object_to_json_string (jsi)
  prval () = minus_addback (fpf1, jsi | jso)
  val str2 = string_copy ($UN.strptr2string(str))
  prval () = fpf2 (str)
  val str2 = strptr2string (str2)
  val () = dynarray_insert_atend_exn (DA, str2)
in
  loop (DA, jso, i+1)
end else () // end of [if]
)
//
in
  loop (DA, jso, 0)
end // end of [val]
//
val () = assertloc (json_object_put (jso) > 0)
//
val () = let
//
fun loop
(
  DA: !dynarray(T)
, argv: !argv(n), i: intGte(1)
) : void =
(
if i < argc then let
  val () = dynarray_insert_atend_exn (DA, argv[i])
in
  loop (DA, argv, i+1)
end else () // end of [if]
)
//
in
  loop (DA, argv, 1)
end // end of [local]
//
val (
) = dynarray_insert_atend_exn (DA, $UN.cast{string}(the_null_ptr))
//
var asz: size_t
val A =
dynarray_getfree_arrayptr (DA, asz)
//
val ec = $UNISTD.execv_unsafe (argv[0], ptrcast(A))
//
val () = arrayptr_free (A) // HX: only if [ec] = -1
//
in
  1(*abnormalexit*)
end // end of [main]

(* ****** ****** *)

(* end of [for-0install.dats] *)

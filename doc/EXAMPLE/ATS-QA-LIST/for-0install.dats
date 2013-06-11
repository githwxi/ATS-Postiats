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

(* ****** ****** *)

staload "json-c/SATS/json.sats"

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
val () = fprintln! (out, "envname2 = ", envname2)
//
val (fpf | jstr) = $STDLIB.getenv ($UN.strptr2string(envname2))
val () = strptr_free (envname2)
val () = assertmsgloc (strptr2ptr (jstr) > 0, "undefined environment variable:\n")
//
val jso =
json_tokener_parse ($UN.strptr2string(jstr))
val () = assertloc (ptrcast(jso) > 0)
prval () = fpf (jstr)
//
val () = fprintln! (out, "jso = ", jso)
//
implement
array_tabulate$fwork<string> (i) =
  case+ i of
  | _ when i = 0 => argv[0]
  | _ when i <= alen => tostring (json_object_array_get (i-1))
  | _ when i < alen+argc => argv[i-alen]
  | _ => stropt_none ()
//
val A = arrayptr_tabulate<string>()
//
val () = assertloc (json_object_put (jso) > 0)
//
val () = execv ....
//
in
  0(*normalexit*)
end // end of [main]

(* ****** ****** *)

(* end of [for-0install.dats] *)

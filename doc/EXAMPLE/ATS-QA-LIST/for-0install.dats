(*
import os, sys, json
envname = os.path.basename(sys.argv[0])
args = json.loads(os.environ["0install-runenv-" + envname])
os.execv(args[0], args + sys.argv[1:])
*)

(* ****** ****** *)

implement
main (argc, argv) = let
//
val envname = filename_get_basename (argv[0])
val envname2 = "0install-runenv-" + envname

val (fpf | jstr) = getenv ($UN.strptr2string(envname2))
val () = strptr_free (envname2)
val () = assertloc (ptrcast (jstr) > 0)

val jso = json_tokener_parse ($UN.strptr2string (jstr))
val (fpf | jsa) = json_object_get_array (jso)
val () = assertloc (ptrcast (jsa) > 0)

val length = array_list_get length (jsa)
fun f (i) = if i < length then ... else if i < ... then ... else ...
val () = arrayptr_tabulate (...)
//
prval () = fpf (jsa)
//
val () = execv (argv[0], ...)
val ...
//
in
end // end of [main]

(* ****** ****** *)

(* end of [for-0install.dats] *)

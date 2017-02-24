(*
** HX-2014-05:
** Toplevel hashtable_chain
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload HT =
{
//
typedef key = string
typedef itm = int(*0/1*)
//
#define CAPACITY 1024
//
staload _ ="libats/DATS/qlist.dats"
//
#include "./../HATS/ghashtbl_chain.hats"
//
} (* end of [staload] *)

(* ****** ****** *)

#define WORDS "/usr/share/dict/words"

(* ****** ****** *)

implement
main0(argc, argv) = let
//
(*
val () =
println! ("$HT.get_size() = ", $HT.get_size())
val () =
println! ("$HT.get_capacity() = ", $HT.get_capacity())
*)
//
val opt =
fileref_open_opt(WORDS, file_mode_r)
//
in
//
case+ opt of
| ~None_vt() => ()
| ~Some_vt(filr) =>
{
//
val () =
loop(filr) where
{
fun loop
(
  filr: FILEref
) : void = let
  val isnot = fileref_isnot_eof(filr)
in
  if isnot
    then let
      val str =
        fileref_get_line_string (filr)
      val str = strptr2string (str)
      val-~None_vt() = $HT.insert_opt (str, 1)
    in
      loop (filr)
    end // end of [then]
    else () // end of [else]
  // end of [if]
end // end of [loop]
} (* end of [val] *)
//
val ((*void*)) = fileref_close (filr)
//
val () =
println! ("$HT.get_size() = ", $HT.get_size())
val () =
println! ("$HT.get_capacity() = ", $HT.get_capacity())
//
val () = assertloc(cptr2ptr($HT.search_ref("zucchini")) > 0)
val () = assertloc(cptr2ptr($HT.search_ref("Geizella")) = 0)
val () = assertloc(cptr2ptr($HT.search_ref("Anairiats")) = 0)
val () = assertloc(cptr2ptr($HT.search_ref("Postiats")) = 0)
//
} (* end of [where] *)
//
end (* end of [main0] *)

(* ****** ****** *)

(* end of [test05-1.dats] *)

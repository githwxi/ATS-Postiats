(*
** HX-2014-05:
** Toplevel hashtable_linprb
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
#include "./../HATS/ghashtbl_linprb.hats"
//
} (* end of [staload] *)

(* ****** ****** *)

#define WORDS "/usr/share/dict/words"

(* ****** ****** *)

implement
main0 () =
{
//
(*
val () =
println! ("$HT.get_size() = ", $HT.get_size())
val () =
println! ("$HT.get_capacity() = ", $HT.get_capacity())
*)
//
val-~Some_vt(filr) = fileref_open_opt (WORDS, file_mode_r)
//
val () = let
//
fun loop
(
  filr: FILEref
) : void = let
  val isnot = fileref_isnot_eof (filr)
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
//
in
  loop (filr)
end // end of [val]
//
val ((*void*)) = fileref_close (filr)
//
val () =
println! ("$HT.get_size() = ", $HT.get_size())
val () =
println! ("$HT.get_capacity() = ", $HT.get_capacity())
//
val () = assertloc (cptr2ptr($HT.search_ref ("zucchini")) > 0)
val () = assertloc (cptr2ptr($HT.search_ref ("Geizella")) = 0)
val () = assertloc (cptr2ptr($HT.search_ref ("Anairiats")) = 0)
val () = assertloc (cptr2ptr($HT.search_ref ("Postiats")) = 0)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test05-2.dats] *)

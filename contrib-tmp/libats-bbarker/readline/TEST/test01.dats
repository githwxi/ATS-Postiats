(*
** testing code for GNU-readline
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/readline.sats"

(* ****** ****** *)

implement
main0 () = () where
{
//
val line = readline ("Enter a line: ")
val () = println! ("line = ", line)
val () = strptr_free (line)
//
val () = println! ("Testing string variants ...")
// c code: printf( "%s\n", readline( "test> " ) );
val line = readline_string("test>")
val () = println! (line)

// Why can't I do this? Need to get my strings down...
// val () = println! (readline_string("test>"))

val prmpt = "test2> "
val prmpt2 = string0_copy (prmpt)  
//val () = println! (readline_strptr( prmpt2 ))
val () = println! (readline_string_n("test3> "))
val () = println! (readline( "test4> "))    
//Apparently, readline does not play nice with this free (test2):
val () = strptr_free(prmpt2)

} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

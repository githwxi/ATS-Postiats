(*
main.atxt: 1(line=1, offs=1) -- 44(line=3, offs=3)
*)

#include "./../MYTEXT/mytextfun.hats"

(*
main.atxt: 196(line=13, offs=2) -- 212(line=13, offs=18)
*)
val __tok1 = patscode_style()
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
main.atxt: 214(line=14, offs=2) -- 230(line=14, offs=18)
*)
val __tok2 = patspage_style()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
main.atxt: 321(line=24, offs=3) -- 641(line=31, offs=3)
*)
val __tok3 = para("\
A great strength in functional programming lies
in its support for a combinator-based style of programming.
In this article, I would like to present some examples
that make extensive use of sequence-processing combinators,
where a sequence may refer to either a list or a stream (that is,
a lazy list) in ATS.
")
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
main.atxt: 643(line=31, offs=5) -- 658(line=31, offs=20)
*)
val __tok4 = comment("para")
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
main.atxt: 798(line=40, offs=2) -- 815(line=40, offs=19)
*)
val __tok5 = patspage_script()
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
main.atxt: 833(line=44, offs=1) -- 902(line=46, offs=3)
*)

implement main () = fprint_filsub (stdout_ref, "main_atxt.txt")


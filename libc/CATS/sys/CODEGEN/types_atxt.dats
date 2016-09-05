(*
types.atxt: 1(line=1, offs=1) -- 253(line=8, offs=3)
*)

#define ATSCODEFORMAT "txt"
#if (ATSCODEFORMAT == "txt")
#include "utils/atsdoc/HATS/postiatsatxt.hats"
#endif // end of [ATSCCODEFORMAT]
val _thisfilename = atext_strcst"types.cats"
val () = theAtextMap_insert_str ("thisfilename", _thisfilename)

(*
types.atxt: 258(line=10, offs=2) -- 280(line=10, offs=24)
*)
val __tok1 = atscode_banner_for_C()
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
types.atxt: 282(line=11, offs=2) -- 311(line=11, offs=31)
*)
val __tok2 = atscode_copyright_GPL_for_C()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
types.atxt: 314(line=13, offs=2) -- 339(line=13, offs=27)
*)
val __tok3 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
types.atxt: 425(line=18, offs=25) -- 436(line=18, offs=36)
*)
val __tok4 = timestamp()
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
types.atxt: 442(line=21, offs=2) -- 467(line=21, offs=27)
*)
val __tok5 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
types.atxt: 473(line=24, offs=2) -- 501(line=24, offs=30)
*)
val __tok6 = atscode_author("Hongwei Xi")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
types.atxt: 503(line=25, offs=2) -- 551(line=25, offs=50)
*)
val __tok7 = atscode_authoremail("hwxi AT cs DOT bu DOT edu")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
types.atxt: 553(line=26, offs=2) -- 586(line=26, offs=35)
*)
val __tok8 = atscode_start_time("March, 2013")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
types.atxt: 592(line=29, offs=2) -- 617(line=29, offs=27)
*)
val __tok9 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
types.atxt: 693(line=34, offs=2) -- 718(line=34, offs=27)
*)
val __tok10 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
types.atxt: 746(line=38, offs=2) -- 771(line=38, offs=27)
*)
val __tok11 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
types.atxt: 809(line=42, offs=2) -- 834(line=42, offs=27)
*)
val __tok12 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
types.atxt: 968(line=50, offs=2) -- 993(line=50, offs=27)
*)
val __tok13 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok13", __tok13)

(*
types.atxt: 1171(line=61, offs=2) -- 1196(line=61, offs=27)
*)
val __tok14 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok14", __tok14)

(*
types.atxt: 1264(line=66, offs=2) -- 1289(line=66, offs=27)
*)
val __tok15 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok15", __tok15)

(*
types.atxt: 1389(line=72, offs=2) -- 1414(line=72, offs=27)
*)
val __tok16 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok16", __tok16)

(*
types.atxt: 1733(line=94, offs=2) -- 1758(line=94, offs=27)
*)
val __tok17 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok17", __tok17)

(*
types.atxt: 2675(line=141, offs=2) -- 2700(line=141, offs=27)
*)
val __tok18 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok18", __tok18)

(*
types.atxt: 2749(line=145, offs=2) -- 2774(line=145, offs=27)
*)
val __tok19 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok19", __tok19)

(*
types.atxt: 2777(line=147, offs=2) -- 2820(line=147, offs=45)
*)
val __tok20 = atscode_eof_strsub_for_C("#thisfilename$")
val () = theAtextMap_insert_str ("__tok20", __tok20)

(*
types.atxt: 2823(line=149, offs=1) -- 2903(line=152, offs=3)
*)

implement
main (argc, argv) = fprint_filsub (stdout_ref, "types_atxt.txt")


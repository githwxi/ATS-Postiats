(*
stat.atxt: 1(line=1, offs=1) -- 252(line=8, offs=3)
*)

#define ATSCODEFORMAT "txt"
#if (ATSCODEFORMAT == "txt")
#include "utils/atsdoc/HATS/postiatsatxt.hats"
#endif // end of [ATSCCODEFORMAT]
val _thisfilename = atext_strcst"stat.cats"
val () = theAtextMap_insert_str ("thisfilename", _thisfilename)

(*
stat.atxt: 257(line=10, offs=2) -- 279(line=10, offs=24)
*)
val __tok1 = atscode_banner_for_C()
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
stat.atxt: 281(line=11, offs=2) -- 310(line=11, offs=31)
*)
val __tok2 = atscode_copyright_GPL_for_C()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
stat.atxt: 313(line=13, offs=2) -- 338(line=13, offs=27)
*)
val __tok3 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
stat.atxt: 423(line=18, offs=25) -- 434(line=18, offs=36)
*)
val __tok4 = timestamp()
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
stat.atxt: 440(line=21, offs=2) -- 465(line=21, offs=27)
*)
val __tok5 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
stat.atxt: 471(line=24, offs=2) -- 499(line=24, offs=30)
*)
val __tok6 = atscode_author("Hongwei Xi")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
stat.atxt: 501(line=25, offs=2) -- 549(line=25, offs=50)
*)
val __tok7 = atscode_authoremail("hwxi AT cs DOT bu DOT edu")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
stat.atxt: 551(line=26, offs=2) -- 584(line=26, offs=35)
*)
val __tok8 = atscode_start_time("March, 2013")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
stat.atxt: 590(line=29, offs=2) -- 615(line=29, offs=27)
*)
val __tok9 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
stat.atxt: 689(line=34, offs=2) -- 714(line=34, offs=27)
*)
val __tok10 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
stat.atxt: 741(line=38, offs=2) -- 766(line=38, offs=27)
*)
val __tok11 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
stat.atxt: 811(line=44, offs=2) -- 836(line=44, offs=27)
*)
val __tok12 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
stat.atxt: 868(line=48, offs=2) -- 893(line=48, offs=27)
*)
val __tok13 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok13", __tok13)

(*
stat.atxt: 925(line=52, offs=2) -- 950(line=52, offs=27)
*)
val __tok14 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok14", __tok14)

(*
stat.atxt: 1014(line=57, offs=2) -- 1039(line=57, offs=27)
*)
val __tok15 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok15", __tok15)

(*
stat.atxt: 1073(line=61, offs=2) -- 1098(line=61, offs=27)
*)
val __tok16 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok16", __tok16)

(*
stat.atxt: 1184(line=67, offs=2) -- 1209(line=67, offs=27)
*)
val __tok17 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok17", __tok17)

(*
stat.atxt: 1257(line=71, offs=2) -- 1282(line=71, offs=27)
*)
val __tok18 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok18", __tok18)

(*
stat.atxt: 1285(line=73, offs=2) -- 1328(line=73, offs=45)
*)
val __tok19 = atscode_eof_strsub_for_C("#thisfilename$")
val () = theAtextMap_insert_str ("__tok19", __tok19)

(*
stat.atxt: 1331(line=75, offs=1) -- 1410(line=78, offs=3)
*)

implement
main (argc, argv) = fprint_filsub (stdout_ref, "stat_atxt.txt")


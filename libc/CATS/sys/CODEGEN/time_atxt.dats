(*
time.atxt: 1(line=1, offs=1) -- 252(line=8, offs=3)
*)

#define ATSCODEFORMAT "txt"
#if (ATSCODEFORMAT == "txt")
#include "utils/atsdoc/HATS/postiatsatxt.hats"
#endif // end of [ATSCCODEFORMAT]
val _thisfilename = atext_strcst"time.cats"
val () = theAtextMap_insert_str ("thisfilename", _thisfilename)

(*
time.atxt: 257(line=10, offs=2) -- 279(line=10, offs=24)
*)
val __tok1 = atscode_banner_for_C()
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
time.atxt: 281(line=11, offs=2) -- 310(line=11, offs=31)
*)
val __tok2 = atscode_copyright_GPL_for_C()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
time.atxt: 313(line=13, offs=2) -- 338(line=13, offs=27)
*)
val __tok3 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
time.atxt: 423(line=18, offs=25) -- 434(line=18, offs=36)
*)
val __tok4 = timestamp()
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
time.atxt: 440(line=21, offs=2) -- 465(line=21, offs=27)
*)
val __tok5 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
time.atxt: 471(line=24, offs=2) -- 499(line=24, offs=30)
*)
val __tok6 = atscode_author("Hongwei Xi")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
time.atxt: 501(line=25, offs=2) -- 549(line=25, offs=50)
*)
val __tok7 = atscode_authoremail("hwxi AT cs DOT bu DOT edu")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
time.atxt: 551(line=26, offs=2) -- 585(line=26, offs=36)
*)
val __tok8 = atscode_start_time("August, 2013")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
time.atxt: 591(line=29, offs=2) -- 616(line=29, offs=27)
*)
val __tok9 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
time.atxt: 690(line=34, offs=2) -- 715(line=34, offs=27)
*)
val __tok10 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
time.atxt: 742(line=38, offs=2) -- 767(line=38, offs=27)
*)
val __tok11 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
time.atxt: 863(line=43, offs=2) -- 888(line=43, offs=27)
*)
val __tok12 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
time.atxt: 1192(line=52, offs=2) -- 1217(line=52, offs=27)
*)
val __tok13 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok13", __tok13)

(*
time.atxt: 1319(line=58, offs=2) -- 1344(line=58, offs=27)
*)
val __tok14 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok14", __tok14)

(*
time.atxt: 1542(line=66, offs=2) -- 1567(line=66, offs=27)
*)
val __tok15 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok15", __tok15)

(*
time.atxt: 1615(line=70, offs=2) -- 1640(line=70, offs=27)
*)
val __tok16 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok16", __tok16)

(*
time.atxt: 1643(line=72, offs=2) -- 1686(line=72, offs=45)
*)
val __tok17 = atscode_eof_strsub_for_C("#thisfilename$")
val () = theAtextMap_insert_str ("__tok17", __tok17)

(*
time.atxt: 1689(line=74, offs=1) -- 1768(line=77, offs=3)
*)

implement
main (argc, argv) = fprint_filsub (stdout_ref, "time_atxt.txt")


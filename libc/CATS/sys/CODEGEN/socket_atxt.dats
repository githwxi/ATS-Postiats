(*
socket.atxt: 1(line=1, offs=1) -- 254(line=8, offs=3)
*)

#define ATSCODEFORMAT "txt"
#if (ATSCODEFORMAT == "txt")
#include "utils/atsdoc/HATS/postiatsatxt.hats"
#endif // end of [ATSCCODEFORMAT]
val _thisfilename = atext_strcst"socket.cats"
val () = theAtextMap_insert_str ("thisfilename", _thisfilename)

(*
socket.atxt: 259(line=10, offs=2) -- 281(line=10, offs=24)
*)
val __tok1 = atscode_banner_for_C()
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
socket.atxt: 283(line=11, offs=2) -- 312(line=11, offs=31)
*)
val __tok2 = atscode_copyright_GPL_for_C()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
socket.atxt: 315(line=13, offs=2) -- 340(line=13, offs=27)
*)
val __tok3 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
socket.atxt: 427(line=18, offs=25) -- 438(line=18, offs=36)
*)
val __tok4 = timestamp()
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
socket.atxt: 444(line=21, offs=2) -- 469(line=21, offs=27)
*)
val __tok5 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
socket.atxt: 475(line=24, offs=2) -- 503(line=24, offs=30)
*)
val __tok6 = atscode_author("Hongwei Xi")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
socket.atxt: 505(line=25, offs=2) -- 547(line=25, offs=44)
*)
val __tok7 = atscode_authoremail("gmhwxiATgmailDOTcom")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
socket.atxt: 549(line=26, offs=2) -- 585(line=26, offs=38)
*)
val __tok8 = atscode_start_time("November, 2014")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
socket.atxt: 591(line=29, offs=2) -- 616(line=29, offs=27)
*)
val __tok9 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
socket.atxt: 694(line=34, offs=2) -- 719(line=34, offs=27)
*)
val __tok10 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
socket.atxt: 773(line=39, offs=2) -- 798(line=39, offs=27)
*)
val __tok11 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
socket.atxt: 836(line=43, offs=2) -- 861(line=43, offs=27)
*)
val __tok12 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
socket.atxt: 1002(line=52, offs=2) -- 1027(line=52, offs=27)
*)
val __tok13 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok13", __tok13)

(*
socket.atxt: 1123(line=57, offs=2) -- 1148(line=57, offs=27)
*)
val __tok14 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok14", __tok14)

(*
socket.atxt: 1354(line=70, offs=2) -- 1379(line=70, offs=27)
*)
val __tok15 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok15", __tok15)

(*
socket.atxt: 1504(line=79, offs=2) -- 1529(line=79, offs=27)
*)
val __tok16 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok16", __tok16)

(*
socket.atxt: 1747(line=92, offs=2) -- 1772(line=92, offs=27)
*)
val __tok17 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok17", __tok17)

(*
socket.atxt: 1948(line=101, offs=2) -- 1973(line=101, offs=27)
*)
val __tok18 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok18", __tok18)

(*
socket.atxt: 2020(line=105, offs=2) -- 2045(line=105, offs=27)
*)
val __tok19 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok19", __tok19)

(*
socket.atxt: 2101(line=109, offs=2) -- 2126(line=109, offs=27)
*)
val __tok20 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok20", __tok20)

(*
socket.atxt: 2284(line=116, offs=2) -- 2309(line=116, offs=27)
*)
val __tok21 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok21", __tok21)

(*
socket.atxt: 2359(line=120, offs=2) -- 2384(line=120, offs=27)
*)
val __tok22 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok22", __tok22)

(*
socket.atxt: 2387(line=122, offs=2) -- 2430(line=122, offs=45)
*)
val __tok23 = atscode_eof_strsub_for_C("#thisfilename$")
val () = theAtextMap_insert_str ("__tok23", __tok23)

(*
socket.atxt: 2433(line=124, offs=1) -- 2514(line=127, offs=3)
*)

implement
main (argc, argv) = fprint_filsub (stdout_ref, "socket_atxt.txt")


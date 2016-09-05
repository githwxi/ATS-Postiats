(*
socket_in.atxt: 1(line=1, offs=1) -- 257(line=8, offs=3)
*)

#define ATSCODEFORMAT "txt"
#if (ATSCODEFORMAT == "txt")
#include "utils/atsdoc/HATS/postiatsatxt.hats"
#endif // end of [ATSCCODEFORMAT]
val _thisfilename = atext_strcst"socket_in.cats"
val () = theAtextMap_insert_str ("thisfilename", _thisfilename)

(*
socket_in.atxt: 262(line=10, offs=2) -- 284(line=10, offs=24)
*)
val __tok1 = atscode_banner_for_C()
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
socket_in.atxt: 286(line=11, offs=2) -- 315(line=11, offs=31)
*)
val __tok2 = atscode_copyright_GPL_for_C()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
socket_in.atxt: 318(line=13, offs=2) -- 343(line=13, offs=27)
*)
val __tok3 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
socket_in.atxt: 433(line=18, offs=25) -- 444(line=18, offs=36)
*)
val __tok4 = timestamp()
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
socket_in.atxt: 450(line=21, offs=2) -- 475(line=21, offs=27)
*)
val __tok5 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
socket_in.atxt: 481(line=24, offs=2) -- 509(line=24, offs=30)
*)
val __tok6 = atscode_author("Hongwei Xi")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
socket_in.atxt: 511(line=25, offs=2) -- 553(line=25, offs=44)
*)
val __tok7 = atscode_authoremail("gmhwxiATgmailDOTcom")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
socket_in.atxt: 555(line=26, offs=2) -- 591(line=26, offs=38)
*)
val __tok8 = atscode_start_time("November, 2014")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
socket_in.atxt: 597(line=29, offs=2) -- 622(line=29, offs=27)
*)
val __tok9 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
socket_in.atxt: 706(line=34, offs=2) -- 731(line=34, offs=27)
*)
val __tok10 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
socket_in.atxt: 789(line=39, offs=2) -- 814(line=39, offs=27)
*)
val __tok11 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
socket_in.atxt: 1250(line=61, offs=2) -- 1275(line=61, offs=27)
*)
val __tok12 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
socket_in.atxt: 1328(line=65, offs=2) -- 1353(line=65, offs=27)
*)
val __tok13 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok13", __tok13)

(*
socket_in.atxt: 1356(line=67, offs=2) -- 1399(line=67, offs=45)
*)
val __tok14 = atscode_eof_strsub_for_C("#thisfilename$")
val () = theAtextMap_insert_str ("__tok14", __tok14)

(*
socket_in.atxt: 1402(line=69, offs=1) -- 1486(line=72, offs=3)
*)

implement
main (argc, argv) = fprint_filsub (stdout_ref, "socket_in_atxt.txt")


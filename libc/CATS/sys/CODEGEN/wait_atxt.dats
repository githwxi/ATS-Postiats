(*
wait.atxt: 1(line=1, offs=1) -- 252(line=8, offs=3)
*)

#define ATSCODEFORMAT "txt"
#if (ATSCODEFORMAT == "txt")
#include "utils/atsdoc/HATS/postiatsatxt.hats"
#endif // end of [ATSCCODEFORMAT]
val _thisfilename = atext_strcst"wait.cats"
val () = theAtextMap_insert_str ("thisfilename", _thisfilename)

(*
wait.atxt: 257(line=10, offs=2) -- 279(line=10, offs=24)
*)
val __tok1 = atscode_banner_for_C()
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
wait.atxt: 281(line=11, offs=2) -- 310(line=11, offs=31)
*)
val __tok2 = atscode_copyright_GPL_for_C()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
wait.atxt: 313(line=13, offs=2) -- 338(line=13, offs=27)
*)
val __tok3 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
wait.atxt: 423(line=18, offs=25) -- 434(line=18, offs=36)
*)
val __tok4 = timestamp()
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
wait.atxt: 440(line=21, offs=2) -- 465(line=21, offs=27)
*)
val __tok5 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
wait.atxt: 471(line=24, offs=2) -- 499(line=24, offs=30)
*)
val __tok6 = atscode_author("Hongwei Xi")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
wait.atxt: 501(line=25, offs=2) -- 549(line=25, offs=50)
*)
val __tok7 = atscode_authoremail("hwxi AT cs DOT bu DOT edu")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
wait.atxt: 551(line=26, offs=2) -- 586(line=26, offs=37)
*)
val __tok8 = atscode_start_time("October, 2013")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
wait.atxt: 592(line=29, offs=2) -- 617(line=29, offs=27)
*)
val __tok9 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
wait.atxt: 691(line=34, offs=2) -- 716(line=34, offs=27)
*)
val __tok10 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
wait.atxt: 747(line=38, offs=2) -- 772(line=38, offs=27)
*)
val __tok11 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
wait.atxt: 867(line=43, offs=2) -- 892(line=43, offs=27)
*)
val __tok12 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
wait.atxt: 940(line=47, offs=2) -- 965(line=47, offs=27)
*)
val __tok13 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok13", __tok13)

(*
wait.atxt: 968(line=49, offs=2) -- 1011(line=49, offs=45)
*)
val __tok14 = atscode_eof_strsub_for_C("#thisfilename$")
val () = theAtextMap_insert_str ("__tok14", __tok14)

(*
wait.atxt: 1014(line=51, offs=1) -- 1093(line=54, offs=3)
*)

implement
main (argc, argv) = fprint_filsub (stdout_ref, "wait_atxt.txt")


(*
mman.atxt: 1(line=1, offs=1) -- 252(line=8, offs=3)
*)

#define ATSCODEFORMAT "txt"
#if (ATSCODEFORMAT == "txt")
#include "utils/atsdoc/HATS/postiatsatxt.hats"
#endif // end of [ATSCCODEFORMAT]
val _thisfilename = atext_strcst"mman.cats"
val () = theAtextMap_insert_str ("thisfilename", _thisfilename)

(*
mman.atxt: 257(line=10, offs=2) -- 279(line=10, offs=24)
*)
val __tok1 = atscode_banner_for_C()
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
mman.atxt: 281(line=11, offs=2) -- 310(line=11, offs=31)
*)
val __tok2 = atscode_copyright_GPL_for_C()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
mman.atxt: 313(line=13, offs=2) -- 338(line=13, offs=27)
*)
val __tok3 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
mman.atxt: 423(line=18, offs=25) -- 434(line=18, offs=36)
*)
val __tok4 = timestamp()
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
mman.atxt: 440(line=21, offs=2) -- 465(line=21, offs=27)
*)
val __tok5 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
mman.atxt: 471(line=24, offs=2) -- 499(line=24, offs=30)
*)
val __tok6 = atscode_author("Hongwei Xi")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
mman.atxt: 501(line=25, offs=2) -- 549(line=25, offs=50)
*)
val __tok7 = atscode_authoremail("hwxi AT cs DOT bu DOT edu")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
mman.atxt: 551(line=26, offs=2) -- 586(line=26, offs=37)
*)
val __tok8 = atscode_start_time("October, 2013")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
mman.atxt: 592(line=29, offs=2) -- 617(line=29, offs=27)
*)
val __tok9 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
mman.atxt: 691(line=34, offs=2) -- 716(line=34, offs=27)
*)
val __tok10 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
mman.atxt: 794(line=41, offs=2) -- 819(line=41, offs=27)
*)
val __tok11 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
mman.atxt: 895(line=46, offs=2) -- 920(line=46, offs=27)
*)
val __tok12 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
mman.atxt: 968(line=50, offs=2) -- 993(line=50, offs=27)
*)
val __tok13 = atscode_separator_for_C()
val () = theAtextMap_insert_str ("__tok13", __tok13)

(*
mman.atxt: 996(line=52, offs=2) -- 1039(line=52, offs=45)
*)
val __tok14 = atscode_eof_strsub_for_C("#thisfilename$")
val () = theAtextMap_insert_str ("__tok14", __tok14)

(*
mman.atxt: 1042(line=54, offs=1) -- 1121(line=57, offs=3)
*)

implement
main (argc, argv) = fprint_filsub (stdout_ref, "mman_atxt.txt")


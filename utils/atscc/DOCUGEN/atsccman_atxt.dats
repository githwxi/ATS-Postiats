(*
atsccman.atxt: 1(line=1, offs=1) -- 100(line=7, offs=3)
*)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: July, 2013
*)

(*
atsccman.atxt: 102(line=9, offs=1) -- 196(line=15, offs=3)
*)

//
dynload "libatsdoc/dynloadall.dats"
//
#include "utils/atsdoc/HATS/xhtmlatxt.hats"
//

(*
atsccman.atxt: 198(line=17, offs=1) -- 433(line=22, offs=3)
*)

macdef para (x) = xmltagging ("p", ,(x)) // paragraph
macdef command (x) = xmltagging ("strong", ,(x)) // boldfaced
macdef iemph (x) = xmltagging ("i", ,(x)) // underlining
macdef uemph (x) = xmltagging ("u", ,(x)) // underlining

(*
atsccman.atxt: 436(line=24, offs=2) -- 715(line=33, offs=3)
*)
val __tok1 = atext_strcst("\
<!DOCTYPE html \
PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\">
<head>
  <title></title>
  <meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/>
</head>
")
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
atsccman.atxt: 716(line=33, offs=4) -- 735(line=33, offs=23)
*)
val __tok2 = comment("textcopy")
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
atsccman.atxt: 746(line=37, offs=2) -- 757(line=37, offs=13)
*)
val __tok3 = H1("atscc")
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
atsccman.atxt: 789(line=41, offs=2) -- 815(line=41, offs=28)
*)
val __tok4 = comment(" ****** ****** ")
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
atsccman.atxt: 840(line=45, offs=14) -- 856(line=45, offs=30)
*)
val __tok6 = command("atscc")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
atsccman.atxt: 922(line=46, offs=26) -- 939(line=46, offs=43)
*)
val __tok7 = command("atsopt")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
atsccman.atxt: 979(line=47, offs=7) -- 996(line=47, offs=24)
*)
val __tok8 = command("patscc")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
atsccman.atxt: 1031(line=47, offs=59) -- 1047(line=47, offs=75)
*)
val __tok9 = command("atscc")
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
atsccman.atxt: 1189(line=50, offs=2) -- 1206(line=50, offs=19)
*)
val __tok10 = command("atsopt")
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
atsccman.atxt: 818(line=43, offs=2) -- 1329(line=53, offs=3)
*)
val __tok5 = para("\

The command #__tok6$ is a wrapper for convenience around the
ATS-compilation command #__tok7$. Sometimes, it is also given the
name #__tok8$. In a command-line starting with #__tok9$,
each file containing ATS code is first to be replaced with a corresponding
file containing C code generated from compiling the ATS code by
#__tok10$. Then a C-compilation command (such as gcc and clang) is
invoked to process the files containing the generated C code.

")
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
atsccman.atxt: 1332(line=55, offs=2) -- 1359(line=55, offs=29)
*)
val __tok11 = H2("Environment Variables")
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
atsccman.atxt: 1374(line=59, offs=2) -- 1389(line=59, offs=17)
*)
val __tok12 = uemph("ATSOPT")
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
atsccman.atxt: 1502(line=61, offs=36) -- 1517(line=61, offs=51)
*)
val __tok13 = iemph("atsopt")
val () = theAtextMap_insert_str ("__tok13", __tok13)

(*
atsccman.atxt: 1537(line=64, offs=2) -- 1554(line=64, offs=19)
*)
val __tok14 = uemph("ATSCCOMP")
val () = theAtextMap_insert_str ("__tok14", __tok14)

(*
atsccman.atxt: 1688(line=68, offs=2) -- 1791(line=70, offs=3)
*)
val __tok15 = textpre("\
gcc -D_XOPEN_SOURCE -I${ATSHOME} -I${ATSHOME}/ccomp/runtime -L${ATSHOME}/ccomp/atslib/lib
")
val () = theAtextMap_insert_str ("__tok15", __tok15)

(*
atsccman.atxt: 1803(line=74, offs=2) -- 1829(line=74, offs=28)
*)
val __tok16 = comment(" ****** ****** ")
val () = theAtextMap_insert_str ("__tok16", __tok16)

(*
atsccman.atxt: 1832(line=76, offs=2) -- 1862(line=76, offs=32)
*)
val __tok17 = H2("Option-controlling Flags")
val () = theAtextMap_insert_str ("__tok17", __tok17)

(*
atsccman.atxt: 1877(line=80, offs=2) -- 1891(line=80, offs=16)
*)
val __tok18 = uemph("-vats")
val () = theAtextMap_insert_str ("__tok18", __tok18)

(*
atsccman.atxt: 1944(line=81, offs=52) -- 1961(line=81, offs=69)
*)
val __tok19 = command("atsopt")
val () = theAtextMap_insert_str ("__tok19", __tok19)

(*
atsccman.atxt: 1970(line=84, offs=2) -- 1985(line=84, offs=17)
*)
val __tok20 = uemph("-ccats")
val () = theAtextMap_insert_str ("__tok20", __tok20)

(*
atsccman.atxt: 2013(line=85, offs=27) -- 2029(line=85, offs=43)
*)
val __tok21 = command("atscc")
val () = theAtextMap_insert_str ("__tok21", __tok21)

(*
atsccman.atxt: 2193(line=90, offs=2) -- 2208(line=90, offs=17)
*)
val __tok22 = uemph("-tcats")
val () = theAtextMap_insert_str ("__tok22", __tok22)

(*
atsccman.atxt: 2236(line=91, offs=27) -- 2252(line=91, offs=43)
*)
val __tok23 = command("atscc")
val () = theAtextMap_insert_str ("__tok23", __tok23)

(*
atsccman.atxt: 2317(line=95, offs=2) -- 2333(line=95, offs=18)
*)
val __tok24 = uemph("--gline")
val () = theAtextMap_insert_str ("__tok24", __tok24)

(*
atsccman.atxt: 2359(line=96, offs=25) -- 2376(line=96, offs=42)
*)
val __tok25 = command("atsopt")
val () = theAtextMap_insert_str ("__tok25", __tok25)

(*
atsccman.atxt: 2448(line=100, offs=2) -- 2466(line=100, offs=20)
*)
val __tok26 = uemph("-cleanaft")
val () = theAtextMap_insert_str ("__tok26", __tok26)

(*
atsccman.atxt: 2520(line=102, offs=52) -- 2537(line=102, offs=69)
*)
val __tok27 = command("atsopt")
val () = theAtextMap_insert_str ("__tok27", __tok27)

(*
atsccman.atxt: 2606(line=106, offs=2) -- 2624(line=106, offs=20)
*)
val __tok28 = uemph("-atsccomp")
val () = theAtextMap_insert_str ("__tok28", __tok28)

(*
atsccman.atxt: 2904(line=113, offs=2) -- 2918(line=113, offs=16)
*)
val __tok29 = uemph("-DATS")
val () = theAtextMap_insert_str ("__tok29", __tok29)

(*
atsccman.atxt: 3054(line=116, offs=2) -- 3071(line=116, offs=19)
*)
val __tok30 = command("atsopt")
val () = theAtextMap_insert_str ("__tok30", __tok30)

(*
atsccman.atxt: 3106(line=119, offs=2) -- 3121(line=119, offs=17)
*)
val __tok31 = uemph("-DDATS")
val () = theAtextMap_insert_str ("__tok31", __tok31)

(*
atsccman.atxt: 3262(line=122, offs=2) -- 3279(line=122, offs=19)
*)
val __tok32 = command("atsopt")
val () = theAtextMap_insert_str ("__tok32", __tok32)

(*
atsccman.atxt: 3355(line=126, offs=2) -- 3369(line=126, offs=16)
*)
val __tok33 = uemph("-IATS")
val () = theAtextMap_insert_str ("__tok33", __tok33)

(*
atsccman.atxt: 3434(line=128, offs=2) -- 3451(line=128, offs=19)
*)
val __tok34 = command("atsopt")
val () = theAtextMap_insert_str ("__tok34", __tok34)

(*
atsccman.atxt: 3479(line=131, offs=2) -- 3494(line=131, offs=17)
*)
val __tok35 = uemph("-IIATS")
val () = theAtextMap_insert_str ("__tok35", __tok35)

(*
atsccman.atxt: 3565(line=134, offs=2) -- 3582(line=134, offs=19)
*)
val __tok36 = command("atsopt")
val () = theAtextMap_insert_str ("__tok36", __tok36)

(*
atsccman.atxt: 3651(line=138, offs=2) -- 3666(line=138, offs=17)
*)
val __tok37 = uemph("-fsats")
val () = theAtextMap_insert_str ("__tok37", __tok37)

(*
atsccman.atxt: 3767(line=140, offs=28) -- 3782(line=140, offs=43)
*)
val __tok38 = iemph("static")
val () = theAtextMap_insert_str ("__tok38", __tok38)

(*
atsccman.atxt: 3877(line=142, offs=2) -- 3891(line=142, offs=16)
*)
val __tok39 = uemph(".sats")
val () = theAtextMap_insert_str ("__tok39", __tok39)

(*
atsccman.atxt: 3900(line=145, offs=2) -- 3915(line=145, offs=17)
*)
val __tok40 = uemph("-fdats")
val () = theAtextMap_insert_str ("__tok40", __tok40)

(*
atsccman.atxt: 4016(line=147, offs=28) -- 4032(line=147, offs=44)
*)
val __tok41 = iemph("dynamic")
val () = theAtextMap_insert_str ("__tok41", __tok41)

(*
atsccman.atxt: 4128(line=149, offs=2) -- 4142(line=149, offs=16)
*)
val __tok42 = uemph(".dats")
val () = theAtextMap_insert_str ("__tok42", __tok42)

(*
atsccman.atxt: 4155(line=153, offs=2) -- 4181(line=153, offs=28)
*)
val __tok43 = comment(" ****** ****** ")
val () = theAtextMap_insert_str ("__tok43", __tok43)

(*
atsccman.atxt: 4213(line=157, offs=2) -- 4248(line=157, offs=37)
*)
val __tok44 = comment(" end of [atsccman.atxt] ")
val () = theAtextMap_insert_str ("__tok44", __tok44)

(*
atsccman.atxt: 4267(line=162, offs=1) -- 4340(line=164, offs=3)
*)

implement main () = fprint_filsub (stdout_ref, "atsccman_atxt.txt")


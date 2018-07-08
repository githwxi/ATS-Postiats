(*
: 22(line=3, offs=1) -- 72(line=5, offs=3)
*)

implement srcfilename_get () = "../gmp.sats"

(*
: 95(line=9, offs=1) -- 189(line=12, offs=3)
*)

val () = patscode_count_reset()
val () = patscode_prefix_set("TRYIT/contrib_libgmp_gmp")

(*
: 213(line=16, offs=2) -- 255(line=18, offs=3)
*)
val __datatok1 = decltitle("\
ATSLIB/contrib/libgmp/gmp\
")
val () = theAtextMap_insert_str ("__datatok1", __datatok1)

(*
: 297(line=24, offs=2) -- 403(line=28, offs=3)
*)
val __datatok3 = para("\

This package contains an API in ATS for the <a href=\"http://gmplib.org/\">libgmp</a> package.\

")
val () = theAtextMap_insert_str ("__datatok3", __datatok3)

(*
: 279(line=22, offs=2) -- 407(line=30, offs=3)
*)
val __datatok2 = declpreamble("\

#__datatok3$

")
val () = theAtextMap_insert_str ("__datatok2", __datatok2)

(*
: 408(line=30, offs=4) -- 431(line=30, offs=27)
*)
val __datatok4 = comment("declpreamble")
val () = theAtextMap_insert_str ("__datatok4", __datatok4)

(*
: 455(line=34, offs=2) -- 482(line=34, offs=29)
*)
val __datatok5 = declnamesynop("mpz_vt0ype")
val () = theAtextMap_insert_str ("__datatok5", __datatok5)

(*
: 484(line=35, offs=2) -- 511(line=35, offs=29)
*)
val __datatok6 = declnamesynop("mpq_vt0ype")
val () = theAtextMap_insert_str ("__datatok6", __datatok6)

(*
: 513(line=36, offs=2) -- 540(line=36, offs=29)
*)
val __datatok7 = declnamesynop("mpf_vt0ype")
val () = theAtextMap_insert_str ("__datatok7", __datatok7)

(*
: 564(line=40, offs=2) -- 588(line=40, offs=26)
*)
val __datatok8 = declnamesynop("mp_base")
val () = theAtextMap_insert_str ("__datatok8", __datatok8)

(*
: 612(line=44, offs=2) -- 637(line=44, offs=27)
*)
val __datatok9 = declnamesynop("mpz_init")
val () = theAtextMap_insert_str ("__datatok9", __datatok9)

(*
: 639(line=45, offs=2) -- 665(line=45, offs=28)
*)
val __datatok10 = declnamesynop("mpz_init2")
val () = theAtextMap_insert_str ("__datatok10", __datatok10)

(*
: 689(line=49, offs=2) -- 715(line=49, offs=28)
*)
val __datatok11 = declnamesynop("mpz_clear")
val () = theAtextMap_insert_str ("__datatok11", __datatok11)

(*
: 717(line=50, offs=2) -- 746(line=50, offs=31)
*)
val __datatok12 = declnamesynop("mpz_realloc2")
val () = theAtextMap_insert_str ("__datatok12", __datatok12)

(*
: 770(line=54, offs=2) -- 798(line=54, offs=30)
*)
val __datatok13 = declnamesynop("mpz_get_int")
val () = theAtextMap_insert_str ("__datatok13", __datatok13)

(*
: 800(line=55, offs=2) -- 829(line=55, offs=31)
*)
val __datatok14 = declnamesynop("mpz_get_lint")
val () = theAtextMap_insert_str ("__datatok14", __datatok14)

(*
: 831(line=56, offs=2) -- 860(line=56, offs=31)
*)
val __datatok15 = declnamesynop("mpz_get_uint")
val () = theAtextMap_insert_str ("__datatok15", __datatok15)

(*
: 862(line=57, offs=2) -- 892(line=57, offs=32)
*)
val __datatok16 = declnamesynop("mpz_get_ulint")
val () = theAtextMap_insert_str ("__datatok16", __datatok16)

(*
: 894(line=58, offs=2) -- 925(line=58, offs=33)
*)
val __datatok17 = declnamesynop("mpz_get_double")
val () = theAtextMap_insert_str ("__datatok17", __datatok17)

(*
: 949(line=62, offs=2) -- 977(line=62, offs=30)
*)
val __datatok18 = declnamesynop("mpz_get_str")
val () = theAtextMap_insert_str ("__datatok18", __datatok18)

(*
: 1001(line=66, offs=2) -- 1029(line=66, offs=30)
*)
val __datatok19 = declnamesynop("mpz_set_int")
val () = theAtextMap_insert_str ("__datatok19", __datatok19)

(*
: 1031(line=67, offs=2) -- 1060(line=67, offs=31)
*)
val __datatok20 = declnamesynop("mpz_set_lint")
val () = theAtextMap_insert_str ("__datatok20", __datatok20)

(*
: 1062(line=68, offs=2) -- 1091(line=68, offs=31)
*)
val __datatok21 = declnamesynop("mpz_set_uint")
val () = theAtextMap_insert_str ("__datatok21", __datatok21)

(*
: 1093(line=69, offs=2) -- 1123(line=69, offs=32)
*)
val __datatok22 = declnamesynop("mpz_set_ulint")
val () = theAtextMap_insert_str ("__datatok22", __datatok22)

(*
: 1125(line=70, offs=2) -- 1156(line=70, offs=33)
*)
val __datatok23 = declnamesynop("mpz_set_double")
val () = theAtextMap_insert_str ("__datatok23", __datatok23)

(*
: 1158(line=71, offs=2) -- 1186(line=71, offs=30)
*)
val __datatok24 = declnamesynop("mpz_set_mpz")
val () = theAtextMap_insert_str ("__datatok24", __datatok24)

(*
: 1188(line=72, offs=2) -- 1216(line=72, offs=30)
*)
val __datatok25 = declnamesynop("mpz_set_mpq")
val () = theAtextMap_insert_str ("__datatok25", __datatok25)

(*
: 1218(line=73, offs=2) -- 1246(line=73, offs=30)
*)
val __datatok26 = declnamesynop("mpz_set_mpf")
val () = theAtextMap_insert_str ("__datatok26", __datatok26)

(*
: 1270(line=77, offs=2) -- 1298(line=77, offs=30)
*)
val __datatok27 = declnamesynop("mpz_set_str")
val () = theAtextMap_insert_str ("__datatok27", __datatok27)

(*
: 1300(line=78, offs=2) -- 1332(line=78, offs=34)
*)
val __datatok28 = declnamesynop("mpz_set_str_exn")
val () = theAtextMap_insert_str ("__datatok28", __datatok28)

(*
: 1356(line=82, offs=2) -- 1380(line=82, offs=26)
*)
val __datatok29 = declnamesynop("mpz_neg")
val () = theAtextMap_insert_str ("__datatok29", __datatok29)

(*
: 1382(line=83, offs=2) -- 1407(line=83, offs=27)
*)
val __datatok30 = declnamesynop("mpz_neg1")
val () = theAtextMap_insert_str ("__datatok30", __datatok30)

(*
: 1409(line=84, offs=2) -- 1434(line=84, offs=27)
*)
val __datatok31 = declnamesynop("mpz_neg2")
val () = theAtextMap_insert_str ("__datatok31", __datatok31)

(*
: 1458(line=88, offs=2) -- 1482(line=88, offs=26)
*)
val __datatok32 = declnamesynop("mpz_abs")
val () = theAtextMap_insert_str ("__datatok32", __datatok32)

(*
: 1484(line=89, offs=2) -- 1509(line=89, offs=27)
*)
val __datatok33 = declnamesynop("mpz_abs1")
val () = theAtextMap_insert_str ("__datatok33", __datatok33)

(*
: 1511(line=90, offs=2) -- 1536(line=90, offs=27)
*)
val __datatok34 = declnamesynop("mpz_abs2")
val () = theAtextMap_insert_str ("__datatok34", __datatok34)

(*
: 1560(line=94, offs=2) -- 1584(line=94, offs=26)
*)
val __datatok35 = declnamesynop("mpz_add")
val () = theAtextMap_insert_str ("__datatok35", __datatok35)

(*
: 1586(line=95, offs=2) -- 1615(line=95, offs=31)
*)
val __datatok36 = declnamesynop("mpz_add2_int")
val () = theAtextMap_insert_str ("__datatok36", __datatok36)

(*
: 1617(line=96, offs=2) -- 1647(line=96, offs=32)
*)
val __datatok37 = declnamesynop("mpz_add2_lint")
val () = theAtextMap_insert_str ("__datatok37", __datatok37)

(*
: 1649(line=97, offs=2) -- 1679(line=97, offs=32)
*)
val __datatok38 = declnamesynop("mpz_add2_uint")
val () = theAtextMap_insert_str ("__datatok38", __datatok38)

(*
: 1681(line=98, offs=2) -- 1712(line=98, offs=33)
*)
val __datatok39 = declnamesynop("mpz_add2_ulint")
val () = theAtextMap_insert_str ("__datatok39", __datatok39)

(*
: 1714(line=99, offs=2) -- 1743(line=99, offs=31)
*)
val __datatok40 = declnamesynop("mpz_add2_mpz")
val () = theAtextMap_insert_str ("__datatok40", __datatok40)

(*
: 1745(line=100, offs=2) -- 1774(line=100, offs=31)
*)
val __datatok41 = declnamesynop("mpz_add3_int")
val () = theAtextMap_insert_str ("__datatok41", __datatok41)

(*
: 1776(line=101, offs=2) -- 1806(line=101, offs=32)
*)
val __datatok42 = declnamesynop("mpz_add3_lint")
val () = theAtextMap_insert_str ("__datatok42", __datatok42)

(*
: 1808(line=102, offs=2) -- 1838(line=102, offs=32)
*)
val __datatok43 = declnamesynop("mpz_add3_uint")
val () = theAtextMap_insert_str ("__datatok43", __datatok43)

(*
: 1840(line=103, offs=2) -- 1871(line=103, offs=33)
*)
val __datatok44 = declnamesynop("mpz_add3_ulint")
val () = theAtextMap_insert_str ("__datatok44", __datatok44)

(*
: 1873(line=104, offs=2) -- 1902(line=104, offs=31)
*)
val __datatok45 = declnamesynop("mpz_add3_mpz")
val () = theAtextMap_insert_str ("__datatok45", __datatok45)


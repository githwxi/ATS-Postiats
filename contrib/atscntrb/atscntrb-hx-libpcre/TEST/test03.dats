(* ****** ****** *)
//
// Some code for testing the API in ATS for pcre
//
(* ****** ****** *)
(*
##myatsccdef=\
patscc \
-I./../.. \
-DATS_MEMALLOC_LIBC \
-o $fname($1) $1 -lpcre
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#include "./../mylibies.hats"
#staload $PCRE_ML // opening it

(* ****** ****** *)
//
local
#include "./../mylibies_link.hats"
in (*nothing*) end
//
(* ****** ****** *)

implement
main0 () = () where
{
//
val locstr = "\
/home/hwxi/research/Postiats/git/doc/PROJECT/SMALL/UTFPL/parsing/TEST/test01.dats\
: 119(line=11, offs=1) -- 171(line=12, offs=38)\
" // end of [val]
//
val ret0 =
regstr_match_string (": [0-9]+\\(line=[0-9]+, offs=[0-9]+\\) -- [0-9]+\\(line=[0-9]+, offs=[0-9]+\\)$", locstr)
val () = println! ("ret0 = ", ret0)
//
var err: int
var mbeg: int and mend: int
val res =
regstr_match3_string (": ([0-9]+)\\(line=([0-9]+), offs=([0-9]+)\\) -- ([0-9]+)\\(line=([0-9]+), offs=([0-9]+)\\)$", locstr, mbeg, mend, err)
//
val () = println! ("err = ", err)
//
val-~cons_vt (ntot0, res) = res
val-~cons_vt (line0, res) = res
val-~cons_vt (offs0, res) = res
val-~cons_vt (ntot1, res) = res
val-~cons_vt (line1, res) = res
val-~cons_vt (offs1, res) = res
val-~list_vt_nil ((*void*)) = res
//
val () = println! ("ntot0 = ", ntot0)
val () = println! ("line0 = ", line0)
val () = println! ("offs0 = ", offs0)
val () = println! ("ntot1 = ", ntot1)
val () = println! ("line1 = ", line1)
val () = println! ("offs1 = ", offs1)
//
val () = strptr_free (ntot0)
val () = strptr_free (line0)
val () = strptr_free (offs0)
val () = strptr_free (ntot1)
val () = strptr_free (line1)
val () = strptr_free (offs1)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test03.dats] *)

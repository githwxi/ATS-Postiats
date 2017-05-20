(*
// ATS-texting
*)
(* ****** ****** *)
//
#define
ATEXTING_targetloc "./.."
//
(* ****** ****** *)
//
(*
#include
"{$ATEXTING}/mylibies.hats"
*)
#include
"{$ATEXTING}/mylibies_link.hats"
//
(* ****** ****** *)
//
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_pre.dats"
//
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_xhtml.dats"
//
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_foreach.dats"
//
(* ****** ****** *)
//
extern
fun
libatsynmark_dynloadall(): void = "ext#"
//
val () = libatsynmark_dynloadall((*void*))
//
(* ****** ****** *)

(* end of [mytexting.dats] *)

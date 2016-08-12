(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxiATgmailDOTcom)
**
** Start Time: July, 2016
**
*)

(* ****** ****** *)
//
// HX-2016-07:
//
#define
ATS_DYNLOADFLAG 0
//
#define
ATS_DYNLOADFUN_NAME
"libatsyntext_dynloadall"
//
(* ****** ****** *)
//
dynload "./DATS/libatsyntext.dats"
dynload "./DATS/libatsyntext_d2ecl.dats"
//
(* ****** ****** *)

local
//
extern
fun
libatsopt_dynloadall(): void = "ext#"
//
in (* in-of-local *)

val () = libatsopt_dynloadall((*void*))

end // end of [local]

(* ****** ****** *)

(* end of [dynloadall.dats] *)

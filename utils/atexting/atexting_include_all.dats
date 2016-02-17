(* ****** ****** *)
//
// ATS-texting
//
(* ****** ****** *)
//
// HX-2016-02-16
//
(* ****** ****** *)
//
#define ATS_MAINATSFLAG 1
//
(* ****** ****** *)
//
#define
ATS_DYNLOADNAME
"atexting_include_all_dynload"
//
(* ****** ****** *)
//
local #include "./DATS/atexting_fname.dats" in (*nothing*) end
local #include "./DATS/atexting_posloc.dats" in (*nothing*) end
//
local #include "./DATS/atexting_token.dats" in (*nothing*) end
local #include "./DATS/atexting_atext.dats" in (*nothing*) end
//
local #include "./DATS/atexting_parerr.dats" in (*nothing*) end
//
local #include "./DATS/atexting_lexbuf.dats" in (*nothing*) end
local #include "./DATS/atexting_lexing.dats" in (*nothing*) end
//
local #include "./DATS/atexting_tokbuf.dats" in (*nothing*) end
//
local #include "./DATS/atexting_global.dats" in (*nothing*) end
//
local #include "./DATS/atexting_textdef.dats" in (*nothing*) end
//
local #include "./DATS/atexting_parsing.dats" in (*nothing*) end
//
local #include "./DATS/atexting_strngfy.dats" in (*nothing*) end
local #include "./DATS/atexting_topeval.dats" in (*nothing*) end
//
(* ****** ****** *)

local
//
staload
"./SATS/atexting.sats"
//
in (* in-of-local *)

implement
main0() = () where
{
//
val () = the_nsharp_set(2)
//
val () =
println!("Hello from [atexting]!")
//
val out = stdout_ref
val txts = parsing_from_stdin((*void*))
//
val ((*void*)) = atextlst_topeval(out, txts)
//
} (* end of [main0] *)

end // end of [local]

(* ****** ****** *)

(* end of [atexting_include_all.dats] *)

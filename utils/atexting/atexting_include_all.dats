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
local #include "./DATS/atexting_commarg.dats" in (*nothing*) end
//
(* ****** ****** *)
//
staload
"libc/SATS/stdio.sats"  
//
staload
"libats/ML/SATS/basis.sats"  
//  
(* ****** ****** *)

datatype
outchan =
  | OUTCHANptr of FILEref
  | OUTCHANref of FILEref
// end of [OUTCHAN]

(* ****** ****** *)

fun
outchan_get_fileref
  (x0: outchan): FILEref =
(
//
case+ x0 of
| OUTCHANref(filr) => filr
| OUTCHANptr(filp) => filp
//
) // outchan_get_fileref

(* ****** ****** *)

fun
outchan_close(x0: outchan): void =
(
  case+ x0 of
  | OUTCHANref(filr) => ()
  | OUTCHANptr(filp) => fclose0_exn(filp)
) (* end of [outchan_close] *)

(* ****** ****** *)

#ifdef
MAIN_NONE
#then
//
// HX:
// the [main] is
// to be implemented
//
#else
//
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
//
#endif // #ifdef(MAIN_NONE)

(* ****** ****** *)

(* end of [atexting_include_all.dats] *)

(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#staload "./../SATS/catsparse.sats"

(* ****** ****** *)

staload
FIL = {
//
#include
"share/atspre_define.hats"
//
#staload
"./../SATS/catsparse.sats"
//
typedef T = fil_t
//
#include
"{$HX_GLOBALS}/HATS/gstacklst.hats"
//
implement
the_filename_pop () = pop_exn ()
implement
the_filename_push (fil) = push (fil)
//
implement
the_filename_get () = get_top_exn ()
//
} (* end of [staload] *)

(* ****** ****** *)

val () = the_filename_push (filename_dummy)

(* ****** ****** *)

staload KWORD =
{
//
#include
"share/atspre_define.hats"
//
#staload "./../SATS/catsparse.sats"
//
typedef key = string
typedef itm = keyword
//
#define CAPACITY 1024
//
#staload
"libats/SATS/hashtbl_linprb.sats"
//
implement
hashtbl$recapacitize<> ((*void*)) = 0
//
#include
"{$HX_GLOBALS}/HATS/ghashtbl_linprb.hats"
//
} (* end of [staload] *)

(* ****** ****** *)

val () =
{
//
macdef
kwordins (name, kw) =
  $KWORD.insert_opt (,(name), ,(kw))
//
// HX: line pragma
//
val-~None_vt() = kwordins ("#if", SRPif)
val-~None_vt() = kwordins ("#ifdef", SRPifdef)
val-~None_vt() = kwordins ("#ifndef", SRPifndef)
val-~None_vt() = kwordins ("#endif", SRPendif)
//
val-~None_vt() = kwordins ("#line", SRPline)
val-~None_vt() = kwordins ("#include", SRPinclude)
//
val-~None_vt() = kwordins ("typedef", TYPEDEF)
//
val-~None_vt() = kwordins ("ATSstruct", ATSstruct)
//
val-~None_vt() = kwordins ("ATSinline", ATSinline)
val-~None_vt() = kwordins ("ATSextern", ATSextern)
val-~None_vt() = kwordins ("ATSstatic", ATSstatic)
//
val-~None_vt() = kwordins ("ATSassume", ATSassume)
//
val-~None_vt() = kwordins ("ATSdyncst_mac", ATSdyncst_mac)
//
val-~None_vt() = kwordins ("ATSdyncst_extfun", ATSdyncst_extfun)
//
val-~None_vt() = kwordins ("ATSdyncst_valdec", ATSdyncst_valdec)
val-~None_vt() = kwordins ("ATSdyncst_valimp", ATSdyncst_valimp)
//
val-~None_vt() = kwordins ("ATStmpdec", ATStmpdec)
val-~None_vt() = kwordins ("ATStmpdec_void", ATStmpdec_void)
//
val-~None_vt() = kwordins ("ATSstatmpdec", ATSstatmpdec)
val-~None_vt() = kwordins ("ATSstatmpdec_void", ATSstatmpdec_void)
//
val-~None_vt() = kwordins ("ATSif", ATSif)
val-~None_vt() = kwordins ("ATSthen", ATSthen)
val-~None_vt() = kwordins ("ATSelse", ATSelse)
//
val-~None_vt() = kwordins ("ATSifthen", ATSifthen)
val-~None_vt() = kwordins ("ATSifnthen", ATSifnthen)
//
val-~None_vt() = kwordins ("ATSbranch_beg", ATSbranch_beg)
val-~None_vt() = kwordins ("ATSbranch_end", ATSbranch_end)
//
val-~None_vt() = kwordins ("ATScaseof_beg", ATScaseof_beg)
val-~None_vt() = kwordins ("ATScaseof_end", ATScaseof_end)
//
val-~None_vt() = kwordins ("ATSextcode_beg", ATSextcode_beg)
val-~None_vt() = kwordins ("ATSextcode_end", ATSextcode_end)
//
val-~None_vt() = kwordins ("ATSfunbody_beg", ATSfunbody_beg)
val-~None_vt() = kwordins ("ATSfunbody_end", ATSfunbody_end)
//
val-~None_vt() = kwordins ("ATSreturn", ATSreturn)
val-~None_vt() = kwordins ("ATSreturn_void", ATSreturn_void)
//
val-~None_vt() = kwordins ("ATSPMVint", ATSPMVint)
val-~None_vt() = kwordins ("ATSPMVintrep", ATSPMVintrep)
//
val-~None_vt() = kwordins ("ATSPMVbool_true", ATSPMVbool_true)
val-~None_vt() = kwordins ("ATSPMVbool_false", ATSPMVbool_false)
//
val-~None_vt() = kwordins ("ATSPMVfloat", ATSPMVfloat)
//
val-~None_vt() = kwordins ("ATSPMVstring", ATSPMVstring)
//
val-~None_vt() = kwordins ("ATSPMVi0nt", ATSPMVi0nt)
val-~None_vt() = kwordins ("ATSPMVf0loat", ATSPMVf0loat)
//
val-~None_vt() = kwordins ("ATSPMVempty", ATSPMVempty)
val-~None_vt() = kwordins ("ATSPMVextval", ATSPMVextval)
//
val-~None_vt() = kwordins ("ATSPMVrefarg0", ATSPMVrefarg0)
val-~None_vt() = kwordins ("ATSPMVrefarg1", ATSPMVrefarg1)
//
val-~None_vt() = kwordins ("ATSPMVfunlab", ATSPMVfunlab)
val-~None_vt() = kwordins ("ATSPMVcfunlab", ATSPMVcfunlab)
//
val-~None_vt() = kwordins ("ATSPMVcastfn", ATSPMVcastfn)
//
val-~None_vt() = kwordins ("ATSCSTSPmyloc", ATSCSTSPmyloc)
//
val-~None_vt() = kwordins ("ATSCKiseqz", ATSCKiseqz)
val-~None_vt() = kwordins ("ATSCKisneqz", ATSCKisneqz)
val-~None_vt() = kwordins ("ATSCKptriscons", ATSCKptriscons)
val-~None_vt() = kwordins ("ATSCKptrisnull", ATSCKptrisnull)
//
val-~None_vt() = kwordins ("ATSCKpat_int", ATSCKpat_int)
val-~None_vt() = kwordins ("ATSCKpat_bool", ATSCKpat_bool)
val-~None_vt() = kwordins ("ATSCKpat_string", ATSCKpat_string)
//
val-~None_vt() = kwordins ("ATSCKpat_con0", ATSCKpat_con0)
val-~None_vt() = kwordins ("ATSCKpat_con1", ATSCKpat_con1)
//
val-~None_vt() = kwordins ("ATSSELcon", ATSSELcon)
val-~None_vt() = kwordins ("ATSSELrecsin", ATSSELrecsin)
val-~None_vt() = kwordins ("ATSSELboxrec", ATSSELboxrec)
val-~None_vt() = kwordins ("ATSSELfltrec", ATSSELfltrec)
//
val-~None_vt() = kwordins ("ATSextfcall", ATSextfcall) // fun-call
val-~None_vt() = kwordins ("ATSextmcall", ATSextmcall) // method-call
//
val-~None_vt() = kwordins ("ATSfunclo_fun", ATSfunclo_fun)
val-~None_vt() = kwordins ("ATSfunclo_clo", ATSfunclo_clo)
//
val-~None_vt() = kwordins ("ATSINSlab", ATSINSlab)
val-~None_vt() = kwordins ("ATSINSgoto", ATSINSgoto)
//
val-~None_vt() = kwordins ("ATSINSflab", ATSINSflab)
val-~None_vt() = kwordins ("ATSINSfgoto", ATSINSfgoto)
//
val-~None_vt() = kwordins ("ATSINSfreeclo", ATSINSfreeclo)
val-~None_vt() = kwordins ("ATSINSfreecon", ATSINSfreecon)
//
val-~None_vt() = kwordins ("ATSINSmove", ATSINSmove)
val-~None_vt() = kwordins ("ATSINSmove_void", ATSINSmove_void)
//
val-~None_vt() = kwordins ("ATSINSmove_nil", ATSINSmove_nil)
val-~None_vt() = kwordins ("ATSINSmove_con0", ATSINSmove_con0)
//
val-~None_vt() = kwordins ("ATSINSmove_con1_beg", ATSINSmove_con1_beg)
val-~None_vt() = kwordins ("ATSINSmove_con1_end", ATSINSmove_con1_end)
val-~None_vt() = kwordins ("ATSINSmove_con1_new", ATSINSmove_con1_new)
val-~None_vt() = kwordins ("ATSINSstore_con1_tag", ATSINSstore_con1_tag)
val-~None_vt() = kwordins ("ATSINSstore_con1_ofs", ATSINSstore_con1_ofs)
//
val-~None_vt() = kwordins ("ATSINSmove_boxrec_beg", ATSINSmove_boxrec_beg)
val-~None_vt() = kwordins ("ATSINSmove_boxrec_end", ATSINSmove_boxrec_end)
val-~None_vt() = kwordins ("ATSINSmove_boxrec_new", ATSINSmove_boxrec_new)
val-~None_vt() = kwordins ("ATSINSstore_boxrec_ofs", ATSINSstore_boxrec_ofs)
//
val-~None_vt() = kwordins ("ATSINSmove_fltrec_beg", ATSINSmove_fltrec_beg)
val-~None_vt() = kwordins ("ATSINSmove_fltrec_end", ATSINSmove_fltrec_end)
val-~None_vt() = kwordins ("ATSINSstore_fltrec_ofs", ATSINSstore_fltrec_ofs)
//
val-~None_vt() = kwordins ("ATSINSmove_delay", ATSINSmove_delay)
val-~None_vt() = kwordins ("ATSINSmove_lazyeval", ATSINSmove_lazyeval)
//
val-~None_vt() = kwordins ("ATSINSmove_ldelay", ATSINSmove_ldelay)
val-~None_vt() = kwordins ("ATSINSmove_llazyeval", ATSINSmove_llazyeval)
//
val-~None_vt() = kwordins ("ATStailcal_beg", ATStailcal_beg)
val-~None_vt() = kwordins ("ATStailcal_end", ATStailcal_end)
val-~None_vt() = kwordins ("ATSINSmove_tlcal", ATSINSmove_tlcal)
val-~None_vt() = kwordins ("ATSINSargmove_tlcal", ATSINSargmove_tlcal)
//
val-~None_vt() = kwordins ("ATSINSextvar_assign", ATSINSextvar_assign)
val-~None_vt() = kwordins ("ATSINSdyncst_valbind", ATSINSdyncst_valbind)
//
val-~None_vt() = kwordins ("ATSINScaseof_fail", ATSINScaseof_fail)
val-~None_vt() = kwordins ("ATSINSdeadcode_fail", ATSINSdeadcode_fail)
//
val-~None_vt() = kwordins ("ATSdynload", ATSdynload)
val-~None_vt() = kwordins ("ATSdynloadset", ATSdynloadset)
val-~None_vt() = kwordins ("ATSdynloadfcall", ATSdynloadfcall)
val-~None_vt() = kwordins ("ATSdynloadflag_sta", ATSdynloadflag_sta)
val-~None_vt() = kwordins ("ATSdynloadflag_ext", ATSdynloadflag_ext)
val-~None_vt() = kwordins ("ATSdynloadflag_init", ATSdynloadflag_init)
val-~None_vt() = kwordins ("ATSdynloadflag_minit", ATSdynloadflag_minit)
//
val-~None_vt() = kwordins ("ATSclosurerize_beg", ATSclosurerize_beg)
val-~None_vt() = kwordins ("ATSclosurerize_end", ATSclosurerize_end)
//
val-~None_vt() = kwordins ("ATSdynexn_dec", ATSdynexn_dec)
val-~None_vt() = kwordins ("ATSdynexn_extdec", ATSdynexn_extdec)
val-~None_vt() = kwordins ("ATSdynexn_initize", ATSdynexn_initize)
//
} (* end of [val] *)

(* ****** ****** *)

implement
keyword_search
  (name) = let
//
val cp = $KWORD.search_ref (name)
//
in
//
if isneqz(cp)
  then $UNSAFE.cptr_get<keyword> (cp)
  else KWORDnone()
//
end // end of [keyword_search]

(* ****** ****** *)

staload
LEXERR = {
//
#include
"share/atspre_define.hats"
//
#staload "./../SATS/catsparse.sats"
//
typedef T = lexerr
//
#include
"{$HX_GLOBALS}/HATS/gstacklst.hats"
//
implement
the_lexerrlst_insert (x) = push (x)
//
implement
the_lexerrlst_pop_all () = pop_all ()
//
} (* end of [staload] *)

(* ****** ****** *)

staload
PARERR = {
//
#include
"share/atspre_define.hats"
//
#staload "./../SATS/catsparse.sats"
#staload "./../SATS/catsparse_parsing.sats"
//
typedef T = parerr
//
#include
"{$HX_GLOBALS}/HATS/gstacklst.hats"
//
implement
the_parerrlst_insert(x) = push(x)
//
implement
the_parerrlst_pop_all() = pop_all()
//
} (* end of [staload] *)

(* ****** ****** *)

(* end of [catsparse_global.dats] *)

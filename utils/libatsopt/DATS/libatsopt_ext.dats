(*
//
// For [libatsopt]
//
*)

(* ****** ****** *)
//
// HX: This is ATS1!
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
staload
_ = "prelude/DATS/unsafe.dats"
//
(* ****** ****** *)

staload
_ = "prelude/DATS/list.dats"
staload
_ = "prelude/DATS/array.dats"

(* ****** ****** *)

staload
FCNTL = "libc/SATS/fcntl.sats"
staload
STDIO = "libc/SATS/stdio.sats"
staload
STDLIB = "libc/SATS/stdlib.sats"
staload
STRING = "libc/SATS/string.sats"
staload
UNISTD = "libc/SATS/unistd.sats"
  
(* ****** ****** *)
//
staload
FIL = "src/pats_filename.sats"
//
(* ****** ****** *)
//
staload "src/pats_syntax.sats"
//
staload "src/pats_parsing.sats"
//
(* ****** ****** *)
//
staload "src/pats_staexp1.sats"
staload "src/pats_dynexp1.sats"
//
staload
TRANS1 = "src/pats_trans1.sats"
staload
TRENV1 = "src/pats_trans1_env.sats"
//
(* ****** ****** *)
//
staload "src/pats_staexp2.sats"
staload "src/pats_stacst2.sats"
staload "src/pats_dynexp2.sats"
//
staload
TRANS2 = "src/pats_trans2.sats"
staload
TRENV2 = "src/pats_trans2_env.sats"
//
(* ****** ****** *)
//
staload "src/pats_dynexp3.sats"
//
staload
TRANS3 = "src/pats_trans3.sats"
staload
TRENV3 = "src/pats_trans3_env.sats"
//
(* ****** ****** *)
//
staload "src/pats_histaexp.sats"
staload "src/pats_hidynexp.sats"
//
staload
TYER = "src/pats_typerase.sats"
//
staload CCOMP = "src/pats_ccomp.sats"
//
(* ****** ****** *)
  
%{^
//
extern
ats_ptr_type
patsopt_file2strptr(ats_int_type fd) ;
//
#ifndef \
libatsopt_file2stropt
#define \
libatsopt_file2stropt(fd) patsopt_file2strptr(fd)
#endif // #ifndef
//
%} // end of [%{^]

(* ****** ****** *)

staload "./../SATS/libatsopt_ext.sats"

(* ****** ****** *)
//
implement
comarg_strlit(x) = COMARGstrlit(x)
implement
comarg_strinp(x) = COMARGstrinp(x)
//
implement
comarg_prefil(x) = COMARGprefil(x)
implement
comarg_postfil(x) = COMARGpostfil(x)
//
(* ****** ****** *)
//
implement
comarglst_nil() = list_nil((*void*))
implement
comarglst_cons(x, xs) = list_cons(x, xs)
//
(* ****** ****** *)
//
%{^
//
extern void patsopt_PATSHOME_set() ;
extern char *patsopt_PATSHOME_get() ;
//
%} // end of [{^]
//
implement
PATSHOME_set
  ((*void*)) = let
//
val () = set() where
{
extern
fun
set (
// argumentless
) : void =
  "mac#patsopt_PATSHOME_set"
//
} // end of [where]
//
prval pf = __assert() where
{
  extern prfun __assert(): PATSHOME_set_p  
} (* end of [prval] *)
//
in
  (pf | ((*void*)))
end // end of [PATSHOME_set]
//
implement
PATSHOME_get
(
  pf | (*none*)
) = let
//
val opt = get() where
{
extern
fun
get (
// argumentless
) : Stropt =
  "mac#patsopt_PATSHOME_get"
//
} (* end of [where] *)
val issome = stropt_is_some (opt)
//
in
  if issome
    then stropt_unsome(opt) else "$(PATSHOME)"
  // end of [if]
end // end of [PATSHOME_get]
//
(* ****** ****** *)

local

fun
auxexn
(
  exn: exn
) : bool = let
//
val exn =
$UN.castvwtp0{ptr}(exn)
//
in
  false
end // end of [auxexn]

in (*in-of-local*)

implement
patsopt_main_opt
  (argc, argv) = let
//
extern
fun
patsopt_main:
  (int, ptr) -> void =
  "ext#libatsopt_patsopt_main"
//
in
//
try let
//
val () =
  patsopt_main(argc, &argv)
//
in
  true
end with exn => auxexn(exn)
//
end (* end of [patsopt_main_opt] *)

end // end of [local]

(* ****** ****** *)
//
typedef
stringlst = List0(string)
//
extern
fun
string2file
(
  content: string
, prefils: stringlst
, postfils: stringlst
, number_of_errors: &int >> int
) : string // end-of-string2file
//
(* ****** ****** *)

local

fun
aux_prefils
(
  out: FILEref
, xs0: List(string), nerr: &int >> int
) : void =
(
case+ xs0 of
| list_nil() => ()
| list_cons(x, xs) =>
  {
    val () =
      aux_prefils (out, xs, nerr)
    // end of [val]
    val ec = $STDIO.fputs_err(x, out)
    val () = if ec < 0 then nerr := nerr + 1
  } (* end of [list_cons] *)
) (* end of [aux_prefils] *)

(* ****** ****** *)

fun
aux_postfils
(
  out: FILEref
, xs0: List(string), nerr: &int >> int
) : void =
(
case+ xs0 of
| list_nil() => ()
| list_cons(x, xs) =>
  {
    val () =
      aux_postfils (out, xs, nerr)
    // end of [val]
    val ec = $STDIO.fputs_err(x, out)
    val () = if ec < 0 then nerr := nerr + 1
  } (* end of [list_cons] *)
) (* end of [aux_postfils] *)

in (* in-of-local *)

implement
string2file
(
  content
, prefils, postfils, nerr
) = let
//
stadef
fildes_v = $FCNTL.fildes_v
//
val
prfx = "libatsopt_string2file_"
//
val
tmp0 =
sprintf ("%sXXXXXX", @(prfx))
val
[m,n:int]
tmpbuf = strbuf_of_strptr(tmp0)
prval () =
__assert () where {
  extern prfun __assert (): [n >= 6] void
} (* end of [prval] *)
//
prval
pfstr = tmpbuf.1
val
(pfopt | fd) =
$STDLIB.mkstemp !(tmpbuf.2)
prval ((*ret*)) = tmpbuf.1 := pfstr
//
val tmpres = string_of_strbuf(tmpbuf)
//
in
//
if
fd >= 0
then let
//
  prval
  $FCNTL.open_v_succ(pffil) = pfopt
  val (fpf | out) =
  fdopen (pffil | fd, file_mode_w) where
  {
    extern
    fun
    fdopen{fd:nat}
    (
      pffil: !fildes_v fd
    | fd: int fd, mode: file_mode
    ) : (fildes_v fd -<lin,prf> void | FILEref) = "mac#fdopen"
  } (* end of [out] *)
//
  val () =
    aux_prefils (out, prefils, nerr)
  // end of [val]
//
  val ec =
    $STDIO.fputs_err(content, out)
  val () = if ec < 0 then nerr := nerr + 1
//
  val () =
    aux_postfils (out, postfils, nerr)
  // end of [val]
//
  val ec = $STDIO.fflush_err(out)
  val () = if ec != 0 then nerr := nerr + 1
//
  prval((*void*)) = fpf (pffil)
//
  val ec = $STDIO.fclose_err(out)
  val () = if ec != 0 then nerr := nerr + 1
//
in
  tmpres
end // end of [then]
else let
  val () = nerr := nerr + 1
  prval $FCNTL.open_v_fail((*void*)) = pfopt
in
  tmpres
end // end of [else]
//
end // end of [string2file]

end // end of [local]

(* ****** ****** *)
//
implement
patsoptres_get_nerr
  (res) = nerr where
{
  val+PATSOPTRES(nerr, _, _) = res  
}
implement
patsoptres_get_stdout
  (res) = stdout where
{
  val+PATSOPTRES(_, stdout, _) = res  
}
implement
patsoptres_get_stderr
  (res) = stderr where
{
  val+PATSOPTRES(_, _, stderr) = res  
}
//  
(* ****** ****** *)

implement
patsopt_main_arglst
  (args) = let
//
vtypedef
res = List0_vt(string)
//
fun
auxarglst
{n:nat}
{l:addr}
(
  xs: List(comarg)
, n0: int(n)
, p0: ptr(l)
, prefils: stringlst
, postfils: stringlst
, res: &res >> res, nerr: &int >> int
) : intGte(0) = (
//
case+ xs of
| list_nil() => n0
| list_cons(x, xs) =>
  (
    case+ x of
    | COMARGstrlit(x) => let
        val n1 = n0+1
        val p1 = p0+sizeof<string>
        val () = $UN.ptr0_set<string>(p0, x)
      in
        auxarglst(xs, n1, p1, prefils, postfils, res, nerr)
      end // end of [COMARGstrlit]
    | COMARGstrinp(x) => let
        val n1 = n0+1
        val p1 = p0+sizeof<string>
        val f0 =
        string2file
          (x, prefils, postfils, nerr)
        // end of [val]
        val () =
          res := list_vt_cons(f0, res)
        // end of [val]
        val () = $UN.ptr0_set<string>(p0, f0)
      in
        auxarglst(xs, n1, p1, prefils, postfils, res, nerr)
      end // end of [COMARGstrinp]
    | COMARGprefil(x) => let
        val n1 = n0
        val p1 = p0
        val prefils = list_cons(x, prefils)
      in
        auxarglst(xs, n1, p1, prefils, postfils, res, nerr)
      end // end of [COMARGprefil]
    | COMARGpostfil(x) => let
        val n1 = n0
        val p1 = p0
        val postfils = list_cons(x, postfils)
      in
        auxarglst(xs, n1, p1, prefils, postfils, res, nerr)
      end // end of [COMARGpostfil]
  ) (* end of [list_cons] *)
//
) (* end of [auxarglst] *)
//
fun
unlinklst
(
  xs: res
) : void = let
//
macdef
unlink = $UNISTD.unlink
//
in
//
case+ xs of
| ~list_vt_nil
    ((*void*)) => ()
| ~list_vt_cons
    (x, xs) => let
    val ec = unlink(x) in unlinklst(xs)
  end (* end of [list_cons] *)
//
end // end of [unlinklst]
//
val
argc = list_length(args)
val
asz0 = size1_of_int1(argc+1)
//
val
(pfgc,pfarr|p0) =
array_ptr_alloc<string> (asz0)
//
val
prefils = list_nil()
val
postfils = list_nil()
//
var
res: res = list_vt_nil
//
var
nerr: int = 0 (*errless*)
//
val p1 = p0+sizeof<string>
val () =
$UN.ptr0_set<string>(p0, "patsopt")
val
[n:int]
argc =
auxarglst (
  args, 0, p1, prefils, postfils, res, nerr
) (* end of [val] *)
//
val ((*void*)) = (
//
if
nerr = 0
then let
//
val
(pfarr,fpf|argv) =
$UN.ptr1_vtake{@[string][n+1]}(p0)
//
val
ans = patsopt_main_opt(argc+1, !argv)
//
prval ((*returned*)) = fpf (pfarr)
//
in
//
if not(ans) then nerr := nerr+1
//
end // end of [then]
else ((*void*)) // end of [else]
//
) (* end of [if] *)
//
val () = unlinklst(res)
val () = array_ptr_free(pfgc,pfarr|p0)
//
in
  nerr (*number-of-errors*)
end // end of [patsopt_main_arglst]

(* ****** ****** *)

implement
patsoptres_main_arglst
  (args) = let
//
extern
fun
close : (int) -> int = "mac#atslib_close_err"
//
extern
fun
mydup2
  : (int, int) -> int(*fd*) = "mac#atslib_dup2"
extern
fun
mkstemp{l:addr}
  (tmp: !strptr(l)): int(*fd*) = "mac#atslib_mkstemp"
//
extern
fun
file2stropt: (int(*fd*)) -> stropt = "mac#libatsopt_file2stropt"
//
val
STDOUT = $UNISTD.STDOUT_FILENO
val
STDERR = $UNISTD.STDERR_FILENO
//
var nerr: int = 0
//
val prfx1 = "libatsopt_stdout_"
val prfx2 = "libatsopt_stderr_"
val tmpout = sprintf ("%sXXXXXX", @(prfx1))
val tmperr = sprintf ("%sXXXXXX", @(prfx2))
//
val
fdout =
(
  if nerr=0 then mkstemp(tmpout) else 0
) : int // end of [val]
val () = if fdout < 0 then nerr := nerr+1
//
val
fderr =
(
  if nerr=0 then mkstemp(tmperr) else 0
) : int // end of [val]
val () = if fderr < 0 then nerr := nerr+1
//
val () =
if
nerr=0
then let
//
val fdout2 = mydup2(fdout, STDOUT)
//
in
  if fdout2 < 0 then nerr := nerr + 1
end // end of [then]
//
val () =
if
nerr=0
then let
//
val fderr2 = mydup2(fderr, STDERR)
//
in
  if fderr2 < 0 then nerr := nerr + 1
end // end of [then]
//
val nerr2 = patsopt_main_arglst(args)
//
val _(*err*) =
  if nerr = 0 then close(STDOUT) else 0
val _(*err*) =
  if nerr = 0 then close(STDERR) else 0
//
val
strout =
(
  if fdout >= 0
    then file2stropt(fdout) else stropt_none
  // end of [if]
) : stropt // end of [val]
val _ = if fdout >= 0 then close(fdout) else 0
//
val
strerr =
(
  if fderr >= 0
    then file2stropt(fderr) else stropt_none
  // end of [if]
) : stropt // end of [val]
val _ = if fderr >= 0 then close(fderr) else 0
//
val _(*err*) =
  $UNISTD.unlink($UN.castvwtp1{string}(tmpout))
val _(*err*) =
  $UNISTD.unlink($UN.castvwtp1{string}(tmperr))
//
val () = strptr_free(tmpout) and () = strptr_free(tmperr)
//
var nerr2: int = nerr2
//
val strout =
(
  if stropt_is_some(strout)
    then stropt_unsome(strout) else (nerr2 := nerr2+1; "")
  // end of [if]
) : string // end of [val]
val strerr =
(
  if stropt_is_some(strerr)
    then stropt_unsome(strerr) else (nerr2 := nerr2+1; "")
  // end of [if]
) : string // end of [val]
//
in
  PATSOPTRES(nerr2, strout, strerr)
end // end of [patsoptres_main_arglst]

(* ****** ****** *)
//
extern
fun
patsopt_tcats_d3eclist_exn
  (stadyn: int, inp: string): d3eclist
extern
fun
patsopt_tcats_d3eclist_opt
  (stadyn: int, inp: string): Option_vt(d3eclist)
//
(* ****** ****** *)

implement
patsopt_tcats_d3eclist_exn
  (stadyn, inp) = let
//
val fil = $FIL.filename_string
//
val (pf|()) =
  $FIL.the_filenamelst_push(fil)
//
val
d0cs =
parse_from_string_toplevel(stadyn, inp)
//
val ((*void*)) =
  $FIL.the_filenamelst_pop(pf|(*none*))
//
val
(pf|()) = PATSHOME_set()
val
PATSHOME = PATSHOME_get(pf|(*none*))
//
val () =
  $FIL.the_prepathlst_push(PATSHOME)
val () =
  $TRENV1.the_trans1_env_initialize()
val () =
  $TRENV2.the_trans2_env_initialize()
//
val () = the_prelude_load(PATSHOME)
//
val () = $FIL.the_filenamelst_ppush(fil)
//
val d1cs = $TRANS1.d0eclist_tr_errck(d0cs)
//
val () = $TRANS1.trans1_finalize((*void*))
//
val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
//
val () =
  $TRENV3.the_trans3_env_initialize()
//
val d3cs = $TRANS3.d2eclist_tr_errck(d2cs)
//
(*
val () = fprint_d0eclist(stdout_ref, d0cs)
val () = fprint_d1eclist(stdout_ref, d1cs)
val () = fprint_d2eclist(stdout_ref, d2cs)
val () = fprint_d3eclist(stdout_ref, d3cs)
*)
//
in
//
  d3cs
//
end // end of [patsopt_tcats_d3eclst]

(* ****** ****** *)

local
//
fun
auxexn
(
  exn: exn
) : Option_vt(d3eclist) =
(
case+ exn of 
//
| exn => let
    val p0 = $UN.castvwtp0{ptr}(exn) in None_vt()
  end // end of [rest]
) (* en dof [auxexn] *)
//
in (*in-of-local*)

implement
patsopt_tcats_d3eclist_opt
  (stadyn, inp) = let
//
(*
val () =
println!
(
  "patsopt_tcats_d3eclist_opt"
) (* end of [val] *)
*)
//
in
//
try let
//
val
d3cs =
patsopt_tcats_d3eclist_exn(stadyn, inp)
//
in
  Some_vt(d3cs)
end with exn => auxexn(exn)
//
end // end of [patsopt_tcats_d3eclist_opt]

end // end of [local]

(* ****** ****** *)

(* end of [libatsopt_ext.dats] *)

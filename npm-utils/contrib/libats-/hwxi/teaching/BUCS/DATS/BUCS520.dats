(* ****** ****** *)
//
// Functions on streams
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
%{^
//
#undef ATSextfcall
#define ATSextfcall(fun, arg) fun arg
//
%} // ...
//
staload "libats/libc/SATS/unistd.sats"
//
(* ****** ****** *)
//
datavtype
linetimeout =
  | LNTOline of Strptr1
  | LNTOtimeout of ((*void*))
//
extern
fun{}
streamize_fileref_lnto
( input: FILEref
, nwait: intGte(0)): stream_vt(linetimeout)
extern
fun{}
streamize_fileref_lnto$bufsz(): intGte(2)
//
(* ****** ****** *)

local

#staload
"libats\
/libc/SATS/unistd.sats"

in (* in-of-local *)

implement
{}(*tmp*)
streamize_fileref_lnto
  (input, nwait) = let
//
fun
auxget0
(
  input: FILEref
, nwait: intGte(0)
, bufsz: intGte(2)
) : stream_vt(linetimeout) =
(
if
fileref_is_eof(input)
then stream_vt_make_nil()
else auxget1(input, nwait, bufsz)
) (* end of [auxget0] *)

and
auxget1
(
  input: FILEref
, nwait: intGte(0)
, bufsz: intGte(2)
) : stream_vt(linetimeout) = $ldelay
(
let
//
var
nlen: int
val
nbyte =
i2sz(bufsz)
//
val
(pf | _) =
alarm_set
(g1i2u(nwait))
//
val
[l:addr,n:int]
line =
$extfcall
(
  Strnptr0
, "atspre_fileref_get_line_string_main2"
, nbyte, input, addr@(nlen)
)
//
val
nlen = $UN.cast{int(n)}(nlen)
//
(*
val () = println! ("nlen = ", nlen)
val () = println! ("nbyte = ", nbyte)
*)
//
val
lnto =
(
if nlen >= 0
 then
 LNTOline
 (
 $UN.castvwtp0(line)
 )
 else let
   val () =
   strnptr_free(line)
in
   LNTOtimeout((*void*))
 end // end of [else]
) : linetimeout
//
val _(*leftover*) = alarm_cancel(pf | (*void*))
//
in
//  
stream_vt_cons
  (lnto, auxget0(input, nwait, bufsz))
//
end
) (* end of [auxget1] *)
//
in
//
let
val
bufsz =
streamize_fileref_lnto$bufsz<>
  ((*void*))
in
  auxget0(input, nwait, bufsz)
end // end of [let]
//
end // end of [streamize_fileref_lnto]

implement
streamize_fileref_lnto$bufsz<>() = 1024

end // end of [local]

(* ****** ****** *)
//
extern
fun{}
fileptr_by_url_opt
  (url: string): Option_vt(FILEptr1)
//
extern
fun{}
fileptr_by_command_opt
  (arg0: string, args: stringlst): Option_vt(FILEptr1)
//
(* ****** ****** *)
//
#define :: list_cons
//
implement
{}(*tmp*)
fileptr_by_url_opt
  (url) =
(
fileptr_by_command_opt<>
  ("wget", "-q" :: "-O" :: "-" :: url :: nil{string}())
)
//
(* ****** ****** *)

implement
{}(*tmp*)
fileptr_by_command_opt
  (arg0, args) = let
//
val
fid2 =
arrayref_make_elt<pid_t>
  (i2sz(2), $UNSAFE.cast(0))
//
val
ret =
$extfcall
( int
, "pipe", arrayref2ptr(fid2))
//
val pid =
(
if
ret >= 0
then
$extfcall(int(*child*), "fork")
else (~1)) : int // end of [val]
//
val ((*void*)) =
if(pid >= 0) then
(
//
ifcase
  | pid > 0 => () where
    {
      val () =
      $extfcall(void, "close", fid2[1])
    }
  | _(*pid = 0*) => () where // child
    {
      val () =
      $extfcall(void, "close", fid2[0])
      val () =
      $extfcall(void, "close", STDOUT_FILENO)
      val dupfd1 = $extfcall(int, "dup", fid2[1]) // = 1
      val
      argv =
      arrayref_make_elt<ptr>
        (i2sz(length(args)+2), the_null_ptr)
      // end of [val]
      var p0 = arrayref2ptr(argv)
      val () = $UNSAFE.ptr0_setinc<string>(p0, arg0)
      val () = loop(args, p0) where
      {
        fun
        loop(args: stringlst, p0: &ptr >> _): void =
        (
          case+ args of
          | list_nil() => ()
          | list_cons(arg, args) =>
            loop(args, p0) where
            {
             val () = $UNSAFE.ptr0_setinc<string>(p0, arg)
            } (* end of [list_cons] *)
        )
      }
      val errno = $extfcall(int, "execvp", arg0, argv)
    }
) (* end of [if] *) // end of [if]
//
in
//
if
(pid >= 0)
then let
//
val fid = fid2[0]
val filp =
$extfcall(ptr, "fdopen", fid, file_mode_r)
//
in
//
  if
  isneqz(filp)
  then
  Some_vt($UN.castvwtp0(filp))
  else None_vt((*void*)) where
  { val () =
    $extfcall(void, "close", fid)
  } (* end of [else] *)
//
end else let
  val () =
  $extfcall(void, "close", fid2[0]) in None_vt()
end // end of [else]
//
end // end of [fileptr_by_command_opt]

(* ****** ****** *)
//
extern
fun{}
streamopt_url_char
  (url: string): Option_vt(stream_vt(char))
extern
fun{}
streamopt_url_line
  (url: string): Option_vt(stream_vt(string))
//
(* ****** ****** *)

implement
{}(*tmp*)
streamopt_url_char
  (url) = let
//
val
opt =
fileptr_by_url_opt(url)
//
in
(
  case+ opt of
  | ~None_vt() =>
     None_vt()
  | ~Some_vt(inp) =>
     Some_vt(streamize_fileptr_char(inp))
)
end // end of [streamopt_url_char]

(* ****** ****** *)

implement
{}(*tmp*)
streamopt_url_line
  (url) = let
//
val
opt =
fileptr_by_url_opt(url)
//
in
(
  case+ opt of
  | ~None_vt() =>
     None_vt()
  | ~Some_vt(inp) =>
     Some_vt(streamize_fileptr_line(inp))
)
end // end of [streamopt_url_line]

(* ****** ****** *)

(* end of [BUCS520.dats] *)

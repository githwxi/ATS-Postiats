(* ****** ****** *)
//
// Functions on streams
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
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
staload "libats/libc/SATS/sys/wait.sats"
//
(* ****** ****** *)
//
extern
fun{}
string_make_stream_vt
  (stream_vt(charNZ)): string
//
implement
{}(*tmp*)
string_make_stream_vt
  (cs) = res where
{
//
val cs = stream2list_vt(cs)
val res = strnptr2string(string_make_list($UN.list_vt2t(cs)))
val ((*freed*)) = list_vt_free(cs)
//
} (* end of [string_of_stream_vt] *)
//
(* ****** ****** *)
//
extern
fun{}
stream_by_url
  (url: string): stream_vt(char)
//
extern
fun{}
stream_by_command
  (arg0: string, args: stringlst): stream_vt(char)
//
(* ****** ****** *)
//
#define :: list_cons
//
implement
{}(*tmp*)
stream_by_url
  (url) =
(
stream_by_command<>
  ("wget", "-q" :: "-O" :: "-" :: url :: nil{string}())
)
//
(* ****** ****** *)

implement
{}(*tmp*)
stream_by_command
  (arg0, args) = let
//
val
fid2 =
arrayref_make_elt<pid_t>
  (i2sz(2), $UNSAFE.cast(0))
//
val ret =
$extfcall
  (int, "pipe", arrayref2ptr(fid2))
//
val pid = $extfcall(int(*child*), "fork")
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
      val () =
      $extfcall(void, "close", STDIN_FILENO)
      val dupfd0 = $extfcall(int, "dup", fid2[0]) // = 0
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
if pid >= 0
  then streamize_fileref_char(stdin_ref)
  else (fileref_close(stdin_ref); stream_vt_make_nil())
//
end // end of [stream_by_command]

(* ****** ****** *)
//
// HX: to -> timeout
//
datavtype lineto =
  | LNTOline of Strptr1
  | LNTOtimeout of ((*void*))
//
extern
fun{}
streamize_fileref_lineto
( input: FILEref
, nwait: intGte(0)): stream_vt(lineto)
extern
fun{}
streamize_fileref_lineto$bufsz(): intGte(2)
//
(* ****** ****** *)

local

#staload
"libats\
/libc/SATS/unistd.sats"

in (* in-of-local *)

implement
{}(*tmp*)
streamize_fileref_lineto
  (input, nwait) = let
//
fun
auxget0
(
  input: FILEref
, nwait: intGte(0)
, bufsz: intGte(2)
) : stream_vt(lineto) =
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
) : stream_vt(lineto) = $ldelay
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
 ($UN.castvwtp0{Strptr1}(line))
 else let
   val () =
   strnptr_free(line) in LNTOtimeout((*void*))
 end // end of [else]
) : lineto
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
streamize_fileref_lineto$bufsz<>() in auxget0(input, nwait, bufsz) end
//
end // end of [streamize_fileref_lineto]

implement
streamize_fileref_lineto$bufsz<>() = 1024

end // end of [local]

(* ****** ****** *)

(* end of [BUCS520-2016-Fall.dats] *)

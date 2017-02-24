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

(* end of [BUCS520-2016-Fall.dats] *)

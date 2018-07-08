(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "ATSJS_"
//
(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "showfile_dynload_"

(* ****** ****** *)
//
extern
fun
file2stream
  (fname: string): stream(string)
//
(* ****** ****** *)

implement
file2stream
  (fname) = let
//
fun
aux
(
  filr: FILEref
) : stream(string) = $delay
(
if
fileref_is_eof(filr)
then let
//
val () =
  fileref_close(filr)
//
in
  stream_nil((*void*))
end // end of [then]
else let
val
line =
fileref_get_line_string(filr)
val line = strptr2string(line)
//
in
  stream_cons(line, aux(filr))
end // end of [else]
)
//
in (* in-of-let *)
//
let
//
val
opt =
fileref_open_opt
  (fname, file_mode_r)
//
in
//
case+ opt of
| ~None_vt() => let
    val errmsg =
    string0_append3
      ("fopen(", fname, ") failed!")
    // end of [val]
    val errmsg = strptr2string(errmsg)
  in
    $delay(stream_sing<string>(errmsg))
  end // end of [None_vt]
| ~Some_vt(filr) => aux(filr)
//
end
//
end (* end of [file2stream] *)

(* ****** ****** *)
//
(*
val () =
  println! ("Streamizing [DATA/showfile.html]!")
*)
//
val theStream = file2stream("DATA/showfile.html")
val theStream_ref = ref<stream(string)>(theStream)
//
(* ****** ****** *)
//
extern
fun
fmore (): void = "mac#%"
//
implement
fmore () = let
//
val xs = !theStream_ref
//
in
//
case+ !xs of
| stream_nil() => ()
| stream_cons(x, xs) =>
    (!theStream_ref := xs; println! (x))
//
end // end of [fmore]
//
(*
val () = theMores.onValue{ptr}(lam(_) =<cloref1> fmore())
*)
//
(* ****** ****** *)

(* end of [showfile.dats] *)

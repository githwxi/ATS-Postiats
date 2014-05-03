(*
** Source:
** APUE3-page-5/figure-1.3
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atslib_staload_libc.hats"
//
(* ****** ****** *)

staload "./apue.sats"

(* ****** ****** *)

staload $DIRENT // opening the namespace

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
if (argc != 2) then
  $extfcall (void, "err_quit", "usage: ls <dirname> ")
// end of [if] // end of [val]
//
val () = assertloc (argc = 2)
//
val dp = opendir (argv[1])
val () =
if ptrcast(dp) = 0 then 
  $extfcall (void, "err_sys", "can't open %s", argv[1])
// end of [if] // end of [val]
//
val () = assertloc (ptrcast(dp) > 0)
//
fun loop
(
  dp: !DIRptr1
) : void = let
  val (pfopt | p) = readdir (dp)
in
//
if p > 0
  then let
    prval
    Some_v@(pf, fpf) = pfopt
    val (fpf2 | str2) = dirent_get_d_name (!p)
    prval () = fpf (pf)
    val () = println! (str2)
    prval () = fpf2 (str2)
  in
    loop (dp)
  end // end of [then]
  else let
    prval None_v ((*void*)) = pfopt
  in
    // nothing
  end // end of [else]
end // end of [loop]
//
val () = loop (dp)
//
val () = closedir_exn (dp)
//
val ((*void*)) = exit(0){void}
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [APUE3-1-3.dats] *)

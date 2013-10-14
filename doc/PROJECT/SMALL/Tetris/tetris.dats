(*
** Implementing Tetris
** This is a case study on
** combining ATS with Objective-C
*)

(* ****** ****** *)

(*
**
** Author: Chen GUO
** Authoremail: ...
** Author: Hongwei XI
** Authoremail: gmhwxiATgmailDOTcom
**
*)

(* ****** ****** *)

staload "./tetris.sats"

(* ****** ****** *)

extern
fun
mainloop (): void

(* ****** ****** *)

implement
mainloop () = let
//
val opt = gmstate_poll_event ()
//
in
//
case+ opt of
| ~Some_vt x => let
    val (
    ) = gmstate_handle_event (x)
  in
    mainloop ()
  end // end of [Some_vt]
| ~None_vt () => let
    val () = gmstate_poll_wait ()
  in
    mainloop ()
  end // end of [None_vt]
//
end // end of [mainloop]

(* ****** ****** *)

(* end of [tetris.dats] *)

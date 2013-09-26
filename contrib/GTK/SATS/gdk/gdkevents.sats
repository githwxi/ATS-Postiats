(*
** source: gdkevents.h
*)

(* ****** ****** *)

abst@ype
GdkEventType = $extype"GdkEventType"

(* ****** ****** *)

typedef
GdkEvent =
$extype_struct"GdkEvent" of
{
  type= GdkEventType
, window= ptr // GdkWindow *window;
, send_event= gint8
, _rest= undefined_t0ype // this field cannot be accessed
} (* end of [GdkEvent] *)

(* ****** ****** *)

(* end of [gdkevents.sats] *)

(*
** source: gtkdialog.h
*)

(* ****** ****** *)
//
abst@ype
GtkDialogFlags = $extype"GtkDialogFlags"
abst@ype
GtkResponseType = $extype"GtkResponseType"
//
(* ****** ****** *)
//
(*
typedef enum
{
  GTK_DIALOG_MODAL               = 1 << 0,
  GTK_DIALOG_DESTROY_WITH_PARENT = 1 << 1
} GtkDialogFlags;
*)
//
macdef
GTK_DIALOG_MODAL = $extval(GtkDialogFlags, "GTK_DIALOG_MODAL")
macdef
GTK_DIALOG_DESTROY_WITH_PARENT = $extval(GtkDialogFlags, "GTK_DIALOG_DESTROY_WITH_PARENT")
//
(* ****** ****** *)
//
(*
typedef enum
{
  GTK_RESPONSE_NONE         = -1,
  GTK_RESPONSE_REJECT       = -2,
  GTK_RESPONSE_ACCEPT       = -3,
  GTK_RESPONSE_DELETE_EVENT = -4,
  GTK_RESPONSE_OK           = -5,
  GTK_RESPONSE_CANCEL       = -6,
  GTK_RESPONSE_CLOSE        = -7,
  GTK_RESPONSE_YES          = -8,
  GTK_RESPONSE_NO           = -9,
  GTK_RESPONSE_APPLY        = -10,
  GTK_RESPONSE_HELP         = -11
} GtkResponseType;
*)
//
macdef
GTK_RESPONSE_NONE = $extval(GtkResponseType, "GTK_RESPONSE_NONE")
macdef
GTK_RESPONSE_REJECT = $extval(GtkResponseType, "GTK_RESPONSE_REJECT")
macdef
GTK_RESPONSE_ACCEPT = $extval(GtkResponseType, "GTK_RESPONSE_ACCEPT")
macdef
GTK_RESPONSE_DELETE_EVENT = $extval(GtkResponseType, "GTK_RESPONSE_DELETE_EVENT")
macdef
GTK_RESPONSE_OK = $extval(GtkResponseType, "GTK_RESPONSE_OK")
macdef
GTK_RESPONSE_CANCEL = $extval(GtkResponseType, "GTK_RESPONSE_CANCEL")
macdef
GTK_RESPONSE_CLOSE = $extval(GtkResponseType, "GTK_RESPONSE_CLOSE")
macdef
GTK_RESPONSE_YES = $extval(GtkResponseType, "GTK_RESPONSE_YES")
macdef
GTK_RESPONSE_NO = $extval(GtkResponseType, "GTK_RESPONSE_NO")
macdef
GTK_RESPONSE_APPLY = $extval(GtkResponseType, "GTK_RESPONSE_APPLY")
macdef
GTK_RESPONSE_HELP = $extval(GtkResponseType, "GTK_RESPONSE_HELP")
//
(* ****** ****** *)
//
fun
gtk_dialog_new ((*void*)): gobjref0(GtkDialog) = "mac#%"
//
(* ****** ****** *)

(*
GtkWidget* gtk_dialog_new_with_buttons (const gchar     *title,
                                        GtkWindow       *parent,
                                        GtkDialogFlags   flags,
                                        const gchar     *first_button_text,
                                        ...) G_GNUC_NULL_TERMINATED;
*)

(* ****** ****** *)

fun gtk_dialog_run (dialog: !GtkDialog1): int = "mac#%"

(* ****** ****** *)

fun gtk_dialog_response
  (dialog: !GtkDialog1, response_id: gint): void = "mac#%"
// end of [gtk_dialog_response]

(* ****** ****** *)

(* end of [gtkdialog.sats] *)

(*
** source: gtkmessagedialog.h
*)

(* ****** ****** *)

abst@ype
GtkButtonsType = $extype"GtkButtonsType"

(* ****** ****** *)
//
(*
typedef enum
{
  GTK_BUTTONS_NONE,
  GTK_BUTTONS_OK,
  GTK_BUTTONS_CLOSE,
  GTK_BUTTONS_CANCEL,
  GTK_BUTTONS_YES_NO,
  GTK_BUTTONS_OK_CANCEL
} GtkButtonsType;
*)
//
macdef
GTK_BUTTONS_NONE = $extval(GtkButtonsType, "GTK_BUTTONS_NONE")
macdef
GTK_BUTTONS_OK = $extval(GtkButtonsType, "GTK_BUTTONS_OK")
macdef
GTK_BUTTONS_CLOSE = $extval(GtkButtonsType, "GTK_BUTTONS_CLOSE")
macdef
GTK_BUTTONS_YES_NO = $extval(GtkButtonsType, "GTK_BUTTONS_YES_NO")
macdef
GTK_BUTTONS_OK_CANCEL = $extval(GtkButtonsType, "GTK_BUTTONS_OK_CANCEL")
//
(* ****** ****** *)

(*
GtkWidget* gtk_message_dialog_new      (GtkWindow      *parent,
                                        GtkDialogFlags  flags,
                                        GtkMessageType  type,
                                        GtkButtonsType  buttons,
                                        const gchar    *message_format,
                                        ...) G_GNUC_PRINTF (5, 6);

GtkWidget* gtk_message_dialog_new_with_markup   (GtkWindow      *parent,
                                                 GtkDialogFlags  flags,
                                                 GtkMessageType  type,
                                                 GtkButtonsType  buttons,
                                                 const gchar    *message_format,
                                                 ...) G_GNUC_PRINTF (5, 6);
*)

(* ****** ****** *)
//
fun
gtk_message_dialog_set_image
(
  dialog: !GtkMessageDialog1, image: !GtkWidget1
) : void = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
gtk_message_dialog_get_image
  {l:agz}
(
  dialog: !GtkMessageDialog(l)
) : [l2:addr]
(
  minus (GtkMessageDialog(l), GtkWidget(l2)) | GtkWidget(l2)
) = "mac#%" // end of [gtk_message_dialog_get_image]
//
(* ****** ****** *)

(* end of [gtkmessagedialog.sats] *)

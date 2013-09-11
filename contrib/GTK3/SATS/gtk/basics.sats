(* ****** ****** *)
//
// Mostly some convenient shorthands
//
(* ****** ****** *)
//
stadef GtkWidget = GtkWidget_cls
//
vtypedef
GtkWidget (l:addr) = [c:cls | c <= GtkWidget] gobjref (c, l)
vtypedef GtkWidget0 = [c:cls;l:agez | c <= GtkWidget] gobjref (c, l) 
vtypedef GtkWidget1 = [c:cls;l:addr | c <= GtkWidget; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkContainer = GtkContainer_cls
//
vtypedef
GtkContainer (l:addr) = [c:cls | c <= GtkContainer] gobjref (c, l)
vtypedef GtkContainer0 = [c:cls;l:agez | c <= GtkContainer] gobjref (c, l) 
vtypedef GtkContainer1 = [c:cls;l:addr | c <= GtkContainer; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkButton = GtkButton_cls
//
vtypedef
GtkButton (l:addr) = [c:cls | c <= GtkButton] gobjref (c, l)
vtypedef GtkButton0 = [c:cls;l:agez | c <= GtkButton] gobjref (c, l) 
vtypedef GtkButton1 = [c:cls;l:addr | c <= GtkButton; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkWindow = GtkWindow_cls
//
vtypedef
GtkWindow (l:addr) = [c:cls | c <= GtkWindow] gobjref (c, l)
vtypedef GtkWindow0 = [c:cls;l:agez | c <= GtkWindow] gobjref (c, l) 
vtypedef GtkWindow1 = [c:cls;l:addr | c <= GtkWindow; l > null] gobjref (c, l) 
//
(* ****** ****** *)

(* end of [basics.sats] *)

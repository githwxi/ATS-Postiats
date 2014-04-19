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
stadef GtkBin = GtkBin_cls
//
vtypedef
GtkBin (l:addr) = [c:cls | c <= GtkBin] gobjref (c, l)
vtypedef GtkBin0 = [c:cls;l:agez | c <= GtkBin] gobjref (c, l) 
vtypedef GtkBin1 = [c:cls;l:addr | c <= GtkBin; l > null] gobjref (c, l) 
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
stadef GtkSeparator = GtkSeparator_cls
//
vtypedef
GtkSeparator (l:addr) = [c:cls | c <= GtkSeparator] gobjref (c, l)
vtypedef GtkSeparator0 = [c:cls;l:agez | c <= GtkSeparator] gobjref (c, l) 
vtypedef GtkSeparator1 = [c:cls;l:addr | c <= GtkSeparator; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkHSeparator = GtkHSeparator_cls
//
vtypedef
GtkHSeparator (l:addr) = [c:cls | c <= GtkHSeparator] gobjref (c, l)
vtypedef GtkHSeparator0 = [c:cls;l:agez | c <= GtkHSeparator] gobjref (c, l) 
vtypedef GtkHSeparator1 = [c:cls;l:addr | c <= GtkHSeparator; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkVSeparator = GtkVSeparator_cls
//
vtypedef
GtkVSeparator (l:addr) = [c:cls | c <= GtkVSeparator] gobjref (c, l)
vtypedef GtkVSeparator0 = [c:cls;l:agez | c <= GtkVSeparator] gobjref (c, l) 
vtypedef GtkVSeparator1 = [c:cls;l:addr | c <= GtkVSeparator; l > null] gobjref (c, l) 
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
//
stadef GtkDialog = GtkDialog_cls
//
vtypedef
GtkDialog (l:addr) = [c:cls | c <= GtkDialog] gobjref (c, l)
vtypedef GtkDialog0 = [c:cls;l:agez | c <= GtkDialog] gobjref (c, l) 
vtypedef GtkDialog1 = [c:cls;l:addr | c <= GtkDialog; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkInputDialog = GtkInputDialog_cls
//
vtypedef
GtkInputDialog (l:addr) = [c:cls | c <= GtkInputDialog] gobjref (c, l)
vtypedef GtkInputDialog0 = [c:cls;l:agez | c <= GtkInputDialog] gobjref (c, l) 
vtypedef GtkInputDialog1 = [c:cls;l:addr | c <= GtkInputDialog; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkMessageDialog = GtkMessageDialog_cls
//
vtypedef
GtkMessageDialog (l:addr) = [c:cls | c <= GtkMessageDialog] gobjref (c, l)
vtypedef GtkMessageDialog0 = [c:cls;l:agez | c <= GtkMessageDialog] gobjref (c, l) 
vtypedef GtkMessageDialog1 = [c:cls;l:addr | c <= GtkMessageDialog; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkViewport = GtkViewport_cls
//
vtypedef
GtkViewport (l:addr) = [c:cls | c <= GtkViewport] gobjref (c, l)
vtypedef GtkViewport0 = [c:cls;l:agez | c <= GtkViewport] gobjref (c, l) 
vtypedef GtkViewport1 = [c:cls;l:addr | c <= GtkViewport; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkScrolledWindow = GtkScrolledWindow_cls
//
vtypedef
GtkScrolledWindow (l:addr) = [c:cls | c <= GtkScrolledWindow] gobjref (c, l)
vtypedef GtkScrolledWindow0 = [c:cls;l:agez | c <= GtkScrolledWindow] gobjref (c, l) 
vtypedef GtkScrolledWindow1 = [c:cls;l:addr | c <= GtkScrolledWindow; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkBox = GtkBox_cls
//
vtypedef
GtkBox (l:addr) = [c:cls | c <= GtkBox] gobjref (c, l)
vtypedef GtkBox0 = [c:cls;l:agez | c <= GtkBox] gobjref (c, l) 
vtypedef GtkBox1 = [c:cls;l:addr | c <= GtkBox; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkHBox = GtkHBox_cls
//
vtypedef
GtkHBox (l:addr) = [c:cls | c <= GtkHBox] gobjref (c, l)
vtypedef GtkHBox0 = [c:cls;l:agez | c <= GtkHBox] gobjref (c, l) 
vtypedef GtkHBox1 = [c:cls;l:addr | c <= GtkHBox; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkVBox = GtkVBox_cls
//
vtypedef
GtkVBox (l:addr) = [c:cls | c <= GtkVBox] gobjref (c, l)
vtypedef GtkVBox0 = [c:cls;l:agez | c <= GtkVBox] gobjref (c, l) 
vtypedef GtkVBox1 = [c:cls;l:addr | c <= GtkVBox; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkTable = GtkTable_cls
//
vtypedef
GtkTable (l:addr) = [c:cls | c <= GtkTable] gobjref (c, l)
vtypedef GtkTable0 = [c:cls;l:agez | c <= GtkTable] gobjref (c, l) 
vtypedef GtkTable1 = [c:cls;l:addr | c <= GtkTable; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkDrawingArea = GtkDrawingArea_cls
//
vtypedef
GtkDrawingArea (l:addr) = [c:cls | c <= GtkDrawingArea] gobjref (c, l)
vtypedef GtkDrawingArea0 = [c:cls;l:agez | c <= GtkDrawingArea] gobjref (c, l) 
vtypedef GtkDrawingArea1 = [c:cls;l:addr | c <= GtkDrawingArea; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkTextView = GtkTextView_cls
//
vtypedef
GtkTextView (l:addr) = [c:cls | c <= GtkTextView] gobjref (c, l)
vtypedef GtkTextView0 = [c:cls;l:agez | c <= GtkTextView] gobjref (c, l) 
vtypedef GtkTextView1 = [c:cls;l:addr | c <= GtkTextView; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
// HX: GtkTextBuffer is a GObject
// HX: GtkTextTag is a GObject
// HX: GtkTextTagTable is a GObject
// HX: GtkTextMark is a GObject
//
(* ****** ****** *)
//
stadef GtkTextBuffer = GtkTextBuffer_cls
//
vtypedef
GtkTextBuffer (l:addr) = [c:cls | c <= GtkTextBuffer] gobjref (c, l)
vtypedef GtkTextBuffer0 = [c:cls;l:agez | c <= GtkTextBuffer] gobjref (c, l) 
vtypedef GtkTextBuffer1 = [c:cls;l:addr | c <= GtkTextBuffer; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkTextTag = GtkTextTag_cls
//
vtypedef
GtkTextTag (l:addr) = [c:cls | c <= GtkTextTag] gobjref (c, l)
vtypedef GtkTextTag0 = [c:cls;l:agez | c <= GtkTextTag] gobjref (c, l) 
vtypedef GtkTextTag1 = [c:cls;l:addr | c <= GtkTextTag; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkTextTagTable = GtkTextTagTable_cls
//
vtypedef
GtkTextTagTable (l:addr) = [c:cls | c <= GtkTextTagTable] gobjref (c, l)
vtypedef GtkTextTagTable0 = [c:cls;l:agez | c <= GtkTextTagTable] gobjref (c, l) 
vtypedef GtkTextTagTable1 = [c:cls;l:addr | c <= GtkTextTagTable; l > null] gobjref (c, l) 
//
(* ****** ****** *)
//
stadef GtkTextMark = GtkTextMark_cls
//
vtypedef
GtkTextMark (l:addr) = [c:cls | c <= GtkTextMark] gobjref (c, l)
vtypedef GtkTextMark0 = [c:cls;l:agez | c <= GtkTextMark] gobjref (c, l) 
vtypedef GtkTextMark1 = [c:cls;l:addr | c <= GtkTextMark; l > null] gobjref (c, l) 
//
(* ****** ****** *)

(* end of [mybasis.sats] *)

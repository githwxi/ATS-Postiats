(*
** source: gdkevents.h
*)

(* ****** ****** *)

abst@ype
GdkEventType = $extype"GdkEventType"

(* ****** ****** *)

macdef GDK_NOTHING = $extval(GdkEventType, "GDK_NOTHING")
macdef GDK_DELETE = $extval(GdkEventType, "GDK_DELETE")
macdef GDK_DESTROY = $extval(GdkEventType, "GDK_DESTROY")
macdef GDK_EXPOSE = $extval(GdkEventType, "GDK_EXPOSE")
macdef GDK_MOTION_NOTIFY = $extval(GdkEventType, "GDK_MOTION_NOTIFY")
macdef GDK_BUTTON_PRESS = $extval(GdkEventType, "GDK_BUTTON_PRESS")
macdef GDK_2BUTTON_PRESS = $extval(GdkEventType, "GDK_2BUTTON_PRESS")
macdef GDK_3BUTTON_PRESS = $extval(GdkEventType, "GDK_3BUTTON_PRESS")
macdef GDK_BUTTON_RELEASE = $extval(GdkEventType, "GDK_BUTTON_RELEASE")
macdef GDK_KEY_PRESS = $extval(GdkEventType, "GDK_KEY_PRESS")
macdef GDK_KEY_RELEASE = $extval(GdkEventType, "GDK_KEY_RELEASE")
macdef GDK_ENTER_NOTIFY = $extval(GdkEventType, "GDK_ENTER_NOTIFY")
macdef GDK_LEAVE_NOTIFY = $extval(GdkEventType, "GDK_LEAVE_NOTIFY")
macdef GDK_FOCUS_CHANGE = $extval(GdkEventType, "GDK_FOCUS_CHANGE")
macdef GDK_CONFIGURE = $extval(GdkEventType, "GDK_CONFIGURE")
macdef GDK_MAP = $extval(GdkEventType, "GDK_MAP")
macdef GDK_UNMAP = $extval(GdkEventType, "GDK_UNMAP")
macdef GDK_PROPERTY_NOTIFY = $extval(GdkEventType, "GDK_PROPERTY_NOTIFY")
macdef GDK_SELECTION_CLEAR = $extval(GdkEventType, "GDK_SELECTION_CLEAR")
macdef GDK_SELECTION_REQUEST = $extval(GdkEventType, "GDK_SELECTION_REQUEST")
macdef GDK_SELECTION_NOTIFY = $extval(GdkEventType, "GDK_SELECTION_NOTIFY")
macdef GDK_PROXIMITY_IN = $extval(GdkEventType, "GDK_PROXIMITY_IN")
macdef GDK_PROXIMITY_OUT = $extval(GdkEventType, "GDK_PROXIMITY_OUT")
macdef GDK_DRAG_ENTER = $extval(GdkEventType, "GDK_DRAG_ENTER")
macdef GDK_DRAG_LEAVE = $extval(GdkEventType, "GDK_DRAG_LEAVE")
macdef GDK_DRAG_MOTION = $extval(GdkEventType, "GDK_DRAG_MOTION")
macdef GDK_DRAG_STATUS = $extval(GdkEventType, "GDK_DRAG_STATUS")
macdef GDK_DROP_START = $extval(GdkEventType, "GDK_DROP_START")
macdef GDK_DROP_FINISHED = $extval(GdkEventType, "GDK_DROP_FINISHED")
macdef GDK_CLIENT_EVENT = $extval(GdkEventType, "GDK_CLIENT_EVENT")
macdef GDK_VISIBILITY_NOTIFY = $extval(GdkEventType, "GDK_VISIBILITY_NOTIFY")
macdef GDK_SCROLL = $extval(GdkEventType, "GDK_SCROLL")
macdef GDK_WINDOW_STATE = $extval(GdkEventType, "GDK_WINDOW_STATE")
macdef GDK_SETTING = $extval(GdkEventType, "GDK_SETTING")
macdef GDK_OWNER_CHANGE = $extval(GdkEventType, "GDK_OWNER_CHANGE")
macdef GDK_GRAB_BROKEN = $extval(GdkEventType, "GDK_GRAB_BROKEN")
macdef GDK_DAMAGE = $extval(GdkEventType, "GDK_DAMAGE")
macdef GDK_TOUCH_BEGIN = $extval(GdkEventType, "GDK_TOUCH_BEGIN")
macdef GDK_TOUCH_UPDATE = $extval(GdkEventType, "GDK_TOUCH_UPDATE")
macdef GDK_TOUCH_END = $extval(GdkEventType, "GDK_TOUCH_END")
macdef GDK_TOUCH_CANCEL = $extval(GdkEventType, "GDK_TOUCH_CANCEL")
macdef GDK_EVENT_LAST = $extval(GdkEventType, "GDK_EVENT_LAST")

(* ****** ****** *)
//
abst@ype
GdkVisibilityState = $extype"GdkVisibilityState"
//
macdef
GDK_VISIBILITY_UNOBSCURED = $extval(GdkVisibilityState, "GDK_VISIBILITY_UNOBSCURED")
macdef
GDK_VISIBILITY_PARTIAL = $extval(GdkVisibilityState, "GDK_VISIBILITY_PARTIAL")
macdef
GDK_VISIBILITY_FULLY_OBSCURED = $extval(GdkVisibilityState, "GDK_VISIBILITY_FULLY_OBSCURED")
//
(* ****** ****** *)
//
abst@ype
GdkScrollDirection = $extype"GdkScrollDirection"
//
macdef GDK_SCROLL_UP = $extval(GdkScrollDirection, "GDK_SCROLL_UP")
macdef GDK_SCROLL_DOWN = $extval(GdkScrollDirection, "GDK_SCROLL_DOWN")
macdef GDK_SCROLL_LEFT = $extval(GdkScrollDirection, "GDK_SCROLL_LEFT")
macdef GDK_SCROLL_RIGHT = $extval(GdkScrollDirection, "GDK_SCROLL_RIGHT")
macdef GDK_SCROLL_SMOOTH = $extval(GdkScrollDirection, "GDK_SCROLL_SMOOTH")
//  
(* ****** ****** *)
//
abst@ype
GdkNotifyType = $extype"GdkNotifyType"
//
macdef GDK_NOTIFY_ANCESTOR = $extval(GdkNotifyType, "GDK_NOTIFY_ANCESTOR")
macdef GDK_NOTIFY_VIRTUAL = $extval(GdkNotifyType, "GDK_NOTIFY_VIRTUAL")
macdef GDK_NOTIFY_INFERIOR = $extval(GdkNotifyType, "GDK_NOTIFY_INFERIOR")
macdef GDK_NOTIFY_NONLINEAR = $extval(GdkNotifyType, "GDK_NOTIFY_NONLINEAR")
macdef GDK_NOTIFY_NONLINEAR_VIRTUAL = $extval(GdkNotifyType, "GDK_NOTIFY_NONLINEAR_VIRTUAL")
macdef GDK_NOTIFY_UNKNOWN = $extval(GdkNotifyType, "GDK_NOTIFY_UNKNOWN")
//
(* ****** ****** *)

typedef
GdkEvent =
$extype_struct"GdkEvent" of
{
  type= GdkEventType
} (* end of [GdkEvent] *)

(* ****** ****** *)

typedef
GdkEventAny =
$extype_struct"GdkEventAny" of
{
  type= GdkEventType
, window= ptr // GdkWindow *window;
, send_event= gint8
, _rest= undefined_t0ype // this field cannot be accessed
} (* end of [GdkEventAny] *)

(* ****** ****** *)
  
(*
struct
_GdkEventExpose
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkRectangle area;
  cairo_region_t *region;
  gint count; /* If non-zero, how many more events follow. */
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventVisibility
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkVisibilityState state;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventMotion
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  guint32 time;
  gdouble x;
  gdouble y;
  gdouble *axes;
  guint state;
  gint16 is_hint;
  GdkDevice *device;
  gdouble x_root, y_root;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventButton
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  guint32 time;
  gdouble x;
  gdouble y;
  gdouble *axes;
  guint state;
  guint button;
  GdkDevice *device;
  gdouble x_root, y_root;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventTouch
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  guint32 time;
  gdouble x;
  gdouble y;
  gdouble *axes;
  guint state;
  GdkEventSequence *sequence;
  gboolean emulating_pointer;
  GdkDevice *device;
  gdouble x_root, y_root;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventScroll
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  guint32 time;
  gdouble x;
  gdouble y;
  guint state;
  GdkScrollDirection direction;
  GdkDevice *device;
  gdouble x_root, y_root;
  gdouble delta_x;
  gdouble delta_y;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventKey
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  guint32 time;
  guint state;
  guint keyval;
  gint length;
  gchar *string;
  guint16 hardware_keycode;
  guint8 group;
  guint is_modifier : 1;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventCrossing
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkWindow *subwindow;
  guint32 time;
  gdouble x;
  gdouble y;
  gdouble x_root;
  gdouble y_root;
  GdkCrossingMode mode;
  GdkNotifyType detail;
  gboolean focus;
  guint state;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventFocus
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  gint16 in;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventConfigure
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  gint x, y;
  gint width;
  gint height;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventProperty
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkAtom atom;
  guint32 time;
  guint state;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventSelection
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkAtom selection;
  GdkAtom target;
  GdkAtom property;
  guint32 time;
  GdkWindow *requestor;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventOwnerChange
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkWindow *owner;
  GdkOwnerChange reason;
  GdkAtom selection;
  guint32 time;
  guint32 selection_time;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventProximity
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  guint32 time;
  GdkDevice *device;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventSetting
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkSettingAction action;
  char *name;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventWindowState
{
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkWindowState changed_mask;
  GdkWindowState new_window_state;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventGrabBroken {
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  gboolean keyboard;
  gboolean implicit;
  GdkWindow *grab_window;
} ;
*)

(* ****** ****** *)

(*
struct
_GdkEventDND {
  GdkEventType type;
  GdkWindow *window;
  gint8 send_event;
  GdkDragContext *context;

  guint32 time;
  gshort x_root, y_root;
} ;
*)

(* ****** ****** *)

(* end of [gdkevents.sats] *)

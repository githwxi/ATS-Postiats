/**
  HTML5/canvas-2d functions for ATS2
  Author: Will Blair
  Authoremail: wdblairATcsDOTbuDOTedu
  Start Time: October 2013
  Author: Hongwei Xi
  Authoremail: hwxi AT cs DOT bu DOT edu
  Start Time: October 2013
 */

/* ****** ****** */

var atscntrb_html5_canvas2d =
{
    $Canvas: {
        PI: Math.PI,
        /*
          The C string pointers identify contexts.
        */
        contexts: {}
    },

    atscntrb_html5_canvas2d_make:
    function (ptr) {
	var id = Pointer_stringify(ptr);
        var canvas = document.getElementById(id);

        if(!canvas) {
            return 0;
        }

        if (canvas.getContext) {
            Canvas.contexts[ptr] = canvas.getContext("2d");
        } else {
            throw "atscntrb_html5_canvas2d: 2D-canvas is not supported";
        }
        return ptr; 
    },
    atscntrb_html5_canvas2d_free:
    function (ptr) {
        Canvas.contexts[ptr] = null;
    },

    atscntrb_html5_canvas2d_beginPath:
    function (ptr) {
        Canvas.contexts[ptr].beginPath();
    },
    atscntrb_html5_canvas2d_closePath:
    function (ptr) {
        Canvas.contexts[ptr].closePath();
    },

    atscntrb_html5_canvas2d_moveTo:
    function (ptr, x, y) {
        Canvas.contexts[ptr].moveTo(x, y);
    },
    atscntrb_html5_canvas2d_lineTo:
    function (ptr, x, y) {
        Canvas.contexts[ptr].lineTo(x, y);
    },

    atscntrb_html5_canvas2d_translate:
    function (ptr, x, y) {
        Canvas.contexts[ptr].translate(x, y);
    },
    atscntrb_html5_canvas2d_scale:
    function (ptr, sx, sy) {
        Canvas.contexts[ptr].scale(sx, sy);
    },
    atscntrb_html5_canvas2d_rotate:
    function (ptr, angle) {
        Canvas.contexts[ptr].rotate(angle);
    },

    atscntrb_html5_canvas2d_rect:
    function (ptr, xul, yul, width, height) {
        Canvas.contexts[ptr].rect(xul, yul, width, height);
    },
    atscntrb_html5_canvas2d_arc:
    function (ptr, xc, yc, rad, angle_beg, angle_end, CCW) {
        Canvas.contexts[ptr].arc(xc, yc, rad, angle_beg, angle_end, CCW);
    },

    atscntrb_html5_canvas2d_clearRect:
    function (ptr, xul, yul, width, height) {
        Canvas.contexts[ptr].clearRect(xul, yul, width, height);
    },

    atscntrb_html5_canvas2d_fill:
    function (ptr) {
        Canvas.contexts[ptr].fill();
    },
    atscntrb_html5_canvas2d_fillRect:
    function (ptr, xul, yul, width, height) {
        Canvas.contexts[ptr].fillRect(xul, yul, width, height);
    },
    atscntrb_html5_canvas2d_fillStyle_string:
    function (ptr, string) {
        var style = Pointer_stringify(string);
        Canvas.contexts[ptr].fillStyle = style;
    },

    atscntrb_html5_canvas2d_stroke:
    function (ptr) {
        Canvas.contexts[ptr].stroke();
    },
    atscntrb_html5_canvas2d_strokeStyle_string:
    function (ptr, string) {
        var style = Pointer_stringify(string);
        Canvas.contexts[ptr].strokeStyle = style;
    },

    atscntrb_html5_canvas2d_save:
    function (ptr) {
        Canvas.contexts[ptr].save() ;
    },
    atscntrb_html5_canvas2d_restore:
    function (ptr) {
        Canvas.contexts[ptr].restore();
    },

    atscntrb_html5_canvas2d_set_size:
    function (ptr, width, height) {
        var id = Pointer_stringify(ptr);
        var elt = document.getElementById(id);
        elt.width = width;
        elt.height = height;
    }
};

/* ****** ****** */

autoAddDeps(atscntrb_html5_canvas2d, '$Canvas');

/* ****** ****** */

mergeInto(LibraryManager.library, atscntrb_html5_canvas2d);

/* ****** ****** */

/* end of [HTMLcanvas2d.js] */


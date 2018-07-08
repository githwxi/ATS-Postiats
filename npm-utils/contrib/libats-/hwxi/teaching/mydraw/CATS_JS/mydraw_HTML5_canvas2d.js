/*
HTML5 Canvas functions for ATS2
*/
/* ****** ****** */

/**
  Author: Will Blair
  Start Time: September 2013
  Authoremail: wdblairATcsDOTbuDOTedu
 */

/**
  Author: Hongwei Xi
  Start Time: October 2013
  Authoremail: hwxi AT cs DOT bu DOT edu
 */

/* ****** ****** */

var mydraw_html5_canvas2d =
{
    $MyCanvas: {
        PI: Math.PI,
        /*
          The C string pointers identify contexts.
        */
        contexts: {}
    },
    atscntrb_libatshwxi_canvas2d_make:
    function (ptr) {
	var id = Pointer_stringify(ptr);
        var canvas = document.getElementById(id);
        if (canvas.getContext) {
            MyCanvas.contexts[ptr] = canvas.getContext("2d");
        } else {
            throw "mydraw_html5_canvas2d: 2D-canvas is not supported";
        }
        return ptr; 
    },
    atscntrb_libatshwxi_canvas2d_free:
    function (ptr) {
        MyCanvas.contexts[ptr] = null;
    },

    atscntrb_libatshwxi_canvas2d_beginPath:
    function (ptr) {
        MyCanvas.contexts[ptr].beginPath();
    },
    atscntrb_libatshwxi_canvas2d_closePath:
    function (ptr) {
        MyCanvas.contexts[ptr].closePath();
    },

    atscntrb_libatshwxi_canvas2d_moveTo:
    function (ptr, x, y) {
        MyCanvas.contexts[ptr].moveTo(x, y);
    },
    atscntrb_libatshwxi_canvas2d_lineTo:
    function (ptr, x, y) {
        MyCanvas.contexts[ptr].lineTo(x, y);
    },

    atscntrb_libatshwxi_canvas2d_translate:
    function (ptr, x, y) {
        MyCanvas.contexts[ptr].translate(x, y);
    },
    atscntrb_libatshwxi_canvas2d_scale:
    function (ptr, sx, sy) {
        MyCanvas.contexts[ptr].scale(sx, sy);
    },
    atscntrb_libatshwxi_canvas2d_rotate:
    function (ptr, angle) {
        MyCanvas.contexts[ptr].rotate(angle);
    },

    atscntrb_libatshwxi_canvas2d_rect:
    function (ptr, xul, yul, width, height) {
        MyCanvas.contexts[ptr].rect(xul, yul, width, height);
    },
    atscntrb_libatshwxi_canvas2d_arc:
    function (ptr, xc, yc, rad, angle_beg, angle_end, CCW) {
        MyCanvas.contexts[ptr].arc(xc, yc, rad, angle_beg, angle_end, CCW);
    },

    atscntrb_libatshwxi_canvas2d_fill:
    function (ptr) {
        MyCanvas.contexts[ptr].fill();
    },
    atscntrb_libatshwxi_canvas2d_fillStyle_string:
    function (ptr, string) {
        var style = Pointer_stringify(string);
        MyCanvas.contexts[ptr].fillStyle = style;
    },

    atscntrb_libatshwxi_canvas2d_stroke:
    function (ptr) {
        MyCanvas.contexts[ptr].stroke();
    },
    atscntrb_libatshwxi_canvas2d_strokeStyle_string:
    function (ptr, string) {
        var style = Pointer_stringify(string);
        MyCanvas.contexts[ptr].strokeStyle = style;
    },

    atscntrb_libatshwxi_canvas2d_clearRect:
    function (ptr, xul, yul, width, height) {
        MyCanvas.contexts[ptr].clearRect(xul, yul, width, height);
    },

    atscntrb_libatshwxi_canvas2d_save:
    function (ptr) {
        MyCanvas.contexts[ptr].save();
    },
    atscntrb_libatshwxi_canvas2d_restore:
    function (ptr) {
        MyCanvas.contexts[ptr].restore();
    },
}

/* ****** ****** */

autoAddDeps(mydraw_html5_canvas2d, '$MyCanvas');
mergeInto(LibraryManager.library, mydraw_html5_canvas2d);

/* ****** ****** */

/* end of [mydraw_html5_canvas2d.js] */

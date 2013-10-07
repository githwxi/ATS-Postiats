/**
  HTML5 Canvas functions for ATS2
  Author: Will Blair
  Authoremail: wdblairATcsDOTbuDOTedu
  Author: Hongwei Xi
  Authoremail: hwxi AT cs DOT bu DOT edu
  Start Time: September 2013
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
            throw "mydraw_html5_canvas2d: 2d-canvas is not supported";
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
        MyCanvas.contexts[ptr].rec(xul, yul, width, height);
    },
    atscntrb_libatshwxi_canvas2d_arc:
    function (ptr, xc, yc, rad, angle_beg, angle_end, CCW) {
        MyCanvas.contexts[ptr].arc(xc, yc, rad, angle_beg, angle_end, CCW);
    },

    atscntrb_libatshwxi_canvas2d_fill:
    function (ptr) {
        MyCanvas.contexts[ptr].fill();
    },
    atscntrb_libatshwxi_canvas2d_fillStyle:
    function (ptr, strptr) {
        var style = Pointer_stringify(strptr);
        MyCanvas.contexts[ptr].fillStyle = style;
    },

    atscntrb_libatshwxi_canvas2d_stroke:
    function (ptr) {
        MyCanvas.contexts[ptr].stroke();
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

/* end of [mydraw_html5_canvas2d.js] */

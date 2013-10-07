/**
   Wrapper around HTML5 Canvas functions for an ATS interface

   Author: Will Blair wdblair at cs DOT bu DOT edu
   Time: September 2013
 */
var LibraryClock = {
    $Clock: {
        PI: Math.PI,
        /*
          The C string pointers identify contexts.
        */
        contexts: {}
    },
    make_context: function (ptr) {
        var id = Pointer_stringify(ptr);
        var canvas = document.getElementById(id);

        if(canvas.getContext) {
            Clock.contexts[ptr] = canvas.getContext("2d");
        } else {
            throw "HTML5 Canvas is not supported";
        }
        
        return ptr; 
    },
    free_context: function (ptr) {
        Clock.contexts[ptr] = null;
    },
    clear_rect: function (ptr, x, y, width, height) {
        Clock.contexts[ptr].clearRect(x, y, width, height);
    },
    begin_path: function (ptr) {
        Clock.contexts[ptr].beginPath();
    },
    close_path: function (ptr) {
        Clock.contexts[ptr].closePath();
    },
    move_to: function (ptr, x, y) {
        Clock.contexts[ptr].moveTo(x, y);
    },
    line_to: function (ptr, x, y) {
        Clock.contexts[ptr].lineTo(x, y);
    },
    rotate: function (ptr, radians) {
        Clock.contexts[ptr].rotate(radians);
    },
    translate: function(ptr, x, y) {
        Clock.contexts[ptr].translate(x, y);
    },
    scale: function(ptr, x, y) {
        Clock.contexts[ptr].scale(x, y);
    },
    save: function (ptr) {
        Clock.contexts[ptr].save();
    },
    restore: function (ptr) {
        Clock.contexts[ptr].restore();
    },
    arc: function (ptr, x, y, r, angle_start, angle_end, anticlockwise) {
        Clock.contexts[ptr].arc(
            x, y, r, angle_start, angle_end, anticlockwise
        );
    },
    stroke: function (ptr) {
        Clock.contexts[ptr].stroke();
    },
    fill: function (ptr) {
        Clock.contexts[ptr].fill();
    },
    fill_style: function (ptr, strptr) {
        var style = Pointer_stringify(strptr);
        Clock.contexts[ptr].fillStyle = style;
    },
    atspre_g0float_mod_double: function (a, m) {
        return a % m;
    },
    request_animation_frame_none: function (ptr) {
        var func = Runtime.getFuncWrapper(ptr, 'vi');

        var requestAnimationFrame = window.requestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.msRequestAnimationFrame;

        window.requestAnimationFrame(func);
    },
    request_animation_frame_env: function (ptr, env) {
        var func = Runtime.getFuncWrapper(ptr, 'vii');

        var requestAnimationFrame = window.requestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.msRequestAnimationFrame;

        window.requestAnimationFrame(function (time) {
            func(time, env);
        });
    },
    wallclock_now: function (ptr) {
        /* 
           Assuming that the layout of a struct in memory isn't
           changed by alignment optimizations.
        */
        var now = new Date();

        var mils = now.getMilliseconds();
        var secs = now.getSeconds() + mils / 1000.0;
        var mins = now.getMinutes() + secs / 60.0;
        var hours = (now.getHours() % 12) + mins / 60.0;
        
        /*
          Note that we have to do pointer arithmetic to set the fields
          of our struct.
        */
        Module.setValue(ptr, hours, "double");
        Module.setValue(ptr + 8, mins, "double");
        Module.setValue(ptr + 16, secs, "double");
    }
};

autoAddDeps(LibraryClock, '$Clock');
mergeInto(LibraryManager.library, LibraryClock);

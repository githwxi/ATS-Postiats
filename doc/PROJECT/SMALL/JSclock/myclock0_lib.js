/**
   A Javascript Wall Clock
   Author: Will Blair wdblairATcsDOTbuDOTedu
   Start Time: September 2013
 */
var MyClockLib =
{
    request_animation_frame:
    function (ptr, env) {
        var func = Runtime.getFuncWrapper(ptr, 'vii');

        var window_requestAnimationFrame =
	    window.requestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.msRequestAnimationFrame;

        window_requestAnimationFrame(function (time) { func(time, env); });
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

/* ****** ****** */

mergeInto(LibraryManager.library, MyClockLib);

/* ****** ****** */

/* end of [myclocklib.js] */

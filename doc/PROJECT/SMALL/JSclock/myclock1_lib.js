/**
   A Javascript Wall Clock
   Author: Will Blair wdblairATcsDOTbuDOTedu
   Start Time: September 2013
 */
var MyClockLib =
{
    JS_request_animation_frame:
    function (ptr, env) {
        var func = Runtime.getFuncWrapper(ptr, 'vii');
        window.setTimeout(function (time) { func(time, env); }, 200);
    },

    JS_wallclock_now:
    function (nhr, nmin, nsec) {
        var now = new Date();
/*
        var mils = now.getMilliseconds();
        var secs = now.getSeconds() + mils / 1000.0;
*/
	var secs = now.getSeconds()
        var mins = now.getMinutes()
        var mins = mins + secs / 60.0
        var hours = now.getHours()
        var hours = hours + mins / 60.0
        Module.setValue(nhr, hours, "double");
        Module.setValue(nmin, mins, "double");
        Module.setValue(nsec, secs, "double");
    }
};

/* ****** ****** */

mergeInto(LibraryManager.library, MyClockLib);

/* ****** ****** */

/* end of [myclock1_lib.js] */

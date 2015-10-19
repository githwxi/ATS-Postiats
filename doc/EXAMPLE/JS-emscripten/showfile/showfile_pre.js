/* ****** ****** */

var Module = {
/* 
** Since we respond to events, we
** don't destroy the process once main returns.
*/
    noExitRuntime: true,
    print: function (str) {
/*
        alert("print: str = " + str);
*/
        var output =
        document.getElementById("output");
//
        var cleaned = str
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, "&#039;");
//
        output.innerHTML += cleaned + "\n";
//
        // Scroll to the latest.
        output.scrollTop = 1000000;
//
    }
};

/* ****** ****** */

Module['TOTAL_MEMORY'] = 1048576;

/* ****** ****** */

/* end of [showfile_pre.js] */

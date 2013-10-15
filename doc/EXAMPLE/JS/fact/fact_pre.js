var Module = {
    /* 
       Since we respond to events, don't destroy the process once main
       returns.
    */
    noExitRuntime: true,
    print: function (str) {
        var output = document.getElementById("output");
        
        var cleaned = str
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, "&#039;");
        
        output.innerText += cleaned + "\n";

        //Scroll to the latest.
        output.scrollTop = 1000000;
    }
};

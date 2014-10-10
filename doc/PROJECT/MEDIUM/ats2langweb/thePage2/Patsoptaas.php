<script>
/*
alert("window.innerWidth = " + window.innerWidth);
alert("window.innerHeight = " + window.innerHeight);
alert("document.body.offsetWidth = " + document.body.offsetWidth);
alert("document.body.offsetHeight = " + document.body.offsetHeight);
*/
</script>

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_thePage2_initize()
{
//
var
editor=
ace.edit('thePage2RBody1_prop');
//
editor.setFontSize('16px');
editor.setTheme('ace/theme/monokai');
editor.getSession().setValue(Patsoptaas_getWelcomeMessage());
//
Patsoptaas_thePatsopt_stderr_set("");
//
Editor_KB_select_onchange(document.getElementById('Editor_KB_select'));
//
document.getElementById('Editor-read-only').checked = false;
document.getElementById('Editor-show-gutter').checked = true;
//
document.getElementById('Patsopt-tcats-flag').checked = true;
document.getElementById('Patsopt2js-eval-flag').checked = true;
document.getElementById('Compile-stderr-flag').checked = true;
//
document.getElementById('File_special_select').selectedIndex = 0;
//
} // end of [Patsoptaas_thePage2_initize]
//
</script>

<?php /* end of [Patsoptaas.php] */ ?>
